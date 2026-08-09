<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PersonalAccessToken;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\CurrentSchool;
use App\Services\TokenIssuer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use PragmaRX\Google2FA\Google2FA;
use Symfony\Component\HttpFoundation\Cookie;

class MfaController extends Controller
{
    public function __construct(
        private readonly Google2FA $totp,
        private readonly TokenIssuer $tokenIssuer,
        private readonly CurrentSchool $currentSchool,
    ) {}

    public function enroll(Request $request)
    {
        $user = $request->user();
        abort_if($user->mfa_confirmed_at, 409, 'MFA is already enrolled.');

        if (! $user->mfa_secret) {
            $user->forceFill(['mfa_secret' => $this->totp->generateSecretKey(32)])->save();
        }

        AuditLogger::log($request, 'mfa_enrollment_started', 'user', $user->id, [], $user->id);

        return response()->json([
            'secret' => $user->mfa_secret,
            'otpauth_url' => $this->totp->getQRCodeUrl(config('app.name'), $user->email, $user->mfa_secret),
        ])->header('Cache-Control', 'no-store');
    }

    public function confirm(Request $request)
    {
        $data = $request->validate([
            'code' => ['required', 'digits:6'],
            'device_name' => ['nullable', 'string', 'max:255'],
        ]);

        $result = DB::transaction(function () use ($request, $data) {
            /** @var User $user */
            $user = User::query()->lockForUpdate()->findOrFail($request->user()->id);
            abort_if($user->mfa_confirmed_at, 409, 'MFA is already enrolled.');
            abort_unless($user->mfa_secret, 409, 'Start MFA enrollment first.');

            $timestep = $this->verifyTotp($user->mfa_secret, $data['code'], null);
            if ($timestep === false) {
                AuditLogger::log($request, 'mfa_enrollment_failed', 'user', $user->id, [], $user->id);
                throw ValidationException::withMessages(['code' => ['Invalid authentication code.']]);
            }

            [$plainCodes, $hashedCodes] = $this->newRecoveryCodes();
            $user->forceFill([
                'mfa_confirmed_at' => now(),
                'mfa_last_used_timestep' => $timestep,
                'mfa_recovery_codes' => $hashedCodes,
            ])->save();

            $this->revokeLimitedFamily($request);
            $tokens = $this->tokenIssuer->pair($user, $data['device_name'] ?? 'web');

            return [$user, $tokens, $plainCodes];
        });

        [$user, $tokens, $plainCodes] = $result;
        AuditLogger::log($request, 'mfa_enrolled', 'user', $user->id, [], $user->id);

        return $this->authenticatedResponse($request, $tokens, [
            'recovery_codes' => $plainCodes,
            'message' => 'MFA enrolled. Store these recovery codes securely; they are shown only once.',
        ]);
    }

    public function challenge(Request $request)
    {
        $data = $request->validate([
            'code' => ['nullable', 'digits:6', 'required_without:recovery_code'],
            'recovery_code' => ['nullable', 'string', 'required_without:code'],
            'device_name' => ['nullable', 'string', 'max:255'],
        ]);

        $result = DB::transaction(function () use ($request, $data) {
            /** @var User $user */
            $user = User::query()->lockForUpdate()->findOrFail($request->user()->id);
            abort_unless($user->mfa_confirmed_at && $user->mfa_secret, 409, 'MFA enrollment is incomplete.');

            $usedRecovery = false;
            if (! empty($data['recovery_code'])) {
                $codes = $user->mfa_recovery_codes ?? [];
                $matched = null;
                foreach ($codes as $index => $hash) {
                    if (Hash::check($this->normalizeRecoveryCode($data['recovery_code']), $hash)) {
                        $matched = $index;
                        break;
                    }
                }
                if ($matched !== null) {
                    unset($codes[$matched]);
                    $user->forceFill([
                        'mfa_recovery_codes' => array_values($codes),
                        'mfa_recovery_used_at' => now(),
                    ])->save();
                    $usedRecovery = true;
                }
            } else {
                $timestep = $this->verifyTotp($user->mfa_secret, $data['code'], $user->mfa_last_used_timestep);
                if ($timestep !== false) {
                    $user->forceFill(['mfa_last_used_timestep' => $timestep])->save();
                }
            }

            $valid = $usedRecovery || isset($timestep) && $timestep !== false;
            if (! $valid) {
                AuditLogger::log($request, 'mfa_challenge_failed', 'user', $user->id, [], $user->id);
                throw ValidationException::withMessages(['code' => ['Invalid authentication or recovery code.']]);
            }

            $this->revokeLimitedFamily($request);

            return [$user, $this->tokenIssuer->pair($user, $data['device_name'] ?? 'web'), $usedRecovery];
        });

        [$user, $tokens, $usedRecovery] = $result;
        AuditLogger::log($request, $usedRecovery ? 'mfa_recovery_code_used' : 'mfa_challenge_succeeded', 'user', $user->id, [], $user->id);

        return $this->authenticatedResponse($request, $tokens);
    }

    public function regenerateRecoveryCodes(Request $request)
    {
        $data = $request->validate([
            'password' => ['required', 'string'],
            'code' => ['required', 'digits:6'],
        ]);
        $user = $request->user();
        if (! Hash::check($data['password'], $user->password)) {
            throw ValidationException::withMessages(['password' => ['Incorrect password.']]);
        }
        $timestep = $this->verifyTotp($user->mfa_secret, $data['code'], $user->mfa_last_used_timestep);
        if ($timestep === false) {
            throw ValidationException::withMessages(['code' => ['Invalid authentication code.']]);
        }
        [$plainCodes, $hashedCodes] = $this->newRecoveryCodes();
        $user->forceFill(['mfa_recovery_codes' => $hashedCodes, 'mfa_last_used_timestep' => $timestep])->save();
        AuditLogger::log($request, 'mfa_recovery_codes_regenerated', 'user', $user->id, [], $user->id);

        return response()->json(['recovery_codes' => $plainCodes])->header('Cache-Control', 'no-store');
    }

    public function disable(Request $request)
    {
        $data = $request->validate(['password' => ['required', 'string'], 'code' => ['required', 'digits:6']]);
        $user = $request->user();
        if (! Hash::check($data['password'], $user->password)) {
            throw ValidationException::withMessages(['password' => ['Incorrect password.']]);
        }
        $timestep = $this->verifyTotp($user->mfa_secret, $data['code'], $user->mfa_last_used_timestep);
        if ($timestep === false) {
            throw ValidationException::withMessages(['code' => ['Invalid authentication code.']]);
        }

        DB::transaction(function () use ($user) {
            $user->forceFill([
                'mfa_secret' => null, 'mfa_recovery_codes' => null, 'mfa_confirmed_at' => null,
                'mfa_last_used_timestep' => null, 'mfa_recovery_used_at' => null,
            ])->save();
            $user->tokens()->delete();
        });
        AuditLogger::log($request, 'mfa_disabled', 'user', $user->id, [], $user->id);

        return response()->json(['message' => 'MFA disabled. A required account must enroll again at its next login.']);
    }

    public function requestHelpDeskRecovery(Request $request, int $userId)
    {
        $data = $request->validate(['reason' => ['required', 'string', 'max:2000']]);
        abort_if($request->user()->id === $userId, 422, 'Administrators cannot request their own MFA reset.');
        $target = User::whereKey($userId)
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $this->currentSchool->id()))
            ->firstOrFail();
        abort_unless($target->mfa_confirmed_at, 409, 'The target user does not have enrolled MFA.');
        $id = DB::table('mfa_recovery_requests')->insertGetId([
            'school_id' => $this->currentSchool->id(),
            'target_user_id' => $target->id, 'requested_by' => $request->user()->id,
            'reason' => $data['reason'], 'status' => 'pending', 'created_at' => now(), 'updated_at' => now(),
        ]);
        AuditLogger::log($request, 'mfa_helpdesk_recovery_requested', 'mfa_recovery_request', $id, ['target_user_id' => $target->id]);

        return response()->json(['data' => DB::table('mfa_recovery_requests')->where('school_id', $this->currentSchool->id())->find($id)], 201);
    }

    public function approveHelpDeskRecovery(Request $request, int $requestId)
    {
        $recovery = DB::transaction(function () use ($request, $requestId) {
            $recovery = DB::table('mfa_recovery_requests')->where('school_id', $this->currentSchool->id())
                ->where('id', $requestId)->lockForUpdate()->first();
            abort_unless($recovery, 404);
            abort_unless($recovery->status === 'pending', 409, 'This MFA recovery request is no longer pending.');
            abort_if($recovery->requested_by === $request->user()->id, 422, 'A second administrator must approve this reset.');
            $target = User::query()->lockForUpdate()->findOrFail($recovery->target_user_id);
            $target->forceFill([
                'mfa_secret' => null, 'mfa_recovery_codes' => null, 'mfa_confirmed_at' => null,
                'mfa_last_used_timestep' => null, 'mfa_recovery_used_at' => null,
            ])->save();
            $target->tokens()->delete();
            DB::table('mfa_recovery_requests')->where('school_id', $this->currentSchool->id())->where('id', $requestId)->update([
                'status' => 'approved', 'approved_by' => $request->user()->id,
                'approved_at' => now(), 'updated_at' => now(),
            ]);

            return DB::table('mfa_recovery_requests')->where('school_id', $this->currentSchool->id())->find($requestId);
        });
        AuditLogger::log($request, 'mfa_helpdesk_recovery_approved', 'mfa_recovery_request', $requestId, ['target_user_id' => $recovery->target_user_id]);

        return response()->json(['data' => $recovery]);
    }

    /** @return array{0:array<int,string>,1:array<int,string>} */
    private function newRecoveryCodes(): array
    {
        $plain = collect(range(1, (int) config('mfa.recovery_code_count', 10)))
            ->map(fn () => Str::upper(Str::random(5).'-'.Str::random(5)))
            ->all();

        return [$plain, array_map(fn ($code) => Hash::make($code), $plain)];
    }

    private function normalizeRecoveryCode(string $code): string
    {
        $value = strtoupper(preg_replace('/[^A-Za-z0-9]/', '', $code));

        return substr($value, 0, 5).'-'.substr($value, 5, 5);
    }

    private function verifyTotp(string $secret, string $code, ?int $oldTimestep): int|false
    {
        // google2fa returns boolean true when oldTimestamp is null, which is not
        // sufficient for replay protection. Supplying a bounded earlier counter
        // makes it return the exact accepted counter on first use as well.
        $floor = $oldTimestep ?? ($this->totp->getTimestamp() - 2);
        $result = $this->totp->verifyKeyNewer($secret, $code, $floor, 1);

        return is_int($result) ? $result : false;
    }

    private function revokeLimitedFamily(Request $request): void
    {
        $token = $request->user()->currentAccessToken();
        if ($token instanceof PersonalAccessToken) {
            PersonalAccessToken::query()
                ->where('token_family', $token->token_family)
                ->whereNull('revoked_at')
                ->update(['revoked_at' => now()]);
        }
    }

    private function tokenPayload(array $tokens): array
    {
        return [
            'token' => $tokens['access_token'],
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'token_type' => 'Bearer',
            'expires_in' => 7200,
        ];
    }

    private function authenticatedResponse(Request $request, array $tokens, array $extra = [])
    {
        $payload = $this->tokenPayload($tokens) + $extra;
        if ($request->header('X-Auth-Mode') !== 'cookie') {
            return response()->json($payload)->header('Cache-Control', 'no-store');
        }

        unset($payload['token'], $payload['access_token'], $payload['refresh_token']);

        return response()->json($payload)
            ->withCookie($this->webCookie(config('web-auth.access_cookie'), Crypt::encryptString($tokens['access_token']), config('web-auth.access_minutes'), '/api'))
            ->withCookie($this->webCookie(config('web-auth.refresh_cookie'), Crypt::encryptString($tokens['refresh_token']), config('web-auth.refresh_minutes'), '/api/auth/refresh'))
            ->header('Cache-Control', 'no-store');
    }

    private function webCookie(string $name, string $value, int $minutes, string $path): Cookie
    {
        return new Cookie(
            $name, $value, now()->addMinutes($minutes), $path, config('web-auth.domain'),
            (bool) config('web-auth.secure'), true, false, config('web-auth.same_site'),
        );
    }
}
