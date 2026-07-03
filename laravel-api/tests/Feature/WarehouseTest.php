<?php

namespace Tests\Feature;

use App\Models\NotificationTemplate;
use App\Models\PurchaseRequest;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class WarehouseTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        NotificationTemplate::seedDefaults();
    }

    private function loginWarehouse(): array
    {
        $user = User::factory()->create([
            'role' => 'warehouse',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        return ['user' => $user, 'token' => $response->json('access_token')];
    }

    private function createItem(float $currentQty = 0, float $minStockQty = 0): WarehouseItem
    {
        $category = WarehouseCategory::create(['name' => 'Office Supplies']);

        return WarehouseItem::create([
            'sku' => 'OFS-2026-0001',
            'name' => 'Test Item',
            'category_id' => $category->id,
            'unit' => 'ream',
            'current_qty' => $currentQty,
            'min_stock_qty' => $minStockQty,
            'is_active' => true,
        ]);
    }

    public function test_warehouse_user_can_create_item()
    {
        $auth = $this->loginWarehouse();
        $category = WarehouseCategory::create(['name' => 'Stationery']);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/items', [
                'name' => 'A4 Paper',
                'category_id' => $category->id,
                'unit' => 'ream',
                'min_stock_qty' => 10,
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('warehouse_items', [
            'name' => 'A4 Paper',
        ]);
    }

    public function test_stock_movement_in_increases_qty()
    {
        $auth = $this->loginWarehouse();
        $item = $this->createItem(currentQty: 10);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/movements', [
                'item_id' => $item->id,
                'movement_type' => 'in',
                'quantity' => 5,
                'supplier' => 'Test Supplier',
            ]);

        $response->assertStatus(201);
        $this->assertEquals(15, (float) $item->fresh()->current_qty);
    }

    public function test_stock_movement_out_decreases_qty()
    {
        $auth = $this->loginWarehouse();
        $item = $this->createItem(currentQty: 10);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/movements', [
                'item_id' => $item->id,
                'movement_type' => 'out',
                'quantity' => 3,
                'department' => 'Admin',
            ]);

        $response->assertStatus(201);
        $this->assertEquals(7, (float) $item->fresh()->current_qty);
    }

    public function test_stock_movement_out_fails_when_insufficient()
    {
        $auth = $this->loginWarehouse();
        $item = $this->createItem(currentQty: 5);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/movements', [
                'item_id' => $item->id,
                'movement_type' => 'out',
                'quantity' => 10,
            ]);

        $response->assertStatus(422);
        $this->assertStringContainsString('Insufficient stock', $response->json('message'));
        $this->assertEquals(5, (float) $item->fresh()->current_qty);
    }

    public function test_low_stock_notification_fires_when_threshold_crossed()
    {
        $admin = User::factory()->create(['role' => 'admin', 'is_active' => true]);
        $auth = $this->loginWarehouse();
        $item = $this->createItem(currentQty: 5, minStockQty: 3);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/movements', [
                'item_id' => $item->id,
                'movement_type' => 'out',
                'quantity' => 3,
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('notifications', [
            'user_id' => $admin->id,
            'type' => 'low_stock_alert',
        ]);
    }

    public function test_purchase_request_notifies_admin()
    {
        $admin = User::factory()->create(['role' => 'admin', 'is_active' => true]);
        $auth = $this->loginWarehouse();
        $item = $this->createItem();

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/warehouse/purchase-requests', [
                'item_id' => $item->id,
                'quantity_requested' => 50,
                'unit' => 'ream',
                'justification' => 'Running low',
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('purchase_requests', ['status' => 'pending']);
        $this->assertDatabaseHas('notifications', [
            'user_id' => $admin->id,
            'type' => 'new_purchase_request',
        ]);
    }

    public function test_admin_can_approve_purchase_request()
    {
        $warehouseUser = User::factory()->create([
            'role' => 'warehouse',
            'is_active' => true,
        ]);

        $admin = User::factory()->create([
            'role' => 'admin',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $item = $this->createItem();

        $pr = PurchaseRequest::create([
            'request_no' => 'PR-2026-0001',
            'item_id' => $item->id,
            'quantity_requested' => 20,
            'unit' => 'ream',
            'status' => 'pending',
            'requested_by' => $warehouseUser->id,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $admin->email,
            'password' => 'password',
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$login->json('access_token'))
            ->patchJson("/api/warehouse/purchase-requests/{$pr->id}/review", [
                'status' => 'approved',
                'admin_notes' => 'Approved - proceed with purchase',
            ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('purchase_requests', [
            'id' => $pr->id,
            'status' => 'approved',
            'reviewed_by' => $admin->id,
        ]);
        $this->assertDatabaseHas('notifications', [
            'user_id' => $warehouseUser->id,
            'type' => 'purchase_request_status',
        ]);
    }

    public function test_non_warehouse_user_cannot_access_warehouse_routes()
    {
        $user = User::factory()->create([
            'role' => 'student',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$login->json('access_token'))
            ->getJson('/api/warehouse/items');

        $response->assertStatus(403);
    }
}
