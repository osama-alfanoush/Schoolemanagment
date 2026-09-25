<?php

namespace App\Services;

use App\Models\ChartOfAccount;
use App\Models\FinancialClosing;
use App\Models\JournalBatch;
use App\Models\JournalEntry;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class JournalBatchService
{
    public function create(Request $request): JournalBatch
    {
        $data = $request->validate([
            'entry_date' => 'required|date',
            'description' => 'required|string|max:255',
            'source' => 'nullable|string|max:50',
            'academic_year_id' => 'nullable|exists:academic_years,id',
            'branch_reference' => 'nullable|string|max:100',
            'lines' => 'required|array|min:2',
            'lines.*.account_id' => 'nullable|exists:chart_of_accounts,id',
            'lines.*.account_code' => 'nullable|string|max:50',
            'lines.*.account_name' => 'nullable|string|max:255',
            'lines.*.description' => 'nullable|string|max:255',
            'lines.*.debit' => 'nullable|numeric|money|min:0',
            'lines.*.credit' => 'nullable|numeric|money|min:0',
            'lines.*.cost_center' => 'nullable|string|max:100',
        ]);

        $this->assertPeriodOpen($data['entry_date']);
        $normalized = $this->normalizeLines($data['lines']);

        return DB::transaction(function () use ($data, $normalized, $request) {
            $batch = JournalBatch::create([
                'reference_no' => $this->nextBatchRef(),
                'entry_date' => $data['entry_date'],
                'description' => $data['description'],
                'source' => $data['source'] ?? 'manual',
                'academic_year_id' => $data['academic_year_id'] ?? null,
                'branch_reference' => $data['branch_reference'] ?? null,
                'status' => 'draft',
                'created_by' => $request->user()->id,
            ]);

            foreach ($normalized as $index => $line) {
                JournalEntry::create([
                    'journal_batch_id' => $batch->id,
                    'entry_date' => $batch->entry_date,
                    'reference_no' => $batch->reference_no.'-'.str_pad((string) ($index + 1), 2, '0', STR_PAD_LEFT),
                    'description' => $batch->description,
                    'line_description' => $line['description'],
                    'type' => $line['debit_cents'] > 0 ? 'debit' : 'credit',
                    'account_code' => $line['account_code'],
                    'account_name' => $line['account_name'],
                    'amount' => ($line['debit_cents'] ?: $line['credit_cents']) / 100,
                    'cost_center' => $line['cost_center'],
                    'source' => $batch->source,
                    'created_by' => $request->user()->id,
                ]);
            }

            AuditLogger::log($request, 'create_journal_batch', 'journal_batch', $batch->id, [
                'reference_no' => $batch->reference_no,
                'debit' => collect($normalized)->sum('debit_cents') / 100,
                'credit' => collect($normalized)->sum('credit_cents') / 100,
            ]);

            return $batch->load('lines', 'creator:id,name');
        });
    }

    public function approve(Request $request, int $id): JournalBatch
    {
        return DB::transaction(function () use ($request, $id) {
            $batch = JournalBatch::lockForUpdate()->findOrFail($id);
            abort_if($batch->status !== 'draft', 422, 'Only a draft journal entry can be approved.');
            $this->assertBalanced($batch);
            $batch->update(['status' => 'approved', 'approved_by' => $request->user()->id, 'approved_at' => now()]);
            AuditLogger::log($request, 'approve_journal_batch', 'journal_batch', $batch->id, ['old' => ['status' => 'draft'], 'new' => ['status' => 'approved']]);

            return $batch->fresh('lines');
        });
    }

    public function post(Request $request, int $id): JournalBatch
    {
        return DB::transaction(function () use ($request, $id) {
            $batch = JournalBatch::lockForUpdate()->findOrFail($id);
            abort_if($batch->status !== 'approved', 422, 'Only an approved journal entry can be posted.');
            $this->assertPeriodOpen($batch->entry_date->toDateString());
            $this->assertBalanced($batch);
            $batch->update(['status' => 'posted', 'posted_by' => $request->user()->id, 'posted_at' => now()]);
            AuditLogger::log($request, 'post_journal_batch', 'journal_batch', $batch->id, ['old' => ['status' => 'approved'], 'new' => ['status' => 'posted']]);

            return $batch->fresh('lines');
        });
    }

    public function reverse(Request $request, int $id): JournalBatch
    {
        $data = $request->validate(['reason' => 'required|string|max:1000', 'entry_date' => 'nullable|date']);

        return DB::transaction(function () use ($request, $id, $data) {
            $batch = JournalBatch::with('lines')->lockForUpdate()->findOrFail($id);
            abort_if($batch->status !== 'posted', 422, 'Only a posted journal entry can be reversed.');
            $date = $data['entry_date'] ?? now()->toDateString();
            $this->assertPeriodOpen($date);

            $reversal = JournalBatch::create([
                'reference_no' => $this->nextBatchRef(),
                'entry_date' => $date,
                'description' => 'Reversal: '.$batch->description,
                'source' => 'reversal',
                'source_id' => $batch->id,
                'status' => 'posted',
                'created_by' => $request->user()->id,
                'approved_by' => $request->user()->id,
                'posted_by' => $request->user()->id,
                'approved_at' => now(),
                'posted_at' => now(),
                'reversal_of_id' => $batch->id,
            ]);

            foreach ($batch->lines as $index => $line) {
                JournalEntry::create([
                    'journal_batch_id' => $reversal->id,
                    'entry_date' => $date,
                    'reference_no' => $reversal->reference_no.'-'.str_pad((string) ($index + 1), 2, '0', STR_PAD_LEFT),
                    'description' => $reversal->description,
                    'line_description' => $line->line_description,
                    'type' => $line->type === 'debit' ? 'credit' : 'debit',
                    'account_code' => $line->account_code,
                    'account_name' => $line->account_name,
                    'amount' => $line->amount,
                    'cost_center' => $line->cost_center,
                    'source' => 'reversal',
                    'source_id' => $batch->id,
                    'created_by' => $request->user()->id,
                ]);
            }

            $batch->update([
                'status' => 'reversed', 'reversed_by' => $request->user()->id,
                'reversed_at' => now(), 'reversal_reason' => $data['reason'],
            ]);
            AuditLogger::log($request, 'reverse_journal_batch', 'journal_batch', $batch->id, [
                'old' => ['status' => 'posted'], 'new' => ['status' => 'reversed'],
                'reason' => $data['reason'], 'reversal_id' => $reversal->id,
            ]);

            return $reversal->load('lines');
        });
    }

    private function normalizeLines(array $lines): array
    {
        $normalized = [];
        $debits = 0;
        $credits = 0;
        foreach ($lines as $index => $line) {
            $debit = (int) round(((float) ($line['debit'] ?? 0)) * 100);
            $credit = (int) round(((float) ($line['credit'] ?? 0)) * 100);
            if (($debit > 0 && $credit > 0) || ($debit === 0 && $credit === 0)) {
                throw ValidationException::withMessages(["lines.{$index}" => 'Each line must contain either a debit or a credit amount.']);
            }
            $account = ! empty($line['account_id']) ? ChartOfAccount::where('is_active', true)->find($line['account_id']) : null;
            if (! $account && (empty($line['account_code']) || empty($line['account_name']))) {
                throw ValidationException::withMessages(["lines.{$index}.account_id" => 'An active account is required.']);
            }
            $debits += $debit;
            $credits += $credit;
            $normalized[] = [
                'account_code' => $account?->account_code ?? $line['account_code'],
                'account_name' => $account?->account_name ?? $line['account_name'],
                'description' => $line['description'] ?? null,
                'cost_center' => $line['cost_center'] ?? null,
                'debit_cents' => $debit,
                'credit_cents' => $credit,
            ];
        }
        if ($debits !== $credits) {
            throw ValidationException::withMessages(['lines' => 'Total debits must equal total credits.']);
        }

        return $normalized;
    }

    private function assertBalanced(JournalBatch $batch): void
    {
        $debits = (int) round((float) $batch->lines()->where('type', 'debit')->sum('amount') * 100);
        $credits = (int) round((float) $batch->lines()->where('type', 'credit')->sum('amount') * 100);
        abort_if($debits === 0 || $debits !== $credits, 422, 'Journal entry is not balanced.');
    }

    private function assertPeriodOpen(string $date): void
    {
        $date = Carbon::parse($date);
        abort_if(FinancialClosing::where('month', $date->month)->where('year', $date->year)
            ->whereIn('status', ['closed', 'audited'])->exists(), 422, 'Financial period is closed.');
    }

    private function nextBatchRef(): string
    {
        return 'JB-'.now()->format('Ymd').'-'.Str::upper(Str::random(8));
    }
}
