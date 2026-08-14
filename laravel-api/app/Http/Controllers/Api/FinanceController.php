<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\FeeStructure;
use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PayrollRecord;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\LedgerService;
use App\Services\Notifier;
use App\Services\PaymentReconciliationService;
use App\Services\SchoolContext;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class FinanceController extends Controller
{
    public function __construct(private LedgerService $ledger, private SchoolContext $schools) {}

    public function feeStructures(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'name' => 'required', 'grade' => 'nullable',
                'billing_cycle' => 'required|in:monthly,semester,yearly,one-time',
                'amount' => 'required|numeric|min:0', 'is_active' => 'boolean',
            ]);
            $fs = FeeStructure::create($data);
            AuditLogger::log($request, 'create_fee_structure', 'fee_structure', $fs->id, $data);

            return response()->json($fs, 201);
        }

        return response()->json(FeeStructure::orderBy('name')->get());
    }

    public function updateFeeStructure(Request $request, int $id)
    {
        $fs = FeeStructure::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string',
            'grade' => 'nullable',
            'billing_cycle' => 'sometimes|in:monthly,semester,yearly,one-time',
            'amount' => 'sometimes|numeric|min:0',
            'is_active' => 'sometimes|boolean',
        ]);
        $fs->update($data);
        AuditLogger::log($request, 'update_fee_structure', 'fee_structure', $fs->id, $data);

        return response()->json($fs);
    }

    public function deleteFeeStructure(Request $request, int $id)
    {
        $fs = FeeStructure::findOrFail($id);
        $fs->delete();
        AuditLogger::log($request, 'delete_fee_structure', 'fee_structure', $id);

        return response()->noContent();
    }

    public function invoices(Request $request)
    {
        $q = Invoice::query()->with(['student:id,name', 'payments']);
        if ($s = $request->query('status')) {
            $q->where('status', $s);
        }
        if ($studentId = $request->query('student_user_id')) {
            $q->where('student_user_id', $studentId);
        }

        $invoices = $q->latest()->paginate(50);
        $now = now();
        $summary = [
            'today_total' => (float) (Payment::where('status', 'posted')->whereDate('paid_at', $now->toDateString())->sum('amount') ?? 0),
            'month_total' => (float) (Payment::where('status', 'posted')->whereBetween('paid_at', [
                $now->copy()->startOfMonth(),
                $now->copy()->endOfMonth(),
            ])->sum('amount') ?? 0),
            // Pending gateway intents are not persisted as Payment rows yet.
            'pending_confirmation_total' => 0.0,
        ];

        return response()->json(array_merge($invoices->toArray(), ['summary' => $summary]));
    }

    public function generateInvoices(Request $request)
    {
        $data = $request->validate([
            'fee_structure_id' => 'required|exists:fee_structures,id',
            'due_date' => 'required|date',
            'student_user_ids' => 'nullable|array|min:1',
            'class_room_id' => 'nullable|exists:class_rooms,id',
        ]);
        $fee = FeeStructure::findOrFail($data['fee_structure_id']);

        // Require at least one filter to prevent accidental bulk invoicing
        if (empty($data['student_user_ids']) && empty($data['class_room_id'])) {
            abort(422, 'Either student_user_ids or class_room_id must be provided.');
        }

        $studentIds = $data['student_user_ids'] ?? null;
        if (! $studentIds && ! empty($data['class_room_id'])) {
            $studentIds = User::where('role', 'student')->whereHas('studentProfile',
                fn ($q) => $q->where('class_room_id', $data['class_room_id']))->pluck('id')->all();
        }
        $schoolId = $this->schools->forUser($request->user());
        $authorisedStudentCount = User::whereIn('id', $studentIds)->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $schoolId))
            ->count();
        abort_unless($authorisedStudentCount === count(array_unique($studentIds)), 422, 'One or more students belong to another school.');
        // Pre-fetch all parent links in ONE query (avoids a per-student lookup).
        $parentsByStudent = \DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->whereIn('student_user_id', $studentIds)
            ->get()
            ->groupBy('student_user_id');

        $created = [];
        DB::transaction(function () use ($studentIds, $fee, $data, $parentsByStudent, &$created) {
            foreach ($studentIds as $sid) {
                $inv = Invoice::create([
                    'student_user_id' => $sid,
                    'fee_structure_id' => $fee->id,
                    'invoice_no' => 'INV-'.now()->format('YmdHis').'-'.strtoupper(Str::random(4)),
                    'description' => $fee->name,
                    'amount' => $fee->amount,
                    'due_date' => $data['due_date'],
                ]);
                $created[] = $inv->id;
                Notifier::send($sid, 'new_invoice', 'New invoice', "$fee->name: $fee->amount");
                foreach ($parentsByStudent->get($sid, collect()) as $link) {
                    Notifier::send($link->parent_user_id, 'new_invoice', 'New invoice for child', "$fee->name: $fee->amount");
                }
            }
        });
        AuditLogger::log($request, 'generate_invoices', 'invoice', null, [
            'fee_structure_id' => $fee->id, 'count' => count($created), 'invoice_ids' => $created,
        ]);

        return response()->json(['created' => count($created)], 201);
    }

    public function recordPayment(Request $request, int $invoiceId)
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate([
            'idempotency_key' => 'required|uuid',
            'amount' => 'required|numeric|gt:0',
            'method' => 'required|in:cash,bank_transfer,card,online',
            'reference' => 'nullable|string',
            'paid_at' => 'nullable|date',
            'note' => 'nullable|string',
        ]);

        // Fail fast with 404 before opening a write transaction.
        Invoice::findOrFail($invoiceId);
        $payloadHash = hash('sha256', json_encode([
            'invoice_id' => $invoiceId, 'amount' => round((float) $data['amount'], 2),
            'method' => $data['method'], 'reference' => $data['reference'] ?? null,
            'paid_at' => $data['paid_at'] ?? null, 'note' => $data['note'] ?? null,
        ], JSON_THROW_ON_ERROR));

        $payment = DB::transaction(function () use ($data, $invoiceId, $request, $payloadHash) {
            // Lock the invoice row so concurrent manual payments cannot race and
            // overwrite each other's paid_amount totals.
            $inv = Invoice::lockForUpdate()->findOrFail($invoiceId);
            $existing = Payment::where('idempotency_key', $data['idempotency_key'])->first();
            if ($existing) {
                abort_if($existing->invoice_id !== $inv->id, 409, 'Idempotency key was already used for another invoice.');
                abort_if(! hash_equals((string) $existing->idempotency_payload_hash, $payloadHash), 409, 'Idempotency key was reused with a different payment payload.');

                return $existing;
            }
            $amount = round((float) $data['amount'], 2);
            $newPaid = round((float) $inv->paid_amount + $amount, 2);

            // Reject overpayment (tolerate a sub-cent rounding margin).
            if ($newPaid > (float) $inv->amount + 0.005) {
                $outstanding = round((float) $inv->amount - (float) $inv->paid_amount, 2);
                abort(422, "Payment exceeds the outstanding balance of {$outstanding}.");
            }

            $p = Payment::create(array_merge($data, [
                'invoice_id' => $inv->id,
                'amount' => $amount,
                'paid_at' => $data['paid_at'] ?? now(),
                'recorded_by' => $request->user()->id,
                'idempotency_payload_hash' => $payloadHash,
            ]));
            DB::table('payment_allocations')->insert([
                'school_id' => $inv->school_id,
                'payment_id' => $p->id, 'invoice_id' => $inv->id, 'amount' => $amount,
                'created_at' => now(), 'updated_at' => now(),
            ]);
            $status = $newPaid >= (float) $inv->amount ? 'paid' : 'partial';
            $inv->update(['paid_amount' => $newPaid, 'status' => $status]);

            $this->ledger->postPair(
                "Student payment for {$inv->invoice_no}", $amount,
                'cash', 'accounts_receivable', 'student_payment', $p->id,
                $request->user()->id, substr((string) $p->paid_at, 0, 10)
            );

            return $p;
        });
        AuditLogger::log($request, 'record_payment', 'invoice', $invoiceId, [
            'payment_id' => $payment->id, 'amount' => (float) $data['amount'], 'method' => $data['method'],
        ]);

        return response()->json($payment, $payment->wasRecentlyCreated ? 201 : 200);
    }

    public function reconcilePayments(Request $request, PaymentReconciliationService $reconciliation)
    {
        $result = $reconciliation->run($request->user()->id);
        AuditLogger::log($request, 'payments_reconciled', 'payment_reconciliation_run', null, [
            'run_id' => $result['run_id'], 'mismatch_count' => $result['mismatch_count'],
        ]);

        return response()->json(['data' => $result], $result['mismatch_count'] === 0 ? 200 : 409);
    }

    public function sendReminders(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $reminded = 0;

        // Chunked rather than loaded whole. This previously did ->get() on
        // every unpaid invoice in the school and held the entire result set,
        // plus every parent link for it, in memory at once — memory that grows
        // with the school and with each term's backlog. Chunking bounds the
        // working set to one page regardless of how much is outstanding.
        Invoice::whereIn('status', ['pending', 'partial', 'overdue'])
            ->where('due_date', '<=', now()->addDays(3))
            ->orderBy('id')
            ->chunkById(200, function ($invoices) use ($schoolId, &$reminded) {
                // One parent-link query per chunk, not per invoice.
                $parentsByStudent = \DB::table('parent_student')
                    ->where('school_id', $schoolId)
                    ->whereIn('student_user_id', $invoices->pluck('student_user_id')->unique())
                    ->get()
                    ->groupBy('student_user_id');

                foreach ($invoices as $inv) {
                    foreach ($parentsByStudent->get($inv->student_user_id, collect()) as $link) {
                        Notifier::send($link->parent_user_id, 'fee_reminder', 'Fee reminder', "Invoice {$inv->invoice_no} due {$inv->due_date->format('Y-m-d')}");
                    }
                    $reminded++;
                }
            });

        AuditLogger::log($request, 'send_fee_reminders', 'invoice', null, ['reminded' => $reminded]);

        return response()->json(['reminded' => $reminded]);
    }

    public function outstandingByStudent()
    {
        $rows = Invoice::whereIn('status', ['pending', 'partial', 'overdue'])
            ->select('student_user_id')
            ->selectRaw('sum(COALESCE(amount, 0) - COALESCE(paid_amount, 0)) as outstanding')
            ->groupBy('student_user_id')->with('student:id,name')->get();

        return response()->json($rows);
    }

    public function payroll(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $year = (int) $request->query('year', now()->year);
        $month = (int) $request->query('month', now()->month);

        return response()->json(PayrollRecord::where('school_id', $schoolId)->where('year', $year)->where('month', $month)
            ->with('staff:id,name,role')->get());
    }

    public function processPayroll(Request $request)
    {
        return response()->json([
            'message' => 'This legacy payroll writer is no longer supported. Use POST /api/finance/payroll/runs and the run workflow.',
            'code' => 'LEGACY_PAYROLL_WRITE_DISABLED',
        ], 410);
    }

    /**
     * Generate a PDF payment receipt for a paid invoice.
     */
    public function invoiceReceipt(int $invoiceId)
    {
        $inv = Invoice::with(['student:id,name,email', 'payments', 'feeStructure'])->findOrFail($invoiceId);
        $pdf = Pdf::loadView('pdf.invoice-receipt', ['invoice' => $inv]);

        return $pdf->download("receipt-{$inv->invoice_no}.pdf");
    }

    public function financialReports(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $year = (int) $request->query('year', now()->year);
        $month = (int) $request->query('month', now()->month);

        $income = Payment::where('status', 'posted')->whereYear('paid_at', $year)->whereMonth('paid_at', $month)
            ->select('method')
            ->selectRaw('COALESCE(sum(amount), 0) as total')
            ->groupBy('method')->get();
        $collected = (float) $income->sum('total');
        $billed = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)->sum('amount');
        $payroll = PayrollRecord::where('school_id', $schoolId)->where('year', $year)->where('month', $month)->sum('net_pay');
        $invoicesIssued = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)->count();
        $payrollCount = PayrollRecord::where('school_id', $schoolId)->where('year', $year)->where('month', $month)->count();
        $outstanding = (float) Invoice::whereIn('status', ['pending', 'partial', 'overdue'])
            ->selectRaw('COALESCE(sum(COALESCE(amount, 0) - COALESCE(paid_amount, 0)), 0) as total')
            ->value('total');

        return response()->json([
            'period' => compact('year', 'month'),
            'income_by_method' => $income,
            'total_collected' => $collected,
            'total_billed' => (float) $billed,
            'total_outstanding' => $outstanding,
            'total_payroll' => (float) $payroll,
            'invoices_issued' => $invoicesIssued,
            'payroll_count' => $payrollCount,
            'net' => $collected - (float) $payroll,
        ]);
    }

    /**
     * Mark a single payroll record as paid.
     */
    public function markPayrollPaid(Request $request, int $id)
    {
        return response()->json([
            'message' => 'This legacy payroll writer is no longer supported. Pay the owning payroll run instead.',
            'code' => 'LEGACY_PAYROLL_WRITE_DISABLED',
        ], 410);
    }
}
