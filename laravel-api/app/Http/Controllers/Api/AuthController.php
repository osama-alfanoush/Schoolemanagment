<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Middleware\AccountLockout;
use App\Models\PersonalAccessToken;
use App\Models\PushToken;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\CurrentSchool;
use App\Services\SchoolContext;
use App\Services\TokenIssuer;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpFoundation\Cookie;

class AuthController extends Controller
{
    public function __construct(
        private readonly TokenIssuer $tokenIssuer,
        private readonly SchoolContext $schools,
        private readonly CurrentSchool $currentSchool,
    ) {}

    public function csrfCookie(): JsonResponse
    {
        $token = Str::random(64);

        return response()->json(['csrf_token' => $token])
            ->withCookie($this->webCookie(
                config('web-auth.csrf_cookie'),
                $token,
                config('web-auth.refresh_minutes'),
                '/',
                false,
            ))
            ->header('Cache-Control', 'no-store');
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email:rfc,strict',
            'password' => 'required',
            'device_name' => 'nullable|string',
        ]);

        $data['email'] = Str::lower(trim($data['email']));
        $user = User::whereRaw('LOWER(email) = ?', [$data['email']])->first();

        // Always perform a hash check, even when the user doesn't exist, so the
        // response time doesn't reveal whether an email is registered.
        $hash = $user->password ?? Hash::make(Str::random(40));
        $passwordValid = Hash::check($data['password'], $hash);

        if (! $user || ! $passwordValid || ! $user->is_active) {
            // Record failed attempt for account lockout
            if ($user) {
                AccountLockout::recordFailure($data['email']);
            }
            throw ValidationException::withMessages(['email' => ['Invalid credentials.']]);
        }

        // Clear lockout counter on successful login
        AccountLockout::clearAttempts($user);

        // A token is never issued without an unambiguous active tenant. This
        // also prevents the login response from exposing unscoped relations.
        $schoolId = $this->schools->forUser($user);

        // Track last login
        $user->update(['last_login_at' => now()]);

        $deviceName = $data['device_name'] ?? 'web';
        // Issue access token (short-lived) and refresh token (long-lived).
        // Sanctum personal access tokens — names disambiguate the two grants.
        if ($user->requiresMfa()) {
            $enrollmentRequired = ! $user->mfa_confirmed_at;
            $ability = $enrollmentRequired ? 'mfa-enroll' : 'mfa-challenge';
            $minutes = (int) config($enrollmentRequired ? 'mfa.enrollment_minutes' : 'mfa.challenge_minutes');
            $limited = $this->tokenIssuer->limited($user, $ability, $deviceName, $minutes);

            $this->currentSchool->run($schoolId, fn () => AuditLogger::log(
                $request,
                'mfa_challenge_issued',
                'user',
                $user->id,
                ['enrollment_required' => $enrollmentRequired, 'device_name' => $deviceName],
                $user->id,
            ));

            return response()->json([
                'mfa_required' => true,
                'mfa_enrollment_required' => $enrollmentRequired,
                'mfa_token' => $limited['token'],
                'token_type' => 'Bearer',
                'expires_in' => $limited['expires_in'],
            ], 202)->header('Cache-Control', 'no-store');
        }

        $tokens = $this->tokenIssuer->pair($user, $deviceName);

        $this->currentSchool->run($schoolId, fn () => AuditLogger::log(
            $request,
            'login',
            'user',
            $user->id,
            [],
            $user->id,
        ));

        $payload = [
            'token' => $tokens['access_token'], // alias kept for backwards compatibility
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'token_type' => 'Bearer',
            'expires_in' => 7200,
            'must_change_password' => (bool) $user->must_change_password,
            'user' => $this->currentSchool->run(
                $schoolId,
                fn () => $user->load(['studentProfile.classRoom', 'staffProfile', 'children.studentProfile']),
            ),
        ];

        if (! $this->usesWebCookies($request)) {
            return response()->json($payload);
        }

        // The browser receives identity data only. Both credentials stay in
        // encrypted, scoped, httpOnly cookies and are never exposed to JS.
        unset($payload['token'], $payload['access_token'], $payload['refresh_token']);

        return response()->json($payload)
            ->withCookie($this->webCookie(
                config('web-auth.access_cookie'),
                Crypt::encryptString($tokens['access_token']),
                config('web-auth.access_minutes'),
                '/api',
            ))
            ->withCookie($this->webCookie(
                config('web-auth.refresh_cookie'),
                Crypt::encryptString($tokens['refresh_token']),
                config('web-auth.refresh_minutes'),
                '/api/auth/refresh',
            ));
    }

    /**
     * Exchange a valid refresh token for a fresh access + refresh pair.
     * Caller passes the refresh token in the Authorization header.
     */
    public function refresh(Request $request)
    {
        $token = $request->user()?->currentAccessToken();
        if (! $token instanceof PersonalAccessToken || ! $token->can('refresh')) {
            return response()->json(['message' => 'Invalid refresh token'], 401);
        }

        $user = $request->user();
        $deviceName = $token->device_name ?: (Str::after($token->name, ':') ?: 'web');
        $reused = false;

        $tokens = DB::transaction(function () use ($token, $user, $deviceName, &$reused) {
            /** @var PersonalAccessToken|null $lockedToken */
            $lockedToken = PersonalAccessToken::query()->lockForUpdate()->find($token->id);
            if (! $lockedToken || $lockedToken->rotated_at || $lockedToken->revoked_at) {
                $reused = true;
                if ($lockedToken?->token_family) {
                    PersonalAccessToken::where('token_family', $lockedToken->token_family)
                        ->whereNull('revoked_at')
                        ->update(['revoked_at' => now()]);
                }

                return null;
            }

            $family = $lockedToken->token_family ?: (string) Str::uuid();
            $familyQuery = PersonalAccessToken::where('tokenable_type', $lockedToken->tokenable_type)
                ->where('tokenable_id', $lockedToken->tokenable_id);
            if ($lockedToken->token_family) {
                $familyQuery->where('token_family', $family);
            } else {
                $familyQuery->whereIn('name', ["access:$deviceName", "refresh:$deviceName"]);
            }
            $familyQuery->whereNull('revoked_at')->update(['revoked_at' => now()]);

            $lockedToken->forceFill([
                'token_family' => $family,
                'rotated_at' => now(),
                'revoked_at' => now(),
            ])->save();

            return $this->tokenIssuer->pair($user, $deviceName, $family);
        });

        if ($reused || $tokens === null) {
            AuditLogger::log($request, 'refresh_token_reuse', 'user', $user->id, [
                'device_name' => $deviceName,
                'token_family' => $token->token_family,
            ], $user->id);

            return response()->json(['message' => 'Invalid refresh token'], 401);
        }

        $payload = [
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'token_type' => 'Bearer',
            'expires_in' => 7200,
        ];

        if (! $this->usesWebCookies($request)) {
            return response()->json($payload);
        }

        unset($payload['access_token'], $payload['refresh_token']);

        return response()->json($payload)
            ->withCookie($this->webCookie(
                config('web-auth.access_cookie'),
                Crypt::encryptString($tokens['access_token']),
                config('web-auth.access_minutes'),
                '/api',
            ))
            ->withCookie($this->webCookie(
                config('web-auth.refresh_cookie'),
                Crypt::encryptString($tokens['refresh_token']),
                config('web-auth.refresh_minutes'),
                '/api/auth/refresh',
            ));
    }

    public function me(Request $request)
    {
        return response()->json([
            'user' => $request->user()->load(['studentProfile.classRoom', 'staffProfile', 'children.studentProfile']),
            // Granular sub-module permissions so clients can gate UI. ['*'] for admin.
            'permissions' => $request->user()->allPermissionKeys(),
        ]);
    }

    public function logout(Request $request)
    {
        // Revoke only the current access token (and its matching refresh token by name prefix).
        // When authenticated via a stateful session, currentAccessToken() is a
        // TransientToken with no `name`/delete() — guard against it so logout
        // never 500s and only real personal access tokens are revoked by name.
        $current = $request->user()->currentAccessToken();
        if ($current instanceof PersonalAccessToken) {
            $deviceName = Str::after($current->name, ':') ?: 'web';
            // Delete both the access and refresh tokens for this device
            $request->user()->tokens()
                ->where(function ($q) use ($deviceName) {
                    $q->where('name', "access:$deviceName")
                        ->orWhere('name', "refresh:$deviceName");
                })->delete();
        }

        $response = response()->json(['message' => 'Logged out']);

        if ($this->usesWebCookies($request)) {
            $response
                ->withCookie($this->expiredWebCookie(config('web-auth.access_cookie'), '/api'))
                ->withCookie($this->expiredWebCookie(config('web-auth.refresh_cookie'), '/api/auth/refresh'))
                ->withCookie($this->expiredWebCookie(config('web-auth.csrf_cookie'), '/', false));
        }

        return $response;
    }

    public function updateProfile(Request $request)
    {
        $data = $request->validate([
            'name' => 'sometimes|string|max:255',
            'phone' => 'nullable|string|max:30',
            'locale' => 'sometimes|in:en,ar',
        ]);
        $request->user()->update($data);

        return response()->json(['user' => $request->user()->fresh()]);
    }

    /**
     * Upload a profile photo (multipart). Stored on the configured uploads disk; the public URL
     * is persisted on the user record.
     */
    public function uploadProfilePhoto(Request $request)
    {
        $request->validate([
            'photo' => 'required|file|image|mimes:jpg,jpeg,png,webp|max:5120',
        ]);
        $user = $request->user();
        $uploads = Storage::disk(config('filesystems.uploads_disk'));
        // Remove previous file when present
        if ($user->photo_path) {
            $uploads->delete($user->photo_path);
        }
        $path = $uploads->putFile("profile-photos/{$user->id}", $request->file('photo'), 'public');
        $user->update(['photo_path' => $path]);

        return response()->json([
            'message' => 'Photo updated',
            'photo_path' => $path,
            'photo_url' => $uploads->url($path),
            'user' => $user->fresh(),
        ]);
    }

    public function changePassword(Request $request)
    {
        $data = $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:8|regex:/[A-Z]/|regex:/[0-9]/|confirmed',
        ]);
        $user = $request->user();
        if (! Hash::check($data['current_password'], $user->password)) {
            throw ValidationException::withMessages(['current_password' => ['Incorrect password.']]);
        }
        $currentToken = $user->currentAccessToken();
        $deviceName = $currentToken instanceof PersonalAccessToken
            ? ($currentToken->device_name ?: Str::after($currentToken->name, ':'))
            : 'web';

        $tokens = DB::transaction(function () use ($user, $data, $deviceName) {
            $user->update([
                'password' => Hash::make($data['new_password']),
                'must_change_password' => false,
            ]);
            $user->tokens()->delete();

            return $this->tokenIssuer->pair($user, $deviceName ?: 'web');
        });

        AuditLogger::log($request, 'password_changed', 'user', $user->id, [], $user->id);

        $payload = [
            'message' => 'Password updated',
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'token_type' => 'Bearer',
            'expires_in' => 7200,
        ];

        if (! $this->usesWebCookies($request)) {
            return response()->json($payload);
        }

        unset($payload['access_token'], $payload['refresh_token']);

        return response()->json($payload)
            ->withCookie($this->webCookie(
                config('web-auth.access_cookie'),
                Crypt::encryptString($tokens['access_token']),
                config('web-auth.access_minutes'),
                '/api',
            ))
            ->withCookie($this->webCookie(
                config('web-auth.refresh_cookie'),
                Crypt::encryptString($tokens['refresh_token']),
                config('web-auth.refresh_minutes'),
                '/api/auth/refresh',
            ));
    }

    /**
     * Send a password-reset link to the user's email.
     * Uses Laravel's built-in Password broker; mailer is configurable via MAIL_*.
     */
    public function forgotPassword(Request $request)
    {
        $data = $request->validate(['email' => 'required|email:rfc,strict']);
        $data['email'] = Str::lower(trim($data['email']));
        Password::sendResetLink($data);

        return response()->json([
            'message' => 'If an account exists for that email, a password reset link has been sent.',
        ]);
    }

    /**
     * Reset the user's password using the token mailed by forgotPassword.
     */
    public function resetPassword(Request $request)
    {
        $data = $request->validate([
            'token' => 'required|string',
            'email' => 'required|email:rfc,strict',
            'password' => 'required|string|min:8|regex:/[A-Z]/|regex:/[0-9]/|confirmed',
        ]);
        $status = Password::reset($data, function (User $user, string $password) {
            $user->forceFill([
                'password' => Hash::make($password),
                'must_change_password' => false,
            ])->save();
            $user->tokens()->delete();
            event(new PasswordReset($user));
        });

        return response()->json([
            'message' => __($status),
            'status' => $status,
        ], $status === Password::PASSWORD_RESET ? 200 : 422);
    }

    public function registerPushToken(Request $request)
    {
        $data = $request->validate([
            'token' => 'required|string',
            'platform' => 'required|in:ios,android,web',
        ]);
        PushToken::updateOrCreate(
            ['user_id' => $request->user()->id, 'token' => $data['token']],
            ['platform' => $data['platform']]
        );

        return response()->json(['message' => 'Token registered']);
    }

    private function usesWebCookies(Request $request): bool
    {
        return $request->header('X-Auth-Mode') === 'cookie'
            || $request->attributes->get('web_cookie_auth') === true;
    }

    private function webCookie(
        string $name,
        string $value,
        int $minutes,
        string $path,
        bool $httpOnly = true,
    ): Cookie {
        return new Cookie(
            $name,
            $value,
            now()->addMinutes($minutes),
            $path,
            config('web-auth.domain'),
            (bool) config('web-auth.secure'),
            $httpOnly,
            false,
            config('web-auth.same_site'),
        );
    }

    private function expiredWebCookie(string $name, string $path, bool $httpOnly = true): Cookie
    {
        return new Cookie(
            $name,
            '',
            1,
            $path,
            config('web-auth.domain'),
            (bool) config('web-auth.secure'),
            $httpOnly,
            false,
            config('web-auth.same_site'),
        );
    }
}
