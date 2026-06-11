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
            'Authorization' => 'Bearer ' . $refreshToken,
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
            'Authorization' => 'Bearer ' . $firstRefresh,
        ])->postJson('/api/auth/refresh');

        $refresh->assertOk();
        $this->assertNotEquals($firstAccess, $refresh->json('access_token'));
        $this->assertNotEquals($firstRefresh, $refresh->json('refresh_token'));
    }
}
