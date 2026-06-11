<?php

namespace App\Services;

use App\Models\InventoryCount;
use App\Models\PurchaseRequest;
use App\Models\StockMovement;
use App\Models\User;
use App\Models\WarehouseItem;
use Illuminate\Support\Facades\DB;

class WarehouseService
{
    public function __construct(
        private NotificationService $notifier,
        private AuditLogger $auditor
    ) {}

    public function applyMovement(WarehouseItem $item, array $data, User $actor): StockMovement
    {
        return DB::transaction(function () use ($item, $data, $actor) {
            $qtyBefore = $item->current_qty;

            $delta = in_array($data['movement_type'], ['in', 'return'])
                ? +$data['quantity']
                : -$data['quantity'];

            $qtyAfter = $qtyBefore + $delta;

            if ($qtyAfter < 0) {
                throw new \Exception('Insufficient stock. Available: ' . $qtyBefore);
            }

            $movement = StockMovement::create([
                ...$data,
                'item_id'       => $item->id,
                'qty_before'    => $qtyBefore,
                'qty_after'     => $qtyAfter,
                'performed_by'  => $actor->id,
                'movement_date' => now(),
            ]);

            $item->update(['current_qty' => $qtyAfter]);

            if ($qtyAfter <= $item->min_stock_qty && $qtyBefore > $item->min_stock_qty) {
                $this->fireLowStockAlert($item);
            }

            AuditLogger::log(request(), 'warehouse_movement', 'WarehouseItem', $item->id, [], $actor->id);

            return $movement;
        });
    }

    private function fireLowStockAlert(WarehouseItem $item): void
    {
        $recipientIds = User::whereIn('role', ['warehouse', 'admin'])
            ->where('is_active', true)
            ->pluck('id')
            ->toArray();

        NotificationService::sendToMany($recipientIds, 'low_stock_alert', [
            'item_name'   => $item->name,
            'sku'         => $item->sku,
            'current_qty' => $item->current_qty,
            'min_qty'     => $item->min_stock_qty,
            'unit'        => $item->unit,
        ]);
    }

    public function generateRef(string $prefix, string $modelClass): string
    {
        $year  = date('Y');
        $count = $modelClass::whereYear('created_at', $year)->count() + 1;
        return $prefix . '-' . $year . '-' . str_pad($count, 4, '0', STR_PAD_LEFT);
    }
}
