<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Installment;
use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\CurrentSchool;
use App\Services\InstallmentReminderService;
use App\Services\LedgerService;
use App\Services\WarehouseService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * Installments sub-module: student payment plans with a generated schedule.
 * Guarded by the finance.installments.* permission set.
 */
class InstallmentController extends Controller
{
    public function __construct(
        private WarehouseService $refs,
        private LedgerService $ledger,
        private CurrentSchool $currentSchool,
    ) {}

    public function indexPlans(Request $request)
    {
        $q = PaymentPlan::query()->with(['student:id,name', 'invoice:id,invoice_no,amount']);
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }
        if ($studentId = $request->query('student_user_id')) {
            $q->where('student_user_id', $studentId);
        }

        // Capped: an uncapped client-supplied page size lets one request
        // materialise the whole table.
        return response()->json($q->latest()->paginate($this->perPage($request, 20)));
    }

    public function storePlan(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'invoice_id' => 'nullable|exists:invoices,id',
            'total_amount' => 'required|numeric|money|gt:0',
            'down_payment' => 'nullable|numeric|money|min:0|lt:total_amount',
            'num_installments' => 'required|integer|between:1,36',
            'frequency' => 'nullable|in:monthly,quarterly',
            'start_date' => 'required|date',
        ]);
        $authorisedStudent = User::whereKey($data['student_user_id'])->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $this->currentSchool->id()))
            ->exists();
        abort_unless($authorisedStudent, 422, 'The student belongs to another school.');
        if (! empty($data['invoice_id'])) {
            $invoice = Invoice::findOrFail($data['invoice_id']);
            abort_if($invoice->student_user_id !== (int) $data['student_user_id'], 422, 'Invoice belongs to another student.');
        }

        $plan = DB::transaction(function () use ($data, $request) {
            $plan = PaymentPlan::create([
                ...$data,
                'plan_no' => $this->refs->generateRef('PLAN', PaymentPlan::class),
                'frequency' => $data['frequency'] ?? 'monthly',
                'down_payment' => $data['down_payment'] ?? 0,
                'status' => 'active',
                'created_by' => $request->user()->id,
            ]);

            // Equal installments over the financed amount; the last one absorbs
            // the rounding remainder so the schedule sums exactly.
            $financed = round((float) $data['total_amount'] - (float) ($data['down_payment'] ?? 0), 2);
            $n = (int) $data['num_installments'];
            $base = floor($financed / $n * 100) / 100;
            $stepMonths = ($data['frequency'] ?? 'monthly') === 'quarterly' ? 3 : 1;

            for ($i = 1; $i <= $n; $i++) {
                $amount = $i === $n ? round($financed - $base * ($n - 1), 2) : $base;
                $plan->installments()->create([
                    'sequence_no' => $i,
                    'due_date' => Carbon::parse($data['start_date'])->addMonths(($i - 1) * $stepMonths),
                    'amount' => $amount,
                ]);
            }

            return $plan;
        });

        AuditLogger::log($request, 'create_payment_plan', 'payment_plan', $plan->id, [
            'plan_no' => $plan->plan_no, 'total' => (float) $plan->total_amount,
        ]);

        return response()->json($plan->load('installments', 'student:id,name'), 201);
    }

    public function showPlan(int $id)
    {
        return response()->json(
            PaymentPlan::with([
                'student:id,name,email', 'invoice:id,invoice_no,amount,paid_amount,status',
                'installments', 'createdBy:id,name',
            ])->findOrFail($id)
        );
    }

    /** Reschedule: shift the due dates of unpaid installments. */
    public function updatePlan(Request $request, int $id)
    {
        $data = $request->validate([
            'shift_days' => 'nullable|integer|between:-90,365',
            'status' => 'nullable|in:active,defaulted',
        ]);

        $plan = DB::transaction(function () use ($data, $id) {
            $plan = PaymentPlan::lockForUpdate()->findOrFail($id);
            abort_if($plan->status !== 'active', 422, "A {$plan->status} plan cannot be edited.");
            $installments = $plan->installments()->lockForUpdate()->get();

            if (! empty($data['shift_days'])) {
                foreach ($installments->whereIn('status', ['pending', 'partial', 'overdue']) as $inst) {
                    $inst->update(['due_date' => $inst->due_date->addDays($data['shift_days'])]);
                }
            }
            if (! empty($data['status'])) {
                $plan->update(['status' => $data['status']]);
            }

            return $plan;
        });
        AuditLogger::log($request, 'update_payment_plan', 'payment_plan', $plan->id, $data);

        return response()->json($plan->fresh('installments'));
    }

    public function cancelPlan(Request $request, int $id)
    {
        $plan = DB::transaction(function () use ($id) {
            $plan = PaymentPlan::lockForUpdate()->findOrFail($id);
            abort_if($plan->status !== 'active', 422, "A {$plan->status} plan cannot be cancelled.");
            $hasCollectedMoney = $plan->installments()->lockForUpdate()->get()
                ->contains(fn (Installment $installment) => (float) $installment->paid_amount > 0);
            abort_if($hasCollectedMoney, 422, 'A plan with collected payments cannot be cancelled.');
            $plan->update(['status' => 'cancelled']);

            return $plan;
        });
        AuditLogger::log($request, 'cancel_payment_plan', 'payment_plan', $plan->id);

        return response()->json($plan);
    }

    public function waiveInstallment(Request $request, int $id)
    {
        $inst = DB::transaction(function () use ($id) {
            $inst = Installment::lockForUpdate()->findOrFail($id);
            $plan = PaymentPlan::lockForUpdate()->findOrFail($inst->payment_plan_id);
            abort_if($plan->status !== 'active', 422, "A {$plan->status} plan cannot be changed.");
            abort_if(in_array($inst->status, ['paid', 'waived'], true), 422, "This installment is already {$inst->status}.");
            abort_if((float) $inst->paid_amount > 0, 422, 'A partially paid installment cannot be waived.');
            $inst->update(['status' => 'waived']);
            $this->completePlanIfSettled($plan);

            return $inst;
        });
        AuditLogger::log($request, 'waive_installment', 'installment', $inst->id);

        return response()->json($inst->fresh());
    }

    public function payInstallment(Request $request, int $id)
    {
        $data = $request->validate([
            'amount' => 'required|numeric|money|gt:0',
            'method' => 'required|in:cash,bank_transfer,card,online',
            'reference' => 'nullable|string',
            'note' => 'nullable|string',
        ]);

        Installment::findOrFail($id);

        $inst = DB::transaction(function () use ($data, $id, $request) {
            $inst = Installment::with('plan.invoice')->lockForUpdate()->findOrFail($id);
            $plan = PaymentPlan::lockForUpdate()->findOrFail($inst->payment_plan_id);
            abort_if($plan->status !== 'active', 422, "A {$plan->status} plan cannot receive payments.");
            if (in_array($inst->status, ['paid', 'waived'], true)) {
                abort(422, "This installment is already {$inst->status}.");
            }

            $amount = round((float) $data['amount'], 2);
            $newPaid = round((float) $inst->paid_amount + $amount, 2);
            if ($newPaid > (float) $inst->amount + 0.005) {
                $outstanding = round((float) $inst->amount - (float) $inst->paid_amount, 2);
                abort(422, "Payment exceeds the outstanding balance of {$outstanding}.");
            }

            // When the plan is tied to an invoice, record through the standard
            // payments table so receipts/reports keep working unchanged.
            $paymentId = null;
            $invoice = $plan->invoice;
            if ($invoice) {
                $invoice = Invoice::lockForUpdate()->find($invoice->id);
                $payment = Payment::create([
                    'invoice_id' => $invoice->id,
                    'amount' => $amount,
                    'method' => $data['method'],
                    'reference' => $data['reference'] ?? null,
                    'recorded_by' => $request->user()->id,
                    'paid_at' => now(),
                    'note' => $data['note'] ?? "Installment {$inst->sequence_no} of {$plan->plan_no}",
                ]);
                $newInvoicePaid = min(round((float) $invoice->paid_amount + $amount, 2), (float) $invoice->amount);
                $invoice->update([
                    'paid_amount' => $newInvoicePaid,
                    'status' => $newInvoicePaid >= (float) $invoice->amount ? 'paid' : 'partial',
                ]);
                $paymentId = $payment->id;
                $this->ledger->postPair(
                    "Installment {$inst->sequence_no} of {$plan->plan_no}", $amount,
                    'cash', 'accounts_receivable', 'student_installment', $payment->id,
                    $request->user()->id
                );
            }

            $isSettled = $newPaid >= (float) $inst->amount;
            $inst->update([
                'paid_amount' => $newPaid,
                'status' => $isSettled ? 'paid' : 'partial',
                'paid_at' => $isSettled ? now() : null,
                'payment_id' => $paymentId ?? $inst->payment_id,
            ]);

            $this->completePlanIfSettled($plan);

            return $inst;
        });

        AuditLogger::log($request, 'pay_installment', 'installment', $inst->id, [
            'amount' => (float) $data['amount'], 'method' => $data['method'],
        ]);

        return response()->json($inst->fresh('plan'));
    }

    /** Installments due within N days (default 7) plus everything overdue. */
    public function due(Request $request)
    {
        $days = (int) $request->query('days', 7);

        $due = Installment::with(['plan.student:id,name'])
            ->whereIn('status', ['pending', 'partial', 'overdue'])
            ->where('due_date', '<=', now()->addDays($days)->toDateString())
            ->orderBy('due_date')
            ->get()
            ->each(function ($inst) {
                if ($inst->status !== 'overdue' && $inst->due_date->isPast()) {
                    $inst->update(['status' => 'overdue']);
                }
            });

        return response()->json(['data' => $due]);
    }

    /** Notify parents/students about installments due in the next 3 days or overdue. */
    public function sendReminders(Request $request, InstallmentReminderService $reminders)
    {
        $sent = $reminders->send();
        AuditLogger::log($request, 'send_installment_reminders', 'installment', null, ['count' => $sent]);

        return response()->json(['reminders_sent' => $sent]);
    }

    private function completePlanIfSettled(PaymentPlan $plan): void
    {
        $open = $plan->installments()
            ->whereNotIn('status', ['paid', 'waived'])
            ->exists();
        if (! $open && $plan->status === 'active') {
            $plan->update(['status' => 'completed']);
        }
    }
}
