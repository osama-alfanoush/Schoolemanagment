<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StudentFinancialAdjustment extends Model
{
    protected $fillable = [
        'adjustment_no', 'student_user_id', 'invoice_id', 'type', 'direction',
        'calculation_type', 'value', 'amount', 'reason', 'status', 'created_by',
        'approved_by', 'posted_by', 'reversed_by', 'approved_at', 'posted_at',
        'reversed_at', 'reversal_reason',
    ];

    protected $casts = [
        'value' => 'decimal:4',
        'amount' => 'decimal:2',
        'approved_at' => 'datetime',
        'posted_at' => 'datetime',
        'reversed_at' => 'datetime',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function invoice(): BelongsTo
    {
        return $this->belongsTo(Invoice::class);
    }
}
