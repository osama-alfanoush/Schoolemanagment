<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PayrollRun extends Model
{
    protected $fillable = [
        'run_no', 'year', 'month', 'status', 'total_gross',
        'total_deductions', 'total_net', 'processed_by', 'approved_by', 'approved_at',
        'scope_key', 'school_id', 'period_start', 'period_end', 'created_by', 'processed_at',
        'paid_by', 'paid_at', 'accrual_journal_batch_id', 'payment_journal_batch_id',
        'reversed_by', 'reversed_at', 'reversal_reason', 'policy_snapshot',
    ];

    protected $casts = [
        'total_gross' => 'decimal:2',
        'total_deductions' => 'decimal:2',
        'total_net' => 'decimal:2',
        'approved_at' => 'datetime',
        'period_start' => 'date', 'period_end' => 'date', 'processed_at' => 'datetime',
        'paid_at' => 'datetime', 'reversed_at' => 'datetime', 'policy_snapshot' => 'array',
    ];

    public function records(): HasMany
    {
        return $this->hasMany(PayrollRecord::class);
    }

    public function processedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'processed_by');
    }

    public function approvedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function paidBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'paid_by');
    }

    public function accrualJournal(): BelongsTo
    {
        return $this->belongsTo(JournalBatch::class, 'accrual_journal_batch_id');
    }

    public function paymentJournal(): BelongsTo
    {
        return $this->belongsTo(JournalBatch::class, 'payment_journal_batch_id');
    }
}
