<?php

namespace App\Services;

use App\Models\EmployeeAdvanceInstallment;
use App\Models\HrPayrollSetting;
use App\Models\HrRequest;
use App\Models\PayrollRecord;
use App\Models\SocialInsuranceScheme;
use App\Models\StaffProfile;
use Carbon\Carbon;
use Illuminate\Validation\ValidationException;

class PayrollCalculationService
{
    public function calculate(PayrollRecord $record, StaffProfile $profile, Carbon $periodStart, Carbon $periodEnd, bool $reserveAdvances): PayrollRecord
    {
        $contract = $profile->contracts()->where('school_id', $profile->school_id)->whereDate('start_date', '<=', $periodEnd)
            ->where(fn ($q) => $q->whereNull('end_date')->orWhereDate('end_date', '>=', $periodStart))
            ->orderByDesc('start_date')->first();
        $baseCents = $this->cents($contract?->base_salary ?? $profile->base_salary);
        $settings = HrPayrollSetting::where('school_id', $profile->school_id)->firstOrFail();
        $baseCents = $this->prorate($baseCents, $profile, $periodStart, $periodEnd, $settings?->proration_policy ?? 'none');

        $legacyAllowanceCents = $this->cents($record->allowances);
        $legacyDeductionCents = $this->cents($record->deductions);
        $earningCents = $legacyAllowanceCents;
        $deductionCents = $legacyDeductionCents;
        $insurableEarningsCents = 0;
        $earningBreakdown = [];
        $componentRows = [];

        if ($legacyAllowanceCents > 0) {
            $componentRows[] = $this->snapshot('LEGACY_ALLOWANCE', 'بدل يدوي', 'Manual allowance', 'earning', 'fixed', $legacyAllowanceCents);
        }
        if ($legacyDeductionCents > 0) {
            $componentRows[] = $this->snapshot('LEGACY_DEDUCTION', 'اقتطاع يدوي', 'Manual deduction', 'deduction', 'fixed', $legacyDeductionCents);
        }

        $assignments = $profile->payrollComponents()->with('component')->where('school_id', $profile->school_id)
            ->where('status', 'approved')->whereDate('effective_from', '<=', $periodEnd)
            ->where(fn ($q) => $q->whereNull('effective_to')->orWhereDate('effective_to', '>=', $periodStart))
            ->where(fn ($q) => $q->whereNull('one_time_period')->orWhereBetween('one_time_period', [$periodStart, $periodEnd]))
            ->get()->filter(function ($assignment) use ($periodStart, $periodEnd) {
                $component = $assignment->component;

                return $component && $component->is_active && $component->effective_from <= $periodEnd
                    && (! $component->effective_to || $component->effective_to >= $periodStart);
            })->sortBy(fn ($assignment) => $assignment->component->priority);

        foreach ($assignments->where(fn ($assignment) => $assignment->component->category === 'earning') as $assignment) {
            $component = $assignment->component;
            $grossSoFar = $baseCents + $earningCents;
            $amount = $this->componentAmount($component, $assignment, $baseCents, $grossSoFar, $baseCents + $insurableEarningsCents);
            $earningCents += $amount;
            if ($component->is_social_insurance_base) {
                $insurableEarningsCents += $amount;
            }
            $earningBreakdown[] = ['code' => $component->code, 'amount_cents' => $amount, 'default_included' => $component->is_social_insurance_base];
            $componentRows[] = $this->snapshot($component->code, $component->name_ar, $component->name_en, 'earning', $component->calculation_type, $amount, $component, $assignment);
        }

        $grossCents = $baseCents + $earningCents;
        [$insurableWageCents, $employeeInsuranceCents, $employerInsuranceCents, $insuranceSnapshot] =
            $this->insurance($profile, $periodEnd, $baseCents, $earningBreakdown);
        if ($employeeInsuranceCents > 0) {
            $componentRows[] = $this->snapshot('SOCIAL_EMPLOYEE', 'الضمان الاجتماعي - حصة الموظف', 'Social insurance - employee', 'deduction', 'percentage', $employeeInsuranceCents, null, null, $insuranceSnapshot);
        }
        if ($employerInsuranceCents > 0) {
            $componentRows[] = $this->snapshot('SOCIAL_EMPLOYER', 'الضمان الاجتماعي - حصة صاحب العمل', 'Social insurance - employer', 'employer_contribution', 'percentage', $employerInsuranceCents, null, null, $insuranceSnapshot);
        }

        foreach ($assignments->where(fn ($assignment) => $assignment->component->category === 'deduction') as $assignment) {
            $component = $assignment->component;
            $amount = $this->componentAmount($component, $assignment, $baseCents, $grossCents, $insurableWageCents);
            $deductionCents += $amount;
            $componentRows[] = $this->snapshot($component->code, $component->name_ar, $component->name_en, 'deduction', $component->calculation_type, $amount, $component, $assignment);
        }

        $employerContributionCents = 0;
        foreach ($assignments->where(fn ($assignment) => $assignment->component->category === 'employer_contribution') as $assignment) {
            $component = $assignment->component;
            $amount = $this->componentAmount($component, $assignment, $baseCents, $grossCents, $insurableWageCents);
            $employerContributionCents += $amount;
            $componentRows[] = $this->snapshot($component->code, $component->name_ar, $component->name_en, 'employer_contribution', $component->calculation_type, $amount, $component, $assignment);
        }

        $advanceInstallments = EmployeeAdvanceInstallment::query()
            ->with('advance')->where('school_id', $profile->school_id)
            ->whereHas('advance', fn ($q) => $q->where('school_id', $profile->school_id)->where('staff_profile_id', $profile->id)->whereIn('status', ['active', 'disbursed']))
            ->whereIn('status', ['due', 'overdue'])->whereNull('payroll_record_id')->whereDate('due_date', '<=', $periodEnd)
            ->orderBy('due_date')->orderBy('id');
        if ($reserveAdvances) {
            $advanceInstallments->lockForUpdate();
        }
        $installments = $advanceInstallments->get();
        $advanceCents = 0;
        $reservedByAdvance = [];
        foreach ($installments as $installment) {
            $alreadyReserved = $reservedByAdvance[$installment->employee_advance_id] ?? 0;
            $remainingCents = $this->cents($installment->advance->remaining_balance) - $alreadyReserved;
            if ($remainingCents <= 0) {
                continue;
            }
            $amount = min($this->cents($installment->amount), $remainingCents);
            $advanceCents += $amount;
            $reservedByAdvance[$installment->employee_advance_id] = $alreadyReserved + $amount;
            $componentRows[] = $this->snapshot('ADVANCE-'.$installment->employee_advance_id.'-'.$installment->installment_no, 'قسط سلفة', 'Advance installment', 'deduction', 'fixed', $amount, null, null, ['installment_id' => $installment->id]);
            if ($reserveAdvances) {
                $installment->update(['payroll_record_id' => $record->id, 'status' => 'reserved']);
            }
        }

        // Transitional compatibility for approved legacy salary_advance requests.
        $legacyAdvanceCents = $this->cents(HrRequest::where('school_id', $profile->school_id)->where('teacher_user_id', $profile->user_id)
            ->where('type', 'salary_advance')->where('status', 'approved')
            ->whereBetween('reviewed_at', [$periodStart, $periodEnd])->sum('amount'));
        if ($legacyAdvanceCents > 0) {
            $advanceCents += $legacyAdvanceCents;
            $componentRows[] = $this->snapshot('LEGACY_ADVANCE_REQUEST', 'طلب سلفة قديم', 'Legacy salary advance request', 'deduction', 'fixed', $legacyAdvanceCents, null, null, ['legacy' => true]);
        }

        $netCents = $grossCents - $employeeInsuranceCents - $deductionCents - $advanceCents;
        if ($netCents < 0 && ($settings?->negative_net_policy ?? 'block') === 'block') {
            throw ValidationException::withMessages(['net_pay' => "صافي راتب {$profile->user?->name} سالب. راجع الاقتطاعات والسلف."]);
        }

        $record->update([
            'base_salary' => $this->money($baseCents), 'total_earnings' => $this->money($earningCents),
            'gross_salary' => $this->money($grossCents), 'insurable_wage' => $this->money($insurableWageCents),
            'employee_social_insurance' => $this->money($employeeInsuranceCents),
            'employer_social_insurance' => $this->money($employerInsuranceCents),
            'employer_contributions' => $this->money($employerContributionCents),
            'other_deductions' => $this->money($deductionCents), 'advance_deduction' => $this->money($advanceCents),
            'net_pay' => $this->money($netCents), 'employer_cost' => $this->money($grossCents + $employerInsuranceCents + $employerContributionCents),
            'contract_snapshot' => $contract ? $contract->only(['id', 'contract_no', 'contract_type', 'start_date', 'end_date', 'base_salary']) : [
                'legacy' => true, 'contract_type' => $profile->contract_type, 'start_date' => $profile->contract_start ?? $profile->hire_date,
                'end_date' => $profile->contract_end, 'base_salary' => $profile->base_salary,
            ],
            'social_insurance_snapshot' => $insuranceSnapshot,
            'calculation_snapshot' => [
                'formula' => 'net = base + earnings - employee_social_insurance - other_deductions - advance_installments',
                'currency' => $settings?->currency ?? 'USD', 'proration_policy' => $settings?->proration_policy ?? 'none',
                'amounts_cents' => ['base' => $baseCents, 'earnings' => $earningCents, 'gross' => $grossCents,
                    'employee_social_insurance' => $employeeInsuranceCents, 'other_deductions' => $deductionCents,
                    'advance_installments' => $advanceCents, 'net' => $netCents, 'employer_social_insurance' => $employerInsuranceCents,
                    'employer_contributions' => $employerContributionCents],
            ],
        ]);
        $record->components()->delete();
        foreach ($componentRows as $row) {
            $record->components()->create(['school_id' => $profile->school_id, ...$row]);
        }

        return $record->fresh(['components', 'staff:id,name,role']);
    }

    private function insurance(StaffProfile $profile, Carbon $date, int $baseCents, array $earnings): array
    {
        if (! $profile->social_insurance_registered) {
            return [0, 0, 0, ['registered' => false]];
        }
        $scheme = SocialInsuranceScheme::where('school_id', $profile->school_id)->where('scheme_code', $profile->social_insurance_scheme_code)
            ->where('is_active', true)->whereDate('effective_from', '<=', $date)
            ->where(fn ($q) => $q->whereNull('effective_to')->orWhereDate('effective_to', '>=', $date))
            ->orderByDesc('effective_from')->first();
        if (! $scheme) {
            throw ValidationException::withMessages(['social_insurance_scheme_code' => 'لا توجد نسخة سارية من نظام الضمان المسجل للموظف.']);
        }
        $allEarnings = collect($earnings)->sum('amount_cents');
        $defaultInsurable = collect($earnings)->where('default_included', true)->sum('amount_cents');
        $wageCents = match ($scheme->calculation_base) {
            'base' => $baseCents,
            'gross' => $baseCents + $allEarnings,
            'custom' => 0,
            default => $baseCents + $defaultInsurable,
        };
        $included = $scheme->included_component_codes ?? [];
        if ($included !== []) {
            $wageCents = in_array('BASE', $included, true) ? $baseCents : 0;
            $wageCents += collect($earnings)->whereIn('code', $included)->sum('amount_cents');
        }
        $excluded = $scheme->excluded_component_codes ?? [];
        if (in_array('BASE', $excluded, true)) {
            $wageCents = max(0, $wageCents - $baseCents);
        }
        $wageCents = max(0, $wageCents - collect($earnings)->whereIn('code', $excluded)->sum('amount_cents'));
        if ($scheme->minimum_wage !== null) {
            $wageCents = max($wageCents, $this->cents($scheme->minimum_wage));
        }
        if ($scheme->maximum_wage !== null) {
            $wageCents = min($wageCents, $this->cents($scheme->maximum_wage));
        }
        $employee = $this->applyRounding((int) round($wageCents * (float) $scheme->employee_rate / 100), $scheme->rounding_mode);
        $employer = $this->applyRounding((int) round($wageCents * (float) $scheme->employer_rate / 100), $scheme->rounding_mode);

        return [$wageCents, $employee, $employer, [
            'registered' => true, 'scheme_id' => $scheme->id, 'scheme_code' => $scheme->scheme_code,
            'name_ar' => $scheme->name_ar, 'effective_from' => $scheme->effective_from->toDateString(),
            'employee_rate' => $scheme->employee_rate, 'employer_rate' => $scheme->employer_rate,
            'insurable_wage' => $this->money($wageCents), 'employee_amount' => $this->money($employee),
            'employer_amount' => $this->money($employer), 'rounding_mode' => $scheme->rounding_mode,
            'employee_payable_account_code' => $scheme->employee_payable_account_code,
            'employer_expense_account_code' => $scheme->employer_expense_account_code,
            'employer_payable_account_code' => $scheme->employer_payable_account_code,
        ]];
    }

    private function componentAmount($component, $assignment, int $base, int $gross, int $insurable): int
    {
        if ($component->calculation_type === 'fixed') {
            $amount = $this->cents($assignment->amount_override ?? $component->amount ?? 0);
        } else {
            $rate = (float) ($assignment->rate_override ?? $component->rate ?? 0);
            $basis = match ($component->percentage_base) {
                'gross' => $gross, 'insurable' => $insurable, default => $base
            };
            $amount = (int) round($basis * $rate / 100);
        }
        if ($component->minimum_amount !== null) {
            $amount = max($amount, $this->cents($component->minimum_amount));
        }
        if ($component->maximum_amount !== null) {
            $amount = min($amount, $this->cents($component->maximum_amount));
        }

        return $this->applyRounding($amount, $component->rounding_mode);
    }

    private function applyRounding(int $cents, string $mode): int
    {
        return match ($mode) {
            'down' => intdiv($cents, 100) * 100,
            'up' => (int) (ceil($cents / 100) * 100),
            'nearest_unit' => (int) (round($cents / 100) * 100),
            default => $cents,
        };
    }

    private function prorate(int $base, StaffProfile $profile, Carbon $start, Carbon $end, string $policy): int
    {
        if ($policy !== 'calendar_days') {
            return $base;
        }
        $activeStart = collect([$start, $profile->hire_date, $profile->contract_start])->filter()->map(fn ($date) => Carbon::parse($date))->max();
        $activeEnd = collect([$end, $profile->termination_date, $profile->contract_end])->filter()->map(fn ($date) => Carbon::parse($date))->min();
        if (! $activeStart || ! $activeEnd || $activeStart > $activeEnd) {
            return 0;
        }

        return (int) round($base * ($activeStart->diffInDays($activeEnd) + 1) / ($start->diffInDays($end) + 1));
    }

    private function snapshot(string $code, string $ar, string $en, string $category, string $type, int $amount, $component = null, $assignment = null, array $extra = []): array
    {
        return [
            'payroll_component_id' => $component?->id, 'component_code' => $code, 'name_ar' => $ar,
            'name_en' => $en, 'category' => $category, 'calculation_type' => $type,
            'base_amount' => null, 'rate' => $assignment?->rate_override ?? $component?->rate,
            'amount' => $this->money($amount),
            'rule_snapshot' => $extra + ($component ? $component->only(['percentage_base', 'minimum_amount', 'maximum_amount', 'rounding_mode', 'is_recurring', 'effective_from', 'effective_to', 'debit_account_code', 'credit_account_code']) : []),
        ];
    }

    private function cents(mixed $amount): int
    {
        return (int) round(((float) ($amount ?? 0)) * 100);
    }

    private function money(int $cents): string
    {
        return number_format($cents / 100, 2, '.', '');
    }
}
