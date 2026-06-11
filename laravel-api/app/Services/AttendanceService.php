<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\AttendanceRecord;
use App\Models\StudentProfile;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class AttendanceService
{
    public function markAttendance(array $data, int $teacherId): void
    {
        $windowHours = (int) config('school.attendance_edit_window_hours', 48);
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

        DB::transaction(function () use ($data, $teacherId) {
            foreach ($data['records'] as $r) {
                $existing = AttendanceRecord::where([
                    'student_user_id' => $r['student_user_id'],
                    'date' => $data['date'],
                    'subject_id' => $data['subject_id'] ?? null,
                ])->first();
                $wasAbsent = $existing && $existing->status === 'absent';
                AttendanceRecord::updateOrCreate(
                    ['student_user_id' => $r['student_user_id'], 'date' => $data['date'], 'subject_id' => $data['subject_id'] ?? null],
                    [
                        'class_room_id' => $data['class_room_id'],
                        'status' => $r['status'],
                        'marked_by' => $teacherId,
                        'note' => $r['note'] ?? null,
                    ]
                );
                if ($r['status'] === 'absent' && !$wasAbsent) {
                    Notifier::send($r['student_user_id'], 'absence', 'You were marked absent', "Date: {$data['date']}", ['date' => $data['date']]);
                    $parentIds = DB::table('parent_student')->where('student_user_id', $r['student_user_id'])->pluck('parent_user_id');
                    foreach ($parentIds as $pid) {
                        Notifier::send($pid, 'absence', 'Child marked absent', "Your child was absent on {$data['date']}", ['student_id' => $r['student_user_id'], 'date' => $data['date']]);
                    }
                }
            }
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

    public function attendanceReport(int $classRoomId, array $filters = []): \Illuminate\Database\Eloquent\Builder
    {
        $query = AttendanceRecord::where('class_room_id', $classRoomId);

        if (!empty($filters['date_from'])) {
            $query->where('date', '>=', $filters['date_from']);
        }
        if (!empty($filters['date_to'])) {
            $query->where('date', '<=', $filters['date_to']);
        }
        if (!empty($filters['subject_id'])) {
            $query->where('subject_id', $filters['subject_id']);
        }
        if (!empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        return $query;
    }
}