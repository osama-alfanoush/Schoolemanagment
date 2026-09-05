<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Services\Mobile\StudentService;
use App\Services\PrivateFileVault;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * The student surface of the mobile API.
 *
 * **Self only.** Every route resolves the student from the authenticated
 * token; not one of them accepts a student id in a path, a query string or a
 * body. That is the design, not an omission: cross-student access is the
 * highest-risk failure on the whole mobile surface, and a parameter that does
 * not exist cannot be forged, guessed or enumerated.
 *
 * There is deliberately nothing here that reaches another student — no
 * classmate list, no peer ranking, no student-to-student messaging. Each would
 * be a safeguarding surface with a moderation obligation nobody on this
 * project is staffed to carry.
 */
class StudentController extends Controller
{
    /** How far back attendance goes when the client does not say. */
    private const DEFAULT_WINDOW_DAYS = 90;

    public function __construct(private readonly StudentService $students) {}

    public function home(Request $request): JsonResponse
    {
        return CachedPayload::respond($request, $this->students->home(
            $this->studentId($request),
            $this->schoolId($request),
        ));
    }

    public function timetable(Request $request): JsonResponse
    {
        return CachedPayload::respond($request, $this->students->timetable(
            $this->studentId($request),
            $this->schoolId($request),
        ));
    }

    public function attendance(Request $request): JsonResponse
    {
        $data = $request->validate([
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $to = isset($data['to']) ? Carbon::parse($data['to']) : Carbon::today();
        $from = isset($data['from'])
            ? Carbon::parse($data['from'])
            : $to->copy()->subDays(self::DEFAULT_WINDOW_DAYS);

        // A window the wrong way round would silently return nothing, which
        // reads on the screen as perfect attendance.
        if ($from->gt($to)) {
            return ApiResponse::validationError([
                'from' => ['The start of the window must not be after its end.'],
            ]);
        }

        return CachedPayload::respond($request, $this->students->attendance(
            $this->studentId($request),
            $this->schoolId($request),
            $from,
            $to,
        ));
    }

    public function grades(Request $request): JsonResponse
    {
        return CachedPayload::respond($request, $this->students->grades(
            $this->studentId($request),
            $this->schoolId($request),
        ));
    }

    public function assignments(Request $request): JsonResponse
    {
        return CachedPayload::respond($request, $this->students->assignments(
            $this->studentId($request),
            $this->schoolId($request),
        ));
    }

    /**
     * Hands in one piece of work.
     *
     * `Idempotency-Key` is required. A phone that retries an upload after a
     * timeout must not be told its work conflicts with itself.
     */
    public function submit(Request $request, int $assignmentId): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);

        $data = $request->validate([
            'idempotency_key' => ['required', 'uuid'],
            'content_text' => ['nullable', 'string', 'max:20000'],
            'file' => array_merge(['nullable'], PrivateFileVault::rulesFor('submission')),
        ]);

        if (($data['content_text'] ?? null) === null && ! $request->hasFile('file')) {
            return ApiResponse::validationError([
                'content_text' => ['Hand in some text or a file.'],
            ]);
        }

        try {
            $outcome = $this->students->submit(
                $assignmentId,
                $this->studentId($request),
                $this->schoolId($request),
                (string) $data['idempotency_key'],
                $data['content_text'] ?? null,
                $request->file('file'),
            );
        } catch (HttpException $e) {
            return ApiResponse::error($e->getMessage(), $e->getStatusCode());
        } catch (\InvalidArgumentException $e) {
            // The vault refused the type or the size. Said plainly: a silent
            // failure here leaves a student believing their work went in.
            return ApiResponse::error($e->getMessage(), Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $submission = $outcome['submission'];

        return ApiResponse::success([
            'assignment_id' => (int) $submission->assignment_id,
            'status' => $submission->status,
            'submitted_at' => $submission->submitted_at?->toIso8601String(),
            'has_file' => $submission->file_path !== null,
            'created' => $outcome['created'],
        ], $outcome['created'] ? Response::HTTP_CREATED : Response::HTTP_OK);
    }

    /**
     * The authenticated student. Never a parameter.
     *
     * This method is the whole access-control story for this controller, which
     * is why it is one line and has no arguments to get wrong.
     */
    private function studentId(Request $request): int
    {
        return (int) $request->user()->id;
    }

    /** Server-side, from the resolved tenant context. Never from the client. */
    private function schoolId(Request $request): int
    {
        return (int) $request->attributes->get('school_id');
    }
}
