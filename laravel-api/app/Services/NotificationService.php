<?php

namespace App\Services;

use App\Events\NotificationReceived;
use App\Mail\NotificationEmail;
use App\Models\DeviceToken;
use App\Models\Notification;
use App\Models\NotificationDelivery;
use App\Models\NotificationPreference;
use App\Models\NotificationTemplate;
use App\Models\User;
use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class NotificationService
{
    /**
     * Send a notification using a template
     */
    public static function sendWithTemplate(
        int $userId,
        string $templateKey,
        array $templateData = [],
        array $options = []
    ): ?Notification {
        $template = NotificationTemplate::getByKey($templateKey);

        if (! $template) {
            Log::error("Notification template not found: {$templateKey}");

            return null;
        }

        $rendered = $template->render($templateData);

        return self::send(
            userId: $userId,
            type: $templateKey,
            category: $rendered['category'],
            title: $rendered['title'],
            body: $rendered['body'],
            priority: $options['priority'] ?? $rendered['priority'],
            data: array_merge($templateData, ['template_key' => $templateKey]),
            actionUrl: $rendered['action_url'],
            sourceType: $options['source_type'] ?? null,
            sourceId: $options['source_id'] ?? null,
        );
    }

    /**
     * Send notification to multiple users
     */
    public static function sendToMany(
        array $userIds,
        string $templateKey,
        array $templateData = [],
        array $options = []
    ): array {
        $notifications = [];

        foreach ($userIds as $userId) {
            $notification = self::sendWithTemplate($userId, $templateKey, $templateData, $options);
            if ($notification) {
                $notifications[] = $notification;
            }
        }

        return $notifications;
    }

    /**
     * Send notification to a role
     */
    public static function sendToRole(
        string $role,
        string $templateKey,
        array $templateData = [],
        array $options = []
    ): array {
        $userIds = User::where('role', $role)->where('is_active', true)->pluck('id')->toArray();

        return self::sendToMany($userIds, $templateKey, $templateData, $options);
    }

    /**
     * Send notification to parents of a student
     */
    public static function sendToParents(
        int $studentId,
        string $templateKey,
        array $templateData = [],
        array $options = []
    ): array {
        $parentIds = \DB::table('parent_student')
            ->where('student_user_id', $studentId)
            ->pluck('parent_user_id')
            ->toArray();

        return self::sendToMany($parentIds, $templateKey, $templateData, $options);
    }

    /**
     * Send notification to all users in a class
     */
    public static function sendToClass(
        int $classRoomId,
        string $templateKey,
        array $templateData = [],
        array $options = []
    ): array {
        $studentIds = User::where('role', 'student')
            ->whereHas('studentProfile', fn ($q) => $q->where('class_room_id', $classRoomId))
            ->pluck('id')
            ->toArray();

        return self::sendToMany($studentIds, $templateKey, $templateData, $options);
    }

    /**
     * Core send method
     */
    public static function send(
        int $userId,
        string $type,
        string $category,
        string $title,
        string $body,
        string $priority = 'normal',
        array $data = [],
        ?string $actionUrl = null,
        ?string $sourceType = null,
        ?int $sourceId = null,
        ?\DateTime $scheduledAt = null
    ): Notification {
        // Get user preferences
        $preferences = NotificationPreference::getOrCreateForUser($userId);

        // Create in-app notification
        $notification = Notification::create([
            'user_id' => $userId,
            'type' => $type,
            'category' => $category,
            'priority' => $priority,
            'title' => $title,
            'body' => $body,
            'data' => $data,
            'action_url' => $actionUrl,
            'icon' => self::getIconForType($type),
            'source_type' => $sourceType,
            'source_id' => $sourceId,
            'scheduled_at' => $scheduledAt,
        ]);

        // Deliver through enabled channels
        if ($preferences->canReceive('in_app', $type)) {
            self::deliverInApp($notification);
        }

        if ($preferences->canReceive('push', $type)) {
            self::deliverPush($notification);
        }

        if ($preferences->canReceive('email', $type)) {
            self::deliverEmail($notification);
        }

        // Broadcast via WebSocket for real-time updates
        self::broadcast($notification);

        return $notification;
    }

    /**
     * Deliver in-app notification
     */
    protected static function deliverInApp(Notification $notification): void
    {
        NotificationDelivery::create([
            'notification_id' => $notification->id,
            'channel' => NotificationDelivery::CHANNEL_IN_APP,
            'status' => NotificationDelivery::STATUS_DELIVERED,
            'delivered_at' => now(),
        ]);
    }

    /**
     * Deliver push notification via FCM
     */
    protected static function deliverPush(Notification $notification): void
    {
        $tokens = DeviceToken::getTokensForUser($notification->user_id);

        if (empty($tokens)) {
            return;
        }

        $delivery = NotificationDelivery::create([
            'notification_id' => $notification->id,
            'channel' => NotificationDelivery::CHANNEL_PUSH,
            'status' => NotificationDelivery::STATUS_PENDING,
        ]);

        try {
            $serverKey = config('services.fcm.server_key');

            if (! $serverKey) {
                $delivery->markAsFailed('FCM server key not configured');

                return;
            }

            // Send to all device tokens
            $response = Http::withHeaders([
                'Authorization' => 'key='.$serverKey,
                'Content-Type' => 'application/json',
            ])->timeout(10)->post('https://fcm.googleapis.com/fcm/send', [
                'registration_ids' => $tokens,
                'notification' => [
                    'title' => $notification->title,
                    'body' => $notification->body,
                    'icon' => $notification->icon ?? 'default',
                    'click_action' => $notification->action_url ?? '/',
                ],
                'data' => array_merge(
                    array_map('strval', $notification->data ?? []),
                    [
                        'notification_id' => (string) $notification->id,
                        'type' => $notification->type,
                        'priority' => $notification->priority,
                    ]
                ),
                'android' => [
                    'priority' => $notification->priority === 'urgent' ? 'high' : 'normal',
                    'notification' => [
                        'channel_id' => $notification->category,
                    ],
                ],
                'apns' => [
                    'headers' => [
                        'apns-priority' => $notification->priority === 'urgent' ? '10' : '5',
                    ],
                    'payload' => [
                        'aps' => [
                            'badge' => 1,
                            'sound' => $notification->priority === 'urgent' ? 'alert.caf' : 'default',
                        ],
                    ],
                ],
            ]);

            if ($response->successful()) {
                $result = $response->json();
                $delivery->markAsSent($result['multicast_id'] ?? null);

                // Clean up invalid tokens
                if (isset($result['results'])) {
                    foreach ($result['results'] as $index => $resultItem) {
                        if (isset($resultItem['error']) && $resultItem['error'] === 'InvalidRegistration') {
                            DeviceToken::remove($notification->user_id, $tokens[$index]);
                        }
                    }
                }
            } else {
                $delivery->markAsFailed('FCM request failed: '.$response->body());
            }
        } catch (\Exception $e) {
            $delivery->markAsFailed($e->getMessage());
            Log::error('Push notification failed', [
                'notification_id' => $notification->id,
                'error' => $e->getMessage(),
            ]);
        }
    }

    /**
     * Deliver email notification
     */
    protected static function deliverEmail(Notification $notification): void
    {
        $delivery = NotificationDelivery::create([
            'notification_id' => $notification->id,
            'channel' => NotificationDelivery::CHANNEL_EMAIL,
            'status' => NotificationDelivery::STATUS_PENDING,
        ]);

        try {
            $user = User::find($notification->user_id);

            if (! $user || ! $user->email) {
                $delivery->markAsFailed('User email not found');

                return;
            }

            // Queue email for sending
            \Mail::to($user->email)->queue(new NotificationEmail($notification));

            $delivery->markAsSent();
        } catch (\Exception $e) {
            $delivery->markAsFailed($e->getMessage());
        }
    }

    /**
     * Broadcast via WebSocket for real-time UI updates
     */
    protected static function broadcast(Notification $notification): void
    {
        try {
            broadcast(new NotificationReceived($notification))->toOthers();
        } catch (\Exception $e) {
            Log::warning('WebSocket broadcast failed', ['error' => $e->getMessage()]);
        }
    }

    /**
     * Get appropriate icon for notification type
     */
    protected static function getIconForType(string $type): string
    {
        return match ($type) {
            'assignment_created', 'assignment_due_soon' => 'assignment',
            'submission_graded', 'grade_posted' => 'grade',
            'absence_alert', 'attendance_marked' => 'attendance',
            'fee_invoice_created', 'fee_reminder', 'payment_received' => 'payment',
            'announcement' => 'announcement',
            'message_received' => 'message',
            'hr_request_approved', 'hr_request_rejected' => 'hr',
            'conduct_positive', 'conduct_warning' => 'conduct',
            'exam_scheduled' => 'exam',
            'timetable_change' => 'timetable',
            'system_maintenance' => 'system',
            default => 'default',
        };
    }

    /**
     * Mark notification as read
     */
    public static function markAsRead(int $notificationId, int $userId): bool
    {
        $notification = Notification::where('id', $notificationId)
            ->where('user_id', $userId)
            ->first();

        if (! $notification) {
            return false;
        }

        $notification->markAsRead();

        // Update delivery status
        NotificationDelivery::where('notification_id', $notificationId)
            ->update(['status' => NotificationDelivery::STATUS_READ]);

        return true;
    }

    /**
     * Mark all notifications as read for a user
     */
    public static function markAllAsRead(int $userId): int
    {
        $count = Notification::forUser($userId)->unread()->count();

        Notification::forUser($userId)->unread()->update(['read_at' => now()]);

        return $count;
    }

    /**
     * Get unread count for user
     */
    public static function getUnreadCount(int $userId): int
    {
        return Notification::forUser($userId)->unread()->count();
    }

    /**
     * Get recent notifications for user
     */
    public static function getRecentForUser(
        int $userId,
        int $limit = 20,
        bool $unreadOnly = false
    ): array {
        $query = Notification::forUser($userId)
            ->orderBy('created_at', 'desc')
            ->limit($limit);

        if ($unreadOnly) {
            $query->unread();
        }

        return $query->get()->toArray();
    }

    /**
     * Schedule a notification for later delivery
     */
    public static function schedule(
        int $userId,
        string $templateKey,
        array $templateData,
        \DateTime $scheduledAt,
        array $options = []
    ): Notification {
        $template = NotificationTemplate::getByKey($templateKey);

        if (! $template) {
            throw new \InvalidArgumentException("Template not found: {$templateKey}");
        }

        $rendered = $template->render($templateData);

        return self::send(
            userId: $userId,
            type: $templateKey,
            category: $rendered['category'],
            title: $rendered['title'],
            body: $rendered['body'],
            priority: $options['priority'] ?? $rendered['priority'],
            data: array_merge($templateData, ['template_key' => $templateKey]),
            actionUrl: $rendered['action_url'],
            scheduledAt: $scheduledAt,
        );
    }

    /**
     * Process scheduled notifications that are due
     */
    public static function processScheduled(): int
    {
        $dueNotifications = Notification::whereNotNull('scheduled_at')
            ->where('scheduled_at', '<=', now())
            ->whereNull('read_at') // Not yet processed
            ->get();

        $processed = 0;

        foreach ($dueNotifications as $notification) {
            // Re-deliver to all channels
            $preferences = NotificationPreference::getOrCreateForUser($notification->user_id);

            if ($preferences->canReceive('push', $notification->type)) {
                self::deliverPush($notification);
            }

            if ($preferences->canReceive('email', $notification->type)) {
                self::deliverEmail($notification);
            }

            $processed++;
        }

        return $processed;
    }

    /**
     * Get notification analytics for admin dashboard
     */
    public static function getAnalytics(int $days = 30): array
    {
        $startDate = now()->subDays($days);

        return [
            'total_sent' => Notification::where('created_at', '>=', $startDate)->count(),
            'total_read' => Notification::where('created_at', '>=', $startDate)->whereNotNull('read_at')->count(),
            'by_type' => Notification::where('created_at', '>=', $startDate)
                ->selectRaw('type, count(*) as count')
                ->groupBy('type')
                ->pluck('count', 'type')
                ->toArray(),
            'by_category' => Notification::where('created_at', '>=', $startDate)
                ->selectRaw('category, count(*) as count')
                ->groupBy('category')
                ->pluck('count', 'category')
                ->toArray(),
            'delivery_success_rate' => NotificationDelivery::where('created_at', '>=', $startDate)
                ->selectRaw('channel, status, count(*) as count')
                ->groupBy('channel', 'status')
                ->get()
                ->groupBy('channel')
                ->map(fn ($items) => [
                    'total' => $items->sum('count'),
                    'success' => $items->whereIn('status', [NotificationDelivery::STATUS_SENT, NotificationDelivery::STATUS_DELIVERED])->sum('count'),
                ])
                ->toArray(),
        ];
    }
}
