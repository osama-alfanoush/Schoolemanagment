<?php

namespace App\Services;

use App\Models\EmployeeAdvance;
use App\Models\PayrollAccountSetting;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class EmployeeAdvanceService
{
    public function __construct(private LedgerService $ledger) {}

    public function approve(Request $request, EmployeeAdvance $advance): EmployeeAdvance
    {
        return DB::transaction(function () use ($request, $advance) {
            $advance = EmployeeAdvance::lockForUpdate()->findOrFail($advance->id);
            if ($advance->status !== 'requested') {
                abort(422, 'Only a requested advance can be approved.');
            }
            if ($advance->requested_by === $request->user()->id) {
                abort(422, 'The requester cannot approve the same advance.');
            }
            $advance->update(['status' => 'approved', 'approved_by' => $request->user()->id, 'approved_at' => now()]);
            $this->buildSchedule($advance);
            AuditLogger::log($request, 'approve_employee_advance', 'employee_advance', $advance->id, ['old' => ['status' => 'requested'], 'new' => ['status' => 'approved']]);

            return $advance->fresh('installments');
        });
    }

    public function disburse(Request $request, EmployeeAdvance $advance, string $method): EmployeeAdvance
    {
        return DB::transaction(function () use ($request, $advance, $method) {
            $advance = EmployeeAdvance::lockForUpdate()->findOrFail($advance->id);
            if ($advance->status !== 'approved') {
                abort(422, 'Only an approved advance can be disbursed.');
            }
            $accounts = PayrollAccountSetting::where('school_id', $advance->school_id)->firstOrFail();
            $amount = $this->cents($advance->original_amount);
            $batch = $this->ledger->postBalanced("Employee advance {$advance->advance_no}", [
                $this->line('debit', $amount, $advance->receivable_account_code ?: $accounts->employee_advances_receivable_code, $accounts->employee_advances_receivable_name),
                $this->line('credit', $amount, $advance->cash_account_code ?: $accounts->cash_bank_code, $accounts->cash_bank_name),
            ], 'employee_advance', $advance->id, $request->user()->id, null, $advance->school_id);
            $advance->update([
                'status' => 'disbursed', 'disbursed_by' => $request->user()->id, 'disbursed_at' => now(),
                'disbursement_method' => $method, 'journal_batch_id' => $batch->id,
            ]);
            AuditLogger::log($request, 'disburse_employee_advance', 'employee_advance', $advance->id, ['amount' => $advance->original_amount, 'journal_batch_id' => $batch->id]);

            return $advance->fresh(['installments', 'staffProfile.user:id,name']);
        });
    }

    public function settle(Request $request, EmployeeAdvance $advance, string $method): EmployeeAdvance
    {
        return DB::transaction(function () use ($request, $advance, $method) {
            $advance = EmployeeAdvance::lockForUpdate()->findOrFail($advance->id);
            if (! in_array($advance->status, ['disbursed', 'active'], true)) {
                abort(422, 'Only an active advance can be settled.');
            }
            $remaining = $this->cents($advance->remaining_balance);
            if ($remaining <= 0) {
                return $advance;
            }
            $accounts = PayrollAccountSetting::where('school_id', $advance->school_id)->firstOrFail();
            $this->ledger->postBalanced("Early settlement {$advance->advance_no}", [
                $this->line('debit', $remaining, $accounts->cash_bank_code, $accounts->cash_bank_name),
                $this->line('credit', $remaining, $advance->receivable_account_code ?: $accounts->employee_advances_receivable_code, $accounts->employee_advances_receivable_name),
            ], 'employee_advance_settlement', $advance->id, $request->user()->id, null, $advance->school_id);
            $advance->installments()->whereIn('status', ['due', 'overdue', 'reserved'])->update(['status' => 'paid', 'collected_at' => now()]);
            $advance->update(['remaining_balance' => 0, 'status' => 'settled', 'closure_reason' => "Early settlement via {$method}"]);
            AuditLogger::log($request, 'settle_employee_advance', 'employee_advance', $advance->id, ['amount' => $remaining / 100, 'method' => $method]);

            return $advance->fresh('installments');
        });
    }

    public function buildSchedule(EmployeeAdvance $advance): void
    {
        if ($advance->installments()->exists()) {
            return;
        }
        $total = $this->cents($advance->original_amount);
        $count = $advance->installment_count;
        $regular = intdiv($total, $count);
        if ($regular <= 0) {
            throw ValidationException::withMessages(['installment_amount' => 'Installment amount must be greater than zero.']);
        }
        $remaining = $total;
        $date = Carbon::parse($advance->first_deduction_month)->startOfMonth();
        for ($i = 1; $i <= $count; $i++) {
            $amount = $i === $count ? $remaining : min($regular, $remaining);
            $advance->installments()->create([
                'school_id' => $advance->school_id,
                'installment_no' => $i, 'due_date' => $date->copy()->addMonthsNoOverflow($i - 1)->endOfMonth(),
                'amount' => number_format($amount / 100, 2, '.', ''), 'status' => 'due',
            ]);
            $remaining -= $amount;
        }
        if ($remaining !== 0) {
            throw ValidationException::withMessages(['installments' => 'Installment schedule does not equal the advance amount.']);
        }
    }

    private function cents(mixed $value): int
    {
        return (int) round(((float) $value) * 100);
    }

    private function line(string $type, int $amount, string $code, string $name): array
    {
        return ['type' => $type, 'amount_cents' => $amount, 'account_code' => $code, 'account_name' => $name];
    }
}
