<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\GoodsReceipt;
use App\Models\PurchaseOrder;
use App\Models\Supplier;
use App\Models\SupplierAccount;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\NotificationService;
use App\Services\ProcurementService;
use App\Services\WarehouseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProcurementController extends Controller
{
    public function __construct(
        private ProcurementService $procurement,
        private WarehouseService $warehouse,
    ) {}

    // ── Suppliers ────────────────────────────────────────────────────────

    public function indexSuppliers(Request $request)
    {
        $q = Supplier::query()->with('account');
        if ($search = $request->query('q')) {
            $q->where(function ($w) use ($search) {
                $w->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%")
                    ->orWhere('contact_person', 'like', "%{$search}%");
            });
        }
        if (! is_null($request->query('is_active'))) {
            $q->where('is_active', $request->boolean('is_active'));
        }

        return response()->json($q->orderBy('name')->paginate($this->perPage($request, 20)));
    }

    public function storeSupplier(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'contact_person' => 'nullable|string|max:255',
            'phone' => 'required|string|max:50',
            'secondary_phone' => 'nullable|string|max:50',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
            'tax_number' => 'nullable|string|max:100',
            'payment_terms' => 'nullable|in:cash,net_15,net_30,net_60',
            'credit_limit' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        $supplier = $this->procurement->createSupplier(
            collect($data)->except(['payment_terms', 'credit_limit', 'notes'])->all(),
            collect($data)->only(['payment_terms', 'credit_limit', 'notes'])->filter()->all(),
        );

        AuditLogger::log($request, 'create_supplier', 'supplier', $supplier->id, ['name' => $supplier->name]);

        return response()->json($supplier, 201);
    }

    public function showSupplier(int $id)
    {
        $supplier = Supplier::with([
            'account.transactions' => fn ($q) => $q->latest('transaction_date')->limit(20),
        ])->findOrFail($id);

        return response()->json($supplier);
    }

    public function updateSupplier(Request $request, int $id)
    {
        $supplier = Supplier::with('account')->findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string|max:255',
            'contact_person' => 'nullable|string|max:255',
            'phone' => 'sometimes|string|max:50',
            'secondary_phone' => 'nullable|string|max:50',
            'email' => 'nullable|email',
            'address' => 'nullable|string',
            'tax_number' => 'nullable|string|max:100',
            'is_active' => 'sometimes|boolean',
            'payment_terms' => 'sometimes|in:cash,net_15,net_30,net_60',
            'credit_limit' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        $supplier->update(collect($data)->except(['payment_terms', 'credit_limit', 'notes'])->all());
        $accountData = collect($data)->only(['payment_terms', 'credit_limit', 'notes'])->all();
        if ($accountData) {
            $supplier->account->update($accountData);
        }
        AuditLogger::log($request, 'update_supplier', 'supplier', $supplier->id, $data);

        return response()->json($supplier->fresh('account'));
    }

    public function destroySupplier(Request $request, int $id)
    {
        $supplier = Supplier::findOrFail($id);
        $openOrders = $supplier->purchaseOrders()
            ->whereNotIn('status', ['received', 'closed', 'cancelled'])->exists();
        $openInvoices = $supplier->invoices()
            ->whereNotIn('status', ['paid', 'cancelled'])->exists();
        if ($openOrders || $openInvoices) {
            return response()->json([
                'message' => 'Supplier has open purchase orders or unpaid invoices and cannot be deleted.',
            ], 409);
        }

        $supplier->delete();
        AuditLogger::log($request, 'delete_supplier', 'supplier', $id);

        return response()->json(['message' => 'Supplier deleted']);
    }

    public function supplierTransactions(Request $request, int $id)
    {
        $supplier = Supplier::with('account')->findOrFail($id);

        return response()->json(
            $supplier->account->transactions()
                ->with('performedBy:id,name')
                ->latest('transaction_date')
                ->paginate($this->perPage($request, 20))
        );
    }

    // ── Purchase orders ──────────────────────────────────────────────────

    public function indexPurchaseOrders(Request $request)
    {
        $q = PurchaseOrder::query()->with(['supplier:id,code,name', 'requestedBy:id,name']);
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }
        if ($supplierId = $request->query('supplier_id')) {
            $q->where('supplier_id', $supplierId);
        }
        if ($from = $request->query('date_from')) {
            $q->where('order_date', '>=', $from);
        }
        if ($to = $request->query('date_to')) {
            $q->where('order_date', '<=', $to);
        }

        return response()->json($q->latest()->paginate($this->perPage($request, 20)));
    }

    public function storePurchaseOrder(Request $request)
    {
        $data = $request->validate([
            'supplier_id' => 'required|exists:suppliers,id',
            'order_date' => 'required|date',
            'expected_date' => 'nullable|date|after_or_equal:order_date',
            'tax' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
            'purchase_request_id' => 'nullable|exists:purchase_requests,id',
            'items' => 'required|array|min:1',
            'items.*.warehouse_item_id' => 'required|exists:warehouse_items,id',
            'items.*.description' => 'nullable|string|max:255',
            'items.*.quantity_ordered' => 'required|numeric|gt:0',
            'items.*.unit' => 'required|string|max:50',
            'items.*.unit_cost' => 'required|numeric|min:0',
            'items.*.warehouse_location' => 'nullable|string|max:255',
        ]);

        $po = DB::transaction(function () use ($data, $request) {
            $subtotal = collect($data['items'])
                ->sum(fn ($i) => round($i['quantity_ordered'] * $i['unit_cost'], 2));
            $tax = round((float) ($data['tax'] ?? 0), 2);

            $po = PurchaseOrder::create([
                'po_no' => $this->warehouse->generateRef('PO', PurchaseOrder::class),
                'supplier_id' => $data['supplier_id'],
                'status' => 'draft',
                'order_date' => $data['order_date'],
                'expected_date' => $data['expected_date'] ?? null,
                'subtotal' => $subtotal,
                'tax' => $tax,
                'total' => $subtotal + $tax,
                'notes' => $data['notes'] ?? null,
                'purchase_request_id' => $data['purchase_request_id'] ?? null,
                'requested_by' => $request->user()->id,
            ]);

            foreach ($data['items'] as $item) {
                $po->items()->create([
                    ...$item,
                    'line_total' => round($item['quantity_ordered'] * $item['unit_cost'], 2),
                ]);
            }

            return $po;
        });

        AuditLogger::log($request, 'create_purchase_order', 'purchase_order', $po->id, [
            'po_no' => $po->po_no, 'total' => (float) $po->total,
        ]);

        return response()->json($po->load('items.warehouseItem:id,sku,name', 'supplier:id,code,name'), 201);
    }

    public function showPurchaseOrder(int $id)
    {
        return response()->json(
            PurchaseOrder::with([
                'supplier.account', 'items.warehouseItem:id,sku,name,current_qty',
                'receipts.items', 'requestedBy:id,name', 'approvedBy:id,name',
            ])->findOrFail($id)
        );
    }

    public function updatePurchaseOrder(Request $request, int $id)
    {
        $po = PurchaseOrder::with('items')->findOrFail($id);
        if (! in_array($po->status, ['draft', 'pending_approval'], true)) {
            return response()->json(['message' => "A {$po->status} purchase order cannot be edited."], 422);
        }

        $data = $request->validate([
            'expected_date' => 'nullable|date',
            'tax' => 'sometimes|numeric|min:0',
            'notes' => 'nullable|string',
            'items' => 'sometimes|array|min:1',
            'items.*.warehouse_item_id' => 'required_with:items|exists:warehouse_items,id',
            'items.*.description' => 'nullable|string|max:255',
            'items.*.quantity_ordered' => 'required_with:items|numeric|gt:0',
            'items.*.unit' => 'required_with:items|string|max:50',
            'items.*.unit_cost' => 'required_with:items|numeric|min:0',
            'items.*.warehouse_location' => 'nullable|string|max:255',
        ]);

        DB::transaction(function () use ($po, $data) {
            if (isset($data['items'])) {
                $po->items()->delete();
                foreach ($data['items'] as $item) {
                    $po->items()->create([
                        ...$item,
                        'line_total' => round($item['quantity_ordered'] * $item['unit_cost'], 2),
                    ]);
                }
                $data['subtotal'] = $po->items()->sum('line_total');
            }
            $po->update(collect($data)->except('items')->all());
            $po->refresh();
            $po->update(['total' => (float) $po->subtotal + (float) $po->tax]);
        });

        AuditLogger::log($request, 'update_purchase_order', 'purchase_order', $po->id, []);

        return response()->json($po->fresh(['items', 'supplier:id,code,name']));
    }

    public function submitPurchaseOrder(Request $request, int $id)
    {
        $po = DB::transaction(function () use ($id) {
            $po = PurchaseOrder::lockForUpdate()->findOrFail($id);
            abort_if($po->status !== 'draft', 422, 'Only draft purchase orders can be submitted.');
            $po->update(['status' => 'pending_approval']);

            return $po->load('supplier:id,name');
        });

        $approverIds = User::whereIn('role', ['procurement', 'admin'])
            ->where('is_active', true)
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $request->attributes->get('school_id')))
            ->pluck('id')->all();
        NotificationService::sendToMany($approverIds, 'po_pending_approval', [
            'po_no' => $po->po_no, 'po_id' => $po->id,
            'supplier_name' => $po->supplier->name,
            'total' => number_format((float) $po->total, 2),
            'requested_by_name' => $request->user()->name,
        ]);
        AuditLogger::log($request, 'submit_purchase_order', 'purchase_order', $po->id);

        return response()->json($po);
    }

    public function approvePurchaseOrder(Request $request, int $id)
    {
        $data = $request->validate([
            'action' => 'nullable|in:approve,reject',
            'reason' => 'required_if:action,reject|nullable|string',
        ]);
        $action = $data['action'] ?? 'approve';
        $po = DB::transaction(function () use ($action, $data, $id, $request) {
            $po = PurchaseOrder::lockForUpdate()->findOrFail($id);
            abort_if($po->status !== 'pending_approval', 422, 'Only pending purchase orders can be reviewed.');

            // Preserve the existing maker-checker rule under concurrent requests.
            abort_if(
                $action === 'approve' && $po->requested_by === $request->user()->id,
                422,
                'You cannot approve a purchase order you created. Another authorised user must review it.',
            );

            if ($action === 'reject') {
                $po->update([
                    'status' => 'draft',
                    'notes' => trim(($po->notes ? $po->notes."\n" : '').'Rejected: '.$data['reason']),
                ]);
            } else {
                $po->update([
                    'status' => 'approved',
                    'approved_by' => $request->user()->id,
                    'approved_at' => now(),
                ]);
            }

            return $po->load('supplier:id,name');
        });
        AuditLogger::log(
            $request,
            $action === 'reject' ? 'reject_purchase_order' : 'approve_purchase_order',
            'purchase_order',
            $po->id,
            $action === 'reject' ? ['reason' => $data['reason']] : [],
        );

        NotificationService::sendToMany([$po->requested_by], 'po_status_changed', [
            'po_no' => $po->po_no, 'po_id' => $po->id,
            'supplier_name' => $po->supplier->name, 'status' => $po->status,
        ]);

        return response()->json($po->fresh());
    }

    public function cancelPurchaseOrder(Request $request, int $id)
    {
        $po = DB::transaction(function () use ($id) {
            $po = PurchaseOrder::lockForUpdate()->findOrFail($id);
            abort_unless(
                in_array($po->status, ['draft', 'pending_approval', 'approved'], true),
                422,
                "A {$po->status} purchase order cannot be cancelled.",
            );
            $po->update(['status' => 'cancelled']);

            return $po;
        });
        AuditLogger::log($request, 'cancel_purchase_order', 'purchase_order', $po->id);

        return response()->json($po);
    }

    /**
     * Inventory sync entry point: post a goods receipt against an approved PO.
     */
    public function receivePurchaseOrder(Request $request, int $id)
    {
        $data = $request->validate([
            'notes' => 'nullable|string',
            'lines' => 'required|array|min:1',
            'lines.*.purchase_order_item_id' => 'required|integer|exists:purchase_order_items,id',
            'lines.*.quantity_received' => 'required|numeric|gt:0',
            'lines.*.unit_cost' => 'nullable|numeric|min:0',
            'lines.*.warehouse_location' => 'nullable|string|max:255',
        ]);

        $po = PurchaseOrder::with(['supplier.account', 'items'])->findOrFail($id);

        try {
            $receipt = $this->procurement->postGoodsReceipt(
                $po, $data['lines'], $request->user(), $data['notes'] ?? null
            );
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        AuditLogger::log($request, 'post_goods_receipt', 'goods_receipt', $receipt->id, [
            'grn_no' => $receipt->grn_no, 'po_no' => $po->po_no,
        ]);

        return response()->json($receipt, 201);
    }

    // ── Goods receipts ───────────────────────────────────────────────────

    public function indexGoodsReceipts(Request $request)
    {
        $q = GoodsReceipt::query()->with([
            'purchaseOrder:id,po_no,supplier_id',
            'purchaseOrder.supplier:id,code,name',
            'receivedBy:id,name',
        ]);
        if ($poId = $request->query('purchase_order_id')) {
            $q->where('purchase_order_id', $poId);
        }

        return response()->json($q->latest('received_at')->paginate($this->perPage($request, 20)));
    }

    public function showGoodsReceipt(int $id)
    {
        return response()->json(
            GoodsReceipt::with([
                'purchaseOrder.supplier:id,code,name',
                'items.purchaseOrderItem.warehouseItem:id,sku,name',
                'items.stockMovement',
                'receivedBy:id,name',
            ])->findOrFail($id)
        );
    }

    // ── Dashboard ────────────────────────────────────────────────────────

    public function dashboard()
    {
        $monthStart = now()->startOfMonth();

        return response()->json([
            'suppliers_active' => Supplier::where('is_active', true)->count(),
            'orders_by_status' => PurchaseOrder::query()
                ->select('status', DB::raw('COUNT(*) as count'))
                ->groupBy('status')->pluck('count', 'status'),
            'pending_approval' => PurchaseOrder::where('status', 'pending_approval')->count(),
            'awaiting_delivery' => PurchaseOrder::whereIn('status', ['approved', 'partially_received'])->count(),
            'month_received_total' => (float) GoodsReceipt::where('received_at', '>=', $monthStart)
                ->join('goods_receipt_items', 'goods_receipt_items.goods_receipt_id', '=', 'goods_receipts.id')
                ->selectRaw('COALESCE(SUM(goods_receipt_items.quantity_received * goods_receipt_items.unit_cost), 0) as total')
                ->value('total'),
            'total_payable' => (float) SupplierAccount::sum('balance'),
        ]);
    }
}
