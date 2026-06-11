<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BudgetPlan extends Model
{
    protected $fillable = [
        'fiscal_year', 'category', 'sub_category', 'planned_amount',
        'actual_amount', 'created_by',
    ];

    protected $casts = [
        'planned_amount' => 'decimal:2',
        'actual_amount' => 'decimal:2',
    ];

    protected $appends = ['variance', 'usage_percent'];

    public function getVarianceAttribute(): float
    {
        return (float) $this->planned_amount - (float) $this->actual_amount;
    }

    public function getUsagePercentAttribute(): float
    {
        $planned = (float) $this->planned_amount;
        if ($planned === 0.0) {
            return 0.0;
        }
        return round((float) $this->actual_amount / $planned * 100, 2);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
