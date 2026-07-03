<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthenticationTest extends TestCase
{
    use RefreshDatabase;

    public function test_student_can_login_with_valid_credentials()
    {
        $user = User::factory()->create([
            'email' => 'student@school.test',
            'password' => bcrypt('password'),
            'role' => 'student',
            'is_active' => true,
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => 'student@school.test',
            'password' => 'password',
            'device_name' => 'Test Device',
        ]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'token',
                'access_token',
                'refresh_token',
                'token_type',
                'expires_in',
                'user' => ['id', 'name', 'email', 'role'],
            ]);
    }

    public function test_login_fails_with_invalid_credentials()
    {
        $user = User::factory()->create([
            'email' => 'student@school.test',
            'password' => bcrypt('password'),
            'role' => 'student',
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => 'student@school.test',
            'password' => 'wrongpassword',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_login_fails_with_nonexistent_user()
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'nonexistent@school.test',
            'password' => 'password',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_login_validation_requires_password()
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'test@school.test',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['password']);
    }

    public function test_authenticated_user_can_access_me_endpoint()
    {
        $user = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($user)
            ->getJson('/api/auth/me');

        $response->assertStatus(200)
            ->assertJsonStructure(['user' => ['id', 'name', 'email', 'role']]);
    }

    public function test_unauthenticated_user_cannot_access_me_endpoint()
    {
        $response = $this->getJson('/api/auth/me');

        $response->assertStatus(401);
    }

    public function test_user_can_logout()
    {
        $user = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($user)
            ->postJson('/api/auth/logout');

        $response->assertStatus(200)
            ->assertJson(['message' => 'Logged out']);
    }

    public function test_user_can_update_profile()
    {
        $user = User::factory()->create([
            'role' => 'student',
            'name' => 'Old Name',
        ]);

        $response = $this->actingAs($user)
            ->patchJson('/api/auth/profile', [
                'name' => 'New Name',
                'phone' => '+1234567890',
            ]);

        $response->assertStatus(200)
            ->assertJsonPath('user.name', 'New Name')
            ->assertJsonPath('user.phone', '+1234567890');
    }

    public function test_user_can_change_password()
    {
        $user = User::factory()->create([
            'password' => bcrypt('oldpassword'),
            'role' => 'student',
        ]);

        $response = $this->actingAs($user)
            ->postJson('/api/auth/change-password', [
                'current_password' => 'oldpassword',
                'new_password' => 'NewPassword123',
                'new_password_confirmation' => 'NewPassword123',
            ]);

        $response->assertStatus(200)
            ->assertJson(['message' => 'Password updated']);
    }

    public function test_change_password_fails_with_wrong_current_password()
    {
        $user = User::factory()->create([
            'password' => bcrypt('correctpassword'),
            'role' => 'student',
        ]);

        $response = $this->actingAs($user)
            ->postJson('/api/auth/change-password', [
                'current_password' => 'wrongpassword',
                'new_password' => 'NewPassword123',
                'new_password_confirmation' => 'NewPassword123',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['current_password']);
    }

    public function test_expired_token_returns_401(): void
    {
        $response = $this->withHeaders([
            'Authorization' => 'Bearer invalid_token_here_abc123xyz',
        ])->getJson('/api/auth/me');

        $response->assertStatus(401);
    }

    public function test_inactive_user_cannot_login(): void
    {
        $user = User::factory()->inactive()->create();

        $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertUnprocessable();
    }

    public function test_login_response_includes_role(): void
    {
        $user = User::factory()->teacher()->create();

        $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->assertOk()->assertJsonPath('user.role', 'teacher');
    }

    public function test_profile_update_validates_phone_format(): void
    {
        $user = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($user)
            ->patchJson('/api/auth/profile', [
                'phone' => str_repeat('x', 50),
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['phone']);
    }
}
