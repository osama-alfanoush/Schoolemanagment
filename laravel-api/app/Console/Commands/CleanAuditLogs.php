<?php

namespace App\Console\Commands;

use App\Services\AuditLogger;
use Illuminate\Console\Command;

class CleanAuditLogs extends Command
{
    protected $signature = 'audit:clean {--days= : Override the configured retention period in days}';

    protected $description = 'Delete audit-log entries older than the configured retention period';

    public function handle(): int
    {
        $keepDays = (int) ($this->option('days') ?? config('audit.retention_days', 90));

        if ($keepDays < 1) {
            $this->error('Retention period must be at least 1 day.');

            return self::FAILURE;
        }

        $deleted = AuditLogger::clean($keepDays);

        $this->info("Deleted {$deleted} audit-log entr".($deleted === 1 ? 'y' : 'ies')." older than {$keepDays} day(s).");

        return self::SUCCESS;
    }
}
