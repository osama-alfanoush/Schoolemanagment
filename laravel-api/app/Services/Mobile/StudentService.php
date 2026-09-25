<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Assignment;
use App\Models\Submission;
use App\Services\PrivateFileVault;
use Illuminate\Database\QueryException;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * What a student may see of their own record, and nothing else.
 *
 * Every method takes the student id from the caller, and every caller passes
 * `$request->user()->id`. There is deliberately no parameter anywhere in this
 * class or its controller that lets a client name a different student: not a
 * path segment, not a query string, not a body field. Cross-student access is
 * the highest-risk failure on the whole mobile surface, and the cheapest way
 * to make it impossible is to give it nothing to travel on.
 *
 * The reads reuse the parent services rather than reimplementing them. A
 * student's attendance and a parent's view of that same attendance must be the
 * same numbers; two implementations eventually are not.
 */
final class StudentService
{
    public function __construct(
        private readonly ParentAcademicsService $academics,
        private readonly ParentInboxService $inbox,
        private readonly PrivateFileVault $vault,
    ) {}

    /** How far back the home screen's attendance summary looks. */
    private const HOME_WINDOW_DAYS = 30;

    /**
     * The one screen a student opens between lessons.
     *
     * @return array<string, mixed>
     */
    public function home(int $studentId, int $schoolId): array
    {
        $today = Carbon::today();

        return [
            'student_user_id' => $studentId,
            'class_name' => $this->className($studentId, $schoolId),
            'today' => $this->lessonsToday($studentId, $schoolId, $today),
            'attendance' => $this->academics->attendance(
                $studentId,
                $schoolId,
                $today->copy()->subDays(self::HOME_WINDOW_DAYS),
                $today,
            )['summary'] ?? [],
            'next_due' => $this->nextDue($studentId, $schoolId),
            'unread_count' => DB::table('notifications')
                ->where('user_id', $studentId)
                ->whereNull('read_at')
                ->count(),
        ];
    }

    /** @return array<string, mixed> */
    public function timetable(int $studentId, int $schoolId): array
    {
        return $this->inbox->timetable($studentId, $schoolId);
    }

    /** @return array<string, mixed> */
    public function attendance(int $studentId, int $schoolId, Carbon $from, Carbon $to): array
    {
        return $this->academics->attendance($studentId, $schoolId, $from, $to);
    }

    /**
     * Marks, filtered to finalized gradebooks by the shared service.
     *
     * A student must never read a mark their teacher has not submitted. That
     * rule lives in one place and this calls it.
     *
     * @return array<string, mixed>
     */
    public function grades(int $studentId, int $schoolId): array
    {
        return $this->academics->grades($studentId, $schoolId);
    }

    /**
     * Homework this student has been set, and what they have done about it.
     *
     * Only published assignments. A draft is a teacher's working note, and a
     * student who can see one is reading over their shoulder.
     *
     * @return array<string, mixed>
     */
    public function assignments(int $studentId, int $schoolId): array
    {
        $classRoomId = DB::table('student_profiles')
            ->where('school_id', $schoolId)
            ->where('user_id', $studentId)
            ->value('class_room_id');

        if ($classRoomId === null) {
            return ['assignments' => []];
        }

        $assignments = Assignment::query()
            ->where('school_id', $schoolId)
            ->where('class_room_id', $classRoomId)
            ->whereNotNull('published_at')
            ->orderByDesc('due_at')
            ->limit(100)
            ->get();

        // This student's own submissions and no one else's. The whole point of
        // the screen is what *they* have handed in.
        $submissions = $assignments->isEmpty() ? collect() : DB::table('submissions')
            ->whereIn('assignment_id', $assignments->pluck('id')->all())
            ->where('student_user_id', $studentId)
            ->get(['assignment_id', 'status', 'submitted_at', 'score', 'feedback', 'file_path'])
            ->keyBy('assignment_id');

        $subjects = DB::table('subjects')
            ->whereIn('id', $assignments->pluck('subject_id')->unique()->all() ?: [0])
            ->pluck('name', 'id');

        return [
            'assignments' => $assignments->map(static function (Assignment $assignment) use ($submissions, $subjects): array {
                $submission = $submissions->get($assignment->id);

                return [
                    'id' => (int) $assignment->id,
                    'title' => $assignment->title,
                    'instructions' => $assignment->instructions,
                    'subject' => $subjects[$assignment->subject_id] ?? null,
                    'due_at' => $assignment->due_at?->toIso8601String(),
                    'has_attachment' => $assignment->attachment_path !== null,
                    'max_score' => sprintf('%.2F', (float) $assignment->max_score),
                    'submission' => $submission === null ? null : [
                        'status' => $submission->status,
                        'submitted_at' => $submission->submitted_at,
                        'score' => $submission->score === null
                            ? null
                            : sprintf('%.2F', (float) $submission->score),
                        'feedback' => $submission->feedback,
                        'has_file' => $submission->file_path !== null,
                    ],
                ];
            })->all(),
        ];
    }

    /**
     * Hands in one piece of work.
     *
     * Idempotent on the key: a phone that retries an upload after a timeout
     * must not produce two submissions, and the unique index on
     * `(assignment_id, student_user_id)` already makes a second row impossible
     * — what the key adds is that the retry is answered rather than refused.
     *
     * @return array{submission: Submission, created: bool}
     */
    public function submit(
        int $assignmentId,
        int $studentId,
        int $schoolId,
        string $idempotencyKey,
        ?string $text,
        ?UploadedFile $file,
    ): array {
        $assignment = Assignment::query()
            ->whereKey($assignmentId)
            ->where('school_id', $schoolId)
            ->whereNotNull('published_at')
            ->first();

        // A draft, another class's homework, or nothing at all. The same
        // answer for all three: a student cannot tell them apart, which is the
        // point.
        if ($assignment === null || ! $this->isInClass($studentId, $schoolId, (int) $assignment->class_room_id)) {
            throw new HttpException(404, 'That assignment is not available.');
        }

        $existing = Submission::query()
            ->where('assignment_id', $assignmentId)
            ->where('student_user_id', $studentId)
            ->first();

        if ($existing !== null && $existing->idempotency_key === $idempotencyKey) {
            return ['submission' => $existing, 'created' => false];
        }

        $key = $file === null ? null : $this->vault->store($file, 'submission');

        // Late is recorded as late, not refused. A student who cannot hand in
        // at all after the deadline simply hands in nothing, and the teacher
        // loses the work rather than the timestamp.
        $status = $assignment->due_at !== null && now()->greaterThan($assignment->due_at)
            ? 'late'
            : 'submitted';

        try {
            $submission = Submission::query()->updateOrCreate(
                ['assignment_id' => $assignmentId, 'student_user_id' => $studentId],
                [
                    'content_text' => $text,
                    'file_path' => $key ?? $existing?->file_path,
                    'submitted_at' => now(),
                    'status' => $status,
                    'idempotency_key' => $idempotencyKey,
                ],
            );
        } catch (QueryException $e) {
            $winner = Submission::query()
                ->where('assignment_id', $assignmentId)
                ->where('student_user_id', $studentId)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            return ['submission' => $winner, 'created' => false];
        }

        // Replacing a file deletes the old object rather than orphaning it.
        if ($key !== null && $existing?->file_path !== null && $existing->file_path !== $key) {
            $this->vault->delete($existing->file_path);
        }

        return ['submission' => $submission, 'created' => $existing === null];
    }

    /* ---------- helpers ---------- */

    private function isInClass(int $studentId, int $schoolId, int $classRoomId): bool
    {
        return DB::table('student_profiles')
            ->where('school_id', $schoolId)
            ->where('user_id', $studentId)
            ->where('class_room_id', $classRoomId)
            ->exists();
    }

    private function className(int $studentId, int $schoolId): ?string
    {
        return DB::table('student_profiles')
            ->join('class_rooms', 'class_rooms.id', '=', 'student_profiles.class_room_id')
            ->where('student_profiles.school_id', $schoolId)
            ->where('student_profiles.user_id', $studentId)
            ->value('class_rooms.name');
    }

    /** @return list<array<string, mixed>> */
    private function lessonsToday(int $studentId, int $schoolId, Carbon $today): array
    {
        $classRoomId = DB::table('student_profiles')
            ->where('school_id', $schoolId)
            ->where('user_id', $studentId)
            ->value('class_room_id');

        if ($classRoomId === null) {
            return [];
        }

        return DB::table('timetable_entries')
            ->leftJoin('subjects', 'subjects.id', '=', 'timetable_entries.subject_id')
            ->where('timetable_entries.school_id', $schoolId)
            ->where('timetable_entries.class_room_id', $classRoomId)
            ->where('timetable_entries.day_of_week', $today->dayOfWeekIso)
            ->orderBy('timetable_entries.start_time')
            ->get([
                'timetable_entries.id',
                'timetable_entries.start_time',
                'timetable_entries.end_time',
                'timetable_entries.room',
                'subjects.name as subject_name',
            ])
            ->map(static fn ($row): array => [
                'id' => (int) $row->id,
                'subject' => $row->subject_name,
                'start_time' => (string) $row->start_time,
                'end_time' => (string) $row->end_time,
                'room' => $row->room,
            ])
            ->all();
    }

    /**
     * The next published assignment this student has not handed in.
     *
     * @return array<string, mixed>|null
     */
    private function nextDue(int $studentId, int $schoolId): ?array
    {
        $classRoomId = DB::table('student_profiles')
            ->where('school_id', $schoolId)
            ->where('user_id', $studentId)
            ->value('class_room_id');

        if ($classRoomId === null) {
            return null;
        }

        $row = DB::table('assignments')
            ->leftJoin('submissions', function ($join) use ($studentId): void {
                $join->on('submissions.assignment_id', '=', 'assignments.id')
                    ->where('submissions.student_user_id', '=', $studentId);
            })
            ->where('assignments.school_id', $schoolId)
            ->where('assignments.class_room_id', $classRoomId)
            ->whereNotNull('assignments.published_at')
            ->whereNull('submissions.id')
            ->where('assignments.due_at', '>=', now())
            ->orderBy('assignments.due_at')
            ->first(['assignments.id', 'assignments.title', 'assignments.due_at']);

        return $row === null ? null : [
            'assignment_id' => (int) $row->id,
            'title' => $row->title,
            'due_at' => Carbon::parse($row->due_at)->toIso8601String(),
        ];
    }
}
