<?php

namespace Tests\Feature;

use App\Models\JournalEntry;
use App\Models\NotificationTemplate;
use App\Models\PurchaseOrder;
use App\Models\Supplier;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProcurementTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        NotificationTemplate::seedDefaults();
        $this->seed(PermissionSeeder::class);
    }

    private function login(string $role): array
    {
        $user = User::factory()->create([
            'role' => $role,
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);
        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        return ['user' => $user, 'token' => $response->json('access_token')];
    }

    private function authed(array $auth)
    {
        // Sanctum's guard caches the resolved user across requests within a
        // test; forget it so each call authenticates as the given token's user.
        $this->app['auth']->forgetGuards();

        return $this->withHeader('Authorization', 'Bearer '.$auth['token']);
    }

    private function createSupplier(array $auth): int
    {
        return $this->authed($auth)->postJson('/api/procurement/suppliers', [
            'name' => 'Al Noor Stationery',
            'contact_person' => 'Samir',
            'phone' => '+971 4 000 0000',
            'email' => 'sales@alnoor.test',
            'payment_terms' => 'net_30',
        ])->json('id');
    }

    private function createItem(float $qty = 0, ?float $unitCost = null): WarehouseItem
    {
        $category = WarehouseCategory::firstOrCreate(['name' => 'Office Supplies']);

        return WarehouseItem::create([
            'sku' => 'OFS-2026-'.str_pad((string) (WarehouseItem::count() + 1), 4, '0', STR_PAD_LEFT),
            'name' => 'A4 Paper',
            'category_id' => $category->id,
            'unit' => 'ream',
            'current_qty' => $qty,
            'min_stock_qty' => 0,
            'unit_cost' => $unitCost,
            'is_active' => true,
        ]);
    }

    /** Create supplier + item + approved PO for 10 units @ 5.00; returns [poId, item]. */
    private function approvedPurchaseOrder(array $procurement): array
    {
        $supplierId = $this->createSupplier($procurement);
        $item = $this->createItem(qty: 10, unitCost: 4.00);

        $poId = $this->authed($procurement)->postJson('/api/procurement/purchase-orders', [
            'supplier_id' => $supplierId,
            'order_date' => now()->toDateString(),
            'items' => [[
                'warehouse_item_id' => $item->id,
                'quantity_ordered' => 10,
                'unit' => 'ream',
                'unit_cost' => 5.00,
            ]],
        ])->json('id');

        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/submit")->assertOk();
        // Separation of duties: the requester cannot approve their own PO,
        // so a second procurement user signs off.
        $approver = $this->login('procurement');
        $this->authed($approver)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertOk();

        return [$poId, $item];
    }

    public function test_supplier_created_with_account()
    {
        $auth = $this->login('procurement');
        $response = $this->authed($auth)->postJson('/api/procurement/suppliers', [
            'name' => 'Gulf Traders',
            'phone' => '+971 4 111 1111',
            'payment_terms' => 'net_15',
        ]);

        $response->assertStatus(201)->assertJsonPath('account.payment_terms', 'net_15');
        $this->assertDatabaseHas('suppliers', ['name' => 'Gulf Traders']);
        $this->assertDatabaseHas('supplier_accounts', [
            'supplier_id' => $response->json('id'), 'balance' => 0,
        ]);
    }

    public function test_goods_receipt_updates_stock_costs_balance_and_journal()
    {
        $procurement = $this->login('procurement');
        [$poId, $item] = $this->approvedPurchaseOrder($procurement);

        $poItemId = PurchaseOrder::find($poId)->items->first()->id;
        $response = $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/receive", [
            'lines' => [[
                'purchase_order_item_id' => $poItemId,
                'quantity_received' => 10,
                'warehouse_location' => 'Shelf B2',
            ]],
        ]);
        $response->assertStatus(201);

        // Inventory: qty 10 → 20, weighted avg cost (10*4 + 10*5)/20 = 4.50
        $item->refresh();
        $this->assertEquals(20.0, (float) $item->current_qty);
        $this->assertEquals(4.50, (float) $item->unit_cost);
        $this->assertEquals(5.00, (float) $item->last_unit_cost);
        $this->assertEquals('Shelf B2', $item->location);

        // Stock movement linked to the PO and receipt
        $this->assertDatabaseHas('stock_movements', [
            'item_id' => $item->id, 'movement_type' => 'in',
            'purchase_order_id' => $poId, 'qty_after' => 20,
        ]);

        // PO fully received
        $this->assertEquals('received', PurchaseOrder::find($poId)->status);

        // Supplier balance accrued: 10 * 5.00
        $supplier = Supplier::with('account')->find($response->json('purchase_order.supplier_id')
            ?? PurchaseOrder::find($poId)->supplier_id);
        $this->assertEquals(50.0, (float) $supplier->account->balance);
        $this->assertDatabaseHas('supplier_transactions', [
            'supplier_account_id' => $supplier->account->id, 'type' => 'invoice', 'balance_after' => 50,
        ]);

        // Balanced journal pair, source = purchase
        $entries = JournalEntry::where('source', 'purchase')->get();
        $this->assertCount(2, $entries);
        $this->assertEquals(['credit', 'debit'], $entries->pluck('type')->sort()->values()->all());
        $this->assertEquals([50.0, 50.0], $entries->pluck('amount')->map(fn ($a) => (float) $a)->all());
    }

    public function test_partial_receipt_and_over_receipt_guard()
    {
        $procurement = $this->login('procurement');
        [$poId, $item] = $this->approvedPurchaseOrder($procurement);
        $poItemId = PurchaseOrder::find($poId)->items->first()->id;

        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/receive", [
            'lines' => [['purchase_order_item_id' => $poItemId, 'quantity_received' => 4]],
        ])->assertStatus(201);
        $this->assertEquals('partially_received', PurchaseOrder::find($poId)->status);

        // 7 more would exceed the 6 remaining — rejected, and nothing moves.
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/receive", [
            'lines' => [['purchase_order_item_id' => $poItemId, 'quantity_received' => 7]],
        ])->assertStatus(422);
        $this->assertEquals(14.0, (float) $item->fresh()->current_qty);
    }

    public function test_receiving_requires_approved_order()
    {
        $procurement = $this->login('procurement');
        $supplierId = $this->createSupplier($procurement);
        $item = $this->createItem();

        $poId = $this->authed($procurement)->postJson('/api/procurement/purchase-orders', [
            'supplier_id' => $supplierId,
            'order_date' => now()->toDateString(),
            'items' => [[
                'warehouse_item_id' => $item->id, 'quantity_ordered' => 5,
                'unit' => 'ream', 'unit_cost' => 3,
            ]],
        ])->json('id');

        $poItemId = PurchaseOrder::find($poId)->items->first()->id;
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/receive", [
            'lines' => [['purchase_order_item_id' => $poItemId, 'quantity_received' => 5]],
        ])->assertStatus(422);
        $this->assertEquals(0.0, (float) $item->fresh()->current_qty);
    }

    public function test_warehouse_role_can_receive_but_not_approve()
    {
        $procurement = $this->login('procurement');
        $warehouse = $this->login('warehouse');
        $supplierId = $this->createSupplier($procurement);
        $item = $this->createItem();

        $poId = $this->authed($procurement)->postJson('/api/procurement/purchase-orders', [
            'supplier_id' => $supplierId,
            'order_date' => now()->toDateString(),
            'items' => [[
                'warehouse_item_id' => $item->id, 'quantity_ordered' => 5,
                'unit' => 'ream', 'unit_cost' => 3,
            ]],
        ])->json('id');
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/submit")->assertOk();

        // warehouse holds procurement.receive but not procurement.approve
        $this->authed($warehouse)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertStatus(403);

        // The requester cannot self-approve — a second procurement user can.
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertStatus(422);
        $approver = $this->login('procurement');
        $this->authed($approver)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertOk();
        $poItemId = PurchaseOrder::find($poId)->items->first()->id;
        $this->authed($warehouse)->postJson("/api/procurement/purchase-orders/{$poId}/receive", [
            'lines' => [['purchase_order_item_id' => $poItemId, 'quantity_received' => 5]],
        ])->assertStatus(201);
    }

    public function test_finance_role_is_read_only_in_procurement()
    {
        $finance = $this->login('finance');
        $this->authed($finance)->getJson('/api/procurement/suppliers')->assertOk();
        $this->authed($finance)->postJson('/api/procurement/suppliers', [
            'name' => 'X', 'phone' => '1',
        ])->assertStatus(403);
    }

    public function test_supplier_with_open_orders_cannot_be_deleted()
    {
        $procurement = $this->login('procurement');
        [$poId] = $this->approvedPurchaseOrder($procurement);
        $supplierId = PurchaseOrder::find($poId)->supplier_id;

        $this->authed($procurement)->deleteJson("/api/procurement/suppliers/{$supplierId}")
            ->assertStatus(409);
    }
}
