<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InventoryCount extends Model
{
    protected $fillable = [
        'count_ref', 'count_type', 'count_date', 'item_id',
        'system_qty', 'physical_qty', 'notes', 'counted_by',
    ];

    protected $casts = [
        'count_date' => 'date',
        'system_qty' => 'decimal:2',
        'physical_qty' => 'decimal:2',
    ];

    public function item(): BelongsTo
    {
        return $this->belongsTo(WarehouseItem::class, 'item_id');
    }

    public function countedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'counted_by');
    }
}
