<?php

namespace App\Services;

use App\Models\EmployeeAdvance;
use App\Models\PayrollAccountSetting;
use App\Models\PayrollRun;

class PayrollAccountingService
{
    public function __construct(private LedgerService $ledger) {}

    public function postAccrual(PayrollRun $run, int $actorId): int
    {
        $accounts = $this->accounts($run);
        $records = $run->records()->with('components')->get();
        $gross = $this->sum($records, 'gross_salary');
        $employerInsurance = $this->sum($records, 'employer_social_insurance');
        $employerContributions = $this->sum($records, 'employer_contributions');
        $employeeInsurance = $this->sum($records, 'employee_social_insurance');
        $other = $this->sum($records, 'other_deductions');
        $advances = $this->sum($records, 'advance_deduction');
        $net = $this->sum($records, 'net_pay');
        $earningDebits = $this->componentGroups($records, 'earning', 'debit_account_code');
        $contributionDebits = $this->componentGroups($records, 'employer_contribution', 'debit_account_code', ['SOCIAL_EMPLOYER']);
        $contributionCredits = $this->componentGroups($records, 'employer_contribution', 'credit_account_code', ['SOCIAL_EMPLOYER']);
        $deductionCredits = $this->componentGroups($records, 'deduction', 'credit_account_code', ['SOCIAL_EMPLOYEE']);
        $insuranceExpense = $this->insuranceGroups($records, 'employer_expense_account_code', 'employer_social_insurance');
        $employeeInsurancePayable = $this->insuranceGroups($records, 'employee_payable_account_code', 'employee_social_insurance');
        $employerInsurancePayable = $this->insuranceGroups($records, 'employer_payable_account_code', 'employer_social_insurance');

        $lines = [
            $this->line('debit', $gross - $this->groupTotal($earningDebits), $accounts->salary_expense_code, $accounts->salary_expense_name),
            $this->line('debit', $employerInsurance + $employerContributions - $this->groupTotal($contributionDebits) - $this->groupTotal($insuranceExpense), $accounts->employer_insurance_expense_code, $accounts->employer_insurance_expense_name),
            $this->line('credit', $net, $accounts->payroll_payable_code, $accounts->payroll_payable_name),
            $this->line('credit', $employeeInsurance + $employerInsurance - $this->groupTotal($employeeInsurancePayable) - $this->groupTotal($employerInsurancePayable), $accounts->social_insurance_payable_code, $accounts->social_insurance_payable_name),
            $this->line('credit', $other + $employerContributions - $this->groupTotal($deductionCredits) - $this->groupTotal($contributionCredits), $accounts->deductions_payable_code, $accounts->deductions_payable_name),
            $this->line('credit', $advances, $accounts->employee_advances_receivable_code, $accounts->employee_advances_receivable_name),
        ];
        $lines = array_merge($lines,
            $this->groupLines('debit', $earningDebits), $this->groupLines('debit', $contributionDebits),
            $this->groupLines('debit', $insuranceExpense), $this->groupLines('credit', $deductionCredits),
            $this->groupLines('credit', $contributionCredits), $this->groupLines('credit', $employeeInsurancePayable),
            $this->groupLines('credit', $employerInsurancePayable));
        $batch = $this->ledger->postBalanced("Payroll accrual {$run->run_no}", array_values(array_filter($lines,
            fn ($line) => $line['amount_cents'] > 0)), 'payroll_accrual', $run->id, $actorId, $run->period_end?->toDateString(), $run->school_id);

        return $batch->id;
    }

    public function postPayment(PayrollRun $run, int $actorId): int
    {
        $accounts = $this->accounts($run);
        $net = $this->cents($run->total_net);
        $batch = $this->ledger->postBalanced("Payroll payment {$run->run_no}", [
            $this->line('debit', $net, $accounts->payroll_payable_code, $accounts->payroll_payable_name),
            $this->line('credit', $net, $accounts->cash_bank_code, $accounts->cash_bank_name),
        ], 'payroll', $run->id, $actorId, null, $run->school_id);

        return $batch->id;
    }

    public function collectReservedAdvances(PayrollRun $run): void
    {
        foreach ($run->records()->with('advanceInstallments.advance')->get() as $record) {
            foreach ($record->advanceInstallments->where('status', 'reserved') as $installment) {
                $advance = EmployeeAdvance::lockForUpdate()->findOrFail($installment->employee_advance_id);
                $collected = min($this->cents($installment->amount), $this->cents($advance->remaining_balance));
                $remaining = max(0, $this->cents($advance->remaining_balance) - $collected);
                $installment->update(['status' => 'deducted', 'collected_amount' => $collected / 100, 'collected_at' => now()]);
                $advance->update(['remaining_balance' => $remaining / 100, 'status' => $remaining === 0 ? 'settled' : 'active']);
            }
        }
    }

    public function releaseOrRestoreAdvances(PayrollRun $run): void
    {
        foreach ($run->records()->with('advanceInstallments.advance')->get() as $record) {
            foreach ($record->advanceInstallments as $installment) {
                $advance = EmployeeAdvance::lockForUpdate()->findOrFail($installment->employee_advance_id);
                if ($installment->status === 'deducted') {
                    $restored = $this->cents($advance->remaining_balance) + $this->cents($installment->collected_amount);
                    $advance->update(['remaining_balance' => $restored / 100, 'status' => 'active']);
                }
                $installment->update(['status' => 'due', 'payroll_record_id' => null, 'collected_amount' => 0, 'collected_at' => null]);
            }
        }
    }

    private function accounts(PayrollRun $run): PayrollAccountSetting
    {
        return PayrollAccountSetting::where('school_id', $run->school_id)->firstOrFail();
    }

    private function sum($records, string $field): int
    {
        return $records->sum(fn ($r) => $this->cents($r->{$field}));
    }

    private function cents(mixed $value): int
    {
        return (int) round(((float) ($value ?? 0)) * 100);
    }

    private function componentGroups($records, string $category, string $accountKey, array $excludedCodes = []): array
    {
        $groups = [];
        foreach ($records as $record) {
            foreach ($record->components->where('category', $category) as $component) {
                if (in_array($component->component_code, $excludedCodes, true)) {
                    continue;
                }
                $code = $component->rule_snapshot[$accountKey] ?? null;
                if (! $code) {
                    continue;
                }
                $groups[$code] ??= ['amount_cents' => 0, 'name' => $component->name_en ?: $component->name_ar];
                $groups[$code]['amount_cents'] += $this->cents($component->amount);
            }
        }

        return $groups;
    }

    private function insuranceGroups($records, string $accountKey, string $amountField): array
    {
        $groups = [];
        foreach ($records as $record) {
            $code = $record->social_insurance_snapshot[$accountKey] ?? null;
            if (! $code) {
                continue;
            }
            $groups[$code] ??= ['amount_cents' => 0, 'name' => 'Social Insurance '.$code];
            $groups[$code]['amount_cents'] += $this->cents($record->{$amountField});
        }

        return $groups;
    }

    private function groupTotal(array $groups): int
    {
        return collect($groups)->sum('amount_cents');
    }

    private function groupLines(string $type, array $groups): array
    {
        return collect($groups)->map(fn ($group, $code) => $this->line($type, $group['amount_cents'], (string) $code, $group['name']))->values()->all();
    }

    private function line(string $type, int $amount, string $code, string $name): array
    {
        return ['type' => $type, 'amount_cents' => $amount, 'account_code' => $code, 'account_name' => $name];
    }
}
