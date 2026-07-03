<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Checks whether the user account referenced in the login request is locked
 * due to excessive failed login attempts.
 *
 * Applied BEFORE the login action; it inspects the email field and checks
 * the `locked_until` column. After a successful login the controller must
 * reset `login_attempts` to 0.
 */
class AccountLockout
{
    /** Maximum allowed consecutive failures before lockout. */
    private const MAX_ATTEMPTS = 5;

    /** Minutes the account stays locked. */
    private const LOCKOUT_MINUTES = 15;

    public function handle(Request $request, Closure $next): Response
    {
        $email = $request->input('email');

        if ($email) {
            $user = User::where('email', $email)->first();

            if ($user && $user->locked_until && now()->lt($user->locked_until)) {
                $minutes = (int) now()->diffInMinutes($user->locked_until, false);

                return response()->json([
                    'message' => "Account locked due to too many failed attempts. Try again in {$minutes} minute(s).",
                    'locked_until' => $user->locked_until->toIso8601String(),
                ], 429);
            }
        }

        return $next($request);
    }

    /**
     * Record a failed login attempt. Called by the AuthController on bad credentials.
     */
    public static function recordFailure(string $email): void
    {
        $user = User::where('email', $email)->first();
        if (! $user) {
            return;
        }

        $attempts = $user->login_attempts + 1;
        $update = ['login_attempts' => $attempts];

        if ($attempts >= self::MAX_ATTEMPTS) {
            $update['locked_until'] = now()->addMinutes(self::LOCKOUT_MINUTES);
        }

        $user->update($update);
    }

    /**
     * Clear login attempts after a successful login.
     */
    public static function clearAttempts(User $user): void
    {
        if ($user->login_attempts > 0 || $user->locked_until) {
            $user->update(['login_attempts' => 0, 'locked_until' => null]);
        }
    }
}
