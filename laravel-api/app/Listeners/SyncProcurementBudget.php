<?php

namespace App\Listeners;

use App\Events\GoodsReceived;
use App\Models\BudgetPlan;

/**
 * Reflect received-goods spend in the budget module. Increments the actuals
 * of the current fiscal year's procurement/operations plan if one exists;
 * silently a no-op otherwise (budget plans are optional).
 */
class SyncProcurementBudget
{
    public function handle(GoodsReceived $event): void
    {
        $plan = BudgetPlan::where('fiscal_year', now()->year)
            ->where(function ($q) {
                $q->whereRaw("LOWER(category) LIKE '%procurement%'")
                    ->orWhereRaw("LOWER(category) LIKE '%operations%'");
            })
            ->orderBy('id')
            ->first();

        $plan?->increment('actual_amount', $event->receiptTotal);
    }
}
