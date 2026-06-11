<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RateLimitTest extends TestCase
{
    use RefreshDatabase;

    public function test_login_rate_limited_after_10_attempts(): void
    {
        User::factory()->create([
            'email' => 'test@school.test',
            'password' => bcrypt('password'),
            'role' => 'student',
            'is_active' => true,
        ]);

        for ($i = 0; $i < 10; $i++) {
            $this->postJson('/api/auth/login', [
                'email' => 'test@school.test',
                'password' => 'wrong',
            ]);
        }

        $response = $this->postJson('/api/auth/login', [
            'email' => 'test@school.test',
            'password' => 'wrong',
        ]);

        $response->assertStatus(429);
    }

    public function test_forgot_password_rate_limited_after_3_attempts(): void
    {
        for ($i = 0; $i < 3; $i++) {
            $this->postJson('/api/auth/forgot-password', [
                'email' => 'test@school.test',
            ]);
        }

        $response = $this->postJson('/api/auth/forgot-password', [
            'email' => 'test@school.test',
        ]);

        $response->assertStatus(429);
    }

    public function test_health_endpoint_not_rate_limited(): void
    {
        for ($i = 0; $i < 20; $i++) {
            $response = $this->getJson('/api/health');
            if ($response->getStatusCode() === 429) {
                $this->fail('Health endpoint should not be rate limited');
            }
        }

        $this->expectNotToPerformAssertions();
    }
}
