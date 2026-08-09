<?php

use App\Services\OutboxProcessor;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Schedule::command('hr:check-contracts')->dailyAt('08:00');

// Deliver scheduled notifications shortly after their scheduled_at time.
Schedule::command('notifications:process-scheduled')->everyFiveMinutes()->withoutOverlapping();

// Enforce the audit-log retention policy (config/audit.php).
Schedule::command('audit:clean')->dailyAt('02:30');

// Purge expired Sanctum access/refresh tokens so personal_access_tokens
// doesn't grow unbounded (tokens rotate on every refresh).
Schedule::command('sanctum:prune-expired --hours=24')->daily();

// Remind students/parents about installments due within 3 days or overdue.
Schedule::command('installments:send-reminders')->dailyAt('07:30');

Artisan::command('outbox:work {--limit=50}', function (OutboxProcessor $processor) {
    $this->info(json_encode($processor->processBatch((int) $this->option('limit')), JSON_THROW_ON_ERROR));
})->purpose('Deliver pending transactional outbox events with retry/dead-letter handling');

Artisan::command('outbox:retry {eventId}', function (string $eventId, OutboxProcessor $processor) {
    return $processor->retry($eventId) ? $this->info('Event queued for retry.') : $this->error('Dead-letter event not found.');
})->purpose('Retry one dead-lettered outbox event');

Schedule::command('outbox:work --limit=100')->everyMinute()->withoutOverlapping();
