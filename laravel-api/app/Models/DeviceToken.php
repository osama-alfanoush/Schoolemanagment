<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DeviceToken extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'token', 'platform', 'device_name', 'app_version',
        'last_used_at', 'verified_at'
    ];

    protected $casts = [
        'last_used_at' => 'datetime',
        'verified_at' => 'datetime',
    ];

    public const PLATFORM_IOS = 'ios';
    public const PLATFORM_ANDROID = 'android';
    public const PLATFORM_WEB = 'web';

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public static function register(int $userId, string $token, string $platform, array $meta = []): self
    {
        $device = self::updateOrCreate(
            ['user_id' => $userId, 'token' => $token],
            [
                'platform' => $platform,
                'device_name' => $meta['device_name'] ?? null,
                'app_version' => $meta['app_version'] ?? null,
                'last_used_at' => now(),
                'verified_at' => now(),
            ]
        );

        return $device;
    }

    public static function remove(int $userId, string $token): void
    {
        self::where('user_id', $userId)->where('token', $token)->delete();
    }

    public static function getTokensForUser(int $userId, ?string $platform = null): array
    {
        $query = self::where('user_id', $userId)->whereNotNull('verified_at');

        if ($platform) {
            $query->where('platform', $platform);
        }

        return $query->pluck('token')->toArray();
    }

    public function touchLastUsed(): void
    {
        $this->update(['last_used_at' => now()]);
    }
}
