<?php

namespace App\Events;

use App\Models\GoodsReceipt;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

/**
 * Fired when a goods receipt is posted and inventory has been updated.
 * Listeners handle the accounting/budget/notification side effects, and are
 * the integration seam for any future outbound webhook.
 */
class GoodsReceived
{
    use Dispatchable, SerializesModels;

    public function __construct(
        public GoodsReceipt $receipt,
        public float $receiptTotal,
    ) {}
}
