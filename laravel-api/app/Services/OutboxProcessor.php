<?php

namespace App\Services;

use App\Models\OutboxEvent;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use RuntimeException;

class OutboxProcessor
{
    public function __construct(private readonly CurrentSchool $currentSchool) {}

    public function processBatch(int $limit = 50): array
    {
        OutboxEvent::query()->where('status', 'processing')->where('locked_at', '<', now()->subMinutes(10))
            ->update(['status' => 'pending', 'locked_by' => null, 'locked_at' => null]);

        $counts = ['processed' => 0, 'retried' => 0, 'dead_lettered' => 0];
        for ($i = 0; $i < $limit; $i++) {
            $event = $this->claim();
            if (! $event) {
                break;
            }
            try {
                $this->currentSchool->run((int) $event->school_id, fn () => $this->dispatch($event));
                $event->forceFill([
                    'status' => 'completed', 'processed_at' => now(), 'last_error' => null,
                    'locked_by' => null, 'locked_at' => null,
                ])->save();
                $counts['processed']++;
            } catch (\Throwable $exception) {
                $attempts = $event->attempts + 1;
                $dead = $attempts >= $event->max_attempts;
                $event->forceFill([
                    'attempts' => $attempts,
                    'status' => $dead ? 'dead_lettered' : 'pending',
                    'available_at' => $dead ? $event->available_at : now()->addSeconds(min(3600, 2 ** min($attempts, 11))),
                    'last_error' => Str::limit($exception->getMessage(), 4000),
                    'dead_lettered_at' => $dead ? now() : null,
                    'locked_by' => null, 'locked_at' => null,
                ])->save();
                $counts[$dead ? 'dead_lettered' : 'retried']++;
            }
        }

        return $counts;
    }

    public function retry(string $eventId): bool
    {
        return OutboxEvent::query()->where('event_id', $eventId)->where('status', 'dead_lettered')->update([
            'status' => 'pending', 'attempts' => 0, 'available_at' => now(), 'last_error' => null,
            'dead_lettered_at' => null, 'locked_by' => null, 'locked_at' => null,
        ]) === 1;
    }

    private function claim(): ?OutboxEvent
    {
        return DB::transaction(function () {
            $query = OutboxEvent::query()->where('status', 'pending')->where('available_at', '<=', now())->orderBy('id');
            $event = DB::getDriverName() === 'pgsql'
                ? $query->lock('FOR UPDATE SKIP LOCKED')->first()
                : $query->lockForUpdate()->first();
            if (! $event) {
                return null;
            }
            $event->forceFill(['status' => 'processing', 'locked_by' => (string) Str::uuid(), 'locked_at' => now()])->save();

            return $event->fresh();
        });
    }

    private function dispatch(OutboxEvent $event): void
    {
        match ($event->type) {
            'attendance.absence_recorded' => $this->absence($event),
            default => throw new RuntimeException("No outbox handler is registered for {$event->type}."),
        };
    }

    private function absence(OutboxEvent $event): void
    {
        $student = User::findOrFail($event->payload['student_id']);
        NotificationService::sendToParents($student->id, 'absence_alert', [
            'student_name' => $student->name,
            'date' => $event->payload['date'],
            'outbox_event_id' => $event->event_id,
        ], ['source_type' => 'outbox_event', 'source_id' => $event->id]);
    }
}
