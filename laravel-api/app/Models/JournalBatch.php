<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class JournalBatch extends Model
{
    protected $fillable = [
        'school_id', 'reference_no', 'entry_date', 'description', 'source', 'source_id', 'idempotency_key',
        'academic_year_id', 'branch_reference', 'status', 'created_by',
        'approved_by', 'posted_by', 'reversed_by', 'reversal_of_id',
        'approved_at', 'posted_at', 'reversed_at', 'reversal_reason',
    ];

    protected $casts = [
        'entry_date' => 'date',
        'approved_at' => 'datetime',
        'posted_at' => 'datetime',
        'reversed_at' => 'datetime',
    ];

    public function lines(): HasMany
    {
        return $this->hasMany(JournalEntry::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function reversalOf(): BelongsTo
    {
        return $this->belongsTo(self::class, 'reversal_of_id');
    }
}
