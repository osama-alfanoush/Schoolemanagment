<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class NotificationDelivery extends Model
{
    use HasFactory;

    protected $fillable = [
        'notification_id', 'channel', 'status', 'error_message',
        'sent_at', 'delivered_at', 'failed_at', 'external_id'
    ];

    protected $casts = [
        'sent_at' => 'datetime',
        'delivered_at' => 'datetime',
        'failed_at' => 'datetime',
    ];

    // Channels
    public const CHANNEL_PUSH = 'push';
    public const CHANNEL_EMAIL = 'email';
    public const CHANNEL_IN_APP = 'in_app';
    public const CHANNEL_WEBSOCKET = 'websocket';

    // Statuses
    public const STATUS_PENDING = 'pending';
    public const STATUS_SENT = 'sent';
    public const STATUS_DELIVERED = 'delivered';
    public const STATUS_FAILED = 'failed';
    public const STATUS_READ = 'read';

    public function notification(): BelongsTo
    {
        return $this->belongsTo(Notification::class);
    }

    public function markAsSent(string $externalId = null): void
    {
        $this->update([
            'status' => self::STATUS_SENT,
            'sent_at' => now(),
            'external_id' => $externalId,
        ]);
    }

    public function markAsDelivered(): void
    {
        $this->update([
            'status' => self::STATUS_DELIVERED,
            'delivered_at' => now(),
        ]);
    }

    public function markAsFailed(string $error): void
    {
        $this->update([
            'status' => self::STATUS_FAILED,
            'failed_at' => now(),
            'error_message' => $error,
        ]);
    }

    public function markAsRead(): void
    {
        $this->update([
            'status' => self::STATUS_READ,
        ]);
    }
}
