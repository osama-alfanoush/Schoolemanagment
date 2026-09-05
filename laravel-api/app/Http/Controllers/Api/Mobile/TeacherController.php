<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Services\AttendanceService;
use App\Services\AuditLogger;
use App\Services\Mobile\TeacherService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
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
