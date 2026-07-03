<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\PurchaseRequest;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class WarehouseExtendedTest extends TestCase
{
    use RefreshDatabase;

    private User $warehouseUser;

    protected function setUp(): void
    {
        parent::setUp();
        $this->warehouseUser = $this->loginAs('warehouse');
    }

    public function test_warehouse_can_update_item(): void
    {
        $category = WarehouseCategory::factory()->create();
        $item = WarehouseItem::factory()->create([
            'category_id' => $category->id,
            'name' => 'Original Name',
        ]);

        $response = $this->actingAs($this->warehouseUser)
            ->patchJson("/api/warehouse/items/{$item->id}", [
                'name' => 'Updated Name',
            ]);

        $response->assertOk()
            ->assertJsonPath('data.name', 'Updated Name');
        $this->assertDatabaseHas('warehouse_items', ['id' => $item->id, 'name' => 'Updated Name']);
    }

    public function test_warehouse_can_view_item(): void
    {
        $category = WarehouseCategory::factory()->create();
        $item = WarehouseItem::factory()->create(['category_id' => $category->id]);

        $response = $this->actingAs($this->warehouseUser)
            ->getJson("/api/warehouse/items/{$item->id}");

        $response->assertOk()
            ->assertJsonStructure(['data' => ['id', 'name', 'sku', 'current_qty']]);
    }

    public function test_stock_movement_requires_valid_item(): void
    {
        $response = $this->actingAs($this->warehouseUser)
            ->postJson('/api/warehouse/movements', [
                'item_id' => 99999,
                'movement_type' => 'in',
                'quantity' => 10,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['item_id']);
    }

    public function test_stock_movement_type_must_be_in_or_out(): void
    {
        $category = WarehouseCategory::factory()->create();
        $item = WarehouseItem::factory()->create(['category_id' => $category->id]);

        $response = $this->actingAs($this->warehouseUser)
            ->postJson('/api/warehouse/movements', [
                'item_id' => $item->id,
                'movement_type' => 'remove',
                'quantity' => 10,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['movement_type']);
    }

    public function test_warehouse_can_view_purchase_requests(): void
    {
        $response = $this->actingAs($this->warehouseUser)
            ->getJson('/api/warehouse/purchase-requests');

        $response->assertOk();
    }

    public function test_admin_can_reject_purchase_request(): void
    {
        $admin = $this->loginAs('admin');
        $category = WarehouseCategory::factory()->create();
        $item = WarehouseItem::factory()->create(['category_id' => $category->id]);
        $requester = User::factory()->warehouse()->create();
        $pr = PurchaseRequest::factory()->create([
            'item_id' => $item->id,
            'requested_by' => $requester->id,
            'status' => 'pending',
        ]);

        $response = $this->actingAs($admin)
            ->patchJson("/api/warehouse/purchase-requests/{$pr->id}/review", [
                'status' => 'rejected',
                'admin_notes' => 'Budget unavailable',
            ]);

        $response->assertOk();
        $this->assertDatabaseHas('purchase_requests', ['id' => $pr->id, 'status' => 'rejected']);
    }
}
