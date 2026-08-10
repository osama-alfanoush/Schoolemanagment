<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Services\AlertDispatcher;
use App\Services\IntegrationGate;
use Illuminate\Console\Command;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Storage;
use Throwable;

/**
 * The operational monitors, evaluated on a schedule.
 *
 * Each check answers a question that would otherwise only be answered by a user
 * complaining: is the queue draining, did the scheduler stop, is the database
 * running out of connections, did last night's backup actually happen, are
 * payment webhooks failing.
 *
 * Every check is fail-safe. A check that cannot run reports critical rather
 * than passing quietly, because "the monitor is broken" and "the thing being
 * monitored is broken" must not look the same from the outside.
 */
class MonitorOperations extends Command
{
    protected $signature = 'ops:monitor
        {--json : Emit machine-readable JSON}
        {--only= : Run a single monitor by name}
        {--no-alert : Evaluate and report without dispatching alerts}';

    protected $description = 'Evaluate operational monitors and dispatch alerts on breach';

    /** Cache key the scheduler heartbeat writes to. */
    public const HEARTBEAT_KEY = 'ops:scheduler:heartbeat';

    /** @var array<string, array{status: string, summary: string, context: array<string, mixed>}> */
    private array $results = [];

    public function handle(AlertDispatcher $alerts): int
    {
        $only = $this->option('only');

        foreach ([
            'dependencies' => fn () => $this->checkDependencies(),
            'queue' => fn () => $this->checkQueue(),
            'scheduler' => fn () => $this->checkScheduler(),
            'database' => fn () => $this->checkDatabase(),
            'redis' => fn () => $this->checkRedis(),
            'backup' => fn () => $this->checkBackup(),
            'payments' => fn () => $this->checkPayments(),
        ] as $name => $check) {
            if ($only !== null && $only !== $name) {
                continue;
            }

            try {
                $check();
            } catch (Throwable $e) {
                // A monitor that throws is itself an incident.
                $this->record($name, 'critical', 'Monitor failed to run: '.$e->getMessage());
            }
        }

        $breaches = array_filter($this->results, fn ($r) => $r['status'] !== 'ok');

        if (! $this->option('no-alert')) {
            foreach ($breaches as $monitor => $result) {
                $result['context']['delivery'] = $alerts->send(
                    $monitor,
                    $result['status'],
                    $result['summary'],
                    $result['context']
                );
                $this->results[$monitor] = $result;
            }
        }

        $worst = $this->worstSeverity();

        if ($this->option('json')) {
            $this->line(json_encode([
                'status' => $worst,
                'environment' => config('app.env'),
                'release' => config('app.release', 'unknown'),
                'checked_at' => now()->toIso8601String(),
                'monitors' => $this->results,
            ], JSON_PRETTY_PRINT | JSON_THROW_ON_ERROR));
        } else {
            foreach ($this->results as $name => $r) {
                $line = sprintf('%-14s %-8s %s', $name, $r['status'], $r['summary']);
                match ($r['status']) {
                    'ok' => $this->info($line),
                    'warning' => $this->warn($line),
                    default => $this->error($line),
                };
            }
        }

        // Non-zero on critical only: a warning should not fail a deploy gate or
        // a cron wrapper, but a critical should be visible to both.
        return $worst === 'critical' ? self::FAILURE : self::SUCCESS;
    }

    // ------------------------------------------------------------- monitors

    private function checkDependencies(): void
    {
        $failures = [];

        try {
            DB::selectOne('select 1');
        } catch (Throwable $e) {
            $failures[] = 'database';
        }

        try {
            Cache::put('ops:monitor:probe', 'ok', 10);
            if (Cache::get('ops:monitor:probe') !== 'ok') {
                $failures[] = 'cache';
            }
        } catch (Throwable $e) {
            $failures[] = 'cache';
        }

        try {
            Storage::disk(config('filesystems.private_uploads_disk'))->put('.monitor-probe', 'ok');
            Storage::disk(config('filesystems.private_uploads_disk'))->delete('.monitor-probe');
        } catch (Throwable $e) {
            $failures[] = 'private-storage';
        }

        $failures === []
            ? $this->record('dependencies', 'ok', 'database, cache and private storage reachable')
            : $this->record('dependencies', 'critical', 'Unreachable: '.implode(', ', $failures), ['failed' => $failures]);
    }

    private function checkQueue(): void
    {
        $failed = (int) DB::table('failed_jobs')->count();
        $pendingOutbox = (int) DB::table('outbox_events')->where('status', 'pending')->count();

        $t = config('alerting.thresholds');
        $context = ['failed_jobs' => $failed, 'outbox_pending' => $pendingOutbox];

        if ($failed >= $t['failed_jobs_critical'] || $pendingOutbox >= $t['outbox_pending_critical']) {
            $this->record('queue', 'critical', "Queue degraded: {$failed} failed job(s), {$pendingOutbox} pending outbox event(s)", $context);

            return;
        }

        if ($failed >= $t['failed_jobs_warning'] || $pendingOutbox >= $t['outbox_pending_warning']) {
            $this->record('queue', 'warning', "Queue attention: {$failed} failed job(s), {$pendingOutbox} pending outbox event(s)", $context);

            return;
        }

        $this->record('queue', 'ok', 'no failed jobs, outbox draining', $context);
    }

    private function checkScheduler(): void
    {
        $last = Cache::get(self::HEARTBEAT_KEY);
        $t = config('alerting.thresholds');

        if (! $last) {
            $this->record('scheduler', 'critical', 'No scheduler heartbeat has ever been recorded');

            return;
        }

        $age = (int) round(now()->diffInSeconds(Carbon::parse($last), true));
        $context = ['last_run' => $last, 'age_seconds' => $age];

        if ($age >= $t['scheduler_heartbeat_critical_seconds']) {
            $this->record('scheduler', 'critical', "Scheduler has not run for {$age}s", $context);

            return;
        }

        if ($age >= $t['scheduler_heartbeat_warning_seconds']) {
            $this->record('scheduler', 'warning', "Scheduler last ran {$age}s ago", $context);

            return;
        }

        $this->record('scheduler', 'ok', "heartbeat {$age}s old", $context);
    }

    private function checkDatabase(): void
    {
        if (DB::connection()->getDriverName() !== 'pgsql') {
            $this->record('database', 'ok', 'connection saturation check applies to PostgreSQL only');

            return;
        }

        $max = (int) DB::selectOne('show max_connections')->max_connections;
        $used = (int) DB::selectOne('select count(*) c from pg_stat_activity')->c;
        $pct = $max > 0 ? (int) round($used / $max * 100) : 0;

        $t = config('alerting.thresholds');
        $context = ['used' => $used, 'max' => $max, 'percent' => $pct];
        $summary = "{$used}/{$max} connections ({$pct}%)";

        match (true) {
            $pct >= $t['db_connection_critical_pct'] => $this->record('database', 'critical', "Connection pool saturated: $summary", $context),
            $pct >= $t['db_connection_warning_pct'] => $this->record('database', 'warning', "Connections high: $summary", $context),
            default => $this->record('database', 'ok', $summary, $context),
        };
    }

    private function checkRedis(): void
    {
        $info = Redis::connection()->info('memory');
        $used = (int) ($info['used_memory'] ?? $info['Memory']['used_memory'] ?? 0);
        $max = (int) ($info['maxmemory'] ?? $info['Memory']['maxmemory'] ?? 0);

        if ($max === 0) {
            $this->record('redis', 'ok', 'reachable; no maxmemory configured', ['used_bytes' => $used]);

            return;
        }

        $pct = (int) round($used / $max * 100);
        $t = config('alerting.thresholds');
        $context = ['used_bytes' => $used, 'max_bytes' => $max, 'percent' => $pct];

        // The eviction policy is noeviction so queued jobs are never silently
        // dropped, which means a full Redis refuses writes instead.
        match (true) {
            $pct >= $t['redis_memory_critical_pct'] => $this->record('redis', 'critical', "Redis memory {$pct}% of maxmemory; writes will start failing", $context),
            $pct >= $t['redis_memory_warning_pct'] => $this->record('redis', 'warning', "Redis memory {$pct}% of maxmemory", $context),
            default => $this->record('redis', 'ok', "memory {$pct}% of maxmemory", $context),
        };
    }

    private function checkBackup(): void
    {
        $marker = base_path('backups/last-success.txt');
        $t = config('alerting.thresholds');

        if (! is_file($marker)) {
            $this->record('backup', 'critical', 'No successful backup has ever been recorded');

            return;
        }

        $ageHours = (int) round((time() - (int) filemtime($marker)) / 3600);
        $context = ['age_hours' => $ageHours];

        match (true) {
            $ageHours >= $t['backup_age_critical_hours'] => $this->record('backup', 'critical', "Last successful backup was {$ageHours}h ago", $context),
            $ageHours >= $t['backup_age_warning_hours'] => $this->record('backup', 'warning', "Last successful backup was {$ageHours}h ago", $context),
            default => $this->record('backup', 'ok', "last backup {$ageHours}h ago", $context),
        };
    }

    private function checkPayments(): void
    {
        $gate = app(IntegrationGate::class);

        if (! $gate->enabled(IntegrationGate::PAYMENTS)) {
            // Disabled is a valid production state — manual receipts still
            // work — so this is informational, not a breach.
            $this->record('payments', 'ok', 'payments integration disabled; no webhook traffic expected');

            return;
        }

        $t = config('alerting.thresholds');
        $failed = (int) DB::table('payment_webhook_events')
            ->where('status', 'failed')
            ->where('updated_at', '>=', now()->subHour())
            ->count();

        $stuck = (int) DB::table('payment_webhook_events')
            ->where('status', 'processing')
            ->where('updated_at', '<', now()->subMinutes(15))
            ->count();

        $context = ['failed_last_hour' => $failed, 'stuck_processing' => $stuck];

        match (true) {
            $failed >= $t['webhook_failures_critical'] || $stuck > 0 => $this->record('payments', 'critical', "Payment webhooks failing: {$failed} failed in the last hour, {$stuck} stuck", $context),
            $failed >= $t['webhook_failures_warning'] => $this->record('payments', 'warning', "{$failed} payment webhook failure(s) in the last hour", $context),
            default => $this->record('payments', 'ok', 'no recent webhook failures', $context),
        };
    }

    // -------------------------------------------------------------- helpers

    private function record(string $monitor, string $status, string $summary, array $context = []): void
    {
        $this->results[$monitor] = compact('status', 'summary', 'context');
    }

    private function worstSeverity(): string
    {
        $statuses = array_column($this->results, 'status');

        return match (true) {
            in_array('critical', $statuses, true) => 'critical',
            in_array('warning', $statuses, true) => 'warning',
            default => 'ok',
        };
    }
}
