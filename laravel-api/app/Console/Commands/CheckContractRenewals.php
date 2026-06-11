<?php

namespace App\Console\Commands;

use App\Models\StaffProfile;
use App\Models\User;
use App\Services\NotificationService;
use Illuminate\Console\Command;

class CheckContractRenewals extends Command
{
    protected $signature = 'hr:check-contracts';
    protected $description = 'Send push alerts for contracts expiring within 30 days';

    public function handle(): int
    {
        $expiring = StaffProfile::whereNotNull('contract_end')
            ->whereBetween('contract_end', [now(), now()->addDays(30)])
            ->with('user')
            ->get();

        $hrAndAdminIds = User::whereIn('role', ['hr', 'admin'])
            ->where('is_active', true)
            ->pluck('id')
            ->toArray();

        foreach ($expiring as $staff) {
            NotificationService::sendToMany($hrAndAdminIds, 'contract_expiry_alert', [
                'employee_name' => $staff->user->name,
                'contract_end' => $staff->contract_end->format('Y-m-d'),
                'days_remaining' => (int) now()->diffInDays($staff->contract_end),
            ]);
        }

        $this->info("Found {$expiring->count()} contracts expiring soon.");

        return self::SUCCESS;
    }
}
