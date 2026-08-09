<?php

namespace Tests\Feature;

use App\Models\NotificationTemplate;
use App\Models\PayrollRun;
use App\Models\StaffProfile;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * User-management governance: temporary admin-set passwords, per-user
 * permission overrides (least privilege), and separation-of-duties guards
 * on finance/procurement approvals.
 */
class UserGovernanceTest extends TestCase
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
            'email' => $user->email, 'password' => 'password',
        ]);

        return ['user' => $user, 'token' => $response->json('access_token')];
    }

    private function authed(array $auth)
    {
        $this->app['auth']->forgetGuards();

        return $this->withHeader('Authorization', 'Bearer '.$auth['token']);
    }

    public function test_admin_created_user_must_change_password()
    {
        $admin = $this->login('admin');
        $this->authed($admin)->postJson('/api/admin/users', [
            'name' => 'Temp Teacher', 'email' => 'temp@school.test',
            'password' => 'temporary-pass', 'role' => 'teacher',
        ])->assertStatus(201);

        $this->app['auth']->forgetGuards();
        $login = $this->postJson('/api/auth/login', [
            'email' => 'temp@school.test', 'password' => 'temporary-pass',
        ]);
        $login->assertOk()->assertJsonPath('must_change_password', true);

        // Setting their own password clears the flag.
        $this->app['auth']->forgetGuards();
        $this->withHeader('Authorization', 'Bearer '.$login->json('access_token'))
            ->postJson('/api/auth/change-password', [
                'current_password' => 'temporary-pass',
                'new_password' => 'MyOwnPass1',
                'new_password_confirmation' => 'MyOwnPass1',
            ])->assertOk();
        $this->assertFalse((bool) User::where('email', 'temp@school.test')->first()->must_change_password);
    }

    public function test_admin_password_reset_flags_password_as_temporary()
    {
        $admin = $this->login('admin');
        $teacher = $this->login('teacher');
        $this->assertFalse((bool) $teacher['user']->must_change_password);

        $this->authed($admin)->patchJson("/api/admin/users/{$teacher['user']->id}", [
            'password' => 'reset-by-admin',
        ])->assertOk();

        $this->assertTrue((bool) $teacher['user']->fresh()->must_change_password);
    }

    public function test_user_permission_read_endpoint_shows_baseline_and_overrides()
    {
        $admin = $this->login('admin');
        $finance = $this->login('finance');

        $this->authed($admin)->putJson("/api/admin/users/{$finance['user']->id}/permissions", [
            'grants' => [],
            'denies' => ['finance.procurement.approve'],
        ])->assertOk();

        $response = $this->authed($admin)->getJson("/api/admin/users/{$finance['user']->id}/permissions");
        $response->assertOk()
            ->assertJsonPath('role', 'finance')
            ->assertJsonPath('denies.0', 'finance.procurement.approve');
        $this->assertContains('finance.procurement.view', $response->json('role_keys'));
        $this->assertNotContains('finance.procurement.approve', $response->json('effective'));
    }

    public function test_denied_finance_user_cannot_pay_supplier_invoices()
    {
        $admin = $this->login('admin');
        $procurement = $this->login('procurement');
        $finance = $this->login('finance');

        // Deny the AP payment permission for this specific accountant.
        $this->authed($admin)->putJson("/api/admin/users/{$finance['user']->id}/permissions", [
            'grants' => [], 'denies' => ['finance.procurement.approve'],
        ])->assertOk();

        $this->app['auth']->forgetGuards();
        $newSession = $this->postJson('/api/auth/login', [
            'email' => $finance['user']->email,
            'password' => 'password',
        ])->assertOk();
        $finance['token'] = $newSession->json('access_token');

        $supplierId = $this->authed($procurement)->postJson('/api/procurement/suppliers', [
            'name' => 'SoD Supplies', 'phone' => '+971 4 555 5555',
        ])->json('id');
        $invoiceId = $this->authed($finance)->postJson('/api/finance/ap/supplier-invoices', [
            'supplier_id' => $supplierId,
            'invoice_date' => now()->toDateString(),
            'due_date' => now()->addDays(30)->toDateString(),
            'amount' => 100,
        ])->json('id');

        // Can still register invoices (create) but not settle them (approve).
        $this->authed($finance)->postJson("/api/finance/ap/supplier-invoices/{$invoiceId}/payments", [
            'amount' => 100, 'method' => 'cash',
        ])->assertStatus(403);
    }

    public function test_po_requester_cannot_self_approve()
    {
        $procurement = $this->login('procurement');
        $reviewer = $this->login('procurement');

        $supplierId = $this->authed($procurement)->postJson('/api/procurement/suppliers', [
            'name' => 'Maker Checker Co', 'phone' => '+971 4 777 7777',
        ])->json('id');
        $category = WarehouseCategory::create(['name' => 'General']);
        $item = WarehouseItem::create([
            'sku' => 'GEN-0001', 'name' => 'Marker', 'category_id' => $category->id,
            'unit' => 'piece', 'current_qty' => 0, 'min_stock_qty' => 0, 'is_active' => true,
        ]);

        $poId = $this->authed($procurement)->postJson('/api/procurement/purchase-orders', [
            'supplier_id' => $supplierId,
            'order_date' => now()->toDateString(),
            'items' => [['warehouse_item_id' => $item->id, 'quantity_ordered' => 2, 'unit' => 'piece', 'unit_cost' => 1]],
        ])->json('id');
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/submit")->assertOk();

        // Requester blocked; may still withdraw (reject) their own order.
        $this->authed($procurement)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertStatus(422);
        $this->authed($reviewer)->postJson("/api/procurement/purchase-orders/{$poId}/approve")->assertOk();
    }

    public function test_payroll_run_drafter_cannot_self_approve()
    {
        $finance = $this->login('finance');
        $reviewer = $this->login('finance');
        $teacher = User::factory()->create(['role' => 'teacher', 'is_active' => true]);
        StaffProfile::create([
            'user_id' => $teacher->id, 'department' => 'Academics', 'position' => 'Teacher',
            'hire_date' => now()->subYear(), 'contract_type' => 'full-time', 'base_salary' => 3000,
            'annual_leave_balance' => 20, 'sick_leave_balance' => 10,
        ]);

        $runId = $this->authed($finance)->postJson('/api/finance/payroll/runs', [
            'year' => 2026, 'month' => 8,
        ])->json('id');
        $this->authed($finance)->postJson("/api/finance/payroll/runs/{$runId}/process")->assertOk();

        $this->authed($finance)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertStatus(422);
        $this->authed($reviewer)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertOk();
        $this->assertEquals('approved', PayrollRun::find($runId)->status);
    }
}
