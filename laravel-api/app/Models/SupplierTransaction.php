<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SupplierTransaction extends Model
{
    protected $fillable = [
        'supplier_account_id', 'type', 'amount', 'balance_after',
        'reference_no', 'source_type', 'source_id', 'description',
        'performed_by', 'transaction_date',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'balance_after' => 'decimal:2',
        'transaction_date' => 'datetime',
    ];

    public function account(): BelongsTo
    {
        return $this->belongsTo(SupplierAccount::class, 'supplier_account_id');
    }

    public function performedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'performed_by');
    }
}
