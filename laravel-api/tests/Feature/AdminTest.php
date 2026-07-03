<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_list_users(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->getJson('/api/admin/users');

        $response->assertOk();
    }

    public function test_admin_can_create_student(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'New Student',
                'email' => 'newstudent@school.test',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('users', [
            'email' => 'newstudent@school.test',
            'role' => 'student',
        ]);
    }

    public function test_admin_can_create_all_roles(): void
    {
        $admin = $this->loginAs('admin');
        $roles = ['student', 'parent', 'teacher', 'admin', 'finance', 'hr', 'warehouse'];

        foreach ($roles as $role) {
            $response = $this->actingAs($admin)
                ->postJson('/api/admin/users', [
                    'name' => "Test $role",
                    'email' => "test{$role}@school.test",
                    'password' => 'password123',
                    'role' => $role,
                ]);

            $response->assertStatus(201);
            $this->assertDatabaseHas('users', ['role' => $role, 'email' => "test{$role}@school.test"]);
        }
    }

    public function test_user_creation_requires_email(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'No Email User',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_user_email_must_be_unique(): void
    {
        $admin = $this->loginAs('admin');
        User::factory()->create(['email' => 'taken@school.test']);

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'Duplicate Email',
                'email' => 'taken@school.test',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_user_creation_requires_valid_role(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'Bad Role',
                'email' => 'badrole@school.test',
                'password' => 'password123',
                'role' => 'superadmin',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['role']);
    }

    public function test_admin_can_deactivate_user(): void
    {
        $admin = $this->loginAs('admin');
        $user = User::factory()->teacher()->create(['is_active' => true]);

        $response = $this->actingAs($admin)
            ->deleteJson("/api/admin/users/{$user->id}");

        $response->assertStatus(204);
        $this->assertDatabaseHas('users', [
            'id' => $user->id,
            'is_active' => false,
        ]);
    }

    public function test_teacher_cannot_create_users(): void
    {
        $teacher = $this->loginAs('teacher');

        $response = $this->actingAs($teacher)
            ->postJson('/api/admin/users', [
                'name' => 'Teacher Created',
                'email' => 'teachercreated@school.test',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertForbidden();
    }
}
