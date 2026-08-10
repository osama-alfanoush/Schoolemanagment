<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Services\AlertDispatcher;
use App\Services\ErrorReporter;
use App\Services\IntegrationGate;
use App\Services\TelemetryScrubber;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use PHPUnit\Framework\Attributes\DataProvider;
use RuntimeException;
use Tests\TestCase;

/**
 * Telemetry leaves the building. An error report or an alert that carries a
 * pupil's name, a bearer token or a card number is a breach that happens to be
 * shaped like a debugging aid, so what these subsystems may emit is pinned.
 */
class TelemetryRedactionTest extends TestCase
{
    use RefreshDatabase;

    private function scrubber(): TelemetryScrubber
    {
        return app(TelemetryScrubber::class);
    }

    /**
     * @return array<string, array{0: string}>
     */
    public static function sensitiveKeys(): array
    {
        return [
            'password' => ['password'],
            'new password' => ['new_password'],
            'bearer token' => ['access_token'],
            'refresh token' => ['refresh_token'],
            'authorization header' => ['authorization'],
            'cookie' => ['cookie'],
            'csrf' => ['xsrf_token'],
            'mfa secret' => ['mfa_secret'],
            'recovery codes' => ['recovery_codes'],
            'card number' => ['card_number'],
            'cvv' => ['cvv'],
            'iban' => ['iban'],
            'student email' => ['email'],
            'phone' => ['phone'],
            'home address' => ['address'],
            'date of birth' => ['date_of_birth'],
            'admission number' => ['admission_no'],
            'medical notes' => ['medical_notes'],
            'guardian name' => ['guardian_name'],
            'stripe signature' => ['stripe_signature'],
        ];
    }

    #[DataProvider('sensitiveKeys')]
    public function test_sensitive_keys_are_removed_from_telemetry(string $key): void
    {
        $scrubbed = $this->scrubber()->scrub([$key => 'the-actual-value', 'safe' => 'kept']);

        $this->assertSame(TelemetryScrubber::PLACEHOLDER, $scrubbed[$key], "$key survived scrubbing");
        $this->assertSame('kept', $scrubbed['safe']);
    }

    /**
     * @return array<string, array{0: string}>
     */
    public static function sensitiveFreeText(): array
    {
        return [
            'stripe secret key' => ['SQL error near sk_live_51ABCdefGHIjklMNOpqrST'],
            'stripe webhook secret' => ['signature check used whsec_ABCdef123456789012345'],
            'aws access key' => ['denied for AKIAIOSFODNN7EXAMPLE'],
            'github token' => ['clone failed ghp_ABCdefGHIjklMNOpqrSTuvwXYZ0123456'],
            'jwt' => ['token eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIn0.dozjgNryP4J3jVmNHl0w5N_XgL0n3I9PlFUP0THsR8U'],
            'bearer header value' => ['Authorization: Bearer 4|aBcDeFgHiJkLmNoPqRsTuVwXyZ0123456789'],
            'sanctum plaintext token' => ['token 12|aBcDeFgHiJkLmNoPqRsTuVwXyZ0123456789abcd'],
            'card number' => ['charge failed for 4242 4242 4242 4242'],
            'student email' => ['could not notify ahmed.alfulani@school.test'],
        ];
    }

    /**
     * A credential in free text — an exception message, a query, a URL — has no
     * key name to match on, so patterns catch it instead.
     */
    #[DataProvider('sensitiveFreeText')]
    public function test_credentials_are_removed_from_free_text(string $text): void
    {
        $scrubbed = $this->scrubber()->scrubString($text);

        foreach (['sk_live_', 'whsec_', 'AKIAIOSFODNN7EXAMPLE', 'ghp_', 'eyJhbGciOi', 'Bearer 4|',
            '4242 4242 4242 4242', 'ahmed.alfulani@school.test'] as $needle) {
            $this->assertStringNotContainsString($needle, $scrubbed, "[$needle] survived in: $scrubbed");
        }
        $this->assertStringContainsString(TelemetryScrubber::PLACEHOLDER, $scrubbed);
    }

    public function test_a_url_keeps_its_path_but_loses_credential_query_parameters(): void
    {
        $scrubbed = $this->scrubber()->scrubUrl(
            'https://api.school.test/api/finance/invoices?token=abc123secret&page=2&email=parent@school.test'
        );

        $this->assertStringContainsString('/api/finance/invoices', $scrubbed, 'the path is what makes a report useful');
        $this->assertStringContainsString('page=2', $scrubbed);
        $this->assertStringNotContainsString('abc123secret', $scrubbed);
        $this->assertStringNotContainsString('parent@school.test', $scrubbed);
    }

    public function test_scrubbing_is_recursive_and_bounded(): void
    {
        $nested = ['a' => ['b' => ['c' => ['password' => 'secret', 'ok' => 'value']]]];
        $scrubbed = $this->scrubber()->scrub($nested);

        $this->assertSame(TelemetryScrubber::PLACEHOLDER, $scrubbed['a']['b']['c']['password']);
        $this->assertSame('value', $scrubbed['a']['b']['c']['ok']);

        // A pathologically deep payload must not turn reporting into an outage.
        $deep = [];
        $ref = &$deep;
        for ($i = 0; $i < 40; $i++) {
            $ref['next'] = [];
            $ref = &$ref['next'];
        }
        unset($ref);

        $this->assertIsArray($this->scrubber()->scrub($deep));
    }

    // ------------------------------------------------------ error reporting

    public function test_an_error_event_carries_environment_release_and_request_id(): void
    {
        config(['app.release' => 'abc1234', 'app.env' => 'staging']);

        $request = Request::create('/api/finance/invoices?token=leakme', 'GET');
        $request->headers->set('X-Request-Id', 'req-correlation-123');

        $event = app(ErrorReporter::class)->buildEvent(
            new RuntimeException('boom'),
            $request
        );

        $this->assertSame('staging', $event['environment']);
        $this->assertSame('abc1234', $event['release']);
        $this->assertSame('req-correlation-123', $event['request_id']);
        $this->assertSame(RuntimeException::class, $event['exception']['type']);
        $this->assertStringNotContainsString('leakme', json_encode($event, JSON_THROW_ON_ERROR));
    }

    public function test_an_error_event_never_carries_a_name_or_an_email(): void
    {
        $user = $this->loginAs('student');
        $request = Request::create('/api/student/dashboard', 'GET');
        $request->setUserResolver(fn () => $user);

        $encoded = json_encode(
            app(ErrorReporter::class)->buildEvent(new RuntimeException('failed'), $request),
            JSON_THROW_ON_ERROR
        );

        // Identity by id and role only.
        $this->assertStringContainsString('"id":'.$user->id, $encoded);
        $this->assertStringNotContainsString($user->email, $encoded);
        $this->assertStringNotContainsString($user->name, $encoded);
    }

    public function test_an_exception_message_containing_a_credential_is_scrubbed(): void
    {
        $event = app(ErrorReporter::class)->buildEvent(
            new RuntimeException('Stripe rejected key sk_live_51ABCdefGHIjklMNOpqrST'),
            Request::create('/api/webhooks/payment', 'POST')
        );

        $this->assertStringNotContainsString('sk_live_', json_encode($event, JSON_THROW_ON_ERROR));
    }

    public function test_error_reporting_is_disabled_by_default_and_falls_back_to_the_log(): void
    {
        $this->assertFalse(app(IntegrationGate::class)->enabled(IntegrationGate::ERROR_REPORTING));

        Http::fake();

        $channel = \Mockery::mock();
        $channel->shouldReceive('error')
            ->once()
            ->withArgs(fn (string $message, array $event) => str_contains($message, 'error-event:')
                && $event['release'] !== ''
                && $event['environment'] !== '');
        Log::shouldReceive('channel')->andReturn($channel);

        app(ErrorReporter::class)->report(new RuntimeException('local only'));

        // No provider configured, so nothing is posted to any third party; the
        // event still reaches the collected log stream.
        Http::assertNothingSent();
    }

    // ------------------------------------------------------------- alerting

    public function test_an_alert_is_always_logged_even_when_no_webhook_is_configured(): void
    {
        config(['alerting.channels.webhook_url' => null, 'alerting.channels.mail_to' => []]);

        // Log::spy() makes channel() return null, which the dispatcher then
        // calls log() on; mock the channel explicitly instead.
        $channel = \Mockery::mock();
        $channel->shouldReceive('log')
            ->once()
            ->withArgs(fn (string $level, string $message, array $context) => $level === 'critical'
                && str_contains($message, 'alert[queue/critical]')
                && $context['owner'] !== '');
        Log::shouldReceive('channel')->andReturn($channel);

        $result = app(AlertDispatcher::class)->send('queue', 'critical', 'Queue degraded', ['failed_jobs' => 12]);

        $this->assertContains('log', $result['delivered']);
        $this->assertSame([], $result['failed']);
    }

    public function test_alert_payloads_are_scrubbed_before_delivery(): void
    {
        Http::fake(['*' => Http::response(['ok' => true], 200)]);
        config(['alerting.channels.webhook_url' => 'https://alerts.example.test/hook']);

        app(AlertDispatcher::class)->send(
            'payments',
            'critical',
            'Webhook rejected with whsec_ABCdef123456789012345',
            ['card_number' => '4242424242424242', 'parent_email' => 'parent@school.test', 'count' => 3]
        );

        Http::assertSent(function ($request) {
            $body = json_encode($request->data(), JSON_THROW_ON_ERROR);

            $this->assertStringNotContainsString('whsec_ABCdef', $body);
            $this->assertStringNotContainsString('4242424242424242', $body);
            $this->assertStringNotContainsString('parent@school.test', $body);
            // Operational facts survive; that is the point of the alert.
            $this->assertStringContainsString('"count":3', $body);

            return true;
        });
    }

    public function test_a_webhook_delivery_failure_does_not_throw_and_is_recorded(): void
    {
        Http::fake(['*' => Http::response('nope', 500)]);
        config(['alerting.channels.webhook_url' => 'https://alerts.example.test/hook']);

        $result = app(AlertDispatcher::class)->send('queue', 'warning', 'Queue attention');

        // The monitor has done its job; a dead alerting tool must not take the
        // record of the incident with it.
        $this->assertContains('log', $result['delivered']);
        $this->assertContains('webhook', $result['failed']);
    }

    public function test_every_monitor_routes_to_a_named_owner(): void
    {
        $dispatcher = app(AlertDispatcher::class);

        foreach (['dependencies', 'queue', 'scheduler', 'database', 'redis', 'backup', 'payments'] as $monitor) {
            $owner = $dispatcher->ownerFor($monitor);

            $this->assertNotSame('', $owner, "$monitor has no owner");
            $this->assertNotSame('PLACEHOLDER-unrouted', $owner, "$monitor is not routed");
        }
    }
}
