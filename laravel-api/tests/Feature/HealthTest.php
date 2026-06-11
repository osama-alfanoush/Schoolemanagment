<?php

declare(strict_types=1);

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class HealthTest extends TestCase
{
    use RefreshDatabase;

    public function test_liveness_endpoint_returns_ok(): void
    {
        $response = $this->getJson('/api/healthz');

        $response->assertOk()
            ->assertJson(['status' => 'ok']);
    }

    public function test_health_endpoint_returns_system_checks(): void
    {
        $response = $this->getJson('/api/health');

        $response->assertOk()
            ->assertJsonStructure([
                'status',
                'service',
                'version',
                'timestamp',
                'checks' => [
                    'database' => ['status'],
                    'storage' => ['status'],
                    'environment' => ['status'],
                ],
            ]);
    }

    public function test_health_reports_database_status(): void
    {
        $response = $this->getJson('/api/health');

        $response->assertOk();
        $this->assertEquals('ok', $response->json('checks.database.status'));
    }

    public function test_health_reports_environment_info(): void
    {
        $response = $this->getJson('/api/health');

        $response->assertOk();
        $this->assertArrayHasKey('env', $response->json('checks.environment'));
        $this->assertArrayHasKey('debug', $response->json('checks.environment'));
    }

    public function test_healthz_is_not_rate_limited(): void
    {
        for ($i = 0; $i < 20; $i++) {
            $response = $this->getJson('/api/healthz');
            $response->assertOk();
        }

        $this->expectNotToPerformAssertions();
    }
}
