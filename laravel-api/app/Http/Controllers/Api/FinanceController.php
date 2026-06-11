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

    public function invoices(Request $request)
    {
        $q = Invoice::query()->with(['student:id,name', 'payments']);
        if ($s = $request->query('status')) $q->where('status', $s);
        if ($studentId = $request->query('student_user_id')) $q->where('student_user_id', $studentId);
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
        if (!$studentIds && !empty($data['class_room_id'])) {
            $studentIds = User::where('role', 'student')->whereHas('studentProfile',
                fn($q) => $q->where('class_room_id', $data['class_room_id']))->pluck('id')->all();
        }
        $created = [];
        DB::transaction(function () use ($studentIds, $fee, $data, &$created) {
            foreach ($studentIds as $sid) {
                $inv = Invoice::create([
                    'student_user_id' => $sid,
                    'fee_structure_id' => $fee->id,
                    'invoice_no' => 'INV-' . now()->format('YmdHis') . '-' . strtoupper(Str::random(4)),
                    'description' => $fee->name,
                    'amount' => $fee->amount,
                    'due_date' => $data['due_date'],
                ]);
                $created[] = $inv->id;
                Notifier::send($sid, 'new_invoice', 'New invoice', "$fee->name: $fee->amount");
                foreach (\DB::table('parent_student')->where('student_user_id', $sid)->pluck('parent_user_id') as $pid) {
                    Notifier::send($pid, 'new_invoice', 'New invoice for child', "$fee->name: $fee->amount");
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
            'amount' => 'required|numeric|min:0',
            'method' => 'required|in:cash,bank_transfer,card,online',
            'reference' => 'nullable|string',
            'paid_at' => 'nullable|date',
            'note' => 'nullable|string',
        ]);
        $inv = Invoice::findOrFail($invoiceId);
        $payment = DB::transaction(function () use ($data, $inv, $request) {
            $p = Payment::create(array_merge($data, [
                'invoice_id' => $inv->id,
                'paid_at' => $data['paid_at'] ?? now(),
                'recorded_by' => $request->user()->id,
            ]));
            $newPaid = $inv->paid_amount + $data['amount'];
            $status = $newPaid >= $inv->amount ? 'paid' : 'partial';
            $inv->update(['paid_amount' => $newPaid, 'status' => $status]);
            return $p;
        });
        AuditLogger::log($request, 'record_payment', 'invoice', $inv->id, [
            'payment_id' => $payment->id, 'amount' => (float) $data['amount'], 'method' => $data['method'],
        ]);
        return response()->json($payment, 201);
    }

    public function sendReminders(Request $request)
    {
        $unpaid = Invoice::whereIn('status', ['pending', 'partial', 'overdue'])
            ->where('due_date', '<=', now()->addDays(3))->get();
        foreach ($unpaid as $inv) {
            foreach (\DB::table('parent_student')->where('student_user_id', $inv->student_user_id)->pluck('parent_user_id') as $pid) {
                Notifier::send($pid, 'fee_reminder', 'Fee reminder', "Invoice {$inv->invoice_no} due {$inv->due_date->format('Y-m-d')}");
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
        $start = \Carbon\Carbon::create($data['year'], $data['month'], 1)->startOfMonth();
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
        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('pdf.invoice-receipt', ['invoice' => $inv]);
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
        $billed = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)->sum('amount');
        $payroll = PayrollRecord::where('year', $year)->where('month', $month)->sum('net_pay');

        return response()->json([
            'period' => compact('year', 'month'),
            'income_by_method' => $income,
            'total_billed' => (float) $billed,
            'total_payroll' => (float) $payroll,
            'net' => (float) $income->sum('total') - (float) $payroll,
        ]);
    }
}
