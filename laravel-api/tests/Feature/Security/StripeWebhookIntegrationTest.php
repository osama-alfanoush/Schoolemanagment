<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentTransaction;
use App\Models\User;
use App\Services\IntegrationGate;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Testing\TestResponse;
use Tests\TestCase;

/**
 * Stripe webhook handling, exercised with genuinely signed payloads.
 *
 * No live Stripe account is involved and none is needed for this: the signing
 * secret is a shared value, so a signature computed here is exactly what
 * Stripe's own signer produces, and Stripe's SDK verifies it with the same code
 * path it uses in production. What is proven is the part that belongs to this
 * application — signature enforcement, replay handling, idempotency and the
 * ledger consequences. What is NOT proven is anything requiring Stripe's
 * servers: real card authorisation, real refunds, real event delivery.
 */
class StripeWebhookIntegrationTest extends TestCase
{
    use RefreshDatabase;

    /**
     * A locally chosen signing secret. This is not, and must never be, a real
     * Stripe credential — it exists only so both sides of the test agree.
     */
    private const TEST_SIGNING_SECRET = 'whsec_local_verification_only_not_a_real_secret';

    protected function setUp(): void
    {
        parent::setUp();

        config([
            'integrations.payments.enabled' => true,
            // The test environment defaults PAYMENT_PROVIDER to "fake"; the
            // webhook handler filters transactions by the configured provider,
            // so the fixture and the handler must agree on "stripe".
            'services.payment.provider' => 'stripe',
            'services.payment.stripe.secret_key' => 'sk_test_local_verification_only',
            'services.payment.stripe.webhook_secret' => self::TEST_SIGNING_SECRET,
        ]);
    }

    /** Sign a payload exactly as Stripe does: t=<ts>,v1=HMAC-SHA256(ts.payload). */
    private function sign(string $payload, ?int $timestamp = null, ?string $secret = null): string
    {
        $timestamp ??= time();
        $signature = hash_hmac('sha256', $timestamp.'.'.$payload, $secret ?? self::TEST_SIGNING_SECRET);

        return "t={$timestamp},v1={$signature}";
    }

    private function event(string $id, string $type, array $object): string
    {
        return json_encode([
            'id' => $id,
            'object' => 'event',
            'type' => $type,
            'created' => time(),
            'data' => ['object' => $object],
        ], JSON_THROW_ON_ERROR);
    }

    private function postWebhook(string $payload, ?string $signature): TestResponse
    {
        return $this->call(
            'POST',
            '/api/webhooks/payment',
            [], [], [],
            array_filter([
                'CONTENT_TYPE' => 'application/json',
                'HTTP_ACCEPT' => 'application/json',
                'HTTP_STRIPE_SIGNATURE' => $signature,
            ]),
            $payload
        );
    }

    // ------------------------------------------------------- signature

    public function test_an_unsigned_webhook_is_rejected(): void
    {
        $this->postWebhook($this->event('evt_unsigned', 'payment_intent.succeeded', ['id' => 'pi_1']), null)
            ->assertStatus(400);

        $this->assertDatabaseCount('payment_webhook_events', 0);
    }

    public function test_a_webhook_with_an_invalid_signature_is_rejected(): void
    {
        $payload = $this->event('evt_bad_sig', 'payment_intent.succeeded', ['id' => 'pi_1']);

        $this->postWebhook($payload, 't='.time().',v1=deadbeef')->assertStatus(400);

        $this->assertDatabaseCount('payment_webhook_events', 0);
    }

    /**
     * The decisive one: a valid signature computed with a DIFFERENT secret must
     * fail. This is what stops anyone who can reach the endpoint from minting
     * their own "payment succeeded" events.
     */
    public function test_a_webhook_signed_with_the_wrong_secret_is_rejected(): void
    {
        $payload = $this->event('evt_wrong_secret', 'payment_intent.succeeded', ['id' => 'pi_1']);

        $this->postWebhook($payload, $this->sign($payload, null, 'whsec_a_different_secret'))
            ->assertStatus(400);

        $this->assertDatabaseCount('payment_webhook_events', 0);
    }

    /**
     * Stripe's own tolerance check: an old signature must not be replayable
     * forever, even though it is cryptographically valid.
     */
    public function test_a_stale_signature_outside_the_tolerance_window_is_rejected(): void
    {
        $payload = $this->event('evt_stale', 'payment_intent.succeeded', ['id' => 'pi_1']);

        $this->postWebhook($payload, $this->sign($payload, time() - 86400))
            ->assertStatus(400);

        $this->assertDatabaseCount('payment_webhook_events', 0);
    }

    public function test_a_correctly_signed_webhook_is_accepted_and_recorded(): void
    {
        $payload = $this->event('evt_ok', 'customer.subscription.updated', ['id' => 'sub_1']);

        $this->postWebhook($payload, $this->sign($payload))->assertOk();

        $this->assertDatabaseHas('payment_webhook_events', [
            'event_id' => 'evt_ok',
            'status' => 'completed',
        ]);
    }

    // ------------------------------------------------------ idempotency

    /**
     * Stripe retries until it gets a 2xx, so duplicate delivery is normal
     * operation rather than an attack. The second delivery must be a no-op.
     */
    public function test_duplicate_delivery_of_the_same_event_is_processed_once(): void
    {
        $payload = $this->event('evt_dup', 'customer.subscription.updated', ['id' => 'sub_1']);
        $signature = $this->sign($payload);

        $this->postWebhook($payload, $signature)->assertOk();
        $this->postWebhook($payload, $signature)->assertOk();
        $this->postWebhook($payload, $this->sign($payload))->assertOk();

        $this->assertSame(
            1,
            DB::table('payment_webhook_events')->where('event_id', 'evt_dup')->count(),
            'the same event id was recorded more than once'
        );
        $this->assertSame(
            1,
            (int) DB::table('payment_webhook_events')->where('event_id', 'evt_dup')->value('attempts'),
            'a duplicate delivery re-processed the event instead of short-circuiting'
        );
    }

    /**
     * An event id that arrives with different content than the one already
     * recorded is a tampering signal, not a retry.
     */
    public function test_a_reused_event_id_carrying_different_content_is_refused(): void
    {
        $first = $this->event('evt_reused', 'customer.subscription.updated', ['id' => 'sub_1']);
        $this->postWebhook($first, $this->sign($first))->assertOk();

        $second = $this->event('evt_reused', 'customer.subscription.updated', ['id' => 'sub_TAMPERED']);
        $this->postWebhook($second, $this->sign($second))->assertStatus(400);
    }

    // --------------------------------------------------- payment effects

    private function seedPayableInvoice(): Invoice
    {
        $student = User::factory()->student()->create();

        return Invoice::query()->create([
            'student_user_id' => $student->id,
            'invoice_no' => 'INV-WEBHOOK-1',
            'description' => 'Term fees',
            'amount' => 100.00,
            'paid_amount' => 0,
            'due_date' => now()->addDays(7),
            'status' => 'pending',
        ]);
    }

    /**
     * A failed payment must mark the transaction failed and must NOT create a
     * payment row or move the invoice.
     */
    public function test_a_failed_payment_event_records_the_failure_without_taking_money(): void
    {
        $invoice = $this->seedPayableInvoice();

        PaymentTransaction::query()->create([
            'invoice_id' => $invoice->id,
            'provider' => 'stripe',
            'provider_transaction_id' => 'pi_failed',
            'amount' => 100.00,
            'currency' => 'usd',
            'status' => 'pending',
        ]);

        $payload = $this->event('evt_failed', 'payment_intent.payment_failed', [
            'id' => 'pi_failed',
            'last_payment_error' => ['message' => 'Your card was declined.'],
        ]);

        $this->postWebhook($payload, $this->sign($payload))->assertOk();

        $this->assertSame('failed', PaymentTransaction::query()
            ->where('provider_transaction_id', 'pi_failed')->value('status'));

        $this->assertSame(0, Payment::query()->where('invoice_id', $invoice->id)->count());
        $this->assertSame('pending', $invoice->fresh()->status);
        $this->assertEquals(0.0, (float) $invoice->fresh()->paid_amount);
    }

    /**
     * An unknown event type must be acknowledged rather than retried forever,
     * but must not be treated as a payment.
     */
    public function test_an_unhandled_event_type_is_acknowledged_without_side_effects(): void
    {
        $invoice = $this->seedPayableInvoice();
        $payload = $this->event('evt_unhandled', 'invoice.finalized', ['id' => 'in_1']);

        $this->postWebhook($payload, $this->sign($payload))->assertOk();

        $this->assertSame(0, Payment::query()->where('invoice_id', $invoice->id)->count());
        $this->assertDatabaseHas('payment_webhook_events', [
            'event_id' => 'evt_unhandled',
            'status' => 'completed',
        ]);
    }

    // ------------------------------------------------- disabled integration

    /**
     * With payments switched off, the client cannot be constructed at all, so
     * no path reaches Stripe. Payments fail closed: a silent no-op could record
     * money that was never taken.
     */
    public function test_payments_fail_closed_when_the_integration_is_disabled(): void
    {
        config(['integrations.payments.enabled' => false]);

        $gate = app(IntegrationGate::class);
        $this->assertFalse($gate->enabled(IntegrationGate::PAYMENTS));
        $this->assertTrue($gate->failsClosed(IntegrationGate::PAYMENTS));

        $this->expectException(\RuntimeException::class);
        $gate->ensureAvailable(IntegrationGate::PAYMENTS);
    }

    public function test_an_enabled_but_unconfigured_payment_integration_is_an_error(): void
    {
        config([
            'integrations.payments.enabled' => true,
            'services.payment.stripe.webhook_secret' => null,
        ]);

        $gate = app(IntegrationGate::class);
        $this->assertFalse($gate->enabled(IntegrationGate::PAYMENTS));
        $this->assertStringContainsString(
            'STRIPE_WEBHOOK_SECRET',
            (string) $gate->missingRequirement(IntegrationGate::PAYMENTS)
        );

        $this->expectException(\RuntimeException::class);
        $gate->ensureAvailable(IntegrationGate::PAYMENTS);
    }

    /**
     * The signing secret must never be echoed into a response or a log line.
     */
    public function test_a_rejected_webhook_response_does_not_disclose_the_signing_secret(): void
    {
        $payload = $this->event('evt_leak', 'payment_intent.succeeded', ['id' => 'pi_1']);

        $body = $this->postWebhook($payload, 't='.time().',v1=deadbeef')->getContent();

        $this->assertStringNotContainsString(self::TEST_SIGNING_SECRET, (string) $body);
        $this->assertStringNotContainsString('whsec_', (string) $body);
    }
}
