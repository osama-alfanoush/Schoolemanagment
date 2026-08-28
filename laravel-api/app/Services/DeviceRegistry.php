<?php

namespace App\Services;

use App\Models\PersonalAccessToken;
use App\Models\User;
use App\Models\UserDevice;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

final class DeviceRegistry
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function register(Request $request, User $user, array $attributes): UserDevice
    {
        $this->assertUserBelongsToCurrentSchool($user);

        return DB::transaction(function () use ($request, $user, $attributes): UserDevice {
            $deviceId = trim((string) $attributes['device_id']);
            $existing = UserDevice::withoutGlobalScope('school')
                ->where('user_id', $user->id)
                ->where('device_id', $deviceId)
                ->lockForUpdate()
                ->first();

            if ($existing && (int) $existing->school_id !== $this->currentSchool->id()) {
                throw new AccessDeniedHttpException('This device belongs to another school.');
            }

            $device = $existing ?? new UserDevice(['user_id' => $user->id, 'device_id' => $deviceId]);
            $device->fill([
                'platform' => $attributes['platform'],
                'push_token' => $attributes['push_token'],
                'app_version' => $attributes['app_version'] ?? null,
                'os_version' => $attributes['os_version'] ?? null,
                'last_seen_at' => now(),
                'revoked_at' => null,
            ]);
            $device->save();

            $this->bindCurrentTokenFamily($request, $user, $deviceId);
            AuditLogger::log($request, 'device_registered', 'user_device', $device->id, [
                'device_id' => $deviceId,
                'platform' => $device->platform,
            ], $user->id);

            return $device->fresh();
        });
    }

    public function touch(User $user, string $deviceId, array $attributes = []): UserDevice
    {
        $this->assertUserBelongsToCurrentSchool($user);
        $device = $this->activeDeviceQuery($user, $deviceId)->firstOrFail();
        $device->fill(array_filter([
            'app_version' => $attributes['app_version'] ?? null,
            'os_version' => $attributes['os_version'] ?? null,
        ], static fn ($value) => $value !== null));
        $device->last_seen_at = now();
        $device->save();

        return $device->fresh();
    }

    public function revoke(Request $request, User $user, string $deviceId): bool
    {
        $this->assertUserBelongsToCurrentSchool($user);

        return DB::transaction(function () use ($request, $user, $deviceId): bool {
            $device = $this->activeDeviceQuery($user, $deviceId)->lockForUpdate()->first();
            if (! $device) {
                return false;
            }

            $device->revoked_at = now();
            $device->save();

            $this->activeTokensForDevice($user, $device->device_id)
                ->update(['revoked_at' => now()]);

            $device->push_token = null;
            $device->save();

            AuditLogger::log($request, 'device_revoked', 'user_device', $device->id, [
                'device_id' => $device->device_id,
            ], $user->id);

            return true;
        });
    }

    public function revokeAllForUser(Request $request, User $user): int
    {
        $this->assertUserBelongsToCurrentSchool($user);

        return DB::transaction(function () use ($request, $user): int {
            $devices = UserDevice::query()
                ->where('user_id', $user->id)
                ->whereNull('revoked_at')
                ->lockForUpdate()
                ->get();

            if ($devices->isEmpty()) {
                return 0;
            }

            $ids = $devices->modelKeys();
            $deviceIds = $devices->pluck('device_id')->all();
            UserDevice::query()->whereKey($ids)->update(['revoked_at' => now()]);
            PersonalAccessToken::query()
                ->where('tokenable_type', $user->getMorphClass())
                ->where('tokenable_id', $user->id)
                ->whereIn('device_id', $deviceIds)
                ->whereNull('revoked_at')
                ->update(['revoked_at' => now()]);
            UserDevice::query()->whereKey($ids)->update(['push_token' => null]);

            AuditLogger::log($request, 'devices_revoked', 'user', $user->id, [
                'device_count' => $devices->count(),
            ], $user->id);

            return $devices->count();
        });
    }

    /** @return Collection<int, UserDevice> */
    public function forUser(User $user): Collection
    {
        $this->assertUserBelongsToCurrentSchool($user);

        return UserDevice::query()
            ->where('user_id', $user->id)
            ->whereNull('revoked_at')
            ->orderByDesc('last_seen_at')
            ->get();
    }

    /** @return array<int, string> */
    public function pushTokensForUser(User $user): array
    {
        return $this->forUser($user)->pluck('push_token')->filter()->values()->all();
    }

    public function clearInvalidPushToken(User $user, string $pushToken): void
    {
        $this->assertUserBelongsToCurrentSchool($user);
        UserDevice::query()
            ->where('user_id', $user->id)
            ->whereNull('revoked_at')
            ->where('push_token', $pushToken)
            ->update(['push_token' => null]);
    }

    private function activeDeviceQuery(User $user, string $deviceId)
    {
        return UserDevice::query()
            ->where('user_id', $user->id)
            ->where('device_id', $deviceId)
            ->whereNull('revoked_at');
    }

    private function activeTokensForDevice(User $user, string $deviceId)
    {
        return PersonalAccessToken::query()
            ->where('tokenable_type', $user->getMorphClass())
            ->where('tokenable_id', $user->id)
            ->where('device_id', $deviceId)
            ->whereNull('revoked_at');
    }

    private function bindCurrentTokenFamily(Request $request, User $user, string $deviceId): void
    {
        $token = $request->user()?->currentAccessToken();
        if (! $token instanceof PersonalAccessToken) {
            return;
        }
        if ($token->device_id !== null && $token->device_id !== $deviceId) {
            throw new AccessDeniedHttpException('The access token belongs to another device.');
        }

        $query = PersonalAccessToken::query()
            ->where('tokenable_type', $user->getMorphClass())
            ->where('tokenable_id', $user->id)
            ->whereNull('revoked_at');
        $token->token_family
            ? $query->where('token_family', $token->token_family)
            : $query->whereKey($token->id);
        $query->update(['device_id' => $deviceId]);
    }

    private function assertUserBelongsToCurrentSchool(User $user): void
    {
        $schoolId = $this->currentSchool->id();
        $belongs = $user->schoolRoles()->where('school_id', $schoolId)->exists();
        if (! $belongs) {
            throw new AccessDeniedHttpException('This user belongs to another school.');
        }
    }
}
