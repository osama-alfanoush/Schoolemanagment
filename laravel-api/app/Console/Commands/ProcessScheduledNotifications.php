<?php

namespace App\Console\Commands;

use App\Services\NotificationService;
use Illuminate\Console\Command;

class ProcessScheduledNotifications extends Command
{
    protected $signature = 'notifications:process-scheduled';

    protected $description = 'Deliver notifications whose scheduled_at time has passed';

    public function handle(): int
    {
        $processed = NotificationService::processScheduled();

        $this->info("Processed {$processed} scheduled notification(s).");

        return self::SUCCESS;
    }
}
