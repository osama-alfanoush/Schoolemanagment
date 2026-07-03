<?php

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
