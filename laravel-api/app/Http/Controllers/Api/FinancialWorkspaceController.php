<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Installment;
use App\Models\JournalBatch;
use App\Models\PaymentReceipt;
use App\Models\StudentFinancialAdjustment;
use App\Services\CurrentSchool;
use App\Services\ReceiptService;
use App\Services\StudentAdjustmentService;
use App\Services\StudentFinanceService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FinancialWorkspaceController extends Controller
{
    public function __construct(
        private StudentFinanceService $students,
        private ReceiptService $receipts,
        private StudentAdjustmentService $adjustments,
        private CurrentSchool $currentSchool,
    ) {}

    public function searchStudents(Request $request)
    {
        return response()->json($this->students->search($request));
    }

    public function studentProfile(int $studentId)
    {
        return response()->json($this->students->profile($studentId));
    }

    public function studentStatement(Request $request, int $studentId)
    {
        return response()->json($this->students->statement($request, $studentId));
    }

    public function indexReceipts(Request $request)
    {
        $query = PaymentReceipt::with(['student:id,name', 'allocations.invoice:id,invoice_no']);
        foreach (['status', 'method', 'student_user_id'] as $filter) {
            if ($request->filled($filter)) {
                $query->where($filter, $request->query($filter));
            }
        }
        if ($request->filled('date_from')) {
            $query->whereDate('receipt_date', '>=', $request->query('date_from'));
        }
        if ($request->filled('date_to')) {
            $query->whereDate('receipt_date', '<=', $request->query('date_to'));
        }
        if ($request->filled('search')) {
            $search = $request->query('search');
            $query->where(fn ($q) => $q->where('receipt_no', 'like', "%{$search}%")
                ->orWhere('reference', 'like', "%{$search}%")
                ->orWhereHas('student', fn ($student) => $student->where('name', 'like', "%{$search}%")));
        }

        return response()->json($query->latest('receipt_date')->latest('id')
            ->paginate($this->perPage($request, 25)));
    }

    public function storeReceipt(Request $request)
    {
        $receipt = $this->receipts->create($request);

        return response()->json($receipt, $receipt->wasRecentlyCreated ? 201 : 200);
    }

    public function showReceipt(int $id)
    {
        return response()->json(PaymentReceipt::with([
            'student.studentProfile.classRoom.academicYear', 'allocations.invoice', 'payments', 'creator:id,name',
        ])->findOrFail($id));
    }

    public function approveReceipt(Request $request, int $id)
    {
        return response()->json($this->receipts->approve($request, $id));
    }

    public function postReceipt(Request $request, int $id)
    {
        return response()->json($this->receipts->post($request, $id));
    }

    public function reverseReceipt(Request $request, int $id)
    {
        return response()->json($this->receipts->reverse($request, $id));
    }

    public function receiptPdf(int $id)
    {
        $receipt = PaymentReceipt::with(['student.studentProfile', 'allocations.invoice', 'creator:id,name'])->findOrFail($id);

        return Pdf::loadView('pdf.payment-receipt', compact('receipt'))
            ->download("receipt-{$receipt->receipt_no}.pdf");
    }

    public function indexAdjustments(Request $request)
    {
        $query = StudentFinancialAdjustment::with(['student:id,name', 'invoice:id,invoice_no']);
        foreach (['status', 'type', 'student_user_id', 'invoice_id'] as $filter) {
            if ($request->filled($filter)) {
                $query->where($filter, $request->query($filter));
            }
        }

        return response()->json($query->latest()->paginate($this->perPage($request, 25)));
    }

    public function storeAdjustment(Request $request)
    {
        return response()->json($this->adjustments->create($request), 201);
    }

    public function approveAdjustment(Request $request, int $id)
    {
        return response()->json($this->adjustments->approve($request, $id));
    }

    public function postAdjustment(Request $request, int $id)
    {
        return response()->json($this->adjustments->post($request, $id));
    }

    public function reverseAdjustment(Request $request, int $id)
    {
        return response()->json($this->adjustments->reverse($request, $id));
    }

    public function report(Request $request, string $type)
    {
        $perPage = $this->perPage($request, 25);
        $schoolId = $this->currentSchool->id();
        $invoiceTotals = DB::table('invoices')->where('school_id', $schoolId)
            ->selectRaw('student_user_id, SUM(amount) gross_fees')->groupBy('student_user_id');
        $paymentTotals = DB::table('payments as p')->join('invoices as i', 'i.id', '=', 'p.invoice_id')
            ->where('p.school_id', $schoolId)->where('i.school_id', $schoolId)
            ->where('p.status', 'posted')->selectRaw('i.student_user_id, SUM(p.amount) paid')->groupBy('i.student_user_id');
        $adjustmentTotals = DB::table('student_financial_adjustments')->where('school_id', $schoolId)->where('status', 'posted')
            ->selectRaw("student_user_id, SUM(CASE WHEN direction = 'debit' THEN amount ELSE 0 END) debits, SUM(CASE WHEN direction = 'credit' THEN amount ELSE 0 END) credits")
            ->groupBy('student_user_id');
        $query = match ($type) {
            'student-balances' => DB::table('users as u')
                ->leftJoin('student_profiles as sp', 'sp.user_id', '=', 'u.id')
                ->leftJoin('class_rooms as cr', 'cr.id', '=', 'sp.class_room_id')
                ->leftJoinSub($invoiceTotals, 'it', 'it.student_user_id', '=', 'u.id')
                ->leftJoinSub($paymentTotals, 'pt', 'pt.student_user_id', '=', 'u.id')
                ->leftJoinSub($adjustmentTotals, 'at', 'at.student_user_id', '=', 'u.id')
                ->where('sp.school_id', $schoolId)
                ->where('cr.school_id', $schoolId)
                ->where('u.role', 'student')
                ->selectRaw('u.id, u.name, sp.admission_no, cr.grade, cr.section,
                    COALESCE(it.gross_fees, 0) gross_fees, COALESCE(at.credits, 0) discounts,
                    COALESCE(at.debits, 0) adjustments, COALESCE(pt.paid, 0) paid,
                    CASE WHEN COALESCE(it.gross_fees, 0) + COALESCE(at.debits, 0) - COALESCE(at.credits, 0) - COALESCE(pt.paid, 0) > 0
                    THEN COALESCE(it.gross_fees, 0) + COALESCE(at.debits, 0) - COALESCE(at.credits, 0) - COALESCE(pt.paid, 0) ELSE 0 END balance')
                ->orderByDesc('balance'),
            'due-installments' => Installment::query()->with(['plan.student:id,name'])
                ->whereIn('status', ['pending', 'partial', 'overdue'])->orderBy('due_date'),
            'receipts' => PaymentReceipt::query()->with('student:id,name')->latest('receipt_date'),
            'discounts' => StudentFinancialAdjustment::query()->with('student:id,name')
                ->where('type', 'discount')->latest(),
            'general-journal' => JournalBatch::query()->with('lines')->latest('entry_date'),
            'reversed' => PaymentReceipt::query()->with('student:id,name')->where('status', 'reversed')->latest('reversed_at'),
            'reconciliation' => DB::table('payment_receipts as r')
                ->leftJoin('journal_batches as j', function ($join) use ($schoolId) {
                    $join->on('j.source_id', '=', 'r.id')->where('j.source', '=', 'student_receipt')
                        ->where('j.school_id', '=', $schoolId);
                })
                ->join('users as u', 'u.id', '=', 'r.student_user_id')
                ->where('r.school_id', $schoolId)
                ->selectRaw("r.id, r.receipt_no, u.name student_name, r.amount, r.status receipt_status, j.reference_no journal_reference, j.status journal_status, CASE WHEN r.status = 'posted' AND j.id IS NULL THEN 'mismatch' ELSE 'matched' END reconciliation_status")
                ->orderByDesc('r.id'),
            default => null,
        };
        abort_if(! $query, 404, 'Unknown financial report.');
        if ($request->filled('date_from')) {
            $column = $type === 'receipts' ? 'receipt_date' : ($type === 'due-installments' ? 'due_date' : ($type === 'student-balances' ? 'u.created_at' : ($type === 'reconciliation' ? 'r.created_at' : 'created_at')));
            $query->whereDate($column, '>=', $request->query('date_from'));
        }
        if ($request->filled('date_to')) {
            $column = $type === 'receipts' ? 'receipt_date' : ($type === 'due-installments' ? 'due_date' : ($type === 'student-balances' ? 'u.created_at' : ($type === 'reconciliation' ? 'r.created_at' : 'created_at')));
            $query->whereDate($column, '<=', $request->query('date_to'));
        }

        return response()->json($query->paginate($perPage));
    }
}
