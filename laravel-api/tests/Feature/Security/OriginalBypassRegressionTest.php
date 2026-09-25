<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class OriginalBypassRegressionTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_refresh_token_is_rejected_from_admin_users(): void
    {
        $user = User::factory()->admin()->create(['password' => bcrypt('password')]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertOk();

        $this->withToken($login->json('refresh_token'))
            ->getJson('/api/admin/users')
            ->assertStatus(403)
            ->assertExactJson(['message' => 'Forbidden']);
    }

    public function test_deactivated_students_existing_access_token_is_rejected(): void
    {
        $user = User::factory()->student()->create(['password' => bcrypt('password')]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertOk();
        $user->update(['is_active' => false]);

        $this->withToken($login->json('access_token'))
            ->getJson('/api/student/dashboard')
            ->assertStatus(401)
            ->assertExactJson(['message' => 'Unauthenticated.']);
    }

    public function test_temporary_password_user_is_rejected_from_student_dashboard(): void
    {
        $user = User::factory()->student()->create([
            'password' => bcrypt('Temporary1'),
            'must_change_password' => true,
        ]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'Temporary1',
        ])->assertOk();

        $this->withToken($login->json('access_token'))
            ->getJson('/api/student/dashboard')
            ->assertStatus(403)
            ->assertExactJson([
                'message' => 'Password change required.',
                'code' => 'PASSWORD_CHANGE_REQUIRED',
            ]);
    }
}
