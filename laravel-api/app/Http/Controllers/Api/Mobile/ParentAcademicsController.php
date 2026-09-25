<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Services\AuditLogger;
use App\Services\Mobile\ParentAcademicsService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

/**
 * A child's attendance, marks and report cards.
 *
 * Scope is resolved from the school-scoped `parent_student` pivot on every
 * call. `EnsureParentOwnsChild` guards the `{studentId}` paths as well, so the
 * child-scoped routes are checked twice; the report-card paths key on an issue
 * id, which that middleware cannot interpret, and are checked here.
 */
class ParentAcademicsController extends Controller
{
    /** How far back attendance goes when the client does not say. */
    private const DEFAULT_WINDOW_DAYS = 90;

    public function __construct(private readonly ParentAcademicsService $academics) {}

    public function attendance(Request $request, int $studentId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        $data = $request->validate([
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $to = isset($data['to']) ? Carbon::parse($data['to']) : Carbon::today();
        $from = isset($data['from'])
            ? Carbon::parse($data['from'])
            : $to->copy()->subDays(self::DEFAULT_WINDOW_DAYS);

        // A window the wrong way round would silently return nothing, which
        // reads as "perfect attendance" on the client.
        if ($from->gt($to)) {
            return ApiResponse::validationError([
                'from' => ['The start of the window must not be after its end.'],
            ]);
        }

        return CachedPayload::respond(
            $request,
            $this->academics->attendance($studentId, $schoolId, $from, $to),
        );
    }

    public function grades(Request $request, int $studentId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        return CachedPayload::respond(
            $request,
            $this->academics->grades($studentId, $schoolId),
        );
    }

    public function reportCards(Request $request, int $studentId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        return CachedPayload::respond($request, [
            'student_user_id' => $studentId,
            'report_cards' => $this->academics->reportCards($studentId, $schoolId),
        ]);
    }

    /**
     * Streams an issued report card.
     *
     * Rendered from the issue's own snapshot, not from live marks. A report
     * card is a document a member of staff signed off at a moment in time;
     * regenerating it from today's grades would hand a parent a different
     * document under the same name.
     */
    public function reportCardPdf(Request $request, int $issueId): Response
    {
        $schoolId = $this->schoolId($request);
        $issue = $this->academics->reportCard(
            $issueId,
            $this->childIds($request, $schoolId),
            $schoolId,
        );

        // An unissued report card is not reachable, not merely hidden: there is
        // no row, so there is nothing to render and nothing to leak.
        if ($issue === null) {
            AuditLogger::log($request, 'authorization_denied', 'report_card_issue', $issueId, [
                'guard' => 'ParentAcademicsController',
            ]);

            return response('', Response::HTTP_FORBIDDEN);
        }

        $snapshot = (array) $issue->snapshot;
        $books = $snapshot['gradebooks'] ?? [];

        $enrollment = DB::table('student_enrollments')
            ->leftJoin('users', 'users.id', '=', 'student_enrollments.student_user_id')
            ->leftJoin('class_rooms', 'class_rooms.id', '=', 'student_enrollments.class_room_id')
            ->where('student_enrollments.id', $issue->student_enrollment_id)
            ->first(['users.name as student_name', 'class_rooms.name as class_name']);

        return Pdf::loadView('pdf.issued-report-card', [
            'issue' => $issue,
            'books' => $books,
            'studentName' => $enrollment->student_name ?? '—',
            'className' => $enrollment->class_name ?? null,
            'periodName' => DB::table('grading_periods')
                ->where('id', $issue->grading_period_id)
                ->value('name'),
            'subjects' => DB::table('subjects')
                ->whereIn('id', array_filter(array_column($books, 'subject_id')))
                ->pluck('name', 'id')
                ->all(),
        ])->download("report-card-{$issue->id}.pdf");
    }

    /**
     * Files a guardian's explanation for an absence.
     *
     * Idempotent, and it never changes the attendance status: only the school
     * decides whether an absence becomes excused. This is the message that
     * asks.
     */
    public function explainAbsence(Request $request, int $recordId): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate([
            'reason' => ['required', 'string', 'min:3', 'max:1000'],
            'idempotency_key' => ['required', 'uuid'],
        ]);

        $schoolId = $this->schoolId($request);
        $childIds = $this->childIds($request, $schoolId);

        $ownerId = DB::table('attendance_records')
            ->where('id', $recordId)
            ->where('school_id', $schoolId)
            ->value('student_user_id');

        if ($ownerId === null || ! in_array((int) $ownerId, $childIds, true)) {
            return $this->deny($request, $recordId, 'attendance_record');
        }

        $result = $this->academics->explainAbsence(
            $request,
            $recordId,
            $request->user()->id,
            $schoolId,
            $data['reason'],
            $data['idempotency_key'],
        );

        return ApiResponse::success([
            'id' => $result['explanation']->id,
            'attendance_record_id' => $recordId,
            'reason' => $result['explanation']->reason,
            'created_at' => $result['explanation']->created_at?->toIso8601String(),
        ], $result['created'] ? Response::HTTP_CREATED : Response::HTTP_OK);
    }

    /* ---------- scope ---------- */

    private function schoolId(Request $request): int
    {
        // Server-side, from the resolved tenant context. Never from the client.
        return (int) $request->attributes->get('school_id');
    }

    /** @return list<int> */
    private function childIds(Request $request, int $schoolId): array
    {
        return DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->where('parent_user_id', $request->user()->id)
            ->pluck('student_user_id')
            ->map(static fn ($id): int => (int) $id)
            ->all();
    }

    private function owns(Request $request, int $childId, int $schoolId): bool
    {
        return in_array($childId, $this->childIds($request, $schoolId), true);
    }

    private function deny(Request $request, int $id, string $entity = 'student'): JsonResponse
    {
        AuditLogger::log($request, 'authorization_denied', $entity, $id, [
            'guard' => 'ParentAcademicsController',
        ]);

        return ApiResponse::error(
            'You do not have access to this record.',
            Response::HTTP_FORBIDDEN,
        );
    }
}
