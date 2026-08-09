<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\StudentFinancialAdjustment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;

class StudentFinanceService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function search(Request $request): LengthAwarePaginator
    {
        $query = $this->students()
            ->with(['studentProfile.classRoom.academicYear', 'parents:id,name,phone']);
        if ($request->filled('q')) {
            $term = trim((string) $request->query('q'));
            $query->where(function ($q) use ($term) {
                $q->where('name', 'like', "%{$term}%")
                    ->orWhere('phone', 'like', "%{$term}%")
                    ->orWhereHas('studentProfile', fn ($profile) => $profile->where('admission_no', 'like', "%{$term}%"))
                    ->orWhereHas('parents', fn ($parent) => $parent->where('name', 'like', "%{$term}%")
                        ->orWhere('phone', 'like', "%{$term}%"));
                if (ctype_digit($term)) {
                    $q->orWhere('id', (int) $term);
                }
            });
        }

        return $query->orderBy('name')->paginate(min((int) $request->query('per_page', 20), 100));
    }

    public function profile(int $studentId): array
    {
        $student = $this->students()
            ->with(['studentProfile.classRoom.academicYear', 'parents:id,name,phone,email'])
            ->findOrFail($studentId);
        $invoices = Invoice::where('student_user_id', $studentId)
            ->with(['feeStructure', 'payments' => fn ($q) => $q->where('status', 'posted')->latest('paid_at'),
                'adjustments' => fn ($q) => $q->whereIn('status', ['posted', 'reversed'])->latest()])
            ->orderByDesc('due_date')->get();
        $plans = PaymentPlan::where('student_user_id', $studentId)
            ->with(['installments', 'invoice:id,invoice_no'])->latest()->get();
        $adjustments = StudentFinancialAdjustment::where('student_user_id', $studentId)
            ->with('invoice:id,invoice_no')->latest()->get();

        $gross = $this->cents($invoices->sum('amount'));
        $discounts = $this->cents($adjustments->where('status', 'posted')->where('direction', 'credit')->sum('amount'));
        $debitAdjustments = $this->cents($adjustments->where('status', 'posted')->where('direction', 'debit')->sum('amount'));
        $paid = $this->cents(Payment::whereHas('invoice', fn ($q) => $q->where('student_user_id', $studentId))
            ->where('status', 'posted')->sum('amount'));
        $due = max(0, $gross + $debitAdjustments - $discounts);
        $overdue = 0;
        foreach ($invoices as $invoice) {
            if ($invoice->due_date->isPast()) {
                $overdue += max(0, $this->invoiceNetCents($invoice) - $this->cents($invoice->payments->sum('amount')));
            }
        }

        return [
            'student' => $student,
            'summary' => [
                'gross_fees' => $gross / 100,
                'discounts' => $discounts / 100,
                'adjustments' => $debitAdjustments / 100,
                'amount_due' => $due / 100,
                'paid' => $paid / 100,
                'remaining' => max(0, $due - $paid) / 100,
                'overdue' => $overdue / 100,
            ],
            'invoices' => $invoices,
            'payment_plans' => $plans,
            'payments' => Payment::whereHas('invoice', fn ($q) => $q->where('student_user_id', $studentId))
                ->where('status', 'posted')->with(['invoice:id,invoice_no', 'receipt:id,receipt_no,status'])
                ->latest('paid_at')->get(),
            'adjustments' => $adjustments,
            'timeline' => $this->timeline($studentId)->take(100)->values(),
        ];
    }

    public function statement(Request $request, int $studentId): array
    {
        $this->students()->findOrFail($studentId);
        $request->validate([
            'date_from' => 'nullable|date', 'date_to' => 'nullable|date|after_or_equal:date_from',
            'type' => 'nullable|in:invoice,payment,discount,adjustment,refund',
            'status' => 'nullable|string', 'per_page' => 'nullable|integer|between:1,100',
        ]);
        $all = $this->timeline($studentId)->sortBy(fn ($row) => $row['date'].'-'.str_pad((string) $row['sort_id'], 12, '0', STR_PAD_LEFT))->values();
        $from = $request->query('date_from');
        $to = $request->query('date_to');
        $opening = $all->filter(fn ($row) => $from && $row['date'] < $from)
            ->sum(fn ($row) => $this->cents($row['debit']) - $this->cents($row['credit']));
        $filtered = $all->filter(function ($row) use ($request, $from, $to) {
            return (! $from || $row['date'] >= $from)
                && (! $to || $row['date'] <= $to)
                && (! $request->filled('type') || $row['type'] === $request->query('type'))
                && (! $request->filled('status') || $row['status'] === $request->query('status'));
        })->values();

        $running = $opening;
        $rows = $filtered->map(function ($row) use (&$running) {
            $running += $this->cents($row['debit']) - $this->cents($row['credit']);
            $row['balance'] = $running / 100;

            return $row;
        });
        $page = max((int) $request->query('page', 1), 1);
        $perPage = min((int) $request->query('per_page', 25), 100);
        $pageRows = $rows->slice(($page - 1) * $perPage, $perPage)->values();

        return [
            'data' => $pageRows,
            'current_page' => $page,
            'per_page' => $perPage,
            'last_page' => max((int) ceil($rows->count() / $perPage), 1),
            'total' => $rows->count(),
            'opening_balance' => $opening / 100,
            'period_debit' => $this->cents($filtered->sum('debit')) / 100,
            'period_credit' => $this->cents($filtered->sum('credit')) / 100,
            'closing_balance' => $running / 100,
        ];
    }

    private function timeline(int $studentId): Collection
    {
        $rows = collect();
        Invoice::where('student_user_id', $studentId)->get()->each(function ($invoice) use ($rows) {
            $rows->push([
                'sort_id' => $invoice->id, 'date' => $invoice->created_at->toDateString(),
                'type' => 'invoice', 'status' => $invoice->status,
                'description' => $invoice->description, 'reference' => $invoice->invoice_no,
                'debit' => (float) $invoice->amount, 'credit' => 0.0,
                'source_type' => 'invoice', 'source_id' => $invoice->id,
            ]);
        });
        Payment::whereHas('invoice', fn ($q) => $q->where('student_user_id', $studentId))
            ->with(['invoice:id,invoice_no', 'receipt:id,receipt_no,status'])->get()->each(function ($payment) use ($rows) {
                $rows->push([
                    'sort_id' => 100000000 + $payment->id, 'date' => $payment->paid_at->toDateString(),
                    'type' => 'payment', 'status' => $payment->status,
                    'description' => $payment->note ?: 'Student payment',
                    'reference' => $payment->receipt?->receipt_no ?? $payment->reference ?? $payment->invoice?->invoice_no,
                    'debit' => 0.0, 'credit' => $payment->status === 'posted' ? (float) $payment->amount : 0.0,
                    'source_type' => $payment->receipt ? 'receipt' : 'payment',
                    'source_id' => $payment->receipt?->id ?? $payment->id,
                ]);
            });
        StudentFinancialAdjustment::where('student_user_id', $studentId)->get()->each(function ($adjustment) use ($rows) {
            $posted = $adjustment->status === 'posted';
            $rows->push([
                'sort_id' => 200000000 + $adjustment->id, 'date' => $adjustment->created_at->toDateString(),
                'type' => $adjustment->type, 'status' => $adjustment->status,
                'description' => $adjustment->reason, 'reference' => $adjustment->adjustment_no,
                'debit' => $posted && $adjustment->direction === 'debit' ? (float) $adjustment->amount : 0.0,
                'credit' => $posted && $adjustment->direction === 'credit' ? (float) $adjustment->amount : 0.0,
                'source_type' => 'adjustment', 'source_id' => $adjustment->id,
            ]);
        });

        return $rows->sortByDesc(fn ($row) => $row['date'].'-'.str_pad((string) $row['sort_id'], 12, '0', STR_PAD_LEFT))->values();
    }

    private function invoiceNetCents(Invoice $invoice): int
    {
        $debit = $invoice->adjustments->where('status', 'posted')->where('direction', 'debit')->sum('amount');
        $credit = $invoice->adjustments->where('status', 'posted')->where('direction', 'credit')->sum('amount');

        return max(0, $this->cents($invoice->amount) + $this->cents($debit) - $this->cents($credit));
    }

    private function cents(mixed $amount): int
    {
        return (int) round((float) $amount * 100);
    }

    private function students()
    {
        return User::query()->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $this->currentSchool->id()));
    }
}
