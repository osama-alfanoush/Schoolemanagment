<?php

namespace App\Console\Commands;

use App\Services\AuditLogger;
use Illuminate\Console\Command;

/**
 * Expire audit-log entries — but only once somebody has decided that they
 * should expire at all.
 *
 * This command was scheduled daily and hard-deleted anything older than 90
 * days, on an engineering default nobody had approved. That directly
 * contradicts the project's own retention inventory, which classifies audit
 * logs as "append-only external retention; never application delete", and it
 * destroys exactly the evidence an investigation or an inspection would need.
 * The 90 came from a framework habit, not from a school.
 *
 * It now refuses to delete anything until config('policy.retention.approved')
 * is true and an audit-log period has been set. Retaining too much is a
 * conversation; deleting too early is unrecoverable.
 */
class CleanAuditLogs extends Command
{
    protected $signature = 'audit:clean
        {--days= : Override the configured retention period in days}
        {--force : Required to delete when overriding --days by hand}';

    protected $description = 'Expire audit-log entries once an approved retention policy allows it';

    public function handle(): int
    {
        $approved = (bool) config('policy.retention.approved', false);
        $configured = config('policy.retention.audit_log_days');
        $override = $this->option('days');

        // A manual run with an explicit period and --force is allowed, because
        // an owner acting deliberately at the console is a different thing from
        // a cron job acting on a default. It is still recorded loudly.
        if ($override !== null) {
            if (! $this->option('force')) {
                $this->error('Refusing to delete audit history: pass --force to confirm a manual expiry run.');

                return self::FAILURE;
            }

            return $this->expire((int) $override, 'manual override');
        }

        if (! $approved) {
            $this->warn('audit:clean: no approved retention policy — nothing deleted.');
            $this->line('  Audit logs are a compliance record. Set RETENTION_POLICY_APPROVED=true and');
            $this->line('  RETENTION_AUDIT_LOG_DAYS only after a named owner approves the schedule');
            $this->line('  in docs/decision-register.md.');

            return self::SUCCESS;
        }

        if ($configured === null) {
            $this->warn('audit:clean: retention approved but RETENTION_AUDIT_LOG_DAYS is unset — keeping indefinitely.');

            return self::SUCCESS;
        }

        return $this->expire((int) $configured, 'approved policy: '.(config('policy.retention.approved_by') ?: 'owner not recorded'));
    }

    private function expire(int $keepDays, string $basis): int
    {
        if ($keepDays < 1) {
            $this->error('Retention period must be at least 1 day.');

            return self::FAILURE;
        }

        $deleted = AuditLogger::clean($keepDays);

        $this->info("Deleted {$deleted} audit-log entr".($deleted === 1 ? 'y' : 'ies')
            ." older than {$keepDays} day(s) [{$basis}].");

        return self::SUCCESS;
    }
}
