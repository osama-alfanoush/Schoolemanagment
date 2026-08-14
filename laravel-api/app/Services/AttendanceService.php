<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\AttendanceRecord;
use App\Models\AttendanceSubmissionBatch;
use App\Models\ClassRoom;
use App\Models\StudentEnrollment;
use App\Models\StudentProfile;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class AttendanceService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function markAttendance(array $data, int $teacherId, string $idempotencyKey): AttendanceSubmissionBatch
    {
        $windowHours = (int) config('policy.attendance.edit_window_hours', config('school.attendance_edit_window_hours', 48));
        $targetDate = Carbon::parse($data['date'])->endOfDay();
        if ($targetDate->diffInHours(now(), false) > $windowHours) {
            throw new \InvalidArgumentException("Attendance for {$data['date']} is locked (past the {$windowHours}h edit window). Ask an administrator to override.");
        }

        $studentIds = collect($data['records'])->pluck('student_user_id')->all();
        $validIds = StudentProfile::where('class_room_id', $data['class_room_id'])
            ->whereIn('user_id', $studentIds)->pluck('user_id')->all();
        if (count($validIds) !== count(array_unique($studentIds))) {
            throw new \InvalidArgumentException('One or more students do not belong to this class.');
        }

        $payloadHash = hash('sha256', json_encode($data, JSON_THROW_ON_ERROR));

        return DB::transaction(function () use ($data, $teacherId, $idempotencyKey, $payloadHash) {
            $existingBatch = AttendanceSubmissionBatch::where('idempotency_key', $idempotencyKey)->first();
            if ($existingBatch) {
                abort_if($existingBatch->payload_hash !== $payloadHash, 409, 'Idempotency key was already used with a different attendance payload.');

                return $existingBatch;
            }

            $schoolId = ClassRoom::whereKey($data['class_room_id'])->value('school_id');
            abort_unless($schoolId === $this->currentSchool->id(), 422, 'The class belongs to another school.');
            $batch = AttendanceSubmissionBatch::create([
                'idempotency_key' => $idempotencyKey,
                'school_id' => $schoolId,
                'class_room_id' => $data['class_room_id'],
                'course_section_id' => $data['course_section_id'] ?? null,
                'attendance_date' => $data['date'],
                'submitted_by' => $teacherId,
                'payload_hash' => $payloadHash,
                'record_count' => count($data['records']),
            ]);
            $scopeKey = isset($data['course_section_id'])
                ? 'section:'.$data['course_section_id']
                : (isset($data['subject_id']) ? 'subject:'.$data['subject_id'] : 'daily');
            $now = now();
            $rows = [];

            foreach ($data['records'] as $record) {
                $enrollment = StudentEnrollment::where('student_user_id', $record['student_user_id'])
                    ->where('class_room_id', $data['class_room_id'])
                    ->where('start_date', '<=', $data['date'])
                    ->where(fn ($query) => $query->whereNull('end_date')->orWhere('end_date', '>=', $data['date']))
                    ->first();
                if (StudentEnrollment::where('student_user_id', $record['student_user_id'])->exists() && ! $enrollment) {
                    throw new \InvalidArgumentException('Attendance date is outside the student enrollment range.');
                }

                $rows[] = [
                    'school_id' => $schoolId,
                    'student_user_id' => $record['student_user_id'],
                    'class_room_id' => $data['class_room_id'],
                    'subject_id' => $data['subject_id'] ?? null,
                    'student_enrollment_id' => $enrollment?->id,
                    'course_section_id' => $data['course_section_id'] ?? null,
                    'submission_batch_id' => $batch->id,
                    'date' => $data['date'],
                    'scope_key' => $scopeKey,
                    'status' => $record['status'],
                    'marked_by' => $teacherId,
                    'note' => $record['note'] ?? null,
                    'version' => 1,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];

                if ($record['status'] === 'absent') {
                    DB::table('outbox_events')->insertOrIgnore([
                        'school_id' => $schoolId,
                        'event_id' => (string) Str::uuid(),
                        'type' => 'attendance.absence_recorded',
                        'aggregate_type' => 'student',
                        'aggregate_id' => $record['student_user_id'],
                        'payload' => json_encode(['student_id' => $record['student_user_id'], 'date' => $data['date']]),
                        'deduplication_key' => "absence:{$record['student_user_id']}:{$data['date']}:{$scopeKey}",
                        'available_at' => $now,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ]);
                }
            }

            AttendanceRecord::upsert($rows, ['student_user_id', 'date', 'scope_key'], [
                'school_id', 'class_room_id', 'subject_id', 'student_enrollment_id', 'course_section_id',
                'submission_batch_id', 'status', 'marked_by', 'note', 'updated_at',
            ]);
            $batch->update(['committed_at' => now()]);

            return $batch->fresh();
        });
    }

    public function updateAttendance(int $recordId, array $data, int $teacherId): AttendanceRecord
    {
        $record = AttendanceRecord::findOrFail($recordId);
        $record->update(array_merge($data, ['marked_by' => $teacherId]));

        return $record->fresh();
    }

    public function attendanceSummary(int $classRoomId, string $date): array
    {
        $records = AttendanceRecord::where('class_room_id', $classRoomId)
            ->where('date', $date)->get();

        return [
            'present' => $records->where('status', 'present')->count(),
            'absent' => $records->where('status', 'absent')->count(),
            'late' => $records->where('status', 'late')->count(),
            'excused' => $records->where('status', 'excused')->count(),
            'total' => $records->count(),
        ];
    }

    public function attendanceReport(int $classRoomId, array $filters = []): Builder
    {
        $query = AttendanceRecord::where('class_room_id', $classRoomId);

        if (! empty($filters['date_from'])) {
            $query->where('date', '>=', $filters['date_from']);
        }
        if (! empty($filters['date_to'])) {
            $query->where('date', '<=', $filters['date_to']);
        }
        if (! empty($filters['subject_id'])) {
            $query->where('subject_id', $filters['subject_id']);
        }
        if (! empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        return $query;
    }
}
