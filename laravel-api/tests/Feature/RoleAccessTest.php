<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RoleAccessTest extends TestCase
{
    use RefreshDatabase;

    public function test_student_cannot_access_admin_routes()
    {
        $student = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($student)
            ->getJson('/api/admin/users');

        $response->assertStatus(403);
    }

    public function test_parent_cannot_access_admin_routes()
    {
        $parent = User::factory()->create(['role' => 'parent']);

        $response = $this->actingAs($parent)
            ->getJson('/api/admin/users');

        $response->assertStatus(403);
    }

    public function test_teacher_cannot_access_admin_routes()
    {
        $teacher = User::factory()->create(['role' => 'teacher']);

        $response = $this->actingAs($teacher)
            ->getJson('/api/admin/users');

        $response->assertStatus(403);
    }

    public function test_admin_can_access_admin_routes()
    {
        $admin = User::factory()->create(['role' => 'admin']);

        $response = $this->actingAs($admin)
            ->getJson('/api/admin/users');

        $response->assertStatus(200);
    }

    public function test_student_can_access_student_routes()
    {
        $student = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($student)
            ->getJson('/api/student/dashboard');

        $response->assertStatus(200);
    }

    public function test_teacher_cannot_access_student_routes()
    {
        $teacher = User::factory()->create(['role' => 'teacher']);

        $response = $this->actingAs($teacher)
            ->getJson('/api/student/dashboard');

        $response->assertStatus(403);
    }

    public function test_parent_can_access_parent_routes()
    {
        $parent = User::factory()->create(['role' => 'parent']);

        $response = $this->actingAs($parent)
            ->getJson('/api/parent/children');

        $response->assertStatus(200);
    }

    public function test_student_cannot_access_parent_routes()
    {
        $student = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($student)
            ->getJson('/api/parent/children');

        $response->assertStatus(403);
    }

    public function test_teacher_can_access_teacher_routes()
    {
        $teacher = User::factory()->create(['role' => 'teacher']);

        $response = $this->actingAs($teacher)
            ->getJson('/api/teacher/classes');

        $response->assertStatus(200);
    }

    public function test_finance_can_access_finance_routes()
    {
        $finance = User::factory()->create(['role' => 'finance']);

        $response = $this->actingAs($finance)
            ->getJson('/api/finance/invoices');

        $response->assertStatus(200);
    }

    public function test_admin_can_access_finance_routes()
    {
        $admin = User::factory()->create(['role' => 'admin']);

        $response = $this->actingAs($admin)
            ->getJson('/api/finance/invoices');

        $response->assertStatus(200);
    }

    public function test_teacher_cannot_access_finance_routes()
    {
        $teacher = User::factory()->create(['role' => 'teacher']);

        $response = $this->actingAs($teacher)
            ->getJson('/api/finance/invoices');

        $response->assertStatus(403);
    }

    public function test_hr_can_access_hr_routes()
    {
        $hr = User::factory()->create(['role' => 'hr']);

        $response = $this->actingAs($hr)
            ->getJson('/api/hr/staff');

        $response->assertStatus(200);
    }

    public function test_admin_can_access_hr_routes()
    {
        $admin = User::factory()->create(['role' => 'admin']);

        $response = $this->actingAs($admin)
            ->getJson('/api/hr/staff');

        $response->assertStatus(200);
    }

    public function test_teacher_cannot_access_hr_routes()
    {
        $teacher = User::factory()->create(['role' => 'teacher']);

        $response = $this->actingAs($teacher)
            ->getJson('/api/hr/staff');

        $response->assertStatus(403);
    }

    public function test_accounting_role_is_valid_and_can_login()
    {
        $user = User::factory()->create([
            'role' => 'accounting',
            'password' => 'password123',
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password123',
        ]);

        $response->assertStatus(200);
        $response->assertJsonPath('user.role', 'accounting');
    }

    public function test_warehouse_role_is_valid_and_can_login()
    {
        $user = User::factory()->create([
            'role' => 'warehouse',
            'password' => 'password123',
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password123',
        ]);

        $response->assertStatus(200);
        $response->assertJsonPath('user.role', 'warehouse');
    }
}
