<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class WarehouseItem extends Model
{
    use HasFactory;
    protected $fillable = [
        'sku', 'name', 'description', 'category_id', 'unit',
        'current_qty', 'min_stock_qty', 'location', 'is_active',
    ];

    protected $casts = [
        'current_qty' => 'decimal:2',
        'min_stock_qty' => 'decimal:2',
        'is_active' => 'boolean',
    ];

    protected $appends = ['is_low_stock'];

    public function getIsLowStockAttribute(): bool
    {
        return (bool) ($this->current_qty <= $this->min_stock_qty);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(WarehouseCategory::class, 'category_id');
    }

    public function movements(): HasMany
    {
        return $this->hasMany(StockMovement::class, 'item_id');
    }

    public function purchaseRequests(): HasMany
    {
        return $this->hasMany(PurchaseRequest::class, 'item_id');
    }
}
