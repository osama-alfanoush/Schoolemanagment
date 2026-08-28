<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Support\Str;

class TokenIssuer
{
    /** @return array{access_token:string,refresh_token:string,token_family:string} */
    public function pair(User $user, string $deviceName, ?string $family = null, ?string $deviceId = null): array
    {
        $family ??= (string) Str::uuid();
        $deviceName = Str::limit(trim($deviceName) ?: 'unknown-device', 255, '');

        $access = $user->createToken("access:$deviceName", ['access'], now()->addHours(2));
        $access->accessToken->forceFill([
            'token_family' => $family,
            'device_name' => $deviceName,
            'device_id' => $this->normalizeDeviceId($deviceId),
        ])->save();

        $refresh = $user->createToken("refresh:$deviceName", ['refresh'], now()->addDays(30));
        $refresh->accessToken->forceFill([
            'token_family' => $family,
            'device_name' => $deviceName,
            'device_id' => $this->normalizeDeviceId($deviceId),
        ])->save();

        return [
            'access_token' => $access->plainTextToken,
            'refresh_token' => $refresh->plainTextToken,
            'token_family' => $family,
        ];
    }

    /** @return array{token:string,token_family:string,expires_in:int} */
    public function limited(User $user, string $ability, string $deviceName, int $minutes, ?string $deviceId = null): array
    {
        $family = (string) Str::uuid();
        $deviceName = Str::limit(trim($deviceName) ?: 'unknown-device', 255, '');
        $token = $user->createToken("$ability:$deviceName", [$ability], now()->addMinutes($minutes));
        $token->accessToken->forceFill([
            'token_family' => $family,
            'device_name' => $deviceName,
            'device_id' => $this->normalizeDeviceId($deviceId),
        ])->save();

        return ['token' => $token->plainTextToken, 'token_family' => $family, 'expires_in' => $minutes * 60];
    }

    private function normalizeDeviceId(?string $deviceId): ?string
    {
        $deviceId = $deviceId === null ? '' : trim($deviceId);

        return $deviceId === '' ? null : Str::limit($deviceId, 255, '');
    }
}
