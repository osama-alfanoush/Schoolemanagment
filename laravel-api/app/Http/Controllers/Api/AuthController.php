<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Middleware\AccountLockout;
use App\Models\PushToken;
use App\Models\User;
use App\Services\AuditLogger;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Laravel\Sanctum\PersonalAccessToken;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email:rfc,strict',
            'password' => 'required',
            'device_name' => 'nullable|string',
        ]);

        $user = User::where('email', $data['email'])->first();

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

        // Track last login
        $user->update(['last_login_at' => now()]);

        $deviceName = $data['device_name'] ?? 'web';
        // Issue access token (short-lived) and refresh token (long-lived).
        // Sanctum personal access tokens — names disambiguate the two grants.
        $access = $user->createToken("access:$deviceName", ['*'], now()->addHours(2))->plainTextToken;
        $refresh = $user->createToken("refresh:$deviceName", ['refresh'], now()->addDays(30))->plainTextToken;

        AuditLogger::log($request, 'login', 'user', $user->id, [], $user->id);

        return response()->json([
            'token' => $access,           // alias kept for backwards compatibility
            'access_token' => $access,
            'refresh_token' => $refresh,
            'token_type' => 'Bearer',
            'expires_in' => 7200,
            'must_change_password' => (bool) $user->must_change_password,
            'user' => $user->load(['studentProfile.classRoom', 'staffProfile', 'children.studentProfile']),
        ]);
    }

    /**
     * Exchange a valid refresh token for a fresh access + refresh pair.
     * Caller passes the refresh token in the Authorization header.
     */
    public function refresh(Request $request)
    {
        $token = $request->user()?->currentAccessToken();
        if (! $token || ! in_array('refresh', $token->abilities ?? [], true)) {
            return response()->json(['message' => 'Invalid refresh token'], 401);
        }
        $user = $request->user();
        $deviceName = Str::after($token->name, ':') ?: 'web';
        $token->delete(); // rotate

        $access = $user->createToken("access:$deviceName", ['*'], now()->addHours(2))->plainTextToken;
        $refresh = $user->createToken("refresh:$deviceName", ['refresh'], now()->addDays(30))->plainTextToken;

        return response()->json([
            'access_token' => $access,
            'refresh_token' => $refresh,
            'token_type' => 'Bearer',
            'expires_in' => 7200,
        ]);
    }

    public function me(Request $request)
    {
        return response()->json([
            'user' => $request->user()->load(['studentProfile.classRoom', 'staffProfile', 'children.studentProfile']),
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

        return response()->json(['message' => 'Logged out']);
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
     * Upload a profile photo (multipart). Stored on the public disk; the public URL
     * is persisted on the user record.
     */
    public function uploadProfilePhoto(Request $request)
    {
        $request->validate([
            'photo' => 'required|file|image|mimes:jpg,jpeg,png,webp|max:5120',
        ]);
        $user = $request->user();
        // Remove previous file when present
        if ($user->photo_path) {
            Storage::disk('public')->delete($user->photo_path);
        }
        $path = $request->file('photo')->store("profile-photos/{$user->id}", 'public');
        $user->update(['photo_path' => $path]);

        return response()->json([
            'message' => 'Photo updated',
            'photo_path' => $path,
            'photo_url' => Storage::disk('public')->url($path),
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
        $user->update([
            'password' => Hash::make($data['new_password']),
            'must_change_password' => false,
        ]);

        return response()->json(['message' => 'Password updated']);
    }

    /**
     * Send a password-reset link to the user's email.
     * Uses Laravel's built-in Password broker; mailer is configurable via MAIL_*.
     */
    public function forgotPassword(Request $request)
    {
        $data = $request->validate(['email' => 'required|email:rfc,strict']);
        $status = Password::sendResetLink($data);

        return response()->json([
            'message' => __($status),
            'status' => $status,
        ], $status === Password::RESET_LINK_SENT ? 200 : 422);
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
}
