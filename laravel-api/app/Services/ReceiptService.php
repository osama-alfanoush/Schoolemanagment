<?php

namespace App\Services;

use App\Models\FinancialClosing;
use App\Models\Installment;
use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\PaymentReceipt;
use App\Models\StudentFinancialAdjustment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class ReceiptService
{
    public function __construct(
        private LedgerService $ledger,
        private CurrentSchool $currentSchool,
    ) {}

    public function create(Request $request): PaymentReceipt
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate([
            'idempotency_key' => 'required|uuid',
            'student_user_id' => 'required|exists:users,id',
            'amount' => 'required|numeric|money|gt:0',
            'method' => 'required|in:cash,bank_transfer,card,online',
            'receipt_date' => 'required|date',
            'reference' => 'nullable|string|max:255',
            'cash_account' => 'nullable|string|max:100',
            'note' => 'nullable|string|max:1000',
            'allocations' => 'nullable|array',
            'allocations.*.invoice_id' => 'required_with:allocations|exists:invoices,id',
            'allocations.*.installment_id' => 'nullable|exists:installments,id',
            'allocations.*.amount' => 'required_with:allocations|numeric|money|gt:0',
        ]);
        $authorisedStudent = User::whereKey($data['student_user_id'])->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $this->currentSchool->id()))
            ->exists();
        abort_unless($authorisedStudent, 422, 'The student belongs to another school.');

        $amount = $this->cents($data['amount']);
        $payloadHash = hash('sha256', json_encode([
            'student_user_id' => (int) $data['student_user_id'], 'amount' => $amount,
            'method' => $data['method'], 'receipt_date' => $data['receipt_date'],
            'reference' => $data['reference'] ?? null, 'cash_account' => $data['cash_account'] ?? null,
            'allocations' => $data['allocations'] ?? null,
        ], JSON_THROW_ON_ERROR));

        return DB::transaction(function () use ($data, $amount, $payloadHash, $request) {
            $existing = PaymentReceipt::where('idempotency_key', $data['idempotency_key'])->first();
            if ($existing) {
                abort_if(! hash_equals($existing->idempotency_payload_hash, $payloadHash), 409,
                    'Idempotency key was reused with a different receipt payload.');

                return $existing->load('allocations.invoice');
            }

            $allocations = empty($data['allocations'])
                ? $this->automaticAllocations((int) $data['student_user_id'], $amount)
                : $this->validateAllocations((int) $data['student_user_id'], $amount, $data['allocations']);

            $receipt = PaymentReceipt::create([
                'receipt_no' => 'RCPT-'.now()->format('Ymd').'-'.Str::upper(Str::random(8)),
                'student_user_id' => $data['student_user_id'],
                'amount' => $amount / 100,
                'method' => $data['method'],
                'receipt_date' => $data['receipt_date'],
                'reference' => $data['reference'] ?? null,
                'cash_account' => $data['cash_account'] ?? null,
                'note' => $data['note'] ?? null,
                'status' => 'draft',
                'idempotency_key' => $data['idempotency_key'],
                'idempotency_payload_hash' => $payloadHash,
                'created_by' => $request->user()->id,
            ]);
            foreach ($allocations as $allocation) {
                $receipt->allocations()->create($allocation);
            }
            AuditLogger::log($request, 'create_receipt', 'payment_receipt', $receipt->id, [
                'receipt_no' => $receipt->receipt_no, 'amount' => $receipt->amount,
                'allocations' => $allocations,
            ]);

            return $receipt->load('allocations.invoice', 'student:id,name');
        });
    }

    public function approve(Request $request, int $id): PaymentReceipt
    {
        return DB::transaction(function () use ($request, $id) {
            $receipt = PaymentReceipt::with('allocations')->lockForUpdate()->findOrFail($id);
            abort_if($receipt->status !== 'draft', 422, 'Only a draft receipt can be approved.');
            $this->assertAllocationTotal($receipt);
            $receipt->update(['status' => 'approved', 'approved_by' => $request->user()->id, 'approved_at' => now()]);
            AuditLogger::log($request, 'approve_receipt', 'payment_receipt', $receipt->id, ['old' => ['status' => 'draft'], 'new' => ['status' => 'approved']]);

            return $receipt->fresh('allocations.invoice');
        });
    }

    public function post(Request $request, int $id): PaymentReceipt
    {
        return DB::transaction(function () use ($request, $id) {
            $receipt = PaymentReceipt::with('allocations')->lockForUpdate()->findOrFail($id);
            abort_if($receipt->status !== 'approved', 422, 'Only an approved receipt can be posted.');
            $this->assertPeriodOpen($receipt->receipt_date->year, $receipt->receipt_date->month);
            $this->assertAllocationTotal($receipt);

            foreach ($receipt->allocations as $allocation) {
                $invoice = Invoice::lockForUpdate()->findOrFail($allocation->invoice_id);
                abort_if($invoice->student_user_id !== $receipt->student_user_id, 422, 'Allocation invoice belongs to another student.');
                $netDue = $this->invoiceNetDueCents($invoice);
                $paid = $this->invoicePaidCents($invoice);
                $allocationCents = $this->cents($allocation->amount);
                abort_if($allocationCents > $netDue - $paid, 422, 'Allocation exceeds the current invoice balance.');

                $payment = Payment::create([
                    'invoice_id' => $invoice->id,
                    'payment_receipt_id' => $receipt->id,
                    'amount' => $allocationCents / 100,
                    'method' => $receipt->method,
                    'reference' => $receipt->reference,
                    'recorded_by' => $request->user()->id,
                    'paid_at' => $receipt->receipt_date,
                    'note' => $receipt->note,
                    'status' => 'posted',
                ]);
                DB::table('payment_allocations')->insert([
                    'school_id' => $receipt->school_id,
                    'payment_id' => $payment->id, 'invoice_id' => $invoice->id,
                    'amount' => $allocationCents / 100, 'created_at' => now(), 'updated_at' => now(),
                ]);

                if ($allocation->installment_id) {
                    $installment = Installment::lockForUpdate()->findOrFail($allocation->installment_id);
                    abort_if($installment->plan->student_user_id !== $receipt->student_user_id, 422, 'Installment belongs to another student.');
                    abort_if($installment->plan->invoice_id !== $invoice->id, 422, 'Installment is not linked to the allocated invoice.');
                    $newPaid = $this->cents($installment->paid_amount) + $allocationCents;
                    abort_if($newPaid > $this->cents($installment->amount), 422, 'Allocation exceeds the installment balance.');
                    $installment->update([
                        'paid_amount' => $newPaid / 100,
                        'status' => $newPaid === $this->cents($installment->amount) ? 'paid' : 'partial',
                        'payment_id' => $payment->id,
                        'paid_at' => $newPaid === $this->cents($installment->amount) ? $receipt->receipt_date : null,
                    ]);
                    if (! $installment->plan->installments()->whereNotIn('status', ['paid', 'waived'])->exists()) {
                        $installment->plan->update(['status' => 'completed']);
                    }
                }

                $this->refreshInvoice($invoice);
            }

            $this->ledger->postPair(
                "Student receipt {$receipt->receipt_no}", (float) $receipt->amount,
                'cash', 'accounts_receivable', 'student_receipt', $receipt->id,
                $request->user()->id, $receipt->receipt_date->toDateString()
            );
            $receipt->update(['status' => 'posted', 'posted_by' => $request->user()->id, 'posted_at' => now()]);
            AuditLogger::log($request, 'post_receipt', 'payment_receipt', $receipt->id, ['old' => ['status' => 'approved'], 'new' => ['status' => 'posted']]);

            return $receipt->fresh(['allocations.invoice', 'payments', 'student:id,name']);
        });
    }

    public function reverse(Request $request, int $id): PaymentReceipt
    {
        $data = $request->validate(['reason' => 'required|string|max:1000']);

        return DB::transaction(function () use ($request, $id, $data) {
            $receipt = PaymentReceipt::with(['payments', 'allocations'])->lockForUpdate()->findOrFail($id);
            abort_if($receipt->status !== 'posted', 422, 'Only a posted receipt can be reversed.');
            $this->assertPeriodOpen(now()->year, now()->month);

            foreach ($receipt->payments as $payment) {
                $payment->update(['status' => 'reversed', 'reversed_at' => now()]);
                DB::table('payment_reversals')->insert([
                    'school_id' => $receipt->school_id,
                    'payment_id' => $payment->id,
                    'amount' => $payment->amount,
                    'provider_reference' => "receipt-{$receipt->id}-payment-{$payment->id}",
                    'reason' => $data['reason'],
                    'reversed_at' => now(), 'created_at' => now(), 'updated_at' => now(),
                ]);
            }
            foreach ($receipt->allocations as $allocation) {
                $invoice = Invoice::lockForUpdate()->findOrFail($allocation->invoice_id);
                if ($allocation->installment_id) {
                    $installment = Installment::lockForUpdate()->findOrFail($allocation->installment_id);
                    $newPaid = max(0, $this->cents($installment->paid_amount) - $this->cents($allocation->amount));
                    $installment->update([
                        'paid_amount' => $newPaid / 100,
                        'status' => $newPaid === 0 ? ($installment->due_date->isPast() ? 'overdue' : 'pending') : 'partial',
                        'paid_at' => null,
                    ]);
                    if ($installment->plan->status === 'completed') {
                        $installment->plan->update(['status' => 'active']);
                    }
                }
                $this->refreshInvoice($invoice);
            }
            $this->ledger->postPair(
                "Reversal of student receipt {$receipt->receipt_no}", (float) $receipt->amount,
                'accounts_receivable', 'cash', 'student_receipt_reversal', $receipt->id,
                $request->user()->id
            );
            $receipt->update([
                'status' => 'reversed', 'reversed_by' => $request->user()->id,
                'reversed_at' => now(), 'reversal_reason' => $data['reason'],
            ]);
            AuditLogger::log($request, 'reverse_receipt', 'payment_receipt', $receipt->id, ['old' => ['status' => 'posted'], 'new' => ['status' => 'reversed'], 'reason' => $data['reason']]);

            return $receipt->fresh(['allocations.invoice', 'payments']);
        });
    }

    private function automaticAllocations(int $studentId, int $amount): array
    {
        $remaining = $amount;
        $result = [];
        $invoices = Invoice::where('student_user_id', $studentId)
            ->whereNotIn('status', ['cancelled'])->orderBy('due_date')->lockForUpdate()->get();
        foreach ($invoices as $invoice) {
            $outstanding = max(0, $this->invoiceNetDueCents($invoice) - $this->invoicePaidCents($invoice));
            if ($outstanding === 0) {
                continue;
            }
            $invoiceAllocation = min($remaining, $outstanding);
            $invoiceRemaining = $invoiceAllocation;
            $plan = PaymentPlan::where('invoice_id', $invoice->id)
                ->where('status', 'active')->with('installments')->first();
            if ($plan) {
                foreach ($plan->installments->whereIn('status', ['pending', 'partial', 'overdue']) as $installment) {
                    $installmentOutstanding = max(0, $this->cents($installment->amount) - $this->cents($installment->paid_amount));
                    $allocated = min($invoiceRemaining, $installmentOutstanding);
                    if ($allocated > 0) {
                        $result[] = ['invoice_id' => $invoice->id, 'installment_id' => $installment->id, 'amount' => $allocated / 100];
                        $invoiceRemaining -= $allocated;
                    }
                    if ($invoiceRemaining === 0) {
                        break;
                    }
                }
            }
            if ($invoiceRemaining > 0) {
                $result[] = ['invoice_id' => $invoice->id, 'installment_id' => null, 'amount' => $invoiceRemaining / 100];
            }
            $remaining -= $invoiceAllocation;
            if ($remaining === 0) {
                break;
            }
        }
        if ($remaining !== 0) {
            throw ValidationException::withMessages(['amount' => 'Receipt amount exceeds the student outstanding balance.']);
        }

        return $result;
    }

    private function validateAllocations(int $studentId, int $amount, array $allocations): array
    {
        $seen = [];
        $total = 0;
        $result = [];
        foreach ($allocations as $index => $allocation) {
            $invoice = Invoice::where('student_user_id', $studentId)->lockForUpdate()->find($allocation['invoice_id']);
            if (! $invoice) {
                throw ValidationException::withMessages(["allocations.{$index}.invoice_id" => 'Invoice does not belong to the selected student.']);
            }
            if (isset($seen[$invoice->id])) {
                throw ValidationException::withMessages(["allocations.{$index}.invoice_id" => 'Invoice is allocated more than once.']);
            }
            $seen[$invoice->id] = true;
            $value = $this->cents($allocation['amount']);
            $outstanding = max(0, $this->invoiceNetDueCents($invoice) - $this->invoicePaidCents($invoice));
            if ($value > $outstanding) {
                throw ValidationException::withMessages(["allocations.{$index}.amount" => 'Allocation exceeds the invoice balance.']);
            }
            $total += $value;
            if (! empty($allocation['installment_id'])) {
                $installment = Installment::with('plan')->find($allocation['installment_id']);
                if (! $installment || $installment->plan->invoice_id !== $invoice->id) {
                    throw ValidationException::withMessages(["allocations.{$index}.installment_id" => 'Installment is not linked to the allocated invoice.']);
                }
                $installmentOutstanding = max(0, $this->cents($installment->amount) - $this->cents($installment->paid_amount));
                if ($value > $installmentOutstanding) {
                    throw ValidationException::withMessages(["allocations.{$index}.amount" => 'Allocation exceeds the installment balance.']);
                }
                $result[] = ['invoice_id' => $invoice->id, 'installment_id' => $installment->id, 'amount' => $value / 100];

                continue;
            }

            $remaining = $value;
            $plan = PaymentPlan::where('invoice_id', $invoice->id)
                ->where('status', 'active')->with('installments')->first();
            if ($plan) {
                foreach ($plan->installments->whereIn('status', ['pending', 'partial', 'overdue']) as $installment) {
                    $installmentOutstanding = max(0, $this->cents($installment->amount) - $this->cents($installment->paid_amount));
                    $part = min($remaining, $installmentOutstanding);
                    if ($part > 0) {
                        $result[] = ['invoice_id' => $invoice->id, 'installment_id' => $installment->id, 'amount' => $part / 100];
                        $remaining -= $part;
                    }
                    if ($remaining === 0) {
                        break;
                    }
                }
            }
            if ($remaining > 0) {
                $result[] = ['invoice_id' => $invoice->id, 'installment_id' => null, 'amount' => $remaining / 100];
            }
        }
        if ($total !== $amount) {
            throw ValidationException::withMessages(['allocations' => 'Allocated amount must equal the receipt amount.']);
        }

        return $result;
    }

    private function assertAllocationTotal(PaymentReceipt $receipt): void
    {
        $allocated = $this->cents($receipt->allocations()->sum('amount'));
        abort_if($allocated !== $this->cents($receipt->amount), 422, 'Allocated amount must equal the receipt amount.');
    }

    private function invoiceNetDueCents(Invoice $invoice): int
    {
        $debits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'debit')->sum('amount');
        $credits = StudentFinancialAdjustment::where('invoice_id', $invoice->id)->where('status', 'posted')->where('direction', 'credit')->sum('amount');

        return max(0, $this->cents($invoice->amount) + $this->cents($debits) - $this->cents($credits));
    }

    private function invoicePaidCents(Invoice $invoice): int
    {
        return $this->cents($invoice->payments()->where('status', 'posted')->sum('amount'));
    }

    private function refreshInvoice(Invoice $invoice): void
    {
        $paid = $this->invoicePaidCents($invoice);
        $due = $this->invoiceNetDueCents($invoice);
        $status = $paid >= $due ? 'paid' : ($paid > 0 ? 'partial' : ($invoice->due_date->isPast() ? 'overdue' : 'pending'));
        $invoice->update(['paid_amount' => $paid / 100, 'status' => $status]);
    }

    private function assertPeriodOpen(int $year, int $month): void
    {
        abort_if(FinancialClosing::where('year', $year)->where('month', $month)
            ->whereIn('status', ['closed', 'audited'])->exists(), 422, 'Financial period is closed.');
    }

    private function cents(mixed $amount): int
    {
        return (int) round((float) $amount * 100);
    }
}
