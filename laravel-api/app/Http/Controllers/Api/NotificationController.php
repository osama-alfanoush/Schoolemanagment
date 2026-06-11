<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\DeviceToken;
use App\Models\Message;
use App\Models\Notification;
use App\Models\NotificationPreference;
use App\Models\NotificationTemplate;
use App\Services\NotificationService;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    /**
     * Get user's notifications
     */
    public function index(Request $request)
    {
        $query = Notification::forUser($request->user()->id)
            ->orderBy('created_at', 'desc');

        if ($request->boolean('unread_only')) {
            $query->unread();
        }

        if ($request->has('is_read')) {
            $request->boolean('is_read') ? $query->read() : $query->unread();
        }

        if ($type = $request->query('type')) {
            $query->ofType($type);
        }

        if ($category = $request->query('category')) {
            $query->ofCategory($category);
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    /**
     * Get unread notification count
     */
    public function unreadCount(Request $request)
    {
        $count = NotificationService::getUnreadCount($request->user()->id);
        $highPriorityCount = Notification::forUser($request->user()->id)
            ->unread()
            ->highPriority()
            ->count();

        return response()->json([
            'total_unread' => $count,
            'high_priority_unread' => $highPriorityCount,
            'notifications' => $count,
            'messages' => Message::where('recipient_user_id', $request->user()->id)
                ->whereNull('read_at')
                ->count(),
        ]);
    }

    /**
     * Mark notification as read
     */
    public function markAsRead(Request $request, int $id)
    {
        $success = NotificationService::markAsRead($id, $request->user()->id);

        if (!$success) {
            return response()->json(['message' => 'Notification not found'], 404);
        }

        return response()->json(['message' => 'Marked as read']);
    }

    /**
     * Mark all notifications as read
     */
    public function markAllAsRead(Request $request)
    {
        $count = NotificationService::markAllAsRead($request->user()->id);

        return response()->json([
            'message' => 'All notifications marked as read',
            'marked_count' => $count,
        ]);
    }

    /**
     * Mark notification as clicked (for analytics)
     */
    public function markAsClicked(Request $request, int $id)
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', $request->user()->id)
            ->first();

        if (!$notification) {
            return response()->json(['message' => 'Notification not found'], 404);
        }

        $notification->markAsClicked();

        return response()->json(['message' => 'Marked as clicked']);
    }

    /**
     * Get notification preferences
     */
    public function getPreferences(Request $request)
    {
        $preferences = NotificationPreference::getOrCreateForUser($request->user()->id);

        return response()->json($preferences);
    }

    /**
     * Update notification preferences
     */
    public function updatePreferences(Request $request)
    {
        $data = $request->validate([
            'push_enabled' => 'boolean',
            'email_enabled' => 'boolean',
            'in_app_enabled' => 'boolean',
            'quiet_hours' => 'nullable|array',
            'quiet_hours.start' => 'required_with:quiet_hours|string',
            'quiet_hours.end' => 'required_with:quiet_hours|string',
            'type_preferences' => 'nullable|array',
        ]);

        $preferences = NotificationPreference::getOrCreateForUser($request->user()->id);
        $preferences->update($data);

        return response()->json($preferences);
    }

    /**
     * Register device token for push notifications
     */
    public function registerDevice(Request $request)
    {
        $data = $request->validate([
            'token' => 'required|string',
            'platform' => 'required|in:ios,android,web',
            'device_name' => 'nullable|string',
            'app_version' => 'nullable|string',
        ]);

        $device = DeviceToken::register(
            $request->user()->id,
            $data['token'],
            $data['platform'],
            [
                'device_name' => $data['device_name'] ?? null,
                'app_version' => $data['app_version'] ?? null,
            ]
        );

        return response()->json([
            'message' => 'Device registered successfully',
            'device_id' => $device->id,
        ]);
    }

    /**
     * Unregister device token
     */
    public function unregisterDevice(Request $request)
    {
        $data = $request->validate(['token' => 'required|string']);

        DeviceToken::remove($request->user()->id, $data['token']);

        return response()->json(['message' => 'Device unregistered']);
    }

    /**
     * Get registered devices
     */
    public function getDevices(Request $request)
    {
        $devices = DeviceToken::where('user_id', $request->user()->id)
            ->orderBy('last_used_at', 'desc')
            ->get();

        return response()->json($devices);
    }

    /**
     * Get notification templates (admin only)
     */
    public function getTemplates(Request $request)
    {
        $templates = NotificationTemplate::all();
        return response()->json($templates);
    }

    /**
     * Update notification template (admin only)
     */
    public function updateTemplate(Request $request, int $id)
    {
        $template = NotificationTemplate::findOrFail($id);

        $data = $request->validate([
            'title_template' => 'string',
            'body_template' => 'string',
            'default_priority' => 'in:low,normal,high,urgent',
            'action_url_template' => 'nullable|string',
        ]);

        $template->update($data);

        return response()->json($template);
    }

    /**
     * Seed default templates (admin only)
     */
    public function seedTemplates(Request $request)
    {
        NotificationTemplate::seedDefaults();

        return response()->json([
            'message' => 'Templates seeded successfully',
            'count' => NotificationTemplate::count(),
        ]);
    }

    /**
     * Send test notification (admin only)
     */
    public function sendTest(Request $request)
    {
        $data = $request->validate([
            'user_id' => 'required|exists:users,id',
            'template_key' => 'required|string',
            'template_data' => 'nullable|array',
        ]);

        $notification = NotificationService::sendWithTemplate(
            $data['user_id'],
            $data['template_key'],
            $data['template_data'] ?? []
        );

        if (!$notification) {
            return response()->json(['message' => 'Failed to send notification'], 400);
        }

        return response()->json([
            'message' => 'Test notification sent',
            'notification' => $notification,
        ]);
    }

    /**
     * Get notification analytics (admin only)
     */
    public function analytics(Request $request)
    {
        $days = $request->query('days', 30);
        $analytics = NotificationService::getAnalytics($days);

        return response()->json($analytics);
    }

    /**
     * Send bulk notification (admin only)
     */
    public function sendBulk(Request $request)
    {
        $data = $request->validate([
            'template_key' => 'required|string',
            'template_data' => 'nullable|array',
            'target' => 'required|array',
            'target.role' => 'nullable|string',
            'target.class_room_id' => 'nullable|integer',
            'target.user_ids' => 'nullable|array',
        ]);

        // Determine target users
        if (!empty($data['target']['user_ids'])) {
            $userIds = $data['target']['user_ids'];
        } elseif (!empty($data['target']['role'])) {
            $userIds = \App\Models\User::where('role', $data['target']['role'])
                ->where('is_active', true)
                ->pluck('id')
                ->toArray();
        } elseif (!empty($data['target']['class_room_id'])) {
            $userIds = \App\Models\User::where('role', 'student')
                ->whereHas('studentProfile', fn($q) => $q->where('class_room_id', $data['target']['class_room_id']))
                ->pluck('id')
                ->toArray();
        } else {
            return response()->json(['message' => 'No valid target specified'], 400);
        }

        $notifications = NotificationService::sendToMany(
            $userIds,
            $data['template_key'],
            $data['template_data'] ?? []
        );

        return response()->json([
            'message' => 'Bulk notification sent',
            'recipient_count' => count($userIds),
            'sent_count' => count($notifications),
        ]);
    }

    /**
     * Delete old notifications (admin only)
     */
    public function cleanup(Request $request)
    {
        $days = $request->query('days', 90);

        $deleted = Notification::where('created_at', '<', now()->subDays($days))
            ->whereNotNull('read_at')
            ->delete();

        return response()->json([
            'message' => 'Old notifications cleaned up',
            'deleted_count' => $deleted,
        ]);
    }
}
