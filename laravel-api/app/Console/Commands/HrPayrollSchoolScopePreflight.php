<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class HrPayrollSchoolScopePreflight extends Command
{
    protected $signature = 'hr-payroll:school-scope-preflight';

    protected $description = 'Report ambiguous HR/payroll rows before the school-scope hardening migration';

    public function handle(): int
    {
        $conflicts = [];
        DB::table('staff_profiles')->orderBy('id')->each(function ($profile) use (&$conflicts) {
            if (isset($profile->school_id) && $profile->school_id) {
                return;
            }
            $ids = DB::table('school_user_roles')->where('user_id', $profile->user_id)->distinct()->pluck('school_id');
            if ($ids->count() !== 1) {
                $conflicts[] = ['resource' => 'staff_profile', 'id' => $profile->id, 'reason' => 'school candidates: ['.$ids->implode(',').']'];
            }
        });

        if (DB::table('schools')->count() !== 1) {
            foreach (['hr_payroll_settings', 'payroll_components', 'social_insurance_schemes', 'payroll_account_settings', 'financial_closings'] as $table) {
                if (! Schema::hasColumn($table, 'school_id')) {
                    if (DB::table($table)->exists()) {
                        $conflicts[] = ['resource' => $table, 'id' => '*', 'reason' => 'legacy global rows cannot be assigned across multiple schools'];
                    }

                    continue;
                }
                foreach (DB::table($table)->whereNull('school_id')->limit(100)->pluck('id') as $id) {
                    $conflicts[] = ['resource' => $table, 'id' => $id, 'reason' => 'school is null with multiple schools'];
                }
            }
        }

        if (Schema::hasColumn('payroll_records', 'school_id')) {
            $duplicates = DB::table('payroll_records')->where('status', '<>', 'reversed')
                ->selectRaw('school_id, staff_user_id, year, month, COUNT(*) aggregate')
                ->groupBy('school_id', 'staff_user_id', 'year', 'month')->havingRaw('COUNT(*) > 1')->get();
            foreach ($duplicates as $row) {
                $conflicts[] = ['resource' => 'payroll_records', 'id' => '*', 'reason' => "duplicate active school={$row->school_id}, staff={$row->staff_user_id}, period={$row->year}-{$row->month}"];
            }
        }

        if ($conflicts !== []) {
            $this->error('Preflight failed. No rows were changed. Resolve every mapping explicitly:');
            $this->table(['resource', 'id', 'reason'], $conflicts);

            return self::FAILURE;
        }

        $this->info('Preflight passed: no ambiguous school mappings or active payroll conflicts were found.');

        return self::SUCCESS;
    }
}
