<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AppNotification;
use App\Models\ClassRoom;
use App\Models\Message;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MessagingController extends Controller
{
    public function threads(Request $request)
    {
        $uid = $request->user()->id;
        $threads = Message::where('sender_user_id', $uid)->orWhere('recipient_user_id', $uid)
            ->with(['sender:id,name,role', 'recipient:id,name,role'])
            ->orderBy('created_at', 'desc')->limit(200)->get()
            ->groupBy(function ($m) use ($uid) {
                return $m->sender_user_id === $uid ? $m->recipient_user_id : $m->sender_user_id;
            })->map(function ($msgs, $otherId) use ($uid) {
                $last = $msgs->first();
                $other = $last->sender_user_id === $uid ? $last->recipient : $last->sender;

                return [
                    'id' => (int) $otherId,
                    'other_user' => $this->userPayload($other),
                    'last_message' => $this->messagePayload($last, $uid),
                    'unread_count' => Message::where('sender_user_id', $otherId)
                        ->where('recipient_user_id', $uid)
                        ->whereNull('read_at')
                        ->count(),
                ];
            });
        return response()->json($threads->values());
    }

    public function recipients(Request $request)
    {
        $sender = $request->user();
        $search = trim((string) $request->query('search', ''));

        $users = User::query()
            ->select(['id', 'name', 'email', 'role', 'photo_path'])
            ->where('id', '!=', $sender->id)
            ->where('is_active', true)
            ->when($search !== '', function ($q) use ($search) {
                $q->where(function ($inner) use ($search) {
                    $inner->where('name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%");
                });
            })
            ->orderBy('name')
            ->limit(100)
            ->get()
            ->filter(fn(User $user) => $this->canMessage($sender, $user->id))
            ->values()
            ->map(fn(User $user) => $this->userPayload($user));

        return response()->json($users);
    }

    public function conversation(Request $request, int $otherId)
    {
        $uid = $request->user()->id;
        $hasConversation = Message::where(function ($q) use ($uid, $otherId) {
            $q->where('sender_user_id', $uid)->where('recipient_user_id', $otherId);
        })->orWhere(function ($q) use ($uid, $otherId) {
            $q->where('sender_user_id', $otherId)->where('recipient_user_id', $uid);
        })->exists();

        if (!$hasConversation && !$this->canMessage($request->user(), $otherId)) {
            return response()->json(['message' => 'You may not message this user.'], 403);
        }

        $msgs = Message::where(function ($q) use ($uid, $otherId) {
                $q->where('sender_user_id', $uid)->where('recipient_user_id', $otherId);
            })->orWhere(function ($q) use ($uid, $otherId) {
                $q->where('sender_user_id', $otherId)->where('recipient_user_id', $uid);
            })->with(['sender:id,name,role', 'recipient:id,name,role'])->orderBy('created_at')->get();
        Message::where('sender_user_id', $otherId)->where('recipient_user_id', $uid)
            ->whereNull('read_at')->update(['read_at' => now()]);
        return response()->json($msgs->map(fn(Message $msg) => $this->messagePayload($msg, $uid)));
    }

    public function send(Request $request)
    {
        $data = $request->validate([
            'recipient_user_id' => 'required|exists:users,id',
            'about_student_user_id' => 'nullable|exists:users,id',
            'body' => 'required|string|max:5000',
        ]);
        $data['body'] = trim($data['body']);
        if ($data['body'] === '') {
            return response()->json(['message' => 'Message cannot be empty.'], 422);
        }
        if (!$this->canMessage($request->user(), (int) $data['recipient_user_id'])) {
            return response()->json(['message' => 'You may not message this user.'], 403);
        }
        $msg = Message::create(array_merge($data, ['sender_user_id' => $request->user()->id]));
        \App\Services\Notifier::send($data['recipient_user_id'], 'message', 'New message', substr($data['body'], 0, 100), ['from' => $request->user()->id]);
        $msg->load(['sender:id,name,role', 'recipient:id,name,role']);
        return response()->json($this->messagePayload($msg, $request->user()->id), 201);
    }

    /**
     * Messaging policy:
     *   - Admin / Finance / HR may message anyone.
     *   - Teachers may message admins/HR, parents of their students, and students in their classes.
     *   - Parents may message their children's teachers, plus admin/HR.
     *   - Students may message their teachers and admin.
     */
    protected function canMessage(\App\Models\User $sender, int $recipientId): bool
    {
        if ($sender->id === $recipientId) return false;
        if (in_array($sender->role, ['admin', 'finance', 'hr', 'accounting', 'warehouse'], true)) return true;

        $recipient = User::find($recipientId);
        if (!$recipient || !$recipient->is_active) return false;
        if (in_array($recipient->role, ['admin', 'hr'], true)) return true;

        $db = DB::table('parent_student');

        if ($sender->role === 'teacher') {
            // Recipient must be a student in one of teacher's classes, OR a parent of such a student.
            $teacherClassIds = ClassRoom::where('homeroom_teacher_id', $sender->id)->pluck('id')
                ->merge(DB::table('class_subject_teacher')
                    ->where('teacher_user_id', $sender->id)->pluck('class_room_id'))
                ->unique()->values();
            if ($recipient->role === 'student') {
                return StudentProfile::where('user_id', $recipient->id)
                    ->whereIn('class_room_id', $teacherClassIds)->exists();
            }
            if ($recipient->role === 'parent') {
                $childIds = $db->where('parent_user_id', $recipient->id)->pluck('student_user_id');
                return StudentProfile::whereIn('user_id', $childIds)
                    ->whereIn('class_room_id', $teacherClassIds)->exists();
            }
            return false;
        }

        if ($sender->role === 'parent') {
            // Recipient must be a teacher of one of the parent's children.
            $childIds = $db->where('parent_user_id', $sender->id)->pluck('student_user_id');
            $childClassIds = StudentProfile::whereIn('user_id', $childIds)->pluck('class_room_id');
            if ($recipient->role !== 'teacher') return false;
            if (ClassRoom::whereIn('id', $childClassIds)->where('homeroom_teacher_id', $recipient->id)->exists()) return true;
            return DB::table('class_subject_teacher')
                ->whereIn('class_room_id', $childClassIds)->where('teacher_user_id', $recipient->id)->exists();
        }

        if ($sender->role === 'student') {
            // Recipient must be a teacher of the student's class.
            if ($recipient->role !== 'teacher') return false;
            $classId = StudentProfile::where('user_id', $sender->id)->value('class_room_id');
            if (!$classId) return false;
            if (ClassRoom::where('id', $classId)->where('homeroom_teacher_id', $recipient->id)->exists()) return true;
            return DB::table('class_subject_teacher')
                ->where('class_room_id', $classId)->where('teacher_user_id', $recipient->id)->exists();
        }

        return false;
    }

    protected function userPayload(?User $user): ?array
    {
        if (!$user) return null;

        return [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'role' => $user->role,
            'photo_path' => $user->photo_path,
        ];
    }

    protected function messagePayload(Message $message, int $currentUserId): array
    {
        return [
            'id' => $message->id,
            'sender_user_id' => $message->sender_user_id,
            'recipient_user_id' => $message->recipient_user_id,
            'about_student_user_id' => $message->about_student_user_id,
            'body' => $message->body,
            'read_at' => optional($message->read_at)->toISOString(),
            'created_at' => optional($message->created_at)->toISOString(),
            'is_mine' => $message->sender_user_id === $currentUserId,
            'sender' => $this->userPayload($message->sender),
            'recipient' => $this->userPayload($message->recipient),
        ];
    }

    public function notifications(Request $request)
    {
        return response()->json(AppNotification::where('user_id', $request->user()->id)
            ->latest()->paginate(50));
    }

    public function markNotificationRead(Request $request, int $id)
    {
        AppNotification::where('user_id', $request->user()->id)->where('id', $id)
            ->update(['read_at' => now()]);
        return response()->json(['message' => 'Marked read']);
    }

    public function unreadCount(Request $request)
    {
        return response()->json([
            'notifications' => AppNotification::where('user_id', $request->user()->id)->whereNull('read_at')->count(),
            'messages' => Message::where('recipient_user_id', $request->user()->id)->whereNull('read_at')->count(),
        ]);
    }
}
