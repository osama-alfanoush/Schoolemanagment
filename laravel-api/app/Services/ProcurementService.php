<?php

namespace App\Services;

use App\Events\GoodsReceived;
use App\Models\GoodsReceipt;
use App\Models\GoodsReceiptItem;
use App\Models\PurchaseOrder;
use App\Models\Supplier;
use App\Models\SupplierAccount;
use App\Models\SupplierTransaction;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class ProcurementService
{
    public function __construct(
        private WarehouseService $warehouse,
    ) {}

    /**
     * Supplier + its account in one step (mirrors user+profile creation).
     */
    public function createSupplier(array $data, array $accountData = []): Supplier
    {
        return DB::transaction(function () use ($data, $accountData) {
            $supplier = Supplier::create([
                ...$data,
                'code' => $this->warehouse->generateRef('SUP', Supplier::class),
            ]);
            $supplier->account()->create($accountData);

            return $supplier->load('account');
        });
    }

    /**
     * Post a goods receipt against an approved PO: moves stock in through
     * WarehouseService (same guarded path as manual movements), updates item
     * costing/location, accrues the supplier balance, and fires GoodsReceived
     * for journal/budget/notification side effects — all in one transaction.
     *
     * $lines: [{purchase_order_item_id, quantity_received, unit_cost?, warehouse_location?}]
     */
    public function postGoodsReceipt(PurchaseOrder $po, array $lines, User $actor, ?string $notes = null): GoodsReceipt
    {
        $receipt = DB::transaction(function () use ($po, $lines, $actor, $notes) {
            $po = PurchaseOrder::query()->lockForUpdate()->findOrFail($po->id);
            if (! in_array($po->status, ['approved', 'partially_received'], true)) {
                throw new \Exception("Purchase order {$po->po_no} is {$po->status}; only approved orders can be received.");
            }
            $po->load(['supplier.account']);

            $receipt = GoodsReceipt::create([
                'grn_no' => $this->warehouse->generateRef('GRN', GoodsReceipt::class),
                'purchase_order_id' => $po->id,
                'status' => 'posted',
                'notes' => $notes,
                'received_by' => $actor->id,
                'received_at' => now(),
            ]);

            $receiptTotal = 0.0;
            $poItems = $po->items()->with('warehouseItem')->lockForUpdate()->get()->keyBy('id');

            foreach ($lines as $line) {
                $poItem = $poItems->get($line['purchase_order_item_id']);
                if (! $poItem) {
                    throw new \Exception('Line does not belong to this purchase order.');
                }

                $qty = (float) $line['quantity_received'];
                $remaining = (float) $poItem->quantity_ordered - (float) $poItem->quantity_received;
                if ($qty <= 0 || $qty > $remaining) {
                    throw new \Exception(
                        "Cannot receive {$qty} of {$poItem->warehouseItem->name}: {$remaining} remaining on order."
                    );
                }

                $unitCost = (float) ($line['unit_cost'] ?? $poItem->unit_cost);
                $item = $poItem->warehouseItem;

                $movement = $this->warehouse->applyMovement($item, [
                    'movement_type' => 'in',
                    'quantity' => $qty,
                    'unit_cost' => $unitCost,
                    'reference_no' => $receipt->grn_no,
                    'supplier' => $po->supplier->name,
                    'purchase_order_id' => $po->id,
                    'reason' => "Goods receipt for PO {$po->po_no}",
                ], $actor);

                // Weighted-average cost over the pre-receipt quantity.
                $qtyBefore = (float) $movement->qty_before;
                $oldCost = (float) ($item->unit_cost ?? $unitCost);
                $newAvg = $qtyBefore + $qty > 0
                    ? (($qtyBefore * $oldCost) + ($qty * $unitCost)) / ($qtyBefore + $qty)
                    : $unitCost;

                $item->update([
                    'unit_cost' => round($newAvg, 2),
                    'last_unit_cost' => $unitCost,
                    'location' => $line['warehouse_location']
                        ?? $poItem->warehouse_location
                        ?? $item->location,
                ]);

                $poItem->increment('quantity_received', $qty);

                GoodsReceiptItem::create([
                    'goods_receipt_id' => $receipt->id,
                    'purchase_order_item_id' => $poItem->id,
                    'quantity_received' => $qty,
                    'unit_cost' => $unitCost,
                    'stock_movement_id' => $movement->id,
                ]);

                $receiptTotal += $qty * $unitCost;
            }

            $po->load('items');
            $po->update(['status' => $po->isFullyReceived() ? 'received' : 'partially_received']);

            // Accrue what we now owe the supplier for the delivered goods.
            $this->postSupplierTransaction(
                $po->supplier->account,
                type: 'invoice',
                amount: $receiptTotal,
                referenceNo: $receipt->grn_no,
                description: "Goods received against PO {$po->po_no}",
                actor: $actor,
                sourceType: GoodsReceipt::class,
                sourceId: $receipt->id,
            );

            event(new GoodsReceived($receipt, $receiptTotal));

            return $receipt;
        });

        return $receipt->load(['items.stockMovement', 'purchaseOrder.supplier']);
    }

    /**
     * Append a supplier ledger row and move the account balance.
     * Positive amounts increase what we owe (invoice), negative decrease (payment).
     */
    public function postSupplierTransaction(
        SupplierAccount $account,
        string $type,
        float $amount,
        ?string $referenceNo,
        ?string $description,
        User $actor,
        ?string $sourceType = null,
        ?int $sourceId = null,
    ): SupplierTransaction {
        return DB::transaction(function () use ($account, $type, $amount, $referenceNo, $description, $actor, $sourceType, $sourceId) {
            $locked = SupplierAccount::query()->lockForUpdate()->findOrFail($account->id);
            $signed = in_array($type, ['payment', 'credit_note'], true) ? -abs($amount) : abs($amount);
            $newBalance = (float) $locked->balance + $signed;

            $transaction = SupplierTransaction::create([
                'supplier_account_id' => $locked->id,
                'type' => $type,
                'amount' => $signed,
                'balance_after' => $newBalance,
                'reference_no' => $referenceNo,
                'source_type' => $sourceType,
                'source_id' => $sourceId,
                'description' => $description,
                'performed_by' => $actor->id,
                'transaction_date' => now(),
            ]);

            $locked->update(['balance' => $newBalance]);

            return $transaction;
        });
    }
}
