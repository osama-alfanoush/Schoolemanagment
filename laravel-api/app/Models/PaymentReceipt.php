<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PaymentReceipt extends Model
{
    protected $fillable = [
        'receipt_no', 'student_user_id', 'amount', 'method', 'receipt_date',
        'reference', 'cash_account', 'note', 'status', 'idempotency_key',
        'idempotency_payload_hash', 'created_by', 'approved_by', 'posted_by',
        'reversed_by', 'approved_at', 'posted_at', 'reversed_at', 'reversal_reason',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'receipt_date' => 'date',
        'approved_at' => 'datetime',
        'posted_at' => 'datetime',
        'reversed_at' => 'datetime',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function allocations(): HasMany
    {
        return $this->hasMany(PaymentReceiptAllocation::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
