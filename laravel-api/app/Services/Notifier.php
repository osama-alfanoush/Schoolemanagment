<?php

namespace App\Services;

use App\Models\AppNotification;
use App\Models\PushToken;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class Notifier
{
    /**
     * Create an in-app notification AND dispatch an FCM push to all registered devices.
     * FCM is fire-and-forget; failures are logged but never block the in-app record.
     */
    public static function send(int $userId, string $type, string $title, string $body, array $data = []): AppNotification
    {
        $note = AppNotification::create([
            'user_id' => $userId,
            'type' => $type,
            'title' => $title,
            'body' => $body,
            'data' => $data,
        ]);

        self::dispatchPush($userId, $title, $body, array_merge($data, ['type' => $type, 'notification_id' => $note->id]));

        return $note;
    }

    protected static function dispatchPush(int $userId, string $title, string $body, array $data): void
    {
        $serverKey = config('services.fcm.server_key');
        if (! $serverKey) {
            return;
        }

        $tokens = PushToken::where('user_id', $userId)->pluck('token')->all();
        if (empty($tokens)) {
            return;
        }

        try {
            Http::withHeaders([
                'Authorization' => 'key='.$serverKey,
                'Content-Type' => 'application/json',
            ])->timeout(5)->post('https://fcm.googleapis.com/fcm/send', [
                'registration_ids' => $tokens,
                'notification' => ['title' => $title, 'body' => $body],
                'data' => array_map('strval', $data),
            ]);
        } catch (\Throwable $e) {
            Log::warning('FCM push failed: '.$e->getMessage(), ['user_id' => $userId]);
        }
    }
}
