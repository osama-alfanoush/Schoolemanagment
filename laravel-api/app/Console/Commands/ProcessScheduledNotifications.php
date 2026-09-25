<?php

namespace App\Console\Commands;

use App\Models\School;
use App\Services\CurrentSchool;
use App\Services\NotificationService;
use Illuminate\Console\Command;

class ProcessScheduledNotifications extends Command
{
    protected $signature = 'notifications:process-scheduled';

    protected $description = 'Deliver notifications whose scheduled_at time has passed';

    public function handle(CurrentSchool $currentSchool): int
    {
        $processed = 0;
        School::query()->where('is_active', true)->orderBy('id')->pluck('id')
            ->each(function (int $schoolId) use (&$processed, $currentSchool): void {
                $processed += $currentSchool->run(
                    $schoolId,
                    fn (): int => NotificationService::processScheduled(),
                );
            });

        $this->info("Processed {$processed} scheduled notification(s).");

        return self::SUCCESS;
    }
}
