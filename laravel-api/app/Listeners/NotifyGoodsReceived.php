<?php

namespace App\Listeners;

use App\Events\GoodsReceived;
use App\Models\User;
use App\Services\CurrentSchool;
use App\Services\NotificationService;

class NotifyGoodsReceived
{
    public function handle(GoodsReceived $event): void
    {
        $receipt = $event->receipt;
        $po = $receipt->purchaseOrder;

        $recipientIds = User::whereIn('role', ['procurement', 'admin'])
            ->where('is_active', true)
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', app(CurrentSchool::class)->id()))
            ->pluck('id')
            ->all();

        // Notification failure must never roll back a posted receipt.
        try {
            NotificationService::sendToMany($recipientIds, 'goods_received', [
                'grn_no' => $receipt->grn_no,
                'grn_id' => $receipt->id,
                'po_no' => $po->po_no,
                'supplier_name' => $po->supplier->name,
                'lines' => $receipt->items()->count(),
                'total' => number_format($event->receiptTotal, 2),
            ]);
        } catch (\Throwable $e) {
            \Log::warning('goods_received notification failed: '.$e->getMessage());
        }
    }
}
