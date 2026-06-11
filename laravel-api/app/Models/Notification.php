<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Notification extends Model
{
    use HasFactory;

    protected $appends = ['is_read'];

    protected $fillable = [
        'user_id', 'type', 'category', 'priority', 'title', 'body',
        'data', 'action_url', 'icon', 'read_at', 'clicked_at',
        'scheduled_at', 'expires_at', 'source_type', 'source_id'
    ];

    protected $casts = [
        'data' => 'array',
        'read_at' => 'datetime',
        'clicked_at' => 'datetime',
        'scheduled_at' => 'datetime',
        'expires_at' => 'datetime',
    ];

    // Priority levels
    public const PRIORITY_LOW = 'low';
    public const PRIORITY_NORMAL = 'normal';
    public const PRIORITY_HIGH = 'high';
    public const PRIORITY_URGENT = 'urgent';

    // Categories
    public const CATEGORY_ACADEMIC = 'academic';
    public const CATEGORY_FINANCIAL = 'financial';
    public const CATEGORY_ADMINISTRATIVE = 'administrative';
    public const CATEGORY_BEHAVIORAL = 'behavioral';
    public const CATEGORY_SYSTEM = 'system';

    // Types
    public const TYPE_ASSIGNMENT_CREATED = 'assignment_created';
    public const TYPE_ASSIGNMENT_DUE = 'assignment_due';
    public const TYPE_SUBMISSION_GRADED = 'submission_graded';
    public const TYPE_GRADE_POSTED = 'grade_posted';
    public const TYPE_ATTENDANCE_MARKED = 'attendance_marked';
    public const TYPE_ABSENCE_ALERT = 'absence_alert';
    public const TYPE_FEE_INVOICE = 'fee_invoice';
    public const TYPE_FEE_REMINDER = 'fee_reminder';
    public const TYPE_PAYMENT_RECEIVED = 'payment_received';
    public const TYPE_ANNOUNCEMENT = 'announcement';
    public const TYPE_MESSAGE_RECEIVED = 'message_received';
    public const TYPE_HR_REQUEST_STATUS = 'hr_request_status';
    public const TYPE_CONDUCT_LOG = 'conduct_log';
    public const TYPE_EXAM_SCHEDULED = 'exam_scheduled';
    public const TYPE_TIMETABLE_CHANGE = 'timetable_change';
    public const TYPE_SYSTEM_MAINTENANCE = 'system_maintenance';

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function deliveries(): HasMany
    {
        return $this->hasMany(NotificationDelivery::class);
    }

    public function scopeUnread($query)
    {
        return $query->whereNull('read_at');
    }

    public function scopeRead($query)
    {
        return $query->whereNotNull('read_at');
    }

    public function scopeForUser($query, int $userId)
    {
        return $query->where('user_id', $userId);
    }

    public function scopeOfType($query, string $type)
    {
        return $query->where('type', $type);
    }

    public function scopeOfCategory($query, string $category)
    {
        return $query->where('category', $category);
    }

    public function scopeHighPriority($query)
    {
        return $query->whereIn('priority', [self::PRIORITY_HIGH, self::PRIORITY_URGENT]);
    }

    public function scopeRecent($query, int $days = 7)
    {
        return $query->where('created_at', '>=', now()->subDays($days));
    }

    public function markAsRead(): void
    {
        if (!$this->read_at) {
            $this->update(['read_at' => now()]);
        }
    }

    public function markAsClicked(): void
    {
        $this->update(['clicked_at' => now()]);
    }

    public function isRead(): bool
    {
        return $this->read_at !== null;
    }

    public function getIsReadAttribute(): bool
    {
        return $this->isRead();
    }

    public function isUrgent(): bool
    {
        return $this->priority === self::PRIORITY_URGENT;
    }

    public function getDeliveryStatus(string $channel): ?NotificationDelivery
    {
        return $this->deliveries()->where('channel', $channel)->first();
    }
}
