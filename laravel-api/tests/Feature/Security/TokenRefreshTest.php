<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TokenRefreshTest extends TestCase
{
    use RefreshDatabase;

    public function test_unauthenticated_user_cannot_refresh_token(): void
    {
        $response = $this->postJson('/api/auth/refresh', [], [
            'Authorization' => 'Bearer invalid_token',
        ]);

        $response->assertStatus(401);
    }

    public function test_authenticated_user_can_refresh_token(): void
    {
        $user = User::factory()->create([
            'role' => 'student',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
            'device_name' => 'Test Device',
        ]);

        $login->assertOk();
        $refreshToken = $login->json('refresh_token');

        $response = $this->withHeaders([
            'Authorization' => 'Bearer '.$refreshToken,
        ])->postJson('/api/auth/refresh');

        $response->assertOk()
            ->assertJsonStructure(['access_token', 'refresh_token']);
    }

    public function test_refresh_token_rotation_returns_new_tokens(): void
    {
        $user = User::factory()->create([
            'role' => 'student',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
            'device_name' => 'Test Device',
        ]);

        $firstAccess = $login->json('access_token');
        $firstRefresh = $login->json('refresh_token');

        $refresh = $this->withHeaders([
            'Authorization' => 'Bearer '.$firstRefresh,
        ])->postJson('/api/auth/refresh');

        $refresh->assertOk();
        $this->assertNotEquals($firstAccess, $refresh->json('access_token'));
        $this->assertNotEquals($firstRefresh, $refresh->json('refresh_token'));
    }

    public function test_access_and_refresh_tokens_are_restricted_to_their_own_purpose(): void
    {
        $user = User::factory()->create([
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertOk();

        $this->withToken($login->json('access_token'))
            ->postJson('/api/auth/refresh')
            ->assertForbidden();

        $this->app['auth']->forgetGuards();
        $this->withToken($login->json('refresh_token'))
            ->getJson('/api/auth/me')
            ->assertForbidden();
    }

    public function test_refresh_token_reuse_revokes_the_entire_device_family(): void
    {
        $user = User::factory()->create([
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
            'device_name' => 'Auditor Browser',
        ])->assertOk();
        $oldRefresh = $login->json('refresh_token');

        $rotation = $this->withToken($oldRefresh)
            ->postJson('/api/auth/refresh')
            ->assertOk();

        $this->withToken($oldRefresh)
            ->postJson('/api/auth/refresh')
            ->assertUnauthorized();

        $this->app['auth']->forgetGuards();
        $this->withToken($rotation->json('access_token'))
            ->getJson('/api/auth/me')
            ->assertUnauthorized();

        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $user->id,
            'action' => 'refresh_token_reuse',
        ]);
    }

    public function test_existing_token_is_rejected_immediately_after_account_deactivation(): void
    {
        $user = User::factory()->create([
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertOk();

        $user->update(['is_active' => false]);

        $this->withToken($login->json('access_token'))
            ->getJson('/api/auth/me')
            ->assertUnauthorized();
        $this->assertDatabaseMissing('personal_access_tokens', [
            'tokenable_type' => User::class,
            'tokenable_id' => $user->id,
        ]);
    }

    public function test_temporary_password_session_is_limited_until_password_change(): void
    {
        $user = User::factory()->create([
            'role' => 'student',
            'password' => bcrypt('Temporary1'),
            'is_active' => true,
            'must_change_password' => true,
        ]);
        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'Temporary1',
        ])->assertOk();
        $oldAccess = $login->json('access_token');

        $this->withToken($oldAccess)->getJson('/api/auth/me')->assertOk();
        $this->withToken($oldAccess)
            ->getJson('/api/student/dashboard')
            ->assertForbidden()
            ->assertJsonPath('code', 'PASSWORD_CHANGE_REQUIRED');

        $changed = $this->withToken($oldAccess)->postJson('/api/auth/change-password', [
            'current_password' => 'Temporary1',
            'new_password' => 'Permanent2',
            'new_password_confirmation' => 'Permanent2',
        ])->assertOk();

        $this->app['auth']->forgetGuards();
        $this->withToken($oldAccess)->getJson('/api/auth/me')->assertUnauthorized();
        $this->app['auth']->forgetGuards();
        $this->withToken($changed->json('access_token'))->getJson('/api/auth/me')->assertOk();
    }
}
