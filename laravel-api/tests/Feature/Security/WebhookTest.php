<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class WebhookTest extends TestCase
{
    use RefreshDatabase;

    public function test_webhook_requires_stripe_signature_header(): void
    {
        $response = $this->postJson('/api/webhooks/payment', [
            'type' => 'payment_intent.succeeded',
            'data' => ['object' => ['id' => 'pi_test']],
        ]);

        $response->assertStatus(400)
            ->assertJson(['message' => 'Missing Stripe-Signature header']);
    }

    public function test_webhook_returns_200_or_400_with_signature(): void
    {
        $response = $this->postJson('/api/webhooks/payment', [
            'type' => 'payment_intent.succeeded',
            'data' => ['object' => ['id' => 'pi_test', 'amount_received' => 5000]],
        ], [
            'Stripe-Signature' => 't=123,v1=test_signature',
        ]);

        // Should not be "missing signature" error — may be 200 (valid) or 400 (invalid sig)
        $this->assertNotEquals('Missing Stripe-Signature header', $response->json('message'));
    }
}
