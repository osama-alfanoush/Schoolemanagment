<?php

namespace Tests\Feature;

use App\Models\NotificationTemplate;
use App\Models\StaffProfile;
use App\Models\User;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * End-to-end lifecycle of a procurement user: admin creates the account,
 * the user logs in, gets the right permissions, and reaches every linked
 * subsystem (HR requests, staff lists, messaging, procurement module).
 */
class ProcurementUserLifecycleTest extends TestCase
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
        if (in_array($role, User::STAFF_ROLES, true)) {
            StaffProfile::firstOrCreate(['user_id' => $user->id], ['employment_status' => 'active']);
        }

        return ['user' => $user, 'token' => $this->httpLogin($user->email)];
    }

    private function httpLogin(string $email, string $password = 'password'): string
    {
        $this->app['auth']->forgetGuards();

        return $this->postJson('/api/auth/login', [
            'email' => $email, 'password' => $password,
        ])->json('access_token');
    }

    private function authed(string $token)
    {
        $this->app['auth']->forgetGuards();

        return $this->withHeader('Authorization', 'Bearer '.$token);
    }

    public function test_admin_creates_procurement_user_with_staff_profile()
    {
        $admin = $this->login('admin');

        $response = $this->authed($admin['token'])->postJson('/api/admin/users', [
            'name' => 'Rania Procurement',
            'email' => 'rania@school.test',
            'password' => 'secret-password',
            'role' => 'procurement',
            'staff' => [
                'department' => 'Procurement',
                'position' => 'Procurement Officer',
                'base_salary' => 3500,
            ],
        ]);

        $response->assertStatus(201)
            ->assertJsonPath('role', 'procurement')
            ->assertJsonPath('staff_profile.department', 'Procurement');
        $this->assertDatabaseHas('staff_profiles', [
            'user_id' => $response->json('id'), 'position' => 'Procurement Officer',
        ]);
    }

    public function test_created_procurement_user_logs_in_and_gets_permissions()
    {
        $admin = $this->login('admin');
        $this->authed($admin['token'])->postJson('/api/admin/users', [
            'name' => 'Rania Procurement', 'email' => 'rania@school.test',
            'password' => 'secret-password', 'role' => 'procurement',
        ])->assertStatus(201);

        $this->app['auth']->forgetGuards();
        $login = $this->postJson('/api/auth/login', [
            'email' => 'rania@school.test', 'password' => 'secret-password',
        ]);
        $login->assertOk()->assertJsonPath('user.role', 'procurement');

        $me = $this->authed($login->json('access_token'))->getJson('/api/auth/me');
        $me->assertOk()->assertJsonPath('user.role', 'procurement');
        $keys = $me->json('permissions');
        $this->assertContains('procurement.approve', $keys);
        $this->assertContains('finance.procurement.view', $keys);
        $this->assertNotContains('finance.payroll.view', $keys);

        // Temporary credentials are server-side restricted until the owner
        // chooses a password; the change returns a fresh session.
        $this->authed($login->json('access_token'))->getJson('/api/procurement/suppliers')->assertForbidden();
        $changed = $this->authed($login->json('access_token'))->postJson('/api/auth/change-password', [
            'current_password' => 'secret-password',
            'new_password' => 'PermanentPass1',
            'new_password_confirmation' => 'PermanentPass1',
        ])->assertOk();
        $this->app['auth']->forgetGuards();
        $this->authed($changed->json('access_token'))->getJson('/api/procurement/suppliers')->assertOk();
    }

    public function test_admin_can_switch_staff_role_to_procurement()
    {
        $admin = $this->login('admin');
        $warehouse = $this->login('warehouse');

        $this->authed($admin['token'])->patchJson("/api/admin/users/{$warehouse['user']->id}", [
            'role' => 'procurement',
        ])->assertOk()->assertJsonPath('role', 'procurement');

        // Fresh login picks up the new role's permission set.
        $token = $this->httpLogin($warehouse['user']->email);
        $this->authed($token)->postJson('/api/procurement/suppliers', [
            'name' => 'Switched Role Supplier', 'phone' => '+971 4 222 2222',
        ])->assertStatus(201);
    }

    public function test_student_accounts_cannot_change_role()
    {
        $admin = $this->login('admin');
        $student = User::factory()->create(['role' => 'student', 'is_active' => true]);

        $this->authed($admin['token'])->patchJson("/api/admin/users/{$student->id}", [
            'role' => 'procurement',
        ])->assertStatus(422);
        $this->assertEquals('student', $student->fresh()->role);
    }

    public function test_procurement_user_reaches_linked_subsystems()
    {
        $procurement = $this->login('procurement');
        $hr = $this->login('hr');

        // HR: can submit a leave request…
        $this->authed($procurement['token'])->postJson('/api/hr-requests', [
            'type' => 'leave_annual',
            'subject' => 'Vacation',
            'reason' => 'Family trip',
            'start_date' => now()->addWeek()->toDateString(),
            'end_date' => now()->addWeek()->addDays(3)->toDateString(),
        ])->assertStatus(201);

        // …and shows up in the HR staff list.
        $staff = $this->authed($hr['token'])->getJson('/api/hr/staff');
        $staff->assertOk();
        $this->assertTrue(
            collect($staff->json('data') ?? $staff->json())
                ->contains(fn ($row) => ($row['id'] ?? null) === $procurement['user']->id)
        );

        // Messaging: privileged staff role sees recipients.
        $this->authed($procurement['token'])->getJson('/api/messages/recipients')->assertOk();
    }

    public function test_admin_kpi_staff_count_includes_procurement_and_warehouse()
    {
        $admin = $this->login('admin');
        $this->login('procurement');
        $this->login('warehouse');

        $kpis = $this->authed($admin['token'])->getJson('/api/admin/dashboard/kpis');
        $kpis->assertOk();
        // admin + procurement + warehouse = 3 staff users in this test DB
        $this->assertEquals(3, $kpis->json('data.staff') ?? $kpis->json('staff'));
    }
}
