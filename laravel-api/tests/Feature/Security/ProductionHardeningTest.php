<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Console\Commands\PreflightEnvironment;
use App\Providers\AppServiceProvider;
use PHPUnit\Framework\Attributes\DataProvider;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Output\BufferedOutput;
use Tests\TestCase;

/**
 * Guards the two controls that stop a mis-set platform variable from turning
 * into an information disclosure: debug output can never be emitted by a
 * production instance, and an unsafe production config refuses to boot.
 */
class ProductionHardeningTest extends TestCase
{
    private ?string $originalEnv = null;

    private string $lastOutput = '';

    protected function setUp(): void
    {
        parent::setUp();
        $this->originalEnv = $this->app['env'];
    }

    protected function tearDown(): void
    {
        if ($this->originalEnv !== null) {
            $this->app->instance('env', $this->originalEnv);
        }

        parent::tearDown();
    }

    /**
     * @param  array<string, mixed>  $config
     */
    private function runPreflight(array $config): int
    {
        // Application::environment() reads the container's "env" binding, not
        // config('app.env'), so both are set to model a real production boot.
        $this->app->instance('env', 'production');
        config($config + ['app.env' => 'production']);

        return $this->runCommand();
    }

    private function runCommand(): int
    {
        $command = new PreflightEnvironment;
        $command->setLaravel($this->app);

        $output = new BufferedOutput;
        $exit = $command->run(new ArrayInput([]), $output);
        $this->lastOutput = $output->fetch();

        return $exit;
    }

    /**
     * @return array<string, mixed>
     */
    private function safeConfig(): array
    {
        return [
            'app.key' => 'base64:'.base64_encode(str_repeat('k', 32)),
            'app.url' => 'https://api.example.test',
            'app.debug' => false,
            'app.debug_forced_off' => false,
            'web-auth.secure' => true,
            'web-auth.same_site' => 'lax',
            'session.secure' => true,
            'cors.allowed_origins' => ['https://app.example.test'],
            'cors.allowed_origins_patterns' => [],
            'database.default' => 'pgsql',
            'cache.default' => 'redis',
            'queue.default' => 'redis',
            'session.driver' => 'redis',
            'filesystems.uploads_disk' => 's3',
            'database.connections.pgsql.host' => 'pgbouncer',
            'database.connections.pgsql_direct.host' => 'postgres',
            'services.payment.stripe.secret_key' => null,
            'services.payment.stripe.webhook_secret' => null,
        ];
    }

    public function test_preflight_passes_on_a_safe_production_configuration(): void
    {
        $this->assertSame(0, $this->runPreflight($this->safeConfig()), $this->lastOutput);
    }

    public function test_preflight_is_a_no_op_outside_production(): void
    {
        $this->assertSame(0, $this->runCommand());
    }

    public function test_api_documentation_is_forbidden_in_production(): void
    {
        $this->app->instance('env', 'production');
        config(['app.env' => 'production']);

        $this->get('/docs/api.json')->assertForbidden();
    }

    /**
     * @return array<string, array{0: array<string, mixed>}>
     */
    public static function unsafeConfigurations(): array
    {
        return [
            'plain http app url' => [['app.url' => 'http://api.example.test']],
            'insecure auth cookie' => [['web-auth.secure' => false]],
            'insecure session cookie' => [['session.secure' => false]],
            'wildcard cors origin' => [['cors.allowed_origins' => ['*']]],
            'non https cors origin' => [['cors.allowed_origins' => ['http://app.example.test']]],
            'empty cors origins' => [['cors.allowed_origins' => []]],
            'localhost cors pattern' => [['cors.allowed_origins_patterns' => ['#^https?://localhost#']]],
            'sqlite database' => [['database.default' => 'sqlite']],
            'lockless cache store' => [['cache.default' => 'array']],
            'missing app key' => [['app.key' => '']],
            'short app key' => [['app.key' => 'base64:'.base64_encode('too-short')]],
            'same site none without secure' => [['web-auth.same_site' => 'none', 'web-auth.secure' => false]],
            'debug enabled' => [['app.debug' => true]],
            'debug forced off at boot' => [['app.debug_forced_off' => true]],
            'migrations have no direct database route' => [['database.connections.pgsql_direct.host' => '']],
            'card payments without a webhook secret' => [[
                'services.payment.stripe.secret_key' => 'stripe-key-is-present',
                'services.payment.stripe.webhook_secret' => null,
            ]],
        ];
    }

    /**
     * @param  array<string, mixed>  $overrides
     */
    #[DataProvider('unsafeConfigurations')]
    public function test_preflight_fails_closed_on_unsafe_configuration(array $overrides): void
    {
        $this->assertSame(1, $this->runPreflight($overrides + $this->safeConfig()));
    }

    /**
     * Uploads on a container filesystem are destroyed by the next redeploy.
     * That is data loss, not a warning, so it must stop the boot unless the
     * operator explicitly states a durable volume is mounted.
     */
    public function test_a_local_uploads_disk_fails_the_boot_by_default(): void
    {
        $exit = $this->runPreflight(['filesystems.uploads_disk' => 'local'] + $this->safeConfig());

        $this->assertSame(1, $exit);
        $this->assertStringContainsString('destroyed by every redeploy', $this->lastOutput);
    }

    public function test_a_local_uploads_disk_is_allowed_when_a_durable_volume_is_acknowledged(): void
    {
        putenv('UPLOADS_LOCAL_PERSISTENT=true');

        try {
            $exit = $this->runPreflight(['filesystems.uploads_disk' => 'local'] + $this->safeConfig());
        } finally {
            putenv('UPLOADS_LOCAL_PERSISTENT');
        }

        $this->assertSame(0, $exit, $this->lastOutput);
    }

    /**
     * @return array<string, array{0: string, 1: int}>
     */
    public static function trustedProxyValues(): array
    {
        return [
            'private ranges (compose)' => ['10.0.0.0/8,172.16.0.0/12,192.168.0.0/16', 0],
            'wildcard (railway)' => ['*', 0],
            'single host address' => ['100.64.0.1', 0],
            'empty' => ['', 1],
            'hostname pattern' => ['*.fly.dev', 1],
            'mixed valid and hostname' => ['10.0.0.0/8,*.example.com', 1],
        ];
    }

    /**
     * A hostname pattern such as the '*.fly.dev' this project used to carry is
     * never evaluated by the proxy middleware: it silently trusts nothing, and
     * the app then emits insecure cookies behind a TLS-terminating edge.
     */
    #[DataProvider('trustedProxyValues')]
    public function test_trusted_proxy_configuration_is_validated(string $value, int $expected): void
    {
        putenv('TRUSTED_PROXIES='.$value);

        try {
            $exit = $this->runPreflight($this->safeConfig());
        } finally {
            putenv('TRUSTED_PROXIES');
        }

        $this->assertSame($expected, $exit, $this->lastOutput);
    }

    /**
     * php-fpm opens a database backend per request. Without a pooler that
     * churn is the dominant database cost, and raising max_connections makes
     * it worse rather than better.
     */
    public function test_missing_connection_pooling_is_reported(): void
    {
        $exit = $this->runPreflight([
            'database.connections.pgsql.host' => 'postgres',
            'database.connections.pgsql_direct.host' => 'postgres',
        ] + $this->safeConfig());

        $this->assertSame(0, $exit, 'pooling is a warning, not a hard failure');
        $this->assertStringContainsString('No connection pooler', $this->lastOutput);
    }

    /**
     * APP_DEBUG=true in production must not survive as an effective setting;
     * AppServiceProvider::register forces it off before the exception handler
     * can render a stack trace.
     */
    public function test_app_debug_is_forced_off_when_registering_in_production(): void
    {
        $this->app->instance('env', 'production');
        config(['app.env' => 'production', 'app.debug' => true]);

        (new AppServiceProvider($this->app))->register();

        $this->assertFalse(config('app.debug'));
    }

    public function test_app_debug_is_left_alone_outside_production(): void
    {
        config(['app.debug' => true]);

        (new AppServiceProvider($this->app))->register();

        $this->assertTrue(config('app.debug'));
    }

    /**
     * Laravel's default guest redirect points at a named `login` route this
     * API-only app does not have. Without an explicit null redirect, every
     * unauthenticated request that omitted `Accept: application/json` raised
     * RouteNotFoundException and returned 500 with a logged stack trace
     * instead of a 401 — on every protected endpoint.
     *
     * @return list<array{0: string, 1: string}>
     */
    public static function protectedEndpoints(): array
    {
        return [
            ['GET', '/api/auth/me'],
            ['GET', '/api/health'],
            ['GET', '/api/admin/users'],
            ['GET', '/api/finance/invoices'],
            ['GET', '/api/teacher/classes'],
            ['GET', '/api/parent/children'],
        ];
    }

    #[DataProvider('protectedEndpoints')]
    public function test_unauthenticated_requests_without_a_json_accept_header_return_401(string $method, string $uri): void
    {
        // Deliberately NOT using getJson(): the bug only appeared when the
        // client did not advertise that it expects JSON.
        $response = $this->call($method, $uri, [], [], [], ['HTTP_ACCEPT' => '*/*']);

        $this->assertSame(401, $response->getStatusCode(), $uri.' returned '.$response->getStatusCode());
        $this->assertSame('Unauthenticated.', $response->json('message'));
    }

    public function test_unauthenticated_requests_with_a_json_accept_header_return_401(): void
    {
        $this->getJson('/api/auth/me')->assertStatus(401);
    }

    /**
     * Error responses must not leak internals to API clients.
     */
    public function test_not_found_responses_expose_no_internal_detail(): void
    {
        $this->getJson('/api/does-not-exist')
            ->assertStatus(404)
            ->assertExactJson(['message' => 'Resource not found']);
    }
}
