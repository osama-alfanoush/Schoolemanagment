<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Models\Message;
use App\Services\AuditLogger;
use App\Services\Mobile\ParentInboxService;
use App\Services\Notifier;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

/**
 * Notifications, messages, timetable and the child profile.
 */
class ParentInboxController extends Controller
{
    public function __construct(private readonly ParentInboxService $inbox) {}

    /* ---------- notifications ---------- */

    public function notifications(Request $request): JsonResponse
    {
        return ApiResponse::success(
            $this->inbox->notifications($request->user()->id),
        );
    }

    public function markRead(Request $request, int $notificationId): JsonResponse
    {
        // Silent when it was already read: a client replaying a tap should see
        // the same answer, not an error about state it cannot control.
        $this->inbox->markRead($notificationId, $request->user()->id);

        return ApiResponse::success(['id' => $notificationId, 'read' => true]);
    }

    public function preferences(Request $request): JsonResponse
    {
        return ApiResponse::success(
            $this->inbox->preferences($request->user()->id),
        );
    }

    /**
     * Toggles notification categories.
     *
     * Only the categories named are touched. Sending the whole map on every
     * toggle is how muting grades quietly mutes fee reminders.
     */
    public function updatePreferences(Request $request): JsonResponse
    {
        $data = $request->validate([
            'categories' => ['nullable', 'array'],
            'categories.*' => ['boolean'],
            'push_enabled' => ['nullable', 'boolean'],
        ]);

        $requested = array_keys($data['categories'] ?? []);
        $mutable = (array) config('mobile.notification_categories', []);
        $alwaysOn = (array) config('mobile.always_on_categories', []);

        // Refused, not silently ignored. A switch that appears to work and does
        // not is worse than no switch.
        $locked = array_values(array_intersect($requested, $alwaysOn));
        if ($locked !== []) {
            return ApiResponse::validationError([
                'categories' => ['These categories always deliver and cannot be muted: '.implode(', ', $locked)],
            ]);
        }

        $unknown = array_values(array_diff($requested, $mutable));
        if ($unknown !== []) {
            return ApiResponse::validationError([
                'categories' => ['Unknown category: '.implode(', ', $unknown)],
            ]);
        }

        return ApiResponse::success($this->inbox->updatePreferences(
            $request->user()->id,
            $data['categories'] ?? [],
            $data['push_enabled'] ?? null,
        ));
    }

    /* ---------- messages ---------- */

    public function threads(Request $request): JsonResponse
    {
        return ApiResponse::success([
            'threads' => $this->inbox->threads($request->user()->id),
        ]);
    }

    public function conversation(Request $request, int $otherId): JsonResponse
    {
        return ApiResponse::success(
            $this->inbox->conversation($request->user()->id, $otherId),
        );
    }

    /**
     * Replies to a thread staff opened.
     *
     * A guardian cannot start a thread from here and cannot reply outside the
     * school's hours. Both refusals are explicit, so the client can say why
     * rather than showing a disabled button with no explanation.
     */
    public function reply(Request $request, int $otherId): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate([
            'body' => ['required', 'string', 'min:1', 'max:5000'],
            'idempotency_key' => ['required', 'uuid'],
        ]);

        $userId = $request->user()->id;

        if (! $this->inbox->staffOpenedThread($userId, $otherId)) {
            AuditLogger::log($request, 'message_initiation_refused', 'user', $otherId, [
                'reason' => 'thread_not_opened_by_staff',
            ], $userId);

            return ApiResponse::error(
                'You can reply to messages the school sends you, but you cannot start a new conversation here.',
                Response::HTTP_FORBIDDEN,
            );
        }

        if (! $this->inbox->withinReplyHours()) {
            return ApiResponse::error(
                'Messages can only be sent during school hours.',
                Response::HTTP_CONFLICT,
            );
        }

        $body = trim($data['body']);

        // Idempotent by content within the thread: a retried send must not
        // post the same reply twice.
        $existing = Message::query()
            ->where('sender_user_id', $userId)
            ->where('recipient_user_id', $otherId)
            ->where('body', $body)
            ->where('created_at', '>=', now()->subMinutes(10))
            ->first();

        if ($existing !== null) {
            return ApiResponse::success([
                'id' => $existing->id,
                'body' => $existing->body,
                'sent_at' => $existing->created_at?->toIso8601String(),
            ]);
        }

        $message = Message::create([
            'sender_user_id' => $userId,
            'recipient_user_id' => $otherId,
            'body' => $body,
        ]);

        Notifier::send($otherId, 'message', 'New message', mb_substr($body, 0, 100), [
            'from' => $userId,
        ]);

        return ApiResponse::success([
            'id' => $message->id,
            'body' => $message->body,
            'sent_at' => $message->created_at?->toIso8601String(),
        ], Response::HTTP_CREATED);
    }

    /* ---------- timetable and profile ---------- */

    public function timetable(Request $request, int $studentId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        return CachedPayload::respond(
            $request,
            $this->inbox->timetable($studentId, $schoolId),
        );
    }

    public function requestCorrection(Request $request, int $studentId): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate([
            'field' => ['required', 'string', 'max:64'],
            'detail' => ['required', 'string', 'min:3', 'max:2000'],
            'idempotency_key' => ['required', 'uuid'],
        ]);

        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        $result = $this->inbox->requestCorrection(
            $request,
            $studentId,
            $request->user()->id,
            $schoolId,
            $data['field'],
            $data['detail'],
            $data['idempotency_key'],
        );

        return ApiResponse::success([
            'id' => $result['request']->id,
            'field' => $result['request']->field,
            'status' => $result['request']->status,
        ], $result['created'] ? Response::HTTP_CREATED : Response::HTTP_OK);
    }

    /* ---------- scope ---------- */

    private function schoolId(Request $request): int
    {
        return (int) $request->attributes->get('school_id');
    }

    private function owns(Request $request, int $childId, int $schoolId): bool
    {
        return DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->where('parent_user_id', $request->user()->id)
            ->where('student_user_id', $childId)
            ->exists();
    }

    private function deny(Request $request, int $id): JsonResponse
    {
        AuditLogger::log($request, 'authorization_denied', 'student', $id, [
            'guard' => 'ParentInboxController',
        ]);

        return ApiResponse::error(
            'You do not have access to this record.',
            Response::HTTP_FORBIDDEN,
        );
    }
}
