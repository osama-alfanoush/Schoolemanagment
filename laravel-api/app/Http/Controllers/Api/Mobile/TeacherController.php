<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Services\AttendanceService;
use App\Services\AuditLogger;
use App\Models\Assignment;
use App\Services\Mobile\TeacherPublishingService;
use App\Services\Mobile\TeacherService;
use App\Services\PrivateFileVault;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * The teacher surface of the mobile API.
 *
 * Every route is scoped to the classes assigned to the authenticated teacher.
 * The class id arrives in the path or the body, which means it is a claim by
 * the client and nothing more: it is checked against the assignment on every
 * call, and a refusal is written to the audit log. A teacher reading another
 * section's roster is the one failure here that a school would call a breach.
 *
 * The school id is never read from the request. It comes from the tenant
 * context the token resolved.
 */
class TeacherController extends Controller
{
    public function __construct(
        private readonly TeacherService $teachers,
        private readonly AttendanceService $attendance,
        private readonly TeacherPublishingService $publishing,
    ) {}

    /** The teacher's periods for a day, and which of them still need marking. */
    public function today(Request $request): JsonResponse
    {
        $data = $request->validate(['date' => ['nullable', 'date']]);

        return CachedPayload::respond($request, $this->teachers->today(
            (int) $request->user()->id,
            $this->schoolId($request),
            isset($data['date']) ? Carbon::parse($data['date']) : null,
        ));
    }

    /** One class's students, with any attendance already recorded for the day. */
    public function roster(Request $request, int $classId): JsonResponse
    {
        $data = $request->validate(['date' => ['nullable', 'date']]);
        $schoolId = $this->schoolId($request);

        if (! $this->teachers->canTeach((int) $request->user()->id, $schoolId, $classId)) {
            return $this->deny($request, $classId);
        }

        return CachedPayload::respond($request, $this->teachers->roster(
            $classId,
            $schoolId,
            isset($data['date']) ? Carbon::parse($data['date']) : null,
        ));
    }

    /**
     * One class's mark sheet for one subject.
     *
     * Carries the gradebook's workflow state and every score's version, so the
     * client can show a locked sheet as locked and a stale edit as stale
     * rather than discovering either at submission time.
     */
    public function gradebook(Request $request, int $classId, int $subjectId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->teachers->canTeach((int) $request->user()->id, $schoolId, $classId, $subjectId)) {
            return $this->deny($request, $classId);
        }

        return CachedPayload::respond(
            $request,
            $this->teachers->gradebook($classId, $subjectId, $schoolId),
        );
    }

    /**
     * A whole class's attendance in one write.
     *
     * `Idempotency-Key` is required. This is the endpoint an offline phone
     * drains into, so the same batch will be sent again after any timeout, and
     * the unique index on the key is what makes the second send a no-op rather
     * than a second submission.
     */
    public function attendanceBatch(Request $request): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);

        $data = $request->validate([
            'idempotency_key' => ['required', 'uuid'],
            'class_room_id' => ['required', 'integer'],
            'subject_id' => ['nullable', 'integer'],
            'course_section_id' => ['nullable', 'integer'],
            'date' => ['required', 'date'],
            'records' => ['required', 'array', 'min:1'],
            'records.*.student_user_id' => ['required', 'integer'],
            'records.*.status' => ['required', 'string', 'in:present,absent,late,excused'],
            'records.*.note' => ['nullable', 'string', 'max:500'],
        ]);

        $teacherId = (int) $request->user()->id;
        $schoolId = $this->schoolId($request);

        if (! $this->teachers->canTeach($teacherId, $schoolId, (int) $data['class_room_id'], $data['subject_id'] ?? null)) {
            return $this->deny($request, (int) $data['class_room_id'], 'class_room');
        }

        try {
            $batch = $this->attendance->markAttendance(
                collect($data)->except('idempotency_key')->all(),
                $teacherId,
                (string) $data['idempotency_key'],
            );
        } catch (\InvalidArgumentException $e) {
            // The window, an unenrolled student, a child from another class.
            // The message is the reason a teacher needs to read; it names no
            // one and carries no record.
            return $this->refuse($e->getMessage(), (string) $data['date']);
        }

        return ApiResponse::success([
            'batch_id' => (int) $batch->id,
            'class_room_id' => (int) $batch->class_room_id,
            'date' => $batch->attendance_date?->toDateString(),
            'record_count' => (int) $batch->record_count,
            'committed_at' => $batch->committed_at?->toIso8601String(),
            'attendance_window' => $this->attendance->editWindow((string) $data['date']),
        ]);
    }

    /**
     * A column of marks in one write.
     *
     * All-or-nothing, and idempotent on the key. A partially applied batch is
     * unrecoverable for an offline client: it cannot tell which half landed.
     */
    public function gradesBatch(Request $request): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);

        $data = $request->validate([
            'idempotency_key' => ['required', 'uuid'],
            'class_room_id' => ['required', 'integer'],
            'subject_id' => ['required', 'integer'],
            'grades' => ['required', 'array', 'min:1'],
            'grades.*.grade_component_id' => ['required', 'integer'],
            'grades.*.student_user_id' => ['required', 'integer'],
            'grades.*.score' => ['required', 'numeric'],
            'grades.*.version' => ['nullable', 'integer'],
            'grades.*.reason' => ['nullable', 'string', 'max:255'],
        ]);

        $teacherId = (int) $request->user()->id;
        $schoolId = $this->schoolId($request);

        if (! $this->teachers->canTeach($teacherId, $schoolId, (int) $data['class_room_id'], (int) $data['subject_id'])) {
            return $this->deny($request, (int) $data['class_room_id'], 'class_room');
        }

        try {
            $outcome = $this->teachers->submitGrades(
                collect($data)->except('idempotency_key')->all(),
                $teacherId,
                $schoolId,
                (string) $data['idempotency_key'],
            );
        } catch (HttpException $e) {
            // A closed gradebook or a stale version. Both are states the
            // teacher can act on, so the reason travels to the client.
            return ApiResponse::error(
                $e->getMessage(),
                $e->getStatusCode() === 0 ? Response::HTTP_CONFLICT : $e->getStatusCode(),
            );
        }

        return ApiResponse::success([
            'batch_id' => (int) $outcome['batch']->id,
            'replayed' => $outcome['replayed'],
            'record_count' => (int) $outcome['batch']->record_count,
            'committed_at' => $outcome['batch']->committed_at?->toIso8601String(),
        ] + (array) $outcome['batch']->result);
    }

    /* ---------- assignments ---------- */

    /** This teacher's homework for their assigned classes, with hand-in counts. */
    public function assignments(Request $request): JsonResponse
    {
        $teacherId = (int) $request->user()->id;

        return CachedPayload::respond($request, [
            'assignments' => $this->publishing->assignments(
                $teacherId,
                $this->teachers->assignedClassIds($teacherId, $this->schoolId($request)),
            ),
        ]);
    }

    /** Creates a draft. Nothing reaches a student until it is published. */
    public function createAssignment(Request $request): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);

        $data = $request->validate([
            'idempotency_key' => ['required', 'uuid'],
            'class_room_id' => ['required', 'integer'],
            'subject_id' => ['required', 'integer'],
            'title' => ['required', 'string', 'max:200'],
            'instructions' => ['required', 'string', 'max:5000'],
            'due_at' => ['required', 'date'],
            'max_score' => ['nullable', 'numeric', 'min:0'],
        ]);

        $teacherId = (int) $request->user()->id;
        $schoolId = $this->schoolId($request);

        if (! $this->teachers->canTeach($teacherId, $schoolId, (int) $data['class_room_id'], (int) $data['subject_id'])) {
            return $this->deny($request, (int) $data['class_room_id']);
        }

        $outcome = $this->publishing->createAssignment(
            collect($data)->except('idempotency_key')->all(),
            $teacherId,
            (string) $data['idempotency_key'],
        );

        return ApiResponse::success(
            $this->assignmentPayload($outcome['assignment']) + ['created' => $outcome['created']],
            $outcome['created'] ? Response::HTTP_CREATED : Response::HTTP_OK,
        );
    }

    /**
     * Attaches a file to a draft.
     *
     * Separate from creating the assignment: an upload over a school
     * connection is the step most likely to fail, and a failure here must not
     * take the text with it. The assignment survives, the attachment is
     * visibly absent, and the upload can be retried without retyping anything.
     */
    public function attachToAssignment(Request $request, int $assignmentId): JsonResponse
    {
        $assignment = $this->ownedAssignment($request, $assignmentId);
        if ($assignment === null) {
            return $this->deny($request, $assignmentId, 'assignment');
        }

        $request->validate([
            'file' => PrivateFileVault::rulesFor('assignment-attachment'),
        ]);

        try {
            $updated = $this->publishing->attach($assignment, $request->file('file'));
        } catch (\InvalidArgumentException $e) {
            // The type or the size. Said plainly, because a silent failure here
            // leaves a teacher believing the file went with the homework.
            return ApiResponse::error($e->getMessage(), Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        return ApiResponse::success($this->assignmentPayload($updated));
    }

    /**
     * Publishes a draft and notifies the class.
     *
     * A second publish is a no-op rather than a second round of notifications
     * to every family in the class.
     */
    public function publishAssignment(Request $request, int $assignmentId): JsonResponse
    {
        $assignment = $this->ownedAssignment($request, $assignmentId);
        if ($assignment === null) {
            return $this->deny($request, $assignmentId, 'assignment');
        }

        $outcome = $this->publishing->publish($assignment);

        return ApiResponse::success(
            $this->assignmentPayload($outcome['assignment'])
            + ['published_now' => $outcome['published']],
        );
    }

    /** Who has handed in, and who has not. */
    public function submissions(Request $request, int $assignmentId): JsonResponse
    {
        $assignment = $this->ownedAssignment($request, $assignmentId);
        if ($assignment === null) {
            return $this->deny($request, $assignmentId, 'assignment');
        }

        return CachedPayload::respond(
            $request,
            $this->publishing->submissions($assignment),
        );
    }

    /* ---------- announcements ---------- */

    /** The notices a teacher may send, and when they may send them. */
    public function announcementTemplates(Request $request): JsonResponse
    {
        return CachedPayload::respond($request, [
            'templates' => $this->publishing->templates(),
            'window' => $this->publishing->window(),
            'open_now' => $this->publishing->withinHours(),
        ]);
    }

    /**
     * Sends one approved notice to a class or a single guardian.
     *
     * Free text is deliberately not accepted here: one tap from a phone
     * reaches thirty households, and moderating that is not something anyone
     * on this project is staffed to do.
     */
    public function announce(Request $request): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);

        $data = $request->validate([
            'idempotency_key' => ['required', 'uuid'],
            'template_key' => ['required', 'string', 'max:64'],
            'detail' => ['nullable', 'string', 'max:500'],
            'audience' => ['required', 'string', 'regex:/^(class:\d+|guardian:\d+)$/'],
        ]);

        $teacherId = (int) $request->user()->id;
        $schoolId = $this->schoolId($request);

        if (! $this->mayAnnounceTo((string) $data['audience'], $teacherId, $schoolId)) {
            return $this->deny($request, 0, 'announcement');
        }

        try {
            $sent = $this->publishing->announce(
                (string) $data['template_key'],
                (string) ($data['detail'] ?? ''),
                (string) $data['audience'],
                $teacherId,
                $schoolId,
                (string) $data['idempotency_key'],
            );
        } catch (HttpException $e) {
            return ApiResponse::error($e->getMessage(), $e->getStatusCode(), [
                'window' => $this->publishing->window(),
            ]);
        }

        return ApiResponse::success(
            $sent,
            $sent['created'] ? Response::HTTP_CREATED : Response::HTTP_OK,
        );
    }

    /**
     * Whether this teacher may address that audience.
     *
     * A class must be one they are assigned. A guardian must be the guardian of
     * a child in one of those classes -- otherwise this endpoint is a way to
     * message any parent in the school.
     */
    private function mayAnnounceTo(string $audience, int $teacherId, int $schoolId): bool
    {
        $classIds = $this->teachers->assignedClassIds($teacherId, $schoolId);

        if (str_starts_with($audience, 'class:')) {
            return in_array((int) substr($audience, 6), $classIds, true);
        }

        if ($classIds === []) {
            return false;
        }

        return DB::table('parent_student')
            ->join('student_profiles', 'student_profiles.user_id', '=', 'parent_student.student_user_id')
            ->where('parent_student.school_id', $schoolId)
            ->where('parent_student.parent_user_id', (int) substr($audience, strlen('guardian:')))
            ->whereIn('student_profiles.class_room_id', $classIds)
            ->exists();
    }

    /**
     * The assignment, if it belongs to this teacher and an assigned class.
     *
     * Both checks: a teacher who leaves a class must not keep writing to its
     * homework merely because they created it.
     */
    private function ownedAssignment(Request $request, int $assignmentId): ?Assignment
    {
        $teacherId = (int) $request->user()->id;
        $schoolId = $this->schoolId($request);

        $assignment = Assignment::query()
            ->whereKey($assignmentId)
            ->where('school_id', $schoolId)
            ->where('teacher_user_id', $teacherId)
            ->first();

        if ($assignment === null) {
            return null;
        }

        return $this->teachers->canTeach($teacherId, $schoolId, (int) $assignment->class_room_id)
            ? $assignment
            : null;
    }

    /** @return array<string, mixed> */
    private function assignmentPayload(Assignment $assignment): array
    {
        return [
            'id' => (int) $assignment->id,
            'class_room_id' => (int) $assignment->class_room_id,
            'subject_id' => (int) $assignment->subject_id,
            'title' => $assignment->title,
            'instructions' => $assignment->instructions,
            'due_at' => $assignment->due_at?->toIso8601String(),
            'published' => $assignment->isPublished(),
            'published_at' => $assignment->published_at?->toIso8601String(),
            'has_attachment' => $assignment->attachment_path !== null,
        ];
    }

    /** Server-side, from the resolved tenant context. Never from the client. */
    private function schoolId(Request $request): int
    {
        return (int) $request->attributes->get('school_id');
    }

    private function deny(Request $request, int $id, string $entity = 'class_room'): JsonResponse
    {
        AuditLogger::log($request, 'authorization_denied', $entity, $id, [
            'guard' => 'TeacherController',
        ]);

        return ApiResponse::error(
            'You are not assigned to this class.',
            Response::HTTP_FORBIDDEN,
        );
    }

    /**
     * A refusal a teacher can act on, with the window state beside it.
     *
     * Returning a bare 422 would leave the app showing a form it cannot
     * submit and no way for the teacher to learn why.
     */
    private function refuse(string $reason, string $date): JsonResponse
    {
        $window = $this->attendance->editWindow($date);

        return ApiResponse::error($reason, Response::HTTP_UNPROCESSABLE_ENTITY, [
            'attendance_window' => $window,
        ]);
    }
}
