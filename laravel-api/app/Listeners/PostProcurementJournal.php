<?php

namespace App\Listeners;

use App\Events\GoodsReceived;
use App\Services\LedgerService;

/**
 * Double-entry for received goods: debit Inventory (asset), credit
 * Accounts Payable (liability). Runs inside the receipt's DB transaction so
 * inventory and the ledger can never diverge.
 */
class PostProcurementJournal
{
    public function __construct(private LedgerService $ledger) {}

    public function handle(GoodsReceived $event): void
    {
        $receipt = $event->receipt;
        $po = $receipt->purchaseOrder;

        $this->ledger->postPair(
            description: "Goods receipt {$receipt->grn_no} (PO {$po->po_no}, {$po->supplier->name})",
            amount: $event->receiptTotal,
            debitAccount: 'inventory',
            creditAccount: 'accounts_payable',
            source: 'purchase',
            sourceId: $receipt->id,
            createdBy: $receipt->received_by,
            entryDate: $receipt->received_at->toDateString(),
        );
    }
}
