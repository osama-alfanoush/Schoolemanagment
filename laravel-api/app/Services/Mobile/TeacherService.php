<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\ClassRoom;
use App\Models\Gradebook;
use App\Models\GradeComponent;
use App\Models\TeacherGradeBatch;
use App\Services\AttendanceService;
use App\Services\GradeService;
use Illuminate\Database\QueryException;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * What a teacher may see and do from the phone.
 *
 * Scope is a class, never a child. A teacher reads a roster because a class is
 * assigned to them -- homeroom, or a subject on `class_subject_teacher` -- and
 * every method here takes that assignment as its precondition rather than
 * trusting the class id in the path.
 *
 * The two writes both go through the services the web already uses:
 * `AttendanceService::markAttendance()` for attendance and
 * `GradeService::enter()` for marks. Reimplementing either would mean a second
 * copy of the edit window, the gradebook workflow and the optimistic version
 * check, and the mobile copy would be the one that drifts.
 */
final class TeacherService
{
    public function __construct(
        private readonly AttendanceService $attendance,
        private readonly GradeService $grades,
    ) {}

    /* ---------- scope ---------- */

    /**
     * Classes assigned to this teacher: homeroom plus every subject pairing.
     *
     * @return list<int>
     */
    public function assignedClassIds(int $teacherId, int $schoolId): array
    {
        $homeroom = ClassRoom::query()
            ->where('school_id', $schoolId)
            ->where('homeroom_teacher_id', $teacherId)
            ->pluck('id');

        $taught = DB::table('class_subject_teacher')
            ->where('school_id', $schoolId)
            ->where('teacher_user_id', $teacherId)
            ->pluck('class_room_id');

        return $homeroom->merge($taught)
            ->map(static fn ($id): int => (int) $id)
            ->unique()
            ->values()
            ->all();
    }

    /**
     * Whether this teacher may act on a class, optionally for one subject.
     *
     * A homeroom teacher covers the class for any subject -- they are the one
     * who takes daily attendance. A subject teacher covers only their pairing,
     * so passing a subject narrows the check rather than widening it.
     */
    public function canTeach(int $teacherId, int $schoolId, int $classRoomId, ?int $subjectId = null): bool
    {
        $isHomeroom = ClassRoom::query()
            ->whereKey($classRoomId)
            ->where('school_id', $schoolId)
            ->where('homeroom_teacher_id', $teacherId)
            ->exists();

        if ($isHomeroom) {
            return true;
        }

        $pairing = DB::table('class_subject_teacher')
            ->where('school_id', $schoolId)
            ->where('class_room_id', $classRoomId)
            ->where('teacher_user_id', $teacherId);

        if ($subjectId !== null) {
            $pairing->where('subject_id', $subjectId);
        }

        return $pairing->exists();
    }

    /* ---------- today ---------- */

    /**
     * The teacher's day: their periods, and which of them still need marking.
     *
     * `attendance_taken` is the point of the screen. A teacher who cannot see
     * at a glance which period is outstanding marks the same class twice and
     * misses another one entirely.
     *
     * @return array<string, mixed>
     */
    public function today(int $teacherId, int $schoolId, ?Carbon $date = null): array
    {
        $date ??= Carbon::today();
        $isoDate = $date->toDateString();

        $periods = DB::table('timetable_entries')
            ->leftJoin('subjects', 'subjects.id', '=', 'timetable_entries.subject_id')
            ->leftJoin('class_rooms', 'class_rooms.id', '=', 'timetable_entries.class_room_id')
            ->where('timetable_entries.school_id', $schoolId)
            ->where('timetable_entries.teacher_user_id', $teacherId)
            ->where('timetable_entries.day_of_week', $date->dayOfWeekIso)
            ->orderBy('timetable_entries.start_time')
            ->get([
                'timetable_entries.id',
                'timetable_entries.class_room_id',
                'timetable_entries.subject_id',
                'timetable_entries.start_time',
                'timetable_entries.end_time',
                'timetable_entries.room',
                'subjects.name as subject_name',
                'class_rooms.name as class_name',
            ]);

        // One query for the whole day rather than one per period: a full
        // timetable is eight rows, and eight round trips is what a teacher
        // feels on a school connection.
        $classIds = $periods->pluck('class_room_id')->unique()->values()->all();

        $marked = $classIds === [] ? [] : DB::table('attendance_submission_batches')
            ->where('school_id', $schoolId)
            ->whereDate('attendance_date', $isoDate)
            ->whereIn('class_room_id', $classIds)
            ->whereNotNull('committed_at')
            ->pluck('class_room_id')
            ->map(static fn ($id): int => (int) $id)
            ->unique()
            ->all();

        return [
            'date' => $isoDate,
            'attendance_window' => $this->attendance->editWindow($isoDate),
            'periods' => $periods->map(static fn ($row): array => [
                'id' => (int) $row->id,
                'class_room_id' => (int) $row->class_room_id,
                'class_name' => $row->class_name,
                'subject_id' => (int) $row->subject_id,
                'subject' => $row->subject_name,
                'start_time' => (string) $row->start_time,
                'end_time' => (string) $row->end_time,
                'room' => $row->room,
                'attendance_taken' => in_array((int) $row->class_room_id, $marked, true),
            ])->all(),
            'classes' => $this->classes($teacherId, $schoolId),
        ];
    }

    /**
     * Every class this teacher is assigned, for the classes tab.
     *
     * @return list<array<string, mixed>>
     */
    public function classes(int $teacherId, int $schoolId): array
    {
        $ids = $this->assignedClassIds($teacherId, $schoolId);

        if ($ids === []) {
            return [];
        }

        $counts = DB::table('student_profiles')
            ->selectRaw('class_room_id, count(*) as total')
            ->where('school_id', $schoolId)
            ->whereIn('class_room_id', $ids)
            ->groupBy('class_room_id')
            ->pluck('total', 'class_room_id');

        return ClassRoom::query()
            ->whereIn('id', $ids)
            ->orderBy('name')
            ->get(['id', 'name', 'grade', 'section', 'homeroom_teacher_id'])
            ->map(static fn (ClassRoom $room): array => [
                'id' => (int) $room->id,
                'name' => $room->name,
                'grade' => $room->grade,
                'section' => $room->section,
                'is_homeroom' => (int) $room->homeroom_teacher_id === $teacherId,
                'student_count' => (int) ($counts[$room->id] ?? 0),
            ])
            ->all();
    }

    /* ---------- roster ---------- */

    /**
     * One class's students with whatever attendance is already recorded.
     *
     * The existing marks come back with the roster so the phone can open the
     * form pre-filled and offline. Sending an empty form and letting a teacher
     * re-enter a day they already marked is how duplicates happen.
     *
     * @return array<string, mixed>
     */
    public function roster(int $classRoomId, int $schoolId, ?Carbon $date = null): array
    {
        $date ??= Carbon::today();
        $isoDate = $date->toDateString();

        $students = DB::table('student_profiles')
            ->join('users', 'users.id', '=', 'student_profiles.user_id')
            ->where('student_profiles.school_id', $schoolId)
            ->where('student_profiles.class_room_id', $classRoomId)
            ->orderBy('users.name')
            ->get([
                'student_profiles.user_id',
                'student_profiles.admission_no',
                'users.name',
            ]);

        $existing = DB::table('attendance_records')
            ->where('school_id', $schoolId)
            ->where('class_room_id', $classRoomId)
            ->whereDate('date', $isoDate)
            ->get(['student_user_id', 'status', 'note', 'scope_key'])
            ->keyBy('student_user_id');

        return [
            'class_room_id' => $classRoomId,
            'date' => $isoDate,
            'attendance_window' => $this->attendance->editWindow($isoDate),
            'students' => $students->map(static function ($row) use ($existing): array {
                $mark = $existing->get($row->user_id);

                return [
                    'student_user_id' => (int) $row->user_id,
                    'name' => $row->name,
                    'admission_no' => $row->admission_no,
                    'status' => $mark->status ?? null,
                    'note' => $mark->note ?? null,
                    'scope_key' => $mark->scope_key ?? null,
                ];
            })->all(),
        ];
    }

    /* ---------- grades ---------- */

    /**
     * Applies a column of marks, or none of them.
     *
     * All-or-nothing on purpose. A phone that queued twenty marks offline
     * cannot tell which half of a partial success landed, so a stale row aborts
     * the batch and the client refreshes and resubmits something entirely
     * correct.
     *
     * @param  array{class_room_id: int, subject_id: int, grades: list<array<string, mixed>>}  $data
     * @return array{batch: TeacherGradeBatch, replayed: bool}
     */
    public function submitGrades(array $data, int $teacherId, int $schoolId, string $idempotencyKey): array
    {
        $payloadHash = hash('sha256', (string) json_encode($data, JSON_THROW_ON_ERROR));

        $existing = TeacherGradeBatch::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            $this->assertSamePayload($existing, $payloadHash);

            return ['batch' => $existing, 'replayed' => true];
        }

        try {
            return DB::transaction(function () use ($data, $teacherId, $schoolId, $idempotencyKey, $payloadHash): array {
                $components = $this->componentsFor($data, $schoolId);
                $this->assertGradebooksEditable($components);

                // The key is claimed before a single mark is written, so two
                // sends of the same batch are serialised by the unique index
                // rather than by luck. Claiming it afterwards would let the
                // loser apply every grade and only then discover it lost --
                // and each apply bumps the optimistic version, which makes
                // every edit queued on another device stale.
                $batch = TeacherGradeBatch::query()->create([
                    'idempotency_key' => $idempotencyKey,
                    'school_id' => $schoolId,
                    'gradebook_id' => $components->first()?->gradebook_id,
                    'class_room_id' => (int) $data['class_room_id'],
                    'subject_id' => (int) $data['subject_id'],
                    'submitted_by' => $teacherId,
                    'payload_hash' => $payloadHash,
                    'record_count' => count($data['grades']),
                    'result' => [],
                ]);

                $applied = [];

                foreach ($data['grades'] as $row) {
                    $grade = $this->grades->enter([
                        'grade_component_id' => (int) $row['grade_component_id'],
                        'student_user_id' => (int) $row['student_user_id'],
                        'score' => $row['score'],
                        'version' => $row['version'] ?? null,
                        'reason' => $row['reason'] ?? null,
                    ], $teacherId);

                    $applied[] = [
                        'grade_id' => (int) $grade->id,
                        'grade_component_id' => (int) $grade->grade_component_id,
                        'student_user_id' => (int) $grade->student_user_id,
                        'version' => (int) $grade->version,
                    ];
                }

                $batch->update([
                    'result' => [
                        'class_room_id' => (int) $data['class_room_id'],
                        'subject_id' => (int) $data['subject_id'],
                        'grades' => $applied,
                    ],
                    'committed_at' => now(),
                ]);

                return ['batch' => $batch->fresh(), 'replayed' => false];
            });
        } catch (QueryException $e) {
            // Two sends of the same key raced and the unique index decided.
            // The rollback is the point: the loser wrote nothing, so it can
            // report the winner's answer instead of a 500 or a double apply.
            $winner = TeacherGradeBatch::query()
                ->where('idempotency_key', $idempotencyKey)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            $this->assertSamePayload($winner, $payloadHash);

            return ['batch' => $winner, 'replayed' => true];
        }
    }

    /**
     * The components this batch touches, verified to belong to the class.
     *
     * @param  array<string, mixed>  $data
     * @return Collection<int, GradeComponent>
     */
    private function componentsFor(array $data, int $schoolId): Collection
    {
        $ids = collect($data['grades'])
            ->pluck('grade_component_id')
            ->map(static fn ($id): int => (int) $id)
            ->unique()
            ->values();

        $components = GradeComponent::query()
            ->with('gradebook')
            ->whereIn('id', $ids->all())
            ->where('school_id', $schoolId)
            ->where('class_room_id', (int) $data['class_room_id'])
            ->where('subject_id', (int) $data['subject_id'])
            ->get();

        // A component id belonging to another class would otherwise be written
        // under this teacher's assignment: the id in the body is not covered by
        // the class check on the route.
        if ($components->count() !== $ids->count()) {
            throw new HttpException(
                422,
                'One or more grade items do not belong to this class and subject.',
            );
        }

        return $components;
    }

    /** @param Collection<int, GradeComponent> $components */
    private function assertGradebooksEditable(Collection $components): void
    {
        foreach ($components as $component) {
            $gradebook = $component->gradebook;

            if ($gradebook instanceof Gradebook && ! $gradebook->isEditable()) {
                throw new HttpException(
                    409,
                    "This gradebook is {$gradebook->state} and no longer open for editing.",
                );
            }
        }
    }

    private function assertSamePayload(TeacherGradeBatch $batch, string $payloadHash): void
    {
        if ($batch->payload_hash !== $payloadHash) {
            throw new HttpException(
                409,
                'Idempotency key was already used with a different set of marks.',
            );
        }
    }
}
