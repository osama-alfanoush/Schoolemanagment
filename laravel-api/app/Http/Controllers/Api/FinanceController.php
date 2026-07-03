<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\FeeStructure;
use App\Models\HrRequest;
use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PayrollRecord;
use App\Models\StaffProfile;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\Notifier;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class FinanceController extends Controller
{
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

        return response()->json($q->latest()->paginate(50));
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
        // Pre-fetch all parent links in ONE query (avoids a per-student lookup).
        $parentsByStudent = \DB::table('parent_student')
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
        $data = $request->validate([
            'amount' => 'required|numeric|gt:0',
            'method' => 'required|in:cash,bank_transfer,card,online',
            'reference' => 'nullable|string',
            'paid_at' => 'nullable|date',
            'note' => 'nullable|string',
        ]);

        // Fail fast with 404 before opening a write transaction.
        Invoice::findOrFail($invoiceId);

        $payment = DB::transaction(function () use ($data, $invoiceId, $request) {
            // Lock the invoice row so concurrent manual payments cannot race and
            // overwrite each other's paid_amount totals.
            $inv = Invoice::lockForUpdate()->findOrFail($invoiceId);
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
            ]));
            $status = $newPaid >= (float) $inv->amount ? 'paid' : 'partial';
            $inv->update(['paid_amount' => $newPaid, 'status' => $status]);

            return $p;
        });
        AuditLogger::log($request, 'record_payment', 'invoice', $invoiceId, [
            'payment_id' => $payment->id, 'amount' => (float) $data['amount'], 'method' => $data['method'],
        ]);

        return response()->json($payment, 201);
    }

    public function sendReminders(Request $request)
    {
        $unpaid = Invoice::whereIn('status', ['pending', 'partial', 'overdue'])
            ->where('due_date', '<=', now()->addDays(3))->get();

        // Pre-fetch all parent links for the affected students in ONE query.
        $parentsByStudent = \DB::table('parent_student')
            ->whereIn('student_user_id', $unpaid->pluck('student_user_id')->unique())
            ->get()
            ->groupBy('student_user_id');

        foreach ($unpaid as $inv) {
            foreach ($parentsByStudent->get($inv->student_user_id, collect()) as $link) {
                Notifier::send($link->parent_user_id, 'fee_reminder', 'Fee reminder', "Invoice {$inv->invoice_no} due {$inv->due_date->format('Y-m-d')}");
            }
        }
        AuditLogger::log($request, 'send_fee_reminders', 'invoice', null, ['reminded' => $unpaid->count()]);

        return response()->json(['reminded' => $unpaid->count()]);
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
        $year = (int) $request->query('year', now()->year);
        $month = (int) $request->query('month', now()->month);

        return response()->json(PayrollRecord::where('year', $year)->where('month', $month)
            ->with('staff:id,name,role')->get());
    }

    public function processPayroll(Request $request)
    {
        $data = $request->validate(['year' => 'required|integer', 'month' => 'required|integer|between:1,12']);
        $start = Carbon::create($data['year'], $data['month'], 1)->startOfMonth();
        $end = (clone $start)->endOfMonth();
        $created = 0;
        DB::transaction(function () use ($data, $start, $end, &$created) {
            $staffList = StaffProfile::with('user')->get();
            foreach ($staffList as $sp) {
                // Only deduct advances approved within this payroll month — prevents double-deduction.
                $advance = (float) HrRequest::where('teacher_user_id', $sp->user_id)
                    ->where('type', 'salary_advance')
                    ->where('status', 'approved')
                    ->whereBetween('reviewed_at', [$start, $end])
                    ->sum('amount');
                $net = (float) $sp->base_salary - $advance;
                PayrollRecord::updateOrCreate(
                    ['staff_user_id' => $sp->user_id, 'year' => $data['year'], 'month' => $data['month']],
                    [
                        'base_salary' => $sp->base_salary,
                        'allowances' => 0,
                        'deductions' => 0,
                        'advance_deduction' => $advance,
                        'net_pay' => $net,
                        'status' => 'processed',
                    ]
                );
                $created++;
            }
        });
        AuditLogger::log($request, 'process_payroll', 'payroll', null, [
            'year' => $data['year'], 'month' => $data['month'], 'records' => $created,
        ]);

        return response()->json(['processed' => $created]);
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
        $year = (int) $request->query('year', now()->year);
        $month = (int) $request->query('month', now()->month);

        $income = Payment::whereYear('paid_at', $year)->whereMonth('paid_at', $month)
            ->select('method')
            ->selectRaw('COALESCE(sum(amount), 0) as total')
            ->groupBy('method')->get();
        $collected = (float) $income->sum('total');
        $billed = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)->sum('amount');
        $payroll = PayrollRecord::where('year', $year)->where('month', $month)->sum('net_pay');
        $invoicesIssued = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)->count();
        $payrollCount = PayrollRecord::where('year', $year)->where('month', $month)->count();
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
        $record = PayrollRecord::findOrFail($id);
        if ($record->status === 'paid') {
            return response()->json(['message' => 'This payroll record is already paid.'], 400);
        }
        $record->update(['status' => 'paid', 'paid_at' => now()]);
        AuditLogger::log($request, 'mark_payroll_paid', 'payroll', $record->id, [
            'net_pay' => (float) $record->net_pay,
        ]);

        return response()->json($record->load('staff:id,name,role'));
    }
}
