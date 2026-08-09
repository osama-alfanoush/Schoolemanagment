<?php

namespace App\Services;

use App\Models\FinancialClosing;
use App\Models\JournalBatch;
use App\Models\JournalEntry;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

/**
 * Posts balanced debit/credit journal pairs for system-generated events
 * (goods receipts, supplier payments, payroll runs). Manual entries keep
 * going through JournalService, which also enforces closed-period rules.
 */
class LedgerService
{
    public function __construct(private readonly CurrentSchool $currentSchool) {}

    public const ACCOUNTS = [
        'cash' => ['code' => '1000', 'name' => 'Cash & Bank'],
        'accounts_receivable' => ['code' => '1100', 'name' => 'Student Accounts Receivable'],
        'inventory' => ['code' => '1200', 'name' => 'Inventory'],
        'accounts_payable' => ['code' => '2100', 'name' => 'Accounts Payable'],
        'discounts' => ['code' => '4200', 'name' => 'Student Discounts'],
        'salaries_expense' => ['code' => '5100', 'name' => 'Salaries Expense'],
    ];

    /** @return array{0: JournalEntry, 1: JournalEntry} [debit, credit] */
    public function postPair(
        string $description,
        float $amount,
        string $debitAccount,
        string $creditAccount,
        string $source,
        ?int $sourceId,
        int $createdBy,
        ?string $entryDate = null,
    ): array {
        return DB::transaction(function () use ($description, $amount, $debitAccount, $creditAccount, $source, $sourceId, $createdBy, $entryDate) {
            $schoolId = $this->currentSchool->id();
            $date = $entryDate ?? now()->toDateString();
            if ($amount <= 0 || ! isset(self::ACCOUNTS[$debitAccount], self::ACCOUNTS[$creditAccount])) {
                throw ValidationException::withMessages(['journal' => 'A positive amount and valid ledger accounts are required.']);
            }
            $this->assertPeriodOpen($date, $schoolId);
            $idempotencyKey = "school:{$schoolId}:{$source}:{$sourceId}";
            $batch = JournalBatch::firstOrCreate(['idempotency_key' => $idempotencyKey], [
                'school_id' => $schoolId,
                'reference_no' => 'JB-'.now()->format('Ymd').'-'.Str::upper(Str::random(8)),
                'entry_date' => $date,
                'description' => $description,
                'source' => $source,
                'source_id' => $sourceId,
                'status' => 'posted',
                'created_by' => $createdBy,
                'approved_by' => $createdBy,
                'posted_by' => $createdBy,
                'approved_at' => now(),
                'posted_at' => now(),
            ]);
            if (! $batch->wasRecentlyCreated) {
                return $batch->load('lines')->lines->values()->all();
            }

            $base = [
                'school_id' => $schoolId,
                'journal_batch_id' => $batch->id,
                'entry_date' => $date,
                'description' => $description,
                'amount' => round($amount, 2),
                'source' => $source,
                'source_id' => $sourceId,
                'created_by' => $createdBy,
            ];

            $debit = JournalEntry::create($base + [
                'reference_no' => $batch->reference_no.'-01',
                'type' => 'debit',
                'account_code' => self::ACCOUNTS[$debitAccount]['code'],
                'account_name' => self::ACCOUNTS[$debitAccount]['name'],
            ]);
            $credit = JournalEntry::create($base + [
                'reference_no' => $batch->reference_no.'-02',
                'type' => 'credit',
                'account_code' => self::ACCOUNTS[$creditAccount]['code'],
                'account_name' => self::ACCOUNTS[$creditAccount]['name'],
            ]);

            return [$debit, $credit];
        });
    }

    /**
     * Post a configured, balanced batch using integer minor units. Repeating the
     * same source/source id returns the original batch instead of posting twice.
     *
     * @param  array<int,array{type:string,amount_cents:int,account_code:string,account_name:string,description?:string}>  $lines
     */
    public function postBalanced(
        string $description,
        array $lines,
        string $source,
        int $sourceId,
        int $createdBy,
        ?string $entryDate = null,
        ?int $schoolId = null,
    ): JournalBatch {
        return DB::transaction(function () use ($description, $lines, $source, $sourceId, $createdBy, $entryDate, $schoolId) {
            $schoolId ??= $this->currentSchool->id();
            $this->assertPeriodOpen($entryDate ?? now()->toDateString(), $schoolId);
            $idempotencyKey = ($schoolId ? "school:{$schoolId}:" : '')."{$source}:{$sourceId}";
            $existing = JournalBatch::where('idempotency_key', $idempotencyKey)->lockForUpdate()->first();
            if ($existing) {
                return $existing->load('lines');
            }

            $debits = collect($lines)->where('type', 'debit')->sum('amount_cents');
            $credits = collect($lines)->where('type', 'credit')->sum('amount_cents');
            if ($debits <= 0 || $debits !== $credits) {
                throw ValidationException::withMessages(['journal' => 'The payroll journal is not balanced.']);
            }

            $batch = JournalBatch::firstOrCreate(['idempotency_key' => $idempotencyKey], [
                'school_id' => $schoolId,
                'reference_no' => 'JB-'.now()->format('Ymd').'-'.Str::upper(Str::random(8)),
                'entry_date' => $entryDate ?? now()->toDateString(),
                'description' => $description,
                'source' => $source,
                'source_id' => $sourceId,
                'status' => 'posted',
                'created_by' => $createdBy, 'approved_by' => $createdBy, 'posted_by' => $createdBy,
                'approved_at' => now(), 'posted_at' => now(),
            ]);
            if (! $batch->wasRecentlyCreated) {
                return $batch->load('lines');
            }

            foreach (array_values(array_filter($lines, fn ($line) => $line['amount_cents'] > 0)) as $index => $line) {
                JournalEntry::create([
                    'school_id' => $schoolId,
                    'journal_batch_id' => $batch->id,
                    'entry_date' => $batch->entry_date,
                    'reference_no' => $batch->reference_no.'-'.str_pad((string) ($index + 1), 2, '0', STR_PAD_LEFT),
                    'description' => $description,
                    'line_description' => $line['description'] ?? null,
                    'type' => $line['type'],
                    'account_code' => $line['account_code'],
                    'account_name' => $line['account_name'],
                    'amount' => $line['amount_cents'] / 100,
                    'source' => $source, 'source_id' => $sourceId, 'created_by' => $createdBy,
                ]);
            }

            return $batch->load('lines');
        });
    }

    public function reverseBatch(JournalBatch $original, int $createdBy, string $reason): JournalBatch
    {
        return DB::transaction(function () use ($original, $createdBy, $reason) {
            $original = JournalBatch::with('lines')->lockForUpdate()->findOrFail($original->id);
            $this->assertPeriodOpen(now()->toDateString(), (int) $original->school_id);
            $existing = JournalBatch::where('reversal_of_id', $original->id)->first();
            if ($existing) {
                return $existing->load('lines');
            }

            $reversal = JournalBatch::create([
                'school_id' => $original->school_id,
                'reference_no' => 'JB-'.now()->format('Ymd').'-'.Str::upper(Str::random(8)),
                'entry_date' => now()->toDateString(), 'description' => 'Reversal: '.$original->description,
                'source' => 'payroll_reversal', 'source_id' => $original->id,
                'idempotency_key' => 'school:'.$original->school_id.':payroll_reversal:'.$original->id,
                'status' => 'posted',
                'created_by' => $createdBy, 'approved_by' => $createdBy, 'posted_by' => $createdBy,
                'approved_at' => now(), 'posted_at' => now(), 'reversal_of_id' => $original->id,
            ]);
            foreach ($original->lines as $index => $line) {
                JournalEntry::create([
                    'school_id' => $original->school_id,
                    'journal_batch_id' => $reversal->id, 'entry_date' => $reversal->entry_date,
                    'reference_no' => $reversal->reference_no.'-'.str_pad((string) ($index + 1), 2, '0', STR_PAD_LEFT),
                    'description' => $reversal->description, 'line_description' => $line->line_description,
                    'type' => $line->type === 'debit' ? 'credit' : 'debit', 'account_code' => $line->account_code,
                    'account_name' => $line->account_name, 'amount' => $line->amount,
                    'source' => 'payroll_reversal', 'source_id' => $original->id, 'created_by' => $createdBy,
                ]);
            }
            $original->update(['status' => 'reversed', 'reversed_by' => $createdBy, 'reversed_at' => now(), 'reversal_reason' => $reason]);

            return $reversal->load('lines');
        });
    }

    /** Same JE-YYYY-NNNN convention as JournalService::createEntry. */
    public function nextRef(): string
    {
        $year = now()->year;
        $count = JournalEntry::withTrashed()->whereYear('entry_date', $year)->count() + 1;

        return 'JE-'.$year.'-'.str_pad((string) $count, 4, '0', STR_PAD_LEFT);
    }

    private function assertPeriodOpen(string $date, int $schoolId): void
    {
        $period = CarbonImmutable::parse($date);
        abort_if(
            FinancialClosing::query()->where('school_id', $schoolId)
                ->where('year', $period->year)->where('month', $period->month)
                ->whereIn('status', ['closed', 'audited'])->exists(),
            422,
            'The financial period is closed.',
        );
    }
}
