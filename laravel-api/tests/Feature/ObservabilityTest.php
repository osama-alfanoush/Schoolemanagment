<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Http\Middleware\AssignRequestId;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * A production incident starts with "a user saw an error at 14:32". Without a
 * correlation id echoed to the client and attached to every log line, that
 * report cannot be tied to a request, a tenant, or a queued job.
 */
class ObservabilityTest extends TestCase
{
    use RefreshDatabase;

    public function test_every_api_response_carries_a_correlation_id(): void
    {
        $response = $this->getJson('/api/healthz');

        $response->assertOk();
        $this->assertNotEmpty($response->headers->get(AssignRequestId::HEADER));
    }

    public function test_error_responses_also_carry_a_correlation_id(): void
    {
        $response = $this->getJson('/api/auth/me');

        $response->assertStatus(401);
        $this->assertNotEmpty($response->headers->get(AssignRequestId::HEADER));
    }

    public function test_a_well_formed_inbound_correlation_id_is_preserved(): void
    {
        $id = 'edge-7f3a9c21-4b6d-4e8f-9a2b-1c5d7e9f0a3b';

        $this->withHeader(AssignRequestId::HEADER, $id)
            ->getJson('/api/healthz')
            ->assertHeader(AssignRequestId::HEADER, $id);
    }

    /**
     * An attacker-supplied header must never become a log-injection vector or
     * an unbounded string written to every log line.
     */
    public function test_a_malformed_inbound_correlation_id_is_replaced(): void
    {
        foreach (["bad id\nInjected: line", str_repeat('x', 500), 'short', '<script>'] as $hostile) {
            $response = $this->withHeader(AssignRequestId::HEADER, $hostile)->getJson('/api/healthz');

            $issued = $response->headers->get(AssignRequestId::HEADER);
            $this->assertNotSame($hostile, $issued);
            $this->assertMatchesRegularExpression('/^[A-Za-z0-9._-]{8,128}$/', (string) $issued);
        }
    }

    public function test_release_metadata_is_configured_and_reported(): void
    {
        $this->assertNotNull(config('app.release'));

        $admin = $this->loginAs('admin');
        $this->actingAs($admin)->getJson('/api/health')->assertJsonStructure(['release', 'version']);
    }
}
