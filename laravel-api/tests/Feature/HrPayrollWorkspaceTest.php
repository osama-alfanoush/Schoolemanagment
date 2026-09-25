<?php

namespace Tests\Feature;

use App\Models\ContractAlertDelivery;
use App\Models\DisciplinaryWarning;
use App\Models\EmployeeAdvance;
use App\Models\EmployeeContract;
use App\Models\HrPayrollSetting;
use App\Models\JournalBatch;
use App\Models\NotificationTemplate;
use App\Models\PayrollComponent;
use App\Models\PayrollRecord;
use App\Models\SocialInsuranceScheme;
use App\Models\StaffPayrollComponent;
use App\Models\StaffProfile;
use App\Models\User;
use Carbon\Carbon;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class HrPayrollWorkspaceTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(PermissionSeeder::class);
        NotificationTemplate::seedDefaults();
        Carbon::setTestNow('2026-08-02 09:00:00');
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        parent::tearDown();
    }

    private function user(string $role): User
    {
        return User::factory()->create(['role' => $role, 'is_active' => true]);
    }

    private function employee(float $salary = 1000): StaffProfile
    {
        $user = $this->user('teacher');

        return StaffProfile::create([
            'user_id' => $user->id, 'employee_no' => 'EMP-'.$user->id, 'hire_date' => '2025-01-01',
            'employment_status' => 'active', 'department' => 'Academic', 'position' => 'Teacher', 'base_salary' => $salary,
        ]);
    }

    public function test_contract_dates_status_overlap_and_renewal_history(): void
    {
        $hr = $this->user('hr');
        $profile = $this->employee();
        $first = $this->actingAs($hr)->postJson("/api/hr/staff/{$profile->user_id}/contracts", [
            'contract_no' => 'C-001', 'contract_type' => 'fixed_term', 'start_date' => '2026-01-01',
            'end_date' => '2026-08-31', 'base_salary' => 1000,
        ])->assertCreated()->assertJsonPath('days_remaining', 29)->assertJsonPath('display_status', 'expiring_soon')->json('id');

        $this->actingAs($hr)->postJson("/api/hr/staff/{$profile->user_id}/contracts", [
            'contract_no' => 'C-OVERLAP', 'contract_type' => 'fixed_term', 'start_date' => '2026-08-15',
            'end_date' => '2026-12-31', 'base_salary' => 1100,
        ])->assertStatus(422)->assertJsonValidationErrors('start_date');

        $this->actingAs($hr)->postJson("/api/hr/contracts/{$first}/renew", [
            'contract_no' => 'C-002', 'contract_type' => 'indefinite', 'start_date' => '2026-09-01',
            'end_date' => null, 'base_salary' => 1200,
        ])->assertCreated()->assertJsonPath('display_status', 'indefinite');
        $this->assertDatabaseHas('employee_contracts', ['id' => $first, 'status' => 'superseded', 'is_current' => false]);
        $this->assertSame(2, EmployeeContract::where('staff_profile_id', $profile->id)->count());
    }

    public function test_contract_alert_is_sent_once_per_contract_threshold(): void
    {
        $this->user('hr');
        $profile = $this->employee();
        HrPayrollSetting::where('school_id', $profile->school_id)->update(['contract_alert_days' => [30]]);
        EmployeeContract::create([
            'school_id' => $profile->school_id,
            'staff_profile_id' => $profile->id, 'contract_no' => 'ALERT-1', 'contract_type' => 'fixed_term',
            'start_date' => '2026-01-01', 'end_date' => '2026-08-20', 'base_salary' => 1000,
            'status' => 'active', 'is_current' => true,
        ]);
        $this->artisan('hr:check-contracts')->assertSuccessful();
        $this->artisan('hr:check-contracts')->assertSuccessful();
        $this->assertSame(1, ContractAlertDelivery::count());
    }

    public function test_effective_insurance_and_fixed_percentage_components_are_snapshotted(): void
    {
        $hr = $this->user('hr');
        $profile = $this->employee();
        $profile->update(['social_insurance_registered' => true, 'social_insurance_scheme_code' => 'SS']);
        $scheme = SocialInsuranceScheme::create([
            'school_id' => $profile->school_id,
            'scope_key' => 'global', 'scheme_code' => 'SS', 'name_ar' => 'الضمان', 'name_en' => 'Social',
            'employee_rate' => 5, 'employer_rate' => 10, 'calculation_base' => 'insurable',
            'effective_from' => '2026-01-01', 'rounding_mode' => 'nearest', 'is_active' => true,
            'employee_payable_account_code' => '2211', 'employer_expense_account_code' => '5115',
            'employer_payable_account_code' => '2215',
        ]);
        $earning = PayrollComponent::create([
            'school_id' => $profile->school_id,
            'scope_key' => 'global', 'code' => 'ALLOW', 'name_ar' => 'بدل', 'name_en' => 'Allowance',
            'category' => 'earning', 'calculation_type' => 'fixed', 'amount' => 100, 'rounding_mode' => 'nearest',
            'is_recurring' => true, 'effective_from' => '2026-01-01', 'is_social_insurance_base' => true,
            'is_taxable' => false, 'show_on_payslip' => true, 'is_active' => true, 'priority' => 10,
        ]);
        $deduction = PayrollComponent::create([
            'school_id' => $profile->school_id,
            'scope_key' => 'global', 'code' => 'DEDUCT', 'name_ar' => 'اقتطاع', 'name_en' => 'Deduction',
            'category' => 'deduction', 'calculation_type' => 'percentage', 'percentage_base' => 'base', 'rate' => 10,
            'maximum_amount' => 60, 'rounding_mode' => 'nearest', 'is_recurring' => true, 'effective_from' => '2026-01-01',
            'is_social_insurance_base' => false, 'is_taxable' => false, 'show_on_payslip' => true, 'is_active' => true, 'priority' => 20,
        ]);
        $employerContribution = PayrollComponent::create([
            'school_id' => $profile->school_id,
            'scope_key' => 'global', 'code' => 'EMPLOYER_BENEFIT', 'name_ar' => 'مساهمة المدرسة', 'name_en' => 'Employer benefit',
            'category' => 'employer_contribution', 'calculation_type' => 'fixed', 'amount' => 30,
            'rounding_mode' => 'nearest', 'is_recurring' => true, 'effective_from' => '2026-01-01',
            'is_social_insurance_base' => false, 'is_taxable' => false, 'show_on_payslip' => true,
            'debit_account_code' => '5120', 'credit_account_code' => '2230', 'is_active' => true, 'priority' => 30,
        ]);
        foreach ([$earning, $deduction, $employerContribution] as $component) {
            StaffPayrollComponent::create([
                'school_id' => $profile->school_id,
                'staff_profile_id' => $profile->id, 'payroll_component_id' => $component->id,
                'effective_from' => '2026-01-01', 'reason' => 'Contract terms', 'status' => 'approved',
                'approved_by' => $hr->id, 'approved_at' => now(),
            ]);
        }
        $runId = $this->actingAs($hr)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 8])->assertCreated()->json('id');
        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$runId}/process")->assertOk();
        $record = PayrollRecord::where('payroll_run_id', $runId)->firstOrFail();
        $this->assertSame('1100.00', $record->gross_salary);
        $this->assertSame('55.00', $record->employee_social_insurance);
        $this->assertSame('110.00', $record->employer_social_insurance);
        $this->assertSame('30.00', $record->employer_contributions);
        $this->assertSame('1240.00', $record->employer_cost);
        $this->assertSame('60.00', $record->other_deductions);
        $this->assertSame('985.00', $record->net_pay);
        $this->actingAs($hr)->getJson('/api/hr/payroll-reports/social-insurance?year=2026&month=8')
            ->assertOk()->assertJsonPath('data.0.employee_no', $profile->employee_no)
            ->assertJsonPath('data.0.employee_social_insurance', '55.00');
        $this->actingAs($hr)->getJson('/api/hr/payroll-reports/components?year=2026&month=8')
            ->assertOk()->assertJsonFragment(['code' => 'ALLOW']);
        $this->actingAs($hr)->getJson('/api/hr/payroll-reports/employee-cost?year=2026&month=8')
            ->assertOk()->assertJsonPath('data.0.employer_cost', '1240.00');

        $scheme->update(['employee_rate' => 99, 'employer_rate' => 99]);
        $record->refresh();
        $this->assertSame('5.000000', $record->social_insurance_snapshot['employee_rate']);
        $this->assertSame('55.00', $record->employee_social_insurance);
        $finance = $this->user('finance');
        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertOk();
        $this->assertDatabaseHas('journal_entries', ['source' => 'payroll_accrual', 'account_code' => '5120', 'type' => 'debit', 'amount' => 30]);
        $this->assertDatabaseHas('journal_entries', ['source' => 'payroll_accrual', 'account_code' => '2230', 'type' => 'credit', 'amount' => 30]);
    }

    public function test_warning_workflow_is_private_and_never_creates_a_payroll_deduction(): void
    {
        $issuer = $this->user('hr');
        $approver = $this->user('hr');
        $finance = $this->user('finance');
        $profile = $this->employee();
        $warningId = $this->actingAs($issuer)->postJson('/api/hr/warnings', [
            'staff_profile_id' => $profile->id, 'warning_type' => 'written', 'offence' => 'Late arrival',
            'incident_description' => 'Arrived late without notice', 'incident_date' => '2026-08-01',
            'issued_date' => '2026-08-02', 'level' => 'first',
        ])->assertCreated()->json('id');
        $this->actingAs($issuer)->postJson("/api/hr/warnings/{$warningId}/submit")->assertOk();
        $this->actingAs($issuer)->postJson("/api/hr/warnings/{$warningId}/approve")->assertStatus(422);
        $this->actingAs($approver)->postJson("/api/hr/warnings/{$warningId}/approve")->assertOk()->assertJsonPath('status', 'issued');
        $this->actingAs($finance)->getJson('/api/hr/warnings')->assertForbidden();
        $this->assertSame(0, StaffPayrollComponent::where('staff_profile_id', $profile->id)->count());
        $this->assertSame('issued', DisciplinaryWarning::find($warningId)->status);
    }

    public function test_advance_schedule_deduction_accounting_idempotency_and_reversal(): void
    {
        $hr = $this->user('hr');
        $finance = $this->user('finance');
        $profile = $this->employee(2000);
        $advanceId = $this->actingAs($hr)->postJson('/api/hr/advances', [
            'staff_profile_id' => $profile->id, 'original_amount' => 1000, 'reason' => 'Emergency',
            'requested_at' => '2026-08-01', 'installment_count' => 3, 'first_deduction_month' => '2026-08-01',
        ])->assertCreated()->json('id');
        $this->actingAs($hr)->postJson("/api/hr/advances/{$advanceId}/submit")->assertOk();
        $this->actingAs($finance)->postJson("/api/hr/advances/{$advanceId}/approve")->assertOk();
        $advance = EmployeeAdvance::with('installments')->findOrFail($advanceId);
        $this->assertSame(['333.33', '333.33', '333.34'], $advance->installments->pluck('amount')->all());
        $this->assertSame('1000.00', number_format((float) $advance->installments->sum('amount'), 2, '.', ''));
        $this->actingAs($finance)->postJson("/api/hr/advances/{$advanceId}/disburse", ['method' => 'bank_transfer'])->assertOk();

        $runId = $this->actingAs($hr)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 8])->assertCreated()->json('id');
        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$runId}/process")->assertOk();
        $record = PayrollRecord::where('payroll_run_id', $runId)->firstOrFail();
        $this->assertSame('333.33', $record->advance_deduction);
        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertOk();
        $paid = $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$runId}/pay")->assertOk();
        $paid->assertJsonPath('status', 'paid');
        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$runId}/pay")->assertStatus(422);
        $this->assertSame('666.67', EmployeeAdvance::find($advanceId)->remaining_balance);
        $accrual = JournalBatch::with('lines')->where('source', 'payroll_accrual')->where('source_id', $runId)->firstOrFail();
        $this->assertSame($accrual->lines->where('type', 'debit')->sum('amount'), $accrual->lines->where('type', 'credit')->sum('amount'));

        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$runId}/reverse", ['reason' => 'Bank file rejected'])->assertOk()->assertJsonPath('status', 'reversed');
        $this->assertSame('1000.00', EmployeeAdvance::find($advanceId)->remaining_balance);
        $this->assertDatabaseHas('employee_advance_installments', ['employee_advance_id' => $advanceId, 'installment_no' => 1, 'status' => 'due', 'payroll_record_id' => null]);
    }
}
