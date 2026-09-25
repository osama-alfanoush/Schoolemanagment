<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    private array $profileSchool = [];

    public function up(): void
    {
        $this->preflight();

        foreach (['payroll_records', 'payroll_record_components', 'staff_payroll_components', 'disciplinary_warnings',
            'employee_advances', 'employee_advance_installments', 'staff_attendance', 'hr_requests',
            'journal_batches', 'journal_entries', 'financial_closings'] as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            });
        }

        $onlySchool = DB::table('schools')->count() === 1 ? (int) DB::table('schools')->value('id') : null;
        foreach ($this->profileSchool as $profileId => $schoolId) {
            DB::table('staff_profiles')->where('id', $profileId)->update(['school_id' => $schoolId]);
        }
        DB::table('employee_contracts')->whereNull('school_id')->orderBy('id')->each(function ($row) {
            DB::table('employee_contracts')->where('id', $row->id)->update([
                'school_id' => DB::table('staff_profiles')->where('id', $row->staff_profile_id)->value('school_id'),
            ]);
        });

        foreach (['hr_payroll_settings', 'payroll_components', 'social_insurance_schemes', 'payroll_account_settings'] as $table) {
            if ($onlySchool) {
                DB::table($table)->whereNull('school_id')->update(['school_id' => $onlySchool, 'scope_key' => 'school:'.$onlySchool]);
            }
        }

        DB::table('payroll_runs')->orderBy('id')->each(function ($run) use ($onlySchool) {
            $schoolIds = DB::table('payroll_records')->join('staff_profiles', 'staff_profiles.user_id', '=', 'payroll_records.staff_user_id')
                ->where('payroll_records.payroll_run_id', $run->id)->distinct()->pluck('staff_profiles.school_id')->filter();
            $schoolId = $schoolIds->count() === 1 ? (int) $schoolIds->first() : $onlySchool;
            DB::table('payroll_runs')->where('id', $run->id)->update(['school_id' => $schoolId, 'scope_key' => 'school:'.$schoolId]);
        });
        DB::table('payroll_records')->orderBy('id')->each(function ($row) {
            $schoolId = DB::table('staff_profiles')->where('user_id', $row->staff_user_id)->value('school_id');
            DB::table('payroll_records')->where('id', $row->id)->update(['school_id' => $schoolId]);
        });
        DB::table('payroll_record_components')->orderBy('id')->each(function ($row) {
            $schoolId = DB::table('payroll_records')->where('id', $row->payroll_record_id)->value('school_id');
            DB::table('payroll_record_components')->where('id', $row->id)->update(['school_id' => $schoolId]);
        });
        foreach (['staff_payroll_components', 'disciplinary_warnings', 'employee_advances'] as $table) {
            DB::table($table)->orderBy('id')->each(function ($row) use ($table) {
                $schoolId = DB::table('staff_profiles')->where('id', $row->staff_profile_id)->value('school_id');
                DB::table($table)->where('id', $row->id)->update(['school_id' => $schoolId]);
            });
        }
        DB::table('employee_advance_installments')->orderBy('id')->each(function ($row) {
            $schoolId = DB::table('employee_advances')->where('id', $row->employee_advance_id)->value('school_id');
            DB::table('employee_advance_installments')->where('id', $row->id)->update(['school_id' => $schoolId]);
        });
        foreach (['staff_attendance' => 'staff_user_id', 'hr_requests' => 'teacher_user_id'] as $table => $userColumn) {
            DB::table($table)->orderBy('id')->each(function ($row) use ($table, $userColumn) {
                $schoolId = DB::table('staff_profiles')->where('user_id', $row->{$userColumn})->value('school_id');
                DB::table($table)->where('id', $row->id)->update(['school_id' => $schoolId]);
            });
        }
        if ($onlySchool) {
            DB::table('financial_closings')->whereNull('school_id')->update(['school_id' => $onlySchool]);
        }

        foreach (['payroll_accrual', 'payroll', 'payroll_reversal', 'employee_advance', 'employee_advance_settlement'] as $source) {
            DB::table('journal_batches')->where('source', $source)->whereNull('school_id')->orderBy('id')->each(function ($batch) use ($onlySchool) {
                $schoolId = $onlySchool;
                if (in_array($batch->source, ['payroll_accrual', 'payroll'], true)) {
                    $schoolId = DB::table('payroll_runs')->where('id', $batch->source_id)->value('school_id');
                }
                if (in_array($batch->source, ['employee_advance', 'employee_advance_settlement'], true)) {
                    $schoolId = DB::table('employee_advances')->where('id', $batch->source_id)->value('school_id');
                }
                if ($batch->source === 'payroll_reversal') {
                    $schoolId = DB::table('journal_batches')->where('id', $batch->source_id)->value('school_id');
                }
                if ($schoolId) {
                    DB::table('journal_batches')->where('id', $batch->id)->update(['school_id' => $schoolId]);
                    DB::table('journal_entries')->where('journal_batch_id', $batch->id)->update(['school_id' => $schoolId]);
                }
            });
        }

        Schema::table('payroll_records', fn (Blueprint $table) => $table->dropUnique('payroll_records_staff_user_id_year_month_unique'));
        Schema::table('payroll_runs', fn (Blueprint $table) => $table->dropUnique('payroll_run_scope_period_unique'));
        Schema::table('financial_closings', fn (Blueprint $table) => $table->dropUnique('financial_closings_month_year_unique'));

        Schema::table('financial_closings', fn (Blueprint $table) => $table->unique(['school_id', 'month', 'year'], 'financial_closing_school_period_unique'));

        foreach (['staff_profiles', 'employee_contracts', 'hr_payroll_settings', 'payroll_components', 'social_insurance_schemes',
            'payroll_account_settings', 'payroll_runs', 'payroll_records', 'payroll_record_components', 'staff_payroll_components',
            'disciplinary_warnings', 'employee_advances', 'employee_advance_installments', 'staff_attendance', 'hr_requests', 'financial_closings'] as $tableName) {
            Schema::table($tableName, fn (Blueprint $table) => $table->unsignedBigInteger('school_id')->nullable(false)->change());
        }
        // Create partial indexes after SQLite table rebuilds performed by change().
        DB::statement("CREATE UNIQUE INDEX payroll_record_active_school_period_unique ON payroll_records (school_id, staff_user_id, year, month) WHERE status <> 'reversed'");
        DB::statement("CREATE UNIQUE INDEX payroll_run_active_school_period_unique ON payroll_runs (school_id, year, month) WHERE status <> 'reversed'");
    }

    private function preflight(): void
    {
        $conflicts = [];
        DB::table('staff_profiles')->orderBy('id')->each(function ($profile) use (&$conflicts) {
            $authorised = DB::table('school_user_roles')->where('user_id', $profile->user_id)
                ->where(fn ($q) => $q->whereNull('starts_on')->orWhere('starts_on', '<=', now()->toDateString()))
                ->where(fn ($q) => $q->whereNull('ends_on')->orWhere('ends_on', '>=', now()->toDateString()))
                ->distinct()->pluck('school_id');
            $ids = $profile->school_id ? $authorised->filter(fn ($id) => (int) $id === (int) $profile->school_id) : $authorised;
            if ($ids->count() !== 1) {
                $conflicts[] = "staff_profiles:{$profile->id}:school_candidates=[".$ids->implode(',').']';
            } else {
                $this->profileSchool[$profile->id] = (int) $ids->first();
            }
        });

        $schoolCount = DB::table('schools')->count();
        if ($schoolCount !== 1) {
            foreach (['hr_payroll_settings', 'payroll_components', 'social_insurance_schemes', 'payroll_account_settings', 'financial_closings'] as $table) {
                $ids = DB::table($table)->whereNull('school_id')->limit(25)->pluck('id');
                if ($ids->isNotEmpty()) {
                    $conflicts[] = "{$table}:null_school_ids=[".$ids->implode(',').']';
                }
            }
        }

        DB::table('payroll_runs')->orderBy('id')->each(function ($run) use (&$conflicts, $schoolCount) {
            $ids = DB::table('payroll_records')->join('staff_profiles', 'staff_profiles.user_id', '=', 'payroll_records.staff_user_id')
                ->where('payroll_records.payroll_run_id', $run->id)->pluck('staff_profiles.id')
                ->map(fn ($profileId) => $this->profileSchool[$profileId] ?? null)->filter()->unique()->values();
            if ($ids->count() > 1 || ($ids->isEmpty() && ! $run->school_id && $schoolCount !== 1)) {
                $conflicts[] = "payroll_runs:{$run->id}:school_candidates=[".$ids->implode(',').']';
            }
        });

        if ($schoolCount !== 1) {
            DB::table('journal_batches')->whereIn('source', ['payroll_accrual', 'payroll', 'payroll_reversal', 'employee_advance', 'employee_advance_settlement'])
                ->orderBy('id')->each(function ($batch) use (&$conflicts) {
                    $schoolId = null;
                    if (in_array($batch->source, ['payroll_accrual', 'payroll'], true)) {
                        $run = DB::table('payroll_runs')->where('id', $batch->source_id)->first();
                        if ($run) {
                            $profileIds = DB::table('payroll_records')->join('staff_profiles', 'staff_profiles.user_id', '=', 'payroll_records.staff_user_id')
                                ->where('payroll_records.payroll_run_id', $run->id)->pluck('staff_profiles.id');
                            $ids = $profileIds->map(fn ($id) => $this->profileSchool[$id] ?? null)->filter()->unique();
                            $schoolId = $ids->count() === 1 ? $ids->first() : null;
                        }
                    } elseif (in_array($batch->source, ['employee_advance', 'employee_advance_settlement'], true)) {
                        $profileId = DB::table('employee_advances')->where('id', $batch->source_id)->value('staff_profile_id');
                        $schoolId = $this->profileSchool[$profileId] ?? null;
                    } elseif ($batch->source === 'payroll_reversal') {
                        $original = DB::table('journal_batches')->where('id', $batch->source_id)->first();
                        if ($original && in_array($original->source, ['payroll_accrual', 'payroll'], true)) {
                            $run = DB::table('payroll_runs')->where('id', $original->source_id)->first();
                            $profileIds = $run ? DB::table('payroll_records')->join('staff_profiles', 'staff_profiles.user_id', '=', 'payroll_records.staff_user_id')
                                ->where('payroll_records.payroll_run_id', $run->id)->pluck('staff_profiles.id') : collect();
                            $ids = $profileIds->map(fn ($id) => $this->profileSchool[$id] ?? null)->filter()->unique();
                            $schoolId = $ids->count() === 1 ? $ids->first() : null;
                        }
                    }
                    if (! $schoolId) {
                        $conflicts[] = "journal_batches:{$batch->id}:cannot_infer_school_for_source={$batch->source}";
                    }
                });
        }

        $duplicates = DB::table('payroll_records')->join('staff_profiles', 'staff_profiles.user_id', '=', 'payroll_records.staff_user_id')
            ->where('payroll_records.status', '<>', 'reversed')
            ->selectRaw('staff_profiles.school_id, payroll_records.staff_user_id, payroll_records.year, payroll_records.month, COUNT(*) aggregate')
            ->groupBy('staff_profiles.school_id', 'payroll_records.staff_user_id', 'payroll_records.year', 'payroll_records.month')->havingRaw('COUNT(*) > 1')->get();
        foreach ($duplicates as $duplicate) {
            $conflicts[] = "payroll_records:duplicate_active:school={$duplicate->school_id},staff={$duplicate->staff_user_id},period={$duplicate->year}-{$duplicate->month},count={$duplicate->aggregate}";
        }

        if ($conflicts !== []) {
            throw new RuntimeException("HR/Payroll school-scope preflight failed; no data was changed. Resolve explicitly and rerun:\n - ".implode("\n - ", $conflicts));
        }
    }

    public function down(): void
    {
        $rollbackConflicts = [];
        foreach ([
            'payroll_records' => ['staff_user_id', 'year', 'month'],
            'payroll_runs' => ['year', 'month'],
            'financial_closings' => ['month', 'year'],
        ] as $table => $columns) {
            $groups = DB::table($table)->select($columns)->selectRaw('COUNT(*) aggregate')
                ->groupBy($columns)->havingRaw('COUNT(*) > 1')->limit(25)->get();
            foreach ($groups as $group) {
                $rollbackConflicts[] = $table.':'.collect($columns)->map(fn ($column) => $column.'='.$group->{$column})->implode(',');
            }
        }
        $schoolIds = collect(['payroll_records', 'payroll_runs', 'staff_profiles', 'employee_advances'])
            ->flatMap(fn ($table) => DB::table($table)->distinct()->pluck('school_id'))->filter()->unique();
        if ($schoolIds->count() > 1) {
            $rollbackConflicts[] = 'multiple_school_ids=['.$schoolIds->implode(',').']';
        }
        if ($rollbackConflicts !== []) {
            throw new RuntimeException("Safe rollback refused before changing schema. The legacy schema cannot represent current data:\n - ".implode("\n - ", $rollbackConflicts));
        }

        DB::statement('DROP INDEX IF EXISTS payroll_record_active_school_period_unique');
        DB::statement('DROP INDEX IF EXISTS payroll_run_active_school_period_unique');
        Schema::table('financial_closings', fn (Blueprint $table) => $table->dropUnique('financial_closing_school_period_unique'));
        Schema::table('payroll_records', fn (Blueprint $table) => $table->unique(['staff_user_id', 'year', 'month']));
        Schema::table('payroll_runs', fn (Blueprint $table) => $table->unique(['scope_key', 'year', 'month'], 'payroll_run_scope_period_unique'));
        Schema::table('financial_closings', fn (Blueprint $table) => $table->unique(['month', 'year']));
        foreach (array_reverse(['payroll_records', 'payroll_record_components', 'staff_payroll_components', 'disciplinary_warnings',
            'employee_advances', 'employee_advance_installments', 'staff_attendance', 'hr_requests',
            'journal_batches', 'journal_entries', 'financial_closings']) as $tableName) {
            Schema::table($tableName, fn (Blueprint $table) => $table->dropConstrainedForeignId('school_id'));
        }
        foreach (['staff_profiles', 'employee_contracts', 'hr_payroll_settings', 'payroll_components', 'social_insurance_schemes', 'payroll_account_settings', 'payroll_runs'] as $tableName) {
            Schema::table($tableName, fn (Blueprint $table) => $table->unsignedBigInteger('school_id')->nullable()->change());
        }
    }
};
