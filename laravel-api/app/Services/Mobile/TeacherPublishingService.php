<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\Message;
use App\Models\StudentProfile;
use App\Services\Notifier;
use App\Services\PrivateFileVault;
use Illuminate\Database\QueryException;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * Homework a teacher sets from a phone, and the short notices they send home.
 *
 * Two rules shape everything here.
 *
 * An assignment is created as a draft and published as a separate act. A
 * teacher writing homework between lessons is interrupted constantly, and a
 * half-written assignment that has already notified thirty families is worse
 * than no app at all. Nothing reaches a student until publish.
 *
 * An announcement is a template with a short detail filled in, never free
 * text. One tap from a phone reaches thirty households; unmoderated broadcast
 * on that surface is a safeguarding obligation nobody here is staffed to
 * carry. It is also refused outside the school's hours, because a push at
 * 23:40 wakes a family and costs the pilot more than the notice was worth.
 */
final class TeacherPublishingService
{
    public function __construct(private readonly PrivateFileVault $vault) {}

    /* ---------- assignments ---------- */

    /**
     * Creates a draft, or returns the one this key already created.
     *
     * @param  array<string, mixed>  $data
     * @return array{assignment: Assignment, created: bool}
     */
    public function createAssignment(
        array $data,
        int $teacherId,
        string $idempotencyKey,
    ): array {
        $existing = Assignment::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            return ['assignment' => $existing, 'created' => false];
        }

        try {
            $assignment = Assignment::query()->create([
                'teacher_user_id' => $teacherId,
                'class_room_id' => (int) $data['class_room_id'],
                'subject_id' => (int) $data['subject_id'],
                'title' => $data['title'],
                'instructions' => $data['instructions'],
                'due_at' => $data['due_at'],
                'max_score' => $data['max_score'] ?? 100,
                'idempotency_key' => $idempotencyKey,
                // A draft. Publishing is a separate, deliberate act.
                'published_at' => null,
            ]);
        } catch (QueryException $e) {
            $winner = Assignment::query()
                ->where('idempotency_key', $idempotencyKey)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            return ['assignment' => $winner, 'created' => false];
        }

        return ['assignment' => $assignment, 'created' => true];
    }

    /**
     * Attaches a file to a draft.
     *
     * A separate call from creating the assignment, on purpose. An upload over
     * a school connection is the step most likely to fail, and folding it into
     * creation would mean a failed upload loses the text as well. Here the
     * assignment survives, the attachment is visibly absent, and the teacher
     * can try the upload again without retyping anything.
     *
     * Replacing an attachment deletes the old object rather than orphaning it.
     */
    public function attach(Assignment $assignment, UploadedFile $file): Assignment
    {
        $previous = $assignment->attachment_path;
        $key = $this->vault->store($file, 'assignment-attachment');

        $assignment->forceFill(['attachment_path' => $key])->save();

        if ($previous !== null && $previous !== $key) {
            $this->vault->delete($previous);
        }

        return $assignment->fresh();
    }

    /**
     * Publishes a draft and tells the class.
     *
     * Idempotent by its own state: a second publish is a no-op rather than a
     * second round of notifications to every family in the class.
     *
     * @return array{assignment: Assignment, published: bool}
     */
    public function publish(Assignment $assignment): array
    {
        if ($assignment->isPublished()) {
            return ['assignment' => $assignment, 'published' => false];
        }

        $studentIds = StudentProfile::query()
            ->where('class_room_id', $assignment->class_room_id)
            ->pluck('user_id');

        DB::transaction(function () use ($assignment, $studentIds): void {
            $assignment->forceFill(['published_at' => now()])->save();

            foreach ($studentIds as $studentId) {
                Notifier::send(
                    (int) $studentId,
                    'new_assignment',
                    'واجب جديد',
                    $assignment->title,
                    ['assignment_id' => $assignment->id],
                );
            }
        });

        return ['assignment' => $assignment->fresh(), 'published' => true];
    }

    /**
     * This teacher's assignments for a class, with how the class is doing.
     *
     * @param  list<int>  $classRoomIds
     * @return list<array<string, mixed>>
     */
    public function assignments(int $teacherId, array $classRoomIds): array
    {
        if ($classRoomIds === []) {
            return [];
        }

        $assignments = Assignment::query()
            ->where('teacher_user_id', $teacherId)
            ->whereIn('class_room_id', $classRoomIds)
            ->orderByDesc('due_at')
            ->limit(100)
            ->get();

        $counts = $assignments->isEmpty() ? collect() : DB::table('submissions')
            ->selectRaw('assignment_id, status, count(*) as total')
            ->whereIn('assignment_id', $assignments->pluck('id')->all())
            ->groupBy('assignment_id', 'status')
            ->get();

        $rollUp = [];
        foreach ($counts as $row) {
            $rollUp[(int) $row->assignment_id][(string) $row->status] = (int) $row->total;
        }

        $classSizes = DB::table('student_profiles')
            ->selectRaw('class_room_id, count(*) as total')
            ->whereIn('class_room_id', $assignments->pluck('class_room_id')->unique()->all() ?: [0])
            ->groupBy('class_room_id')
            ->pluck('total', 'class_room_id');

        return $assignments->map(function (Assignment $assignment) use ($rollUp, $classSizes): array {
            $byStatus = $rollUp[$assignment->id] ?? [];

            return [
                'id' => (int) $assignment->id,
                'class_room_id' => (int) $assignment->class_room_id,
                'subject_id' => (int) $assignment->subject_id,
                'title' => $assignment->title,
                'due_at' => $assignment->due_at?->toIso8601String(),
                'published' => $assignment->isPublished(),
                'published_at' => $assignment->published_at?->toIso8601String(),
                'has_attachment' => $assignment->attachment_path !== null,
                'submission_counts' => [
                    'submitted' => (int) ($byStatus['submitted'] ?? 0),
                    'late' => (int) ($byStatus['late'] ?? 0),
                    'graded' => (int) ($byStatus['graded'] ?? 0),
                    'pending' => (int) ($byStatus['pending'] ?? 0),
                ],
                'class_size' => (int) ($classSizes[$assignment->class_room_id] ?? 0),
            ];
        })->all();
    }

    /**
     * Who has handed in, and who has not.
     *
     * The whole class, not only those who submitted: the students with nothing
     * against their name are the reason a teacher opens this screen.
     *
     * `status` is cast to string on purpose. Uncast, the contract infers it as
     * "a string or 'pending'", an anyOf the generated Dart client cannot
     * compile. Comments beside the array keys become API descriptions, so the
     * reason lives here.
     *
     * @return array<string, mixed>
     */
    public function submissions(Assignment $assignment): array
    {
        $students = DB::table('student_profiles')
            ->join('users', 'users.id', '=', 'student_profiles.user_id')
            ->where('student_profiles.class_room_id', $assignment->class_room_id)
            ->orderBy('users.name')
            ->get(['student_profiles.user_id', 'users.name']);

        $submissions = DB::table('submissions')
            ->where('assignment_id', $assignment->id)
            ->get(['student_user_id', 'status', 'submitted_at', 'score', 'file_path'])
            ->keyBy('student_user_id');

        return [
            'assignment_id' => (int) $assignment->id,
            'title' => $assignment->title,
            'due_at' => $assignment->due_at?->toIso8601String(),
            'published' => $assignment->isPublished(),
            'students' => $students->map(static function ($row) use ($submissions): array {
                $submission = $submissions->get($row->user_id);

                return [
                    'student_user_id' => (int) $row->user_id,
                    'name' => $row->name,
                    // Absent means not handed in. Reporting nothing at all
                    // would let the screen render a blank that reads as "fine".
                    'status' => (string) ($submission->status ?? 'pending'),
                    'submitted_at' => $submission->submitted_at ?? null,
                    'score' => $submission?->score === null
                        ? null
                        : sprintf('%.2F', (float) $submission->score),
                    'has_file' => ($submission->file_path ?? null) !== null,
                ];
            })->all(),
        ];
    }

    /* ---------- announcements ---------- */

    /**
     * The notices a teacher may send, as the school worded them.
     *
     * @return list<array<string, mixed>>
     */
    public function templates(): array
    {
        $templates = [];

        foreach ((array) config('mobile.announcements.templates', []) as $key => $spec) {
            $templates[] = [
                'key' => (string) $key,
                'title' => (string) ($spec['title'] ?? ''),
                'body' => (string) ($spec['body'] ?? ''),
            ];
        }

        return $templates;
    }

    /** @return array{from: string, to: string} */
    public function window(): array
    {
        return [
            'from' => (string) config('mobile.announcements.from', '07:00'),
            'to' => (string) config('mobile.announcements.to', '17:00'),
        ];
    }

    /** True when a notice may be sent right now. */
    public function withinHours(?Carbon $now = null): bool
    {
        $at = $now ?? Carbon::now();
        $minutes = $at->hour * 60 + $at->minute;
        $window = $this->window();

        return $minutes >= self::minutesOf($window['from'])
            && $minutes <= self::minutesOf($window['to']);
    }

    /**
     * Sends one approved notice to a class or to a single guardian.
     *
     * A guardian notice is written as a message from the teacher, which is
     * what makes it a thread the family may answer: the parent surface is
     * reply-only, and the first message decides who opened it.
     *
     * @return array{id: int, audience: string, title: string, body: string, created: bool}
     */
    public function announce(
        string $templateKey,
        string $detail,
        string $audience,
        int $teacherId,
        int $schoolId,
        string $idempotencyKey,
    ): array {
        if (! $this->withinHours()) {
            $window = $this->window();

            throw new HttpException(
                409,
                "Notices can only be sent between {$window['from']} and {$window['to']}.",
            );
        }

        $templates = (array) config('mobile.announcements.templates', []);
        $template = $templates[$templateKey] ?? null;

        if ($template === null) {
            throw new HttpException(422, 'That notice is not one of the approved templates.');
        }

        $max = (int) config('mobile.announcements.detail_max', 200);
        if (mb_strlen($detail) > $max) {
            throw new HttpException(422, "The detail may be at most {$max} characters.");
        }

        $title = (string) ($template['title'] ?? '');
        $body = trim(str_replace(':detail', $detail, (string) ($template['body'] ?? '')));

        return str_starts_with($audience, 'guardian:')
            ? $this->announceToGuardian(
                (int) substr($audience, strlen('guardian:')),
                $teacherId,
                $title,
                $body,
                $idempotencyKey,
            )
            : $this->announceToClass(
                (int) substr($audience, strlen('class:')),
                $teacherId,
                $schoolId,
                $templateKey,
                $title,
                $body,
                $idempotencyKey,
            );
    }

    /** @return array{id: int, audience: string, title: string, body: string, created: bool} */
    private function announceToClass(
        int $classRoomId,
        int $teacherId,
        int $schoolId,
        string $templateKey,
        string $title,
        string $body,
        string $idempotencyKey,
    ): array {
        $existing = Announcement::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            return [
                'id' => (int) $existing->id,
                'audience' => (string) $existing->audience,
                'title' => (string) $existing->title,
                'body' => (string) $existing->body,
                'created' => false,
            ];
        }

        $recipients = StudentProfile::query()
            ->where('school_id', $schoolId)
            ->where('class_room_id', $classRoomId)
            ->pluck('user_id');

        $guardianIds = $recipients->isEmpty() ? collect() : DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->whereIn('student_user_id', $recipients->all())
            ->pluck('parent_user_id')
            ->unique();

        $announcement = null;

        DB::transaction(function () use (
            $classRoomId, $teacherId, $templateKey, $title, $body,
            $idempotencyKey, $guardianIds, &$announcement
        ): void {
            $announcement = Announcement::query()->create([
                'sender_user_id' => $teacherId,
                'audience' => 'class:'.$classRoomId,
                'template_key' => $templateKey,
                'title' => $title,
                'body' => $body,
                'idempotency_key' => $idempotencyKey,
            ]);

            foreach ($guardianIds as $guardianId) {
                Notifier::send(
                    (int) $guardianId,
                    'announcement',
                    $title,
                    $body,
                    ['announcement_id' => $announcement->id],
                );
            }
        });

        return [
            'id' => (int) $announcement->id,
            'audience' => 'class:'.$classRoomId,
            'title' => $title,
            'body' => $body,
            'created' => true,
        ];
    }

    /** @return array{id: int, audience: string, title: string, body: string, created: bool} */
    private function announceToGuardian(
        int $guardianUserId,
        int $teacherId,
        string $title,
        string $body,
        string $idempotencyKey,
    ): array {
        // A message rather than an announcement, so the family can answer it.
        // The parent surface is reply-only and the first message decides who
        // opened the thread; sending this as a broadcast would leave a
        // guardian reading a notice they cannot respond to.
        $text = trim($title."\n".$body);

        $existing = Message::query()
            ->where('sender_user_id', $teacherId)
            ->where('recipient_user_id', $guardianUserId)
            ->where('body', $text)
            ->where('created_at', '>=', now()->subDay())
            ->first();

        if ($existing !== null) {
            return [
                'id' => (int) $existing->id,
                'audience' => 'guardian:'.$guardianUserId,
                'title' => $title,
                'body' => $body,
                'created' => false,
            ];
        }

        $message = Message::query()->create([
            'sender_user_id' => $teacherId,
            'recipient_user_id' => $guardianUserId,
            'body' => $text,
        ]);

        Notifier::send(
            $guardianUserId,
            'message',
            $title,
            $body,
            ['message_id' => $message->id],
        );

        return [
            'id' => (int) $message->id,
            'audience' => 'guardian:'.$guardianUserId,
            'title' => $title,
            'body' => $body,
            'created' => true,
        ];
    }

    private static function minutesOf(string $time): int
    {
        $parts = explode(':', $time);

        return ((int) ($parts[0] ?? 0)) * 60 + ((int) ($parts[1] ?? 0));
    }
}
