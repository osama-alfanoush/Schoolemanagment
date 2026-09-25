<?php

namespace App\Console\Commands;

use App\Models\School;
use App\Services\CurrentSchool;
use App\Services\InstallmentReminderService;
use Illuminate\Console\Command;

class SendInstallmentReminders extends Command
{
    protected $signature = 'installments:send-reminders';

    protected $description = 'Notify students/parents about installments due soon or overdue';

    public function handle(InstallmentReminderService $reminders, CurrentSchool $currentSchool): int
    {
        $sent = 0;
        School::query()->where('is_active', true)->orderBy('id')->pluck('id')
            ->each(function (int $schoolId) use (&$sent, $currentSchool, $reminders): void {
                $sent += $currentSchool->run($schoolId, fn (): int => $reminders->send());
            });
        $this->info("Sent {$sent} installment reminder(s).");

        return self::SUCCESS;
    }
}
