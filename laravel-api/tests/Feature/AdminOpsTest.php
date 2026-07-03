<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminOpsTest extends TestCase
{
    use RefreshDatabase;

    private User $admin;

    protected function setUp(): void
    {
        parent::setUp();
        $this->admin = User::factory()->admin()->create();
    }

    public function test_admin_dashboard_kpis(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/dashboard/kpis')
            ->assertOk()->assertJsonStructure(['data' => ['students', 'teachers', 'outstanding_fees']]);
    }

    public function test_admin_attendance_dashboard(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/attendance/dashboard')
            ->assertOk()->assertJsonStructure(['today', 'by_class']);
    }

    public function test_admin_monthly_reports(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/reports/monthly')->assertOk();
    }

    public function test_admin_audit_logs(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/audit-logs')->assertOk();
    }

    public function test_admin_can_create_list_delete_announcement(): void
    {
        $create = $this->actingAs($this->admin)->postJson('/api/admin/announcements', [
            'audience' => 'all', 'title' => 'School closed', 'body' => 'Public holiday tomorrow',
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/announcements')->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/announcements/{$id}")->assertNoContent();
    }

    public function test_admin_can_list_users_and_filter_by_role(): void
    {
        User::factory()->teacher()->count(2)->create();
        $this->actingAs($this->admin)->getJson('/api/admin/users?role=teacher')->assertOk();
    }

    public function test_admin_can_view_school_settings(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/school-settings')->assertOk();
    }

    public function test_admin_can_list_hr_requests(): void
    {
        $this->actingAs($this->admin)->getJson('/api/admin/hr-requests')->assertOk();
    }

    public function test_admin_can_create_user(): void
    {
        $this->actingAs($this->admin)->postJson('/api/admin/users', [
            'name' => 'New Teacher', 'email' => 'newteacher@test.com',
            'password' => 'password123', 'role' => 'teacher',
        ])->assertCreated();

        $this->assertDatabaseHas('users', ['email' => 'newteacher@test.com', 'role' => 'teacher']);
    }
}
