<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\User;
use App\Services\Mobile\InvalidInviteCode;
use App\Services\Mobile\ParentInviteService;
use App\Services\SchoolContext;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use RuntimeException;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class ParentInviteController extends Controller
{
    public function __construct(
        private readonly ParentInviteService $invites,
        private readonly SchoolContext $schools,
    ) {}

    /**
     * Issue a guardian activation code.
     *
     * The plaintext code is in this response and nowhere else — it is not
     * stored, logged or recoverable. The office prints it or reads it out; if
     * it is lost, a new one is issued and the old one stops working.
     */
    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'guardian_user_id' => ['required', 'integer'],
            'valid_for_days' => ['nullable', 'integer', 'min:1', 'max:60'],
        ]);

        // Resolved through the school-scoped User query, so an admin cannot
        // issue a code for a guardian in another school by id.
        $guardian = User::query()->find($data['guardian_user_id']);

        if ($guardian === null) {
            return ApiResponse::notFound('Guardian not found.');
        }

        try {
            $issued = $this->invites->issue(
                $request,
                $guardian,
                $request->user(),
                (int) ($data['valid_for_days'] ?? 14),
            );
        } catch (RuntimeException $e) {
            return ApiResponse::error($e->getMessage(), 422);
        }

        return ApiResponse::created([
            'code' => $issued['code'],
            'guardian_user_id' => $guardian->id,
            'expires_at' => $issued['invite']->expires_at->toIso8601String(),
        ]);
    }

    /**
     * Activate a guardian account from a school-issued code.
     *
     * Public, because the guardian has no session yet and no password to sign
     * in with — that is the whole point. Rate limited at the route, single-use
     * and attempt-capped in the service.
     *
     * `device_id` is required, not optional as it is on login: the refresh
     * family this creates is bound to it, and a session that cannot be revoked
     * remotely must not be issued at all.
     */
    public function activate(Request $request): JsonResponse
    {
        $data = $request->validate([
            'code' => ['required', 'string', 'min:8', 'max:32'],
            'device_id' => ['required', 'string', 'max:255'],
            'device_name' => ['nullable', 'string', 'max:255'],
        ]);

        try {
            $result = $this->invites->redeem(
                $request,
                $data['code'],
                $data['device_id'],
                $data['device_name'] ?? 'android',
            );
        } catch (InvalidInviteCode $e) {
            return ApiResponse::error($e->getMessage(), 422);
        }

        $guardian = $result['user'];

        try {
            // A token is never issued without an unambiguous active tenant,
            // exactly as on login.
            $schoolId = $this->schools->forUser($guardian);
        } catch (AccessDeniedHttpException $e) {
            return ApiResponse::error('This account has no active school assignment.', 403);
        }

        return response()->json([
            'access_token' => $result['tokens']['access_token'],
            'refresh_token' => $result['tokens']['refresh_token'],
            'token_type' => 'Bearer',
            'must_change_password' => false,
            'user' => [
                'id' => $guardian->id,
                'name' => $guardian->name,
                'role' => $guardian->role,
                'school_id' => $schoolId,
            ],
        ])->header('Cache-Control', 'no-store');
    }
}
