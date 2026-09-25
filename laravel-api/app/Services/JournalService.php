<?php

namespace App\Services;

use App\Models\FinancialClosing;
use App\Models\JournalEntry;
use Carbon\Carbon;
use Illuminate\Http\Request;

class JournalService
{
    public function __construct(private SchoolContext $schools) {}

    public function listEntries(Request $request): array
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = JournalEntry::query()->where(fn ($q) => $q->where('school_id', $schoolId)
            ->orWhere(fn ($legacy) => $legacy->whereNull('school_id')->whereNotIn('source', ['payroll', 'payroll_accrual', 'payroll_reversal', 'employee_advance', 'employee_advance_settlement'])))
            ->with('creator:id,name');
        if ($from = $request->query('date_from')) {
            $q->where('entry_date', '>=', $from);
        }
        if ($to = $request->query('date_to')) {
            $q->where('entry_date', '<=', $to);
        }
        if ($type = $request->query('type')) {
            $q->where('type', $type);
        }
        if ($code = $request->query('account_code')) {
            $q->where('account_code', $code);
        }

        return ['data' => $q->latest()->paginate((int) $request->query('per_page', 20))];
    }

    public function createEntry(Request $request): array
    {
        $data = $request->validate([
            'entry_date' => 'required|date',
            'description' => 'required|string',
            'type' => 'required|in:debit,credit',
            'account_code' => 'required|string',
            'account_name' => 'required|string',
            'amount' => 'required|numeric|money|min:0.01',
            'source' => 'in:manual,invoice,payroll,expense',
        ]);

        $entryDate = Carbon::parse($data['entry_date']);
        $schoolId = $this->schools->forUser($request->user());
        $closing = FinancialClosing::where('school_id', $schoolId)->where('month', $entryDate->month)
            ->where('year', $entryDate->year)
            ->where('status', 'closed')
            ->first();
        if ($closing) {
            throw new \Exception('Period is closed');
        }

        $year = $entryDate->year;
        $count = JournalEntry::withTrashed()->whereYear('entry_date', $year)->count() + 1;
        $data['reference_no'] = 'JE-'.$year.'-'.str_pad($count, 4, '0', STR_PAD_LEFT);
        $data['source'] = $data['source'] ?? 'manual';
        $data['created_by'] = $request->user()->id;
        $data['school_id'] = $schoolId;

        $entry = JournalEntry::create($data);
        AuditLogger::log($request, 'create_journal_entry', 'journal_entry', $entry->id, $data);

        return ['data' => $entry->load('creator:id,name'), 'status' => 201];
    }

    public function getEntry(int $id): ?JournalEntry
    {
        return JournalEntry::with('creator:id,name')->find($id);
    }

    public function deleteEntry(Request $request, int $id): void
    {
        $entry = JournalEntry::findOrFail($id);
        $schoolId = $this->schools->authorize($request->user(), (int) $entry->school_id);
        if ($entry->journal_batch_id || $entry->source !== 'manual') {
            throw new \Exception('Posted or system-generated entries cannot be deleted; reverse the journal batch instead.');
        }
        $entryDate = Carbon::parse($entry->entry_date);
        $closing = FinancialClosing::where('school_id', $schoolId)->where('month', $entryDate->month)
            ->where('year', $entryDate->year)
            ->where('status', 'closed')
            ->first();
        if ($closing) {
            throw new \Exception('Cannot delete entry in a closed period');
        }
        $entry->delete();
        AuditLogger::log($request, 'delete_journal_entry', 'journal_entry', $entry->id);
    }

    public function listClosings(Request $request): array
    {
        $schoolId = $this->schools->forUser($request->user());

        return ['data' => FinancialClosing::where('school_id', $schoolId)->with('closedBy:id,name')
            ->orderByDesc('year')->orderByDesc('month')->get()];
    }

    public function closeMonth(Request $request): array
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
            'notes' => 'nullable|string',
        ]);
        $schoolId = $this->schools->forUser($request->user());

        $existing = FinancialClosing::where('school_id', $schoolId)->where('month', $data['month'])->where('year', $data['year'])->first();
        if ($existing) {
            throw new \Exception('Closing already exists for this period');
        }

        $closing = FinancialClosing::create([
            'school_id' => $schoolId,
            'month' => $data['month'],
            'year' => $data['year'],
            'status' => 'closed',
            'notes' => $data['notes'] ?? null,
            'closed_by' => $request->user()->id,
            'closed_at' => now(),
        ]);

        AuditLogger::log($request, 'close_month', 'financial_closing', $closing->id, $data);

        return ['data' => $closing->load('closedBy:id,name'), 'status' => 201];
    }
}
