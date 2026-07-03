<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\InventoryCount;
use App\Models\PurchaseRequest;
use App\Models\StockMovement;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;
use App\Services\AuditLogger;
use App\Services\NotificationService;
use App\Services\WarehouseService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;

class WarehouseController extends Controller
{
    public function __construct(private WarehouseService $warehouse) {}

    // ── CATEGORIES ──────────────────────────────────────────

    public function indexCategories()
    {
        return response()->json([
            'data' => WarehouseCategory::withCount('items')->get(),
        ]);
    }

    public function storeCategory(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|unique:warehouse_categories',
            'description' => 'nullable|string',
        ]);
        $category = WarehouseCategory::create($data);
        AuditLogger::log($request, 'create_warehouse_category', 'warehouse_category', $category->id, $data);

        return response()->json(['data' => $category], 201);
    }

    // ── ITEMS ────────────────────────────────────────────────

    public function indexItems(Request $request)
    {
        $q = WarehouseItem::with('category');
        $perPage = min((int) $request->query('per_page', 20), 100);

        if ($categoryId = $request->query('category_id')) {
            $q->where('category_id', (int) $categoryId);
        }
        if (filter_var($request->query('low_stock_only'), FILTER_VALIDATE_BOOLEAN)) {
            $q->whereColumn('current_qty', '<=', 'min_stock_qty');
        }
        if ($search = $request->query('search')) {
            $safe = str_replace(['%', '_'], ['\\%', '\\_'], substr($search, 0, 100));
            $q->where(function ($query) use ($safe) {
                $query->where('name', 'like', "%{$safe}%")
                    ->orWhere('sku', 'like', "%{$safe}%");
            });
        }

        return response()->json(
            $q->orderBy('name')->paginate($perPage)
        );
    }

    public function storeItem(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'category_id' => 'required|exists:warehouse_categories,id',
            'unit' => 'required|string',
            'min_stock_qty' => 'required|numeric|min:0',
            'location' => 'nullable|string',
            'description' => 'nullable|string',
            'sku' => 'nullable|string|unique:warehouse_items',
        ]);

        if (empty($data['sku'])) {
            $category = WarehouseCategory::findOrFail($data['category_id']);
            $prefix = strtoupper(substr($category->name, 0, 3));
            $year = date('Y');
            $count = WarehouseItem::where('category_id', $data['category_id'])
                ->whereYear('created_at', $year)->count() + 1;
            $data['sku'] = $prefix.'-'.$year.'-'.str_pad($count, 4, '0', STR_PAD_LEFT);
        }

        $data['current_qty'] = 0;
        $data['is_active'] = true;

        $item = WarehouseItem::create($data);
        AuditLogger::log($request, 'create_warehouse_item', 'warehouse_item', $item->id, $data);

        return response()->json(['data' => $item], 201);
    }

    public function showItem($id)
    {
        $item = WarehouseItem::with([
            'category',
            'movements' => fn ($q) => $q->orderBy('movement_date', 'desc')->limit(10),
        ])->withCount(['purchaseRequests' => fn ($q) => $q->where('status', 'pending')])->find($id);

        if (! $item) {
            return response()->json(['message' => 'Not found'], 404);
        }

        return response()->json(['data' => $item]);
    }

    public function updateItem(Request $request, $id)
    {
        $item = WarehouseItem::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string',
            'category_id' => 'sometimes|exists:warehouse_categories,id',
            'unit' => 'sometimes|string',
            'min_stock_qty' => 'sometimes|numeric|min:0',
            'location' => 'nullable|string',
            'description' => 'nullable|string',
            'sku' => "sometimes|string|unique:warehouse_items,sku,{$id}",
            'is_active' => 'sometimes|boolean',
        ]);
        $item->update($data);
        AuditLogger::log($request, 'update_warehouse_item', 'warehouse_item', $item->id, $data);

        return response()->json(['data' => $item]);
    }

    // ── STOCK MOVEMENTS ──────────────────────────────────────

    public function indexMovements(Request $request)
    {
        $q = StockMovement::with(['item', 'performedBy:id,name']);
        $perPage = min((int) $request->query('per_page', 20), 100);

        if ($itemId = $request->query('item_id')) {
            $q->where('item_id', (int) $itemId);
        }
        if ($type = $request->query('movement_type')) {
            $q->where('movement_type', $type);
        }
        if ($from = $request->query('date_from')) {
            $q->where('movement_date', '>=', $from);
        }
        if ($to = $request->query('date_to')) {
            $q->where('movement_date', '<=', $to);
        }

        return response()->json(
            $q->orderByDesc('movement_date')->paginate($perPage)
        );
    }

    public function storeMovement(Request $request)
    {
        $data = $request->validate([
            'item_id' => 'required|exists:warehouse_items,id',
            'movement_type' => 'required|in:in,out,adjustment,return',
            'quantity' => 'required|numeric|min:0.01',
            'department' => 'nullable|string',
            'recipient_name' => 'nullable|string',
            'reason' => 'nullable|string',
            'reference_no' => 'nullable|string',
            'supplier' => 'nullable|string',
        ]);

        $item = WarehouseItem::findOrFail($request->item_id);

        try {
            $movement = $this->warehouse->applyMovement($item, $data, $request->user());
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        return response()->json(['data' => $movement->load('item', 'performedBy:id,name')], 201);
    }

    // ── PURCHASE REQUESTS ────────────────────────────────────

    public function indexPurchaseRequests(Request $request)
    {
        $q = PurchaseRequest::with(['item', 'requestedBy:id,name', 'reviewedBy:id,name']);
        $perPage = min((int) $request->query('per_page', 20), 100);

        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }

        return response()->json(
            $q->orderByDesc('created_at')->paginate($perPage)
        );
    }

    public function storePurchaseRequest(Request $request)
    {
        $data = $request->validate([
            'item_id' => 'required|exists:warehouse_items,id',
            'quantity_requested' => 'required|numeric|min:0.01',
            'unit' => 'required|string',
            'justification' => 'nullable|string',
            'estimated_cost' => 'nullable|numeric|min:0',
        ]);

        $item = WarehouseItem::findOrFail($data['item_id']);
        $data['request_no'] = $this->warehouse->generateRef('PR', PurchaseRequest::class);
        $data['requested_by'] = $request->user()->id;
        $data['status'] = 'pending';

        $pr = PurchaseRequest::create($data);

        $adminIds = User::where('role', 'admin')->pluck('id')->toArray();
        NotificationService::sendToMany($adminIds, 'new_purchase_request', [
            'item_name' => $item->name,
            'quantity' => $request->quantity_requested,
            'unit' => $request->unit,
            'requested_by_name' => $request->user()->name,
        ]);

        AuditLogger::log($request, 'create_purchase_request', 'purchase_request', $pr->id, $data);

        return response()->json(['data' => $pr->load('item', 'requestedBy:id,name')], 201);
    }

    public function reviewPurchaseRequest(Request $request, $id)
    {
        $pr = PurchaseRequest::findOrFail($id);
        $data = $request->validate([
            'status' => 'required|in:approved,rejected,purchased',
            'admin_notes' => 'nullable|string',
        ]);

        $pr->update([
            'status' => $data['status'],
            'admin_notes' => $data['admin_notes'] ?? null,
            'reviewed_by' => $request->user()->id,
            'reviewed_at' => now(),
        ]);

        NotificationService::sendToMany(
            [$pr->requested_by],
            'purchase_request_status',
            [
                'status' => $data['status'],
                'item_name' => $pr->item->name,
                'quantity' => $pr->quantity_requested,
                'unit' => $pr->unit,
                'admin_notes' => $data['admin_notes'] ?? 'N/A',
            ]
        );

        AuditLogger::log($request, 'review_purchase_request', 'purchase_request', $pr->id, $data);

        return response()->json(['data' => $pr->load('item', 'requestedBy:id,name', 'reviewedBy:id,name')]);
    }

    // ── INVENTORY COUNTS ─────────────────────────────────────

    public function indexCounts(Request $request)
    {
        $q = InventoryCount::with(['item', 'countedBy:id,name']);
        $perPage = min((int) $request->query('per_page', 20), 100);

        if ($type = $request->query('count_type')) {
            $q->where('count_type', $type);
        }
        if ($from = $request->query('date_from')) {
            $q->where('count_date', '>=', $from);
        }
        if ($to = $request->query('date_to')) {
            $q->where('count_date', '<=', $to);
        }

        return response()->json(
            $q->orderByDesc('count_date')->paginate($perPage)
        );
    }

    public function storeCounts(Request $request)
    {
        $data = $request->validate([
            'count_type' => 'required|in:monthly,annual,spot',
            'count_date' => 'required|date',
            'items' => 'required|array|min:1',
            'items.*.item_id' => 'required|exists:warehouse_items,id',
            'items.*.physical_qty' => 'required|numeric|min:0',
            'items.*.notes' => 'nullable|string',
        ]);

        $created = [];
        foreach ($data['items'] as $itemData) {
            $item = WarehouseItem::findOrFail($itemData['item_id']);
            $created[] = InventoryCount::create([
                'count_ref' => $this->warehouse->generateRef('IC', InventoryCount::class),
                'count_type' => $data['count_type'],
                'count_date' => $data['count_date'],
                'item_id' => $itemData['item_id'],
                'system_qty' => $item->current_qty,
                'physical_qty' => $itemData['physical_qty'],
                'notes' => $itemData['notes'] ?? null,
                'counted_by' => $request->user()->id,
            ]);
        }

        AuditLogger::log($request, 'create_inventory_counts', 'inventory_count', null, ['count' => count($created)]);

        return response()->json(['data' => $created], 201);
    }

    // ── DASHBOARD ────────────────────────────────────────────

    public function dashboard()
    {
        $lowStockItems = WarehouseItem::whereColumn('current_qty', '<=', 'min_stock_qty')
            ->where('is_active', true)
            ->get(['id', 'name', 'sku', 'current_qty', 'min_stock_qty', 'unit']);

        $movementsThisMonth = StockMovement::whereYear('movement_date', now()->year)
            ->whereMonth('movement_date', now()->month)
            ->select('movement_type')
            ->selectRaw('count(*) as count')
            ->groupBy('movement_type')
            ->pluck('count', 'movement_type')
            ->toArray();

        $topConsumed = StockMovement::where('movement_type', 'out')
            ->whereYear('movement_date', now()->year)
            ->whereMonth('movement_date', now()->month)
            ->select('item_id')
            ->selectRaw('sum(quantity) as total_out')
            ->groupBy('item_id')
            ->orderByDesc('total_out')
            ->limit(5)
            ->get()
            ->map(function ($row) {
                $item = WarehouseItem::find($row->item_id);

                return [
                    'item_name' => $item?->name,
                    'sku' => $item?->sku,
                    'total_out' => (float) $row->total_out,
                    'unit' => $item?->unit,
                ];
            });

        return response()->json([
            'total_items' => WarehouseItem::where('is_active', true)->count(),
            'low_stock_items' => $lowStockItems,
            'pending_purchase_requests' => PurchaseRequest::where('status', 'pending')->count(),
            'movements_this_month' => [
                'in' => (int) ($movementsThisMonth['in'] ?? 0),
                'out' => (int) ($movementsThisMonth['out'] ?? 0),
                'adjustment' => (int) ($movementsThisMonth['adjustment'] ?? 0),
                'return' => (int) ($movementsThisMonth['return'] ?? 0),
            ],
            'top_consumed_items' => $topConsumed,
        ]);
    }

    // ── REPORTS ──────────────────────────────────────────────

    public function consumptionReport(Request $request)
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
            'category_id' => 'nullable|exists:warehouse_categories,id',
        ]);

        $q = StockMovement::where('movement_type', 'out')
            ->whereYear('movement_date', $data['year'])
            ->whereMonth('movement_date', $data['month']);

        if (! empty($data['category_id'])) {
            $q->whereHas('item', fn ($iq) => $iq->where('category_id', $data['category_id']));
        }

        $rows = $q->select('item_id', 'department')
            ->selectRaw('sum(quantity) as total_quantity')
            ->groupBy('item_id', 'department')
            ->get()
            ->map(fn ($r) => [
                'item_name' => $r->item?->name,
                'sku' => $r->item?->sku,
                'department' => $r->department,
                'total_quantity' => (float) $r->total_quantity,
                'unit' => $r->item?->unit,
            ]);

        return response()->json(['data' => $rows]);
    }

    public function consumptionReportPdf(Request $request)
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
            'category_id' => 'nullable|exists:warehouse_categories,id',
        ]);

        $q = StockMovement::where('movement_type', 'out')
            ->whereYear('movement_date', $data['year'])
            ->whereMonth('movement_date', $data['month']);

        if (! empty($data['category_id'])) {
            $q->whereHas('item', fn ($iq) => $iq->where('category_id', $data['category_id']));
        }

        $rows = $q->select('item_id', 'department')
            ->selectRaw('sum(quantity) as total_quantity')
            ->groupBy('item_id', 'department')
            ->get();

        $pdf = Pdf::loadView('reports.warehouse-consumption', [
            'rows' => $rows, 'month' => $data['month'], 'year' => $data['year'],
        ]);

        return $pdf->download("consumption-{$data['year']}-{$data['month']}.pdf");
    }

    public function inventoryReport(Request $request)
    {
        $q = WarehouseItem::with('category')->where('is_active', true);

        if ($categoryId = $request->query('category_id')) {
            $q->where('category_id', $categoryId);
        }

        $items = $q->get()->map(fn ($item) => [
            'id' => $item->id,
            'name' => $item->name,
            'sku' => $item->sku,
            'category' => $item->category?->name,
            'unit' => $item->unit,
            'current_qty' => (float) $item->current_qty,
            'min_stock_qty' => (float) $item->min_stock_qty,
            'is_low_stock' => $item->is_low_stock,
        ]);

        return response()->json(['data' => $items]);
    }

    public function inventoryReportPdf(Request $request)
    {
        $q = WarehouseItem::with('category')->where('is_active', true);

        if ($categoryId = $request->query('category_id')) {
            $q->where('category_id', $categoryId);
        }

        $items = $q->get();
        $date = now()->format('Y-m-d');

        $pdf = Pdf::loadView('reports.warehouse-inventory', [
            'items' => $items, 'date' => $date,
        ]);

        return $pdf->download("inventory-{$date}.pdf");
    }
}
