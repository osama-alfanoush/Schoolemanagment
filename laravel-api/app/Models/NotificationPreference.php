<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class NotificationPreference extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'push_enabled', 'email_enabled', 'in_app_enabled',
        'type_preferences', 'quiet_hours'
    ];

    protected $casts = [
        'push_enabled' => 'boolean',
        'email_enabled' => 'boolean',
        'in_app_enabled' => 'boolean',
        'type_preferences' => 'array',
        'quiet_hours' => 'array',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public static function getOrCreateForUser(int $userId): self
    {
        return self::firstOrCreate(
            ['user_id' => $userId],
            [
                'push_enabled' => true,
                'email_enabled' => true,
                'in_app_enabled' => true,
            ]
        );
    }

    public function isQuietHours(): bool
    {
        if (!$this->quiet_hours || !isset($this->quiet_hours['start'], $this->quiet_hours['end'])) {
            return false;
        }

        $now = now();
        $start = $now->copy()->setTimeFromTimeString($this->quiet_hours['start']);
        $end = $now->copy()->setTimeFromTimeString($this->quiet_hours['end']);

        if ($end->lessThan($start)) {
            // Spanning midnight
            return $now->greaterThanOrEqualTo($start) || $now->lessThan($end);
        }

        return $now->between($start, $end);
    }

    public function canReceive(string $channel, string $type = null): bool
    {
        // Check if channel is enabled
        $channelEnabled = match($channel) {
            'push' => $this->push_enabled,
            'email' => $this->email_enabled,
            'in_app' => $this->in_app_enabled,
            default => false,
        };

        if (!$channelEnabled) {
            return false;
        }

        // Check quiet hours for push notifications
        if ($channel === 'push' && $this->isQuietHours()) {
            return false;
        }

        // Check type-specific preferences
        if ($type && $this->type_preferences) {
            $typePref = $this->type_preferences[$type] ?? null;
            if ($typePref !== null && !($typePref[$channel] ?? true)) {
                return false;
            }
        }

        return true;
    }
}
