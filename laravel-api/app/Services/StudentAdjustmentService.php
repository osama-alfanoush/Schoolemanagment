<?php

namespace App\Services;

use App\Models\FinancialClosing;
use App\Models\Invoice;
use App\Models\StudentFinancialAdjustment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class StudentAdjustmentService
{
    public function __construct(
        private LedgerService $ledger,
        private CurrentSchool $currentSchool,
    ) {}

    public function create(Request $request): StudentFinancialAdjustment
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'invoice_id' => 'nullable|exists:invoices,id',
            'type' => 'required|in:discount,adjustment,refund',
            'direction' => 'required|in:debit,credit',
            'calculation_type' => 'required|in:amount,percentage',
            // An amount is money and must fit the column; a percentage is not,
            // and may carry the four decimals its own column holds.
            'value' => ['required', 'numeric', 'gt:0',
                Rule::when(fn ($input) => $input->calculation_type === 'amount', 'money')],
            'reason' => 'required|string|max:500',
        ]);
        abort_if($data['calculation_type'] === 'percentage' && (float) $data['value'] > 100, 422, 'Percentage cannot exceed 100.');
        abort_if($data['calculation_type'] === 'percentage' && empty($data['invoice_id']), 422, 'Percentage adjustments require an invoice.');
        $authorisedStudent = User::whereKey($data['student_user_id'])->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $this->currentSchool->id()))
            ->exists();
        abort_unless($authorisedStudent, 422, 'The student belongs to another school.');

        $invoice = ! empty($data['invoice_id']) ? Invoice::findOrFail($data['invoice_id']) : null;
        abort_if($invoice && $invoice->student_user_id !== (int) $data['student_user_id'], 422, 'Invoice belongs to another student.');
        $amount = $data['calculation_type'] === 'percentage'
            ? round((float) $invoice->amount * (float) $data['value'] / 100, 2)
            : round((float) $data['value'], 2);

        $adjustment = StudentFinancialAdjustment::create([
            ...$data,
            'adjustment_no' => 'ADJ-'.now()->format('Ymd').'-'.Str::upper(Str::random(8)),
            'amount' => $amount,
            'status' => 'draft',
            'created_by' => $request->user()->id,
        ]);
        AuditLogger::log($request, 'create_student_adjustment', 'student_financial_adjustment', $adjustment->id, $adjustment->toArray());

        return $adjustment->load('student:id,name', 'invoice:id,invoice_no,amount,paid_amount');
    }

    public function approve(Request $request, int $id): StudentFinancialAdjustment
    {
        return DB::transaction(function () use ($request, $id) {
            $adjustment = StudentFinancialAdjustment::lockForUpdate()->findOrFail($id);
            abort_if($adjustment->status !== 'draft', 422, 'Only a draft adjustment can be approved.');
            $adjustment->update(['status' => 'approved', 'approved_by' => $request->user()->id, 'approved_at' => now()]);
            AuditLogger::log($request, 'approve_student_adjustment', 'student_financial_adjustment', $adjustment->id);

            return $adjustment->fresh();
        });
    }

    public function post(Request $request, int $id): StudentFinancialAdjustment
    {
        return DB::transaction(function () use ($request, $id) {
            $adjustment = StudentFinancialAdjustment::lockForUpdate()->findOrFail($id);
            abort_if($adjustment->status !== 'approved', 422, 'Only an approved adjustment can be posted.');
            $this->assertCurrentPeriodOpen();
            if ($adjustment->invoice_id) {
                $invoice = Invoice::lockForUpdate()->findOrFail($adjustment->invoice_id);
                $otherDebits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'debit')->sum('amount');
                $otherCredits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'credit')->sum('amount');
                $net = round((float) $invoice->amount + (float) $otherDebits - (float) $otherCredits
                    + ($adjustment->direction === 'debit' ? (float) $adjustment->amount : -(float) $adjustment->amount), 2);
                abort_if($net + 0.005 < (float) $invoice->paid_amount, 422, 'Adjustment would reduce the invoice below the amount already paid.');
            }

            $adjustment->update(['status' => 'posted', 'posted_by' => $request->user()->id, 'posted_at' => now()]);
            $this->ledger->postPair(
                "{$adjustment->type} {$adjustment->adjustment_no}: {$adjustment->reason}",
                (float) $adjustment->amount,
                $adjustment->direction === 'credit' ? 'discounts' : 'accounts_receivable',
                $adjustment->direction === 'credit' ? 'accounts_receivable' : 'discounts',
                'student_adjustment', $adjustment->id, $request->user()->id
            );
            if (isset($invoice)) {
                $this->refreshInvoice($invoice);
            }
            AuditLogger::log($request, 'post_student_adjustment', 'student_financial_adjustment', $adjustment->id, ['old' => ['status' => 'approved'], 'new' => ['status' => 'posted']]);

            return $adjustment->fresh();
        });
    }

    public function reverse(Request $request, int $id): StudentFinancialAdjustment
    {
        $data = $request->validate(['reason' => 'required|string|max:1000']);

        return DB::transaction(function () use ($request, $id, $data) {
            $adjustment = StudentFinancialAdjustment::lockForUpdate()->findOrFail($id);
            abort_if($adjustment->status !== 'posted', 422, 'Only a posted adjustment can be reversed.');
            $this->assertCurrentPeriodOpen();
            $this->ledger->postPair(
                "Reversal of {$adjustment->adjustment_no}", (float) $adjustment->amount,
                $adjustment->direction === 'credit' ? 'accounts_receivable' : 'discounts',
                $adjustment->direction === 'credit' ? 'discounts' : 'accounts_receivable',
                'student_adjustment_reversal', $adjustment->id, $request->user()->id
            );
            $adjustment->update([
                'status' => 'reversed', 'reversed_by' => $request->user()->id,
                'reversed_at' => now(), 'reversal_reason' => $data['reason'],
            ]);
            if ($adjustment->invoice_id) {
                $this->refreshInvoice(Invoice::lockForUpdate()->findOrFail($adjustment->invoice_id));
            }
            AuditLogger::log($request, 'reverse_student_adjustment', 'student_financial_adjustment', $adjustment->id, ['old' => ['status' => 'posted'], 'new' => ['status' => 'reversed'], 'reason' => $data['reason']]);

            return $adjustment->fresh();
        });
    }

    private function refreshInvoice(Invoice $invoice): void
    {
        $debits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'debit')->sum('amount');
        $credits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'credit')->sum('amount');
        $net = round((float) $invoice->amount + (float) $debits - (float) $credits, 2);
        $paid = round((float) $invoice->payments()->where('status', 'posted')->sum('amount'), 2);
        $status = $paid >= $net ? 'paid' : ($paid > 0 ? 'partial' : ($invoice->due_date->isPast() ? 'overdue' : 'pending'));
        $invoice->update(['paid_amount' => $paid, 'status' => $status]);
    }

    private function assertCurrentPeriodOpen(): void
    {
        abort_if(FinancialClosing::where('year', now()->year)->where('month', now()->month)
            ->whereIn('status', ['closed', 'audited'])->exists(), 422, 'Financial period is closed.');
    }
}
