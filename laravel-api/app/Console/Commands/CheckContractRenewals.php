<?php

namespace App\Console\Commands;

use App\Models\ContractAlertDelivery;
use App\Models\EmployeeContract;
use App\Models\HrPayrollSetting;
use App\Models\User;
use App\Services\CurrentSchool;
use App\Services\NotificationService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class CheckContractRenewals extends Command
{
    protected $signature = 'hr:check-contracts {--days=* : Override configured alert thresholds}';

    protected $description = 'Send idempotent alerts for effective-dated employee contracts nearing expiry';

    public function handle(CurrentSchool $currentSchool): int
    {
        $sent = 0;
        $checked = 0;
        foreach (HrPayrollSetting::whereNotNull('school_id')->get() as $setting) {
            $currentSchool->run((int) $setting->school_id, function () use ($setting, &$sent, &$checked): void {
                $thresholds = collect($this->option('days') ?: $setting->contract_alert_days ?? [7, 30, 60, 90])
                    ->map(fn ($days) => (int) $days)->filter(fn ($days) => $days > 0)->unique()->sort()->values();
                if ($thresholds->isEmpty()) {
                    return;
                }

                $recipients = User::whereIn('role', ['hr', 'admin'])->where('is_active', true)
                    ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $setting->school_id))
                    ->pluck('id')->all();
                $contracts = EmployeeContract::with('staffProfile.user')
                    ->where('is_current', true)->where('status', 'active')->whereNotNull('end_date')
                    ->whereBetween('end_date', [now()->startOfDay(), now()->addDays($thresholds->max())->endOfDay()])
                    ->get();
                $checked += $contracts->count();

                foreach ($contracts as $contract) {
                    $daysRemaining = (int) now()->startOfDay()->diffInDays($contract->end_date, false);
                    foreach ($thresholds->filter(fn ($threshold) => $daysRemaining <= $threshold) as $threshold) {
                        $delivery = DB::transaction(fn () => ContractAlertDelivery::firstOrCreate(
                            ['employee_contract_id' => $contract->id, 'threshold_days' => $threshold],
                            ['sent_at' => now()],
                        ));
                        if (! $delivery->wasRecentlyCreated) {
                            continue;
                        }

                        NotificationService::sendToMany($recipients, 'contract_expiry_alert', [
                            'employee_id' => $contract->staffProfile->user_id,
                            'employee_name' => $contract->staffProfile->user->name,
                            'contract_end' => $contract->end_date->format('Y-m-d'),
                            'days_remaining' => $daysRemaining,
                        ]);
                        $sent++;
                    }
                }
            });
        }
        $this->info("Checked {$checked} contracts; sent {$sent} new alert(s).");

        return self::SUCCESS;
    }
}
