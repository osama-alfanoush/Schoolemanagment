<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class EmployeeAdvance extends Model
{
    protected $fillable = [
        'school_id', 'advance_no', 'staff_profile_id', 'original_amount', 'remaining_balance', 'reason', 'requested_at',
        'approved_at', 'disbursed_at', 'disbursement_method', 'installment_count', 'installment_amount',
        'first_deduction_month', 'status', 'receivable_account_code', 'cash_account_code', 'requested_by',
        'approved_by', 'disbursed_by', 'journal_batch_id', 'attachments', 'notes', 'closure_reason',
    ];

    protected $casts = [
        'original_amount' => 'decimal:2', 'remaining_balance' => 'decimal:2', 'installment_amount' => 'decimal:2',
        'requested_at' => 'date', 'first_deduction_month' => 'date', 'approved_at' => 'datetime',
        'disbursed_at' => 'datetime', 'attachments' => 'array',
    ];

    public function staffProfile(): BelongsTo
    {
        return $this->belongsTo(StaffProfile::class);
    }

    public function installments(): HasMany
    {
        return $this->hasMany(EmployeeAdvanceInstallment::class);
    }
}
