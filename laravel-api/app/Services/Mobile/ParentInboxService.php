<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Message;
use App\Models\Notification;
use App\Models\NotificationPreference;
use App\Models\ProfileCorrectionRequest;
use App\Services\AuditLogger;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

/**
 * Notifications, message threads, timetable and the child profile.
 *
 * The messaging rules here are stricter than the web's and deliberately so.
 * A guardian may reply to a thread staff opened; they cannot open one, and
 * they cannot reply outside working hours. Unconstrained parent-initiated chat
 * is how teachers come to hate the product, and staff resistance is what kills
 * a pilot. This is a product requirement, not a limitation to remove.
 */
final class ParentInboxService
{
    /* ---------- notifications ---------- */

    /** @return array<string, mixed> */
    public function notifications(int $userId, int $limit = 50): array
    {
        $rows = Notification::query()
            ->where('user_id', $userId)
            ->orderByDesc('created_at')
            ->limit($limit)
            ->get();

        return [
            'unread_count' => Notification::query()
                ->where('user_id', $userId)
                ->whereNull('read_at')
                ->count(),
            'notifications' => $rows->map(fn (Notification $row): array => [
                'id' => $row->id,
                'category' => $row->category,
                'type' => $row->type,
                'priority' => $row->priority,
                'title' => $row->title,
                'body' => $row->body,
                'action_url' => $row->action_url,
                'read' => $row->read_at !== null,
                'created_at' => $row->created_at?->toIso8601String(),
            ])->all(),
        ];
    }

    /**
     * Marks one notification read.
     *
     * Writes the same `read_at` column the web client writes, so a parent who
     * reads a notice on their phone does not find it unread on the website.
     */
    public function markRead(int $notificationId, int $userId): bool
    {
        return Notification::query()
            ->whereKey($notificationId)
            ->where('user_id', $userId)
            ->whereNull('read_at')
            ->update(['read_at' => now()]) > 0;
    }

    /**
     * The categories a user may mute, and their current state.
     *
     * @return array<string, mixed>
     */
    public function preferences(int $userId): array
    {
        $preference = NotificationPreference::getOrCreateForUser($userId);
        $stored = (array) ($preference->type_preferences ?? []);

        $categories = [];
        foreach ((array) config('mobile.notification_categories', []) as $category) {
            // Absent means on. A category nobody has touched should still
            // deliver; defaulting to off would silently mute a new one.
            $categories[$category] = ($stored[$category] ?? true) !== false;
        }

        return [
            'push_enabled' => (bool) $preference->push_enabled,
            'categories' => $categories,
            // Reported so the client can say why nothing arrived last night,
            // but not mutable here.
            'always_on' => array_values((array) config('mobile.always_on_categories', [])),
            'quiet_hours' => $preference->quiet_hours,
        ];
    }

    /**
     * Updates only the categories named, leaving every other one alone.
     *
     * A merge, not a replace. Sending the whole map on every toggle is how
     * muting grades quietly mutes fee reminders — the one thing a parent must
     * never stop receiving by accident.
     *
     * @param  array<string, bool>  $changes
     * @return array<string, mixed>
     */
    public function updatePreferences(int $userId, array $changes, ?bool $pushEnabled = null): array
    {
        $preference = NotificationPreference::getOrCreateForUser($userId);
        $stored = (array) ($preference->type_preferences ?? []);

        $mutable = (array) config('mobile.notification_categories', []);

        foreach ($changes as $category => $enabled) {
            // An always-on category is not silently accepted and ignored: it
            // is simply not in the mutable set, so a client asking to mute it
            // gets told rather than believing it worked.
            if (! in_array($category, $mutable, true)) {
                continue;
            }

            $stored[$category] = (bool) $enabled;
        }

        $preference->type_preferences = $stored;
        if ($pushEnabled !== null) {
            $preference->push_enabled = $pushEnabled;
        }
        $preference->save();

        return $this->preferences($userId);
    }

    /* ---------- messages ---------- */

    /**
     * Threads this guardian is part of.
     *
     * @return list<array<string, mixed>>
     */
    public function threads(int $userId): array
    {
        $messages = Message::query()
            ->where(fn ($q) => $q->where('sender_user_id', $userId)
                ->orWhere('recipient_user_id', $userId))
            ->with(['sender:id,name,role', 'recipient:id,name,role'])
            ->orderByDesc('created_at')
            ->limit(200)
            ->get();

        $threads = [];

        foreach ($messages as $message) {
            $otherId = $message->sender_user_id === $userId
                ? (int) $message->recipient_user_id
                : (int) $message->sender_user_id;

            $threads[$otherId] ??= [
                'other_user_id' => $otherId,
                'name' => $message->sender_user_id === $userId
                    ? $message->recipient?->name
                    : $message->sender?->name,
                'role' => $message->sender_user_id === $userId
                    ? $message->recipient?->role
                    : $message->sender?->role,
                'last_message' => $message->body,
                'last_at' => $message->created_at?->toIso8601String(),
                'unread' => 0,
            ];

            if ((int) $message->recipient_user_id === $userId && $message->read_at === null) {
                $threads[$otherId]['unread']++;
            }
        }

        foreach ($threads as $otherId => $thread) {
            $threads[$otherId]['can_reply'] = $this->staffOpenedThread($userId, $otherId);
        }

        return array_values($threads);
    }

    /**
     * One conversation, oldest first.
     *
     * @return array<string, mixed>
     */
    public function conversation(int $userId, int $otherId): array
    {
        $messages = Message::query()
            ->where(fn ($q) => $q->where('sender_user_id', $userId)
                ->where('recipient_user_id', $otherId))
            ->orWhere(fn ($q) => $q->where('sender_user_id', $otherId)
                ->where('recipient_user_id', $userId))
            ->orderBy('created_at')
            ->get();

        // Reading a thread marks it read, in the same column the web writes.
        Message::query()
            ->where('sender_user_id', $otherId)
            ->where('recipient_user_id', $userId)
            ->whereNull('read_at')
            ->update(['read_at' => now()]);

        return [
            'other_user_id' => $otherId,
            'can_reply' => $this->staffOpenedThread($userId, $otherId),
            'reply_window' => $this->replyWindow(),
            'messages' => $messages->map(fn (Message $message): array => [
                'id' => $message->id,
                'mine' => (int) $message->sender_user_id === $userId,
                'body' => $message->body,
                'sent_at' => $message->created_at?->toIso8601String(),
            ])->all(),
        ];
    }

    /**
     * Whether staff opened this thread.
     *
     * The first message decides. If the guardian sent it, this thread was
     * parent-initiated — which the web allows and this surface does not — and
     * no reply is offered here either.
     */
    public function staffOpenedThread(int $userId, int $otherId): bool
    {
        $first = Message::query()
            ->where(fn ($q) => $q->where('sender_user_id', $userId)
                ->where('recipient_user_id', $otherId))
            ->orWhere(fn ($q) => $q->where('sender_user_id', $otherId)
                ->where('recipient_user_id', $userId))
            ->orderBy('created_at')
            ->orderBy('id')
            ->first();

        return $first !== null && (int) $first->sender_user_id !== $userId;
    }

    /** True when replies are allowed right now. */
    public function withinReplyHours(?Carbon $now = null): bool
    {
        $window = $this->replyWindow();
        $minutes = ($now ?? Carbon::now())->hour * 60 + ($now ?? Carbon::now())->minute;

        return $minutes >= self::minutesOf($window['from'])
            && $minutes <= self::minutesOf($window['to']);
    }

    /** @return array{from: string, to: string} */
    public function replyWindow(): array
    {
        return [
            'from' => (string) config('mobile.messaging.reply_from', '07:00'),
            'to' => (string) config('mobile.messaging.reply_to', '17:00'),
        ];
    }

    /* ---------- timetable ---------- */

    /**
     * A child's week, keyed by ISO day of week.
     *
     * @return array<string, mixed>
     */
    public function timetable(int $childId, int $schoolId): array
    {
        $classRoomId = DB::table('student_profiles')
            ->where('school_id', $schoolId)
            ->where('user_id', $childId)
            ->value('class_room_id');

        if ($classRoomId === null) {
            return ['student_user_id' => $childId, 'days' => []];
        }

        $rows = DB::table('timetable_entries')
            ->leftJoin('subjects', 'subjects.id', '=', 'timetable_entries.subject_id')
            ->leftJoin('users', 'users.id', '=', 'timetable_entries.teacher_user_id')
            ->where('timetable_entries.school_id', $schoolId)
            ->where('timetable_entries.class_room_id', $classRoomId)
            ->orderBy('timetable_entries.day_of_week')
            ->orderBy('timetable_entries.start_time')
            ->get([
                'timetable_entries.id',
                'timetable_entries.day_of_week',
                'timetable_entries.start_time',
                'timetable_entries.end_time',
                'timetable_entries.room',
                'subjects.name as subject_name',
                'users.name as teacher_name',
            ]);

        $days = [];
        foreach ($rows as $row) {
            $days[(string) (int) $row->day_of_week][] = [
                'id' => (int) $row->id,
                'subject' => $row->subject_name,
                'teacher' => $row->teacher_name,
                'start_time' => (string) $row->start_time,
                'end_time' => (string) $row->end_time,
                'room' => $row->room,
            ];
        }

        return [
            'student_user_id' => $childId,
            'today' => (string) Carbon::today()->dayOfWeekIso,
            'days' => $days,
        ];
    }

    /* ---------- profile ---------- */

    /**
     * Files a correction request.
     *
     * A request, not an edit. An admission number or a date of birth a family
     * can rewrite is not a record anyone can rely on, so this asks a human to
     * look rather than changing anything.
     *
     * @return array{request: ProfileCorrectionRequest, created: bool}
     */
    public function requestCorrection(
        Request $request,
        int $childId,
        int $guardianId,
        int $schoolId,
        string $field,
        string $detail,
        string $idempotencyKey,
    ): array {
        $existing = ProfileCorrectionRequest::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            return ['request' => $existing, 'created' => false];
        }

        try {
            $correction = ProfileCorrectionRequest::query()->create([
                'school_id' => $schoolId,
                'student_user_id' => $childId,
                'requested_by' => $guardianId,
                'field' => $field,
                'detail' => $detail,
                'idempotency_key' => $idempotencyKey,
            ]);
        } catch (QueryException $e) {
            $winner = ProfileCorrectionRequest::query()
                ->where('idempotency_key', $idempotencyKey)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            return ['request' => $winner, 'created' => false];
        }

        // The field name, not the family's account of what is wrong.
        AuditLogger::log($request, 'profile_correction_requested', 'student', $childId, [
            'field' => $field,
            'request_id' => $correction->id,
        ], $guardianId);

        return ['request' => $correction, 'created' => true];
    }

    private static function minutesOf(string $time): int
    {
        $parts = explode(':', $time);
        $hours = (int) ($parts[0] ?? 0);
        $minutes = (int) ($parts[1] ?? 0);

        return $hours * 60 + $minutes;
    }
}
