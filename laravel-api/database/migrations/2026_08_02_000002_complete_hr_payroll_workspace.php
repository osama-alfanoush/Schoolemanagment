<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('journal_batches', function (Blueprint $table) {
            $table->string('idempotency_key')->nullable()->unique();
        });

        Schema::table('staff_profiles', function (Blueprint $table) {
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('employee_no')->nullable()->unique();
            $table->foreignId('supervisor_user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('employment_type')->nullable();
            $table->string('employment_status')->default('active');
            $table->date('termination_date')->nullable();
            $table->date('contract_start')->nullable();
            $table->unsignedSmallInteger('probation_days')->nullable();
            $table->date('probation_end')->nullable();
            $table->string('payment_method')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_account')->nullable();
            $table->boolean('social_insurance_registered')->default(false);
            $table->string('social_insurance_number')->nullable();
            $table->date('social_insurance_start')->nullable();
            $table->date('social_insurance_end')->nullable();
            $table->string('social_insurance_scheme_code')->nullable();
            $table->json('documents')->nullable();
            $table->index(['employment_status', 'contract_end']);
        });

        Schema::create('employee_contracts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('staff_profile_id')->constrained()->restrictOnDelete();
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('contract_no')->unique();
            $table->string('contract_type'); // fixed_term, indefinite
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->unsignedSmallInteger('probation_days')->nullable();
            $table->date('probation_end')->nullable();
            $table->decimal('base_salary', 14, 2);
            $table->string('payment_method')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_account')->nullable();
            $table->string('status')->default('active'); // draft, active, expired, terminated, superseded
            $table->boolean('is_current')->default(true);
            $table->foreignId('renewed_from_id')->nullable()->constrained('employee_contracts')->nullOnDelete();
            $table->json('attachments')->nullable();
            $table->text('notes')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
            $table->index(['staff_profile_id', 'start_date', 'end_date']);
            $table->index(['is_current', 'status', 'end_date']);
        });

        Schema::create('contract_alert_deliveries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_contract_id')->constrained()->cascadeOnDelete();
            $table->unsignedSmallInteger('threshold_days');
            $table->timestamp('sent_at');
            $table->timestamps();
            $table->unique(['employee_contract_id', 'threshold_days'], 'contract_alert_once');
        });

        Schema::create('hr_payroll_settings', function (Blueprint $table) {
            $table->id();
            $table->string('scope_key')->unique()->default('global');
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->json('contract_alert_days')->nullable();
            $table->string('proration_policy')->default('none');
            $table->string('negative_net_policy')->default('block');
            $table->string('currency')->default('USD');
            $table->timestamps();
        });

        Schema::create('payroll_components', function (Blueprint $table) {
            $table->id();
            $table->string('scope_key')->default('global');
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('code');
            $table->string('name_ar');
            $table->string('name_en');
            $table->string('category'); // earning, deduction, employer_contribution
            $table->string('calculation_type'); // fixed, percentage
            $table->string('percentage_base')->nullable(); // base, gross, insurable, custom
            $table->decimal('amount', 14, 2)->nullable();
            $table->decimal('rate', 12, 6)->nullable();
            $table->decimal('minimum_amount', 14, 2)->nullable();
            $table->decimal('maximum_amount', 14, 2)->nullable();
            $table->string('rounding_mode')->default('nearest');
            $table->boolean('is_recurring')->default(true);
            $table->date('effective_from');
            $table->date('effective_to')->nullable();
            $table->boolean('is_social_insurance_base')->default(false);
            $table->boolean('is_taxable')->default(false);
            $table->boolean('show_on_payslip')->default(true);
            $table->string('debit_account_code')->nullable();
            $table->string('credit_account_code')->nullable();
            $table->boolean('is_active')->default(true);
            $table->unsignedSmallInteger('priority')->default(100);
            $table->timestamps();
            $table->unique(['scope_key', 'code', 'effective_from'], 'payroll_component_version_unique');
            $table->index(['scope_key', 'is_active', 'effective_from', 'effective_to'], 'payroll_component_effective_idx');
        });

        Schema::create('social_insurance_schemes', function (Blueprint $table) {
            $table->id();
            $table->string('scope_key')->default('global');
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('scheme_code');
            $table->string('name_ar');
            $table->string('name_en');
            $table->decimal('employee_rate', 12, 6);
            $table->decimal('employer_rate', 12, 6);
            $table->string('calculation_base')->default('insurable');
            $table->decimal('minimum_wage', 14, 2)->nullable();
            $table->decimal('maximum_wage', 14, 2)->nullable();
            $table->json('included_component_codes')->nullable();
            $table->json('excluded_component_codes')->nullable();
            $table->date('effective_from');
            $table->date('effective_to')->nullable();
            $table->string('employee_payable_account_code')->nullable();
            $table->string('employer_expense_account_code')->nullable();
            $table->string('employer_payable_account_code')->nullable();
            $table->string('rounding_mode')->default('nearest');
            $table->boolean('is_active')->default(true);
            $table->timestamps();
            $table->unique(['scope_key', 'scheme_code', 'effective_from'], 'insurance_scheme_version_unique');
            $table->index(['scope_key', 'scheme_code', 'effective_from', 'effective_to'], 'insurance_scheme_effective_idx');
        });

        Schema::create('staff_payroll_components', function (Blueprint $table) {
            $table->id();
            $table->foreignId('staff_profile_id')->constrained()->cascadeOnDelete();
            $table->foreignId('payroll_component_id')->constrained()->restrictOnDelete();
            $table->decimal('amount_override', 14, 2)->nullable();
            $table->decimal('rate_override', 12, 6)->nullable();
            $table->date('effective_from');
            $table->date('effective_to')->nullable();
            $table->date('one_time_period')->nullable();
            $table->string('reason')->nullable();
            $table->string('status')->default('approved');
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->timestamps();
            $table->index(['staff_profile_id', 'status', 'effective_from', 'effective_to'], 'staff_component_effective_idx');
        });

        Schema::create('disciplinary_warnings', function (Blueprint $table) {
            $table->id();
            $table->string('warning_no')->unique();
            $table->foreignId('staff_profile_id')->constrained()->restrictOnDelete();
            $table->string('warning_type');
            $table->string('offence');
            $table->text('incident_description');
            $table->date('incident_date');
            $table->date('issued_date');
            $table->string('level');
            $table->foreignId('issued_by')->constrained('users')->restrictOnDelete();
            $table->string('status')->default('draft');
            $table->timestamp('received_at')->nullable();
            $table->text('employee_comments')->nullable();
            $table->json('attachments')->nullable();
            $table->date('effect_expires_at')->nullable();
            $table->foreignId('previous_warning_id')->nullable()->constrained('disciplinary_warnings')->nullOnDelete();
            $table->text('cancellation_reason')->nullable();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->timestamps();
            $table->index(['staff_profile_id', 'status', 'issued_date']);
        });

        Schema::create('employee_advances', function (Blueprint $table) {
            $table->id();
            $table->string('advance_no')->unique();
            $table->foreignId('staff_profile_id')->constrained()->restrictOnDelete();
            $table->decimal('original_amount', 14, 2);
            $table->decimal('remaining_balance', 14, 2);
            $table->text('reason');
            $table->date('requested_at');
            $table->timestamp('approved_at')->nullable();
            $table->timestamp('disbursed_at')->nullable();
            $table->string('disbursement_method')->nullable();
            $table->unsignedSmallInteger('installment_count');
            $table->decimal('installment_amount', 14, 2);
            $table->date('first_deduction_month');
            $table->string('status')->default('draft');
            $table->string('receivable_account_code')->nullable();
            $table->string('cash_account_code')->nullable();
            $table->foreignId('requested_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('disbursed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('journal_batch_id')->nullable()->constrained('journal_batches')->nullOnDelete();
            $table->json('attachments')->nullable();
            $table->text('notes')->nullable();
            $table->text('closure_reason')->nullable();
            $table->timestamps();
            $table->index(['staff_profile_id', 'status']);
        });

        Schema::create('employee_advance_installments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_advance_id')->constrained()->cascadeOnDelete();
            $table->unsignedSmallInteger('installment_no');
            $table->date('due_date');
            $table->decimal('amount', 14, 2);
            $table->decimal('collected_amount', 14, 2)->default(0);
            $table->string('status')->default('due'); // due, reserved, deducted, overdue, paid, waived
            $table->foreignId('payroll_record_id')->nullable()->constrained('payroll_records')->nullOnDelete();
            $table->timestamp('collected_at')->nullable();
            $table->timestamps();
            $table->unique(['employee_advance_id', 'installment_no'], 'advance_installment_number_unique');
            $table->index('payroll_record_id');
            $table->index(['status', 'due_date']);
        });

        Schema::create('payroll_account_settings', function (Blueprint $table) {
            $table->id();
            $table->string('scope_key')->unique()->default('global');
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('salary_expense_code');
            $table->string('salary_expense_name');
            $table->string('employer_insurance_expense_code');
            $table->string('employer_insurance_expense_name');
            $table->string('payroll_payable_code');
            $table->string('payroll_payable_name');
            $table->string('social_insurance_payable_code');
            $table->string('social_insurance_payable_name');
            $table->string('deductions_payable_code');
            $table->string('deductions_payable_name');
            $table->string('employee_advances_receivable_code');
            $table->string('employee_advances_receivable_name');
            $table->string('cash_bank_code');
            $table->string('cash_bank_name');
            $table->timestamps();
        });

        Schema::table('payroll_runs', function (Blueprint $table) {
            $table->string('scope_key')->default('global');
            $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            $table->date('period_start')->nullable();
            $table->date('period_end')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('processed_at')->nullable();
            $table->foreignId('paid_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('paid_at')->nullable();
            $table->foreignId('accrual_journal_batch_id')->nullable()->constrained('journal_batches')->nullOnDelete();
            $table->foreignId('payment_journal_batch_id')->nullable()->constrained('journal_batches')->nullOnDelete();
            $table->foreignId('reversed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('reversed_at')->nullable();
            $table->text('reversal_reason')->nullable();
            $table->json('policy_snapshot')->nullable();
        });
        Schema::table('payroll_runs', function (Blueprint $table) {
            $table->dropUnique('payroll_runs_year_month_unique');
            $table->unique(['scope_key', 'year', 'month'], 'payroll_run_scope_period_unique');
        });

        Schema::table('payroll_records', function (Blueprint $table) {
            $table->decimal('total_earnings', 14, 2)->default(0);
            $table->decimal('gross_salary', 14, 2)->default(0);
            $table->decimal('insurable_wage', 14, 2)->default(0);
            $table->decimal('employee_social_insurance', 14, 2)->default(0);
            $table->decimal('employer_social_insurance', 14, 2)->default(0);
            $table->decimal('employer_contributions', 14, 2)->default(0);
            $table->decimal('other_deductions', 14, 2)->default(0);
            $table->decimal('employer_cost', 14, 2)->default(0);
            $table->json('contract_snapshot')->nullable();
            $table->json('social_insurance_snapshot')->nullable();
            $table->json('calculation_snapshot')->nullable();
        });

        Schema::create('payroll_record_components', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payroll_record_id')->constrained()->cascadeOnDelete();
            $table->foreignId('payroll_component_id')->nullable()->constrained()->nullOnDelete();
            $table->string('component_code');
            $table->string('name_ar');
            $table->string('name_en');
            $table->string('category');
            $table->string('calculation_type');
            $table->decimal('base_amount', 14, 2)->nullable();
            $table->decimal('rate', 12, 6)->nullable();
            $table->decimal('amount', 14, 2);
            $table->json('rule_snapshot')->nullable();
            $table->timestamps();
            $table->index(['payroll_record_id', 'category']);
        });

        DB::table('staff_profiles')->whereNull('employment_status')->update(['employment_status' => 'active']);
        DB::table('payroll_runs')->update([
            'scope_key' => 'global',
            'created_by' => DB::raw('processed_by'),
        ]);
        DB::table('hr_payroll_settings')->insert([
            'scope_key' => 'global',
            'contract_alert_days' => json_encode([7, 30, 60, 90]),
            'proration_policy' => 'none',
            'negative_net_policy' => 'block',
            'currency' => 'USD',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        DB::table('payroll_account_settings')->insert([
            'scope_key' => 'global',
            'salary_expense_code' => '5100', 'salary_expense_name' => 'Salaries Expense',
            'employer_insurance_expense_code' => '5110', 'employer_insurance_expense_name' => 'Employer Social Insurance Expense',
            'payroll_payable_code' => '2200', 'payroll_payable_name' => 'Payroll Payable',
            'social_insurance_payable_code' => '2210', 'social_insurance_payable_name' => 'Social Insurance Payable',
            'deductions_payable_code' => '2220', 'deductions_payable_name' => 'Payroll Deductions Payable',
            'employee_advances_receivable_code' => '1300', 'employee_advances_receivable_name' => 'Employee Advances Receivable',
            'cash_bank_code' => '1000', 'cash_bank_name' => 'Cash & Bank',
            'created_at' => now(), 'updated_at' => now(),
        ]);

        // Preserve the legacy single-contract fields as the first historical contract.
        DB::table('staff_profiles')->whereNotNull('hire_date')->orderBy('id')->each(function ($profile) {
            DB::table('employee_contracts')->insert([
                'staff_profile_id' => $profile->id,
                'school_id' => $profile->school_id,
                'contract_no' => 'LEGACY-'.$profile->id,
                'contract_type' => $profile->contract_end ? 'fixed_term' : 'indefinite',
                'start_date' => $profile->contract_start ?? $profile->hire_date,
                'end_date' => $profile->contract_end,
                'base_salary' => $profile->base_salary,
                'payment_method' => $profile->payment_method,
                'bank_name' => $profile->bank_name,
                'bank_account' => $profile->bank_account,
                'status' => $profile->contract_end && $profile->contract_end < now()->toDateString() ? 'expired' : 'active',
                'is_current' => true,
                'created_at' => now(), 'updated_at' => now(),
            ]);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payroll_record_components');
        Schema::table('payroll_records', function (Blueprint $table) {
            $table->dropColumn(['total_earnings', 'gross_salary', 'insurable_wage', 'employee_social_insurance',
                'employer_social_insurance', 'employer_contributions', 'other_deductions', 'employer_cost', 'contract_snapshot',
                'social_insurance_snapshot', 'calculation_snapshot']);
        });
        Schema::table('payroll_runs', function (Blueprint $table) {
            $table->dropUnique('payroll_run_scope_period_unique');
            $table->unique(['year', 'month']);
            $table->dropConstrainedForeignId('school_id');
            $table->dropConstrainedForeignId('created_by');
            $table->dropConstrainedForeignId('paid_by');
            $table->dropConstrainedForeignId('accrual_journal_batch_id');
            $table->dropConstrainedForeignId('payment_journal_batch_id');
            $table->dropConstrainedForeignId('reversed_by');
            $table->dropColumn(['scope_key', 'period_start', 'period_end', 'processed_at', 'paid_at',
                'reversed_at', 'reversal_reason', 'policy_snapshot']);
        });
        Schema::dropIfExists('payroll_account_settings');
        Schema::dropIfExists('employee_advance_installments');
        Schema::dropIfExists('employee_advances');
        Schema::dropIfExists('disciplinary_warnings');
        Schema::dropIfExists('staff_payroll_components');
        Schema::dropIfExists('social_insurance_schemes');
        Schema::dropIfExists('payroll_components');
        Schema::dropIfExists('hr_payroll_settings');
        Schema::dropIfExists('contract_alert_deliveries');
        Schema::dropIfExists('employee_contracts');
        Schema::table('staff_profiles', function (Blueprint $table) {
            $table->dropIndex('staff_profiles_employment_status_contract_end_index');
            $table->dropConstrainedForeignId('school_id');
            $table->dropConstrainedForeignId('supervisor_user_id');
            $table->dropUnique('staff_profiles_employee_no_unique');
            $table->dropColumn(['employee_no', 'employment_type', 'employment_status', 'termination_date',
                'contract_start', 'probation_days', 'probation_end', 'payment_method', 'bank_name',
                'bank_account', 'social_insurance_registered', 'social_insurance_number',
                'social_insurance_start', 'social_insurance_end', 'social_insurance_scheme_code', 'documents']);
        });
        Schema::table('journal_batches', function (Blueprint $table) {
            $table->dropUnique('journal_batches_idempotency_key_unique');
            $table->dropColumn('idempotency_key');
        });
    }
};
