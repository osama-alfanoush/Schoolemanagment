<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FinancialClosing extends Model
{
    protected $fillable = [
        'month', 'year', 'status', 'notes', 'closed_by', 'closed_at',
    ];

    protected $casts = [
        'closed_at' => 'datetime',
    ];

    public function closedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'closed_by');
    }
}
