<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

/**
 * Startup gate for platform-managed deployments (Railway, Fly, Render...).
 *
 * deploy/preflight.sh validates a `.env.prod` file before `docker compose up`,
 * but a platform injects environment variables at container start, so nothing
 * validated them there. This command runs from the container entrypoint and
 * refuses to boot a production instance that is configured unsafely.
 */
class PreflightEnvironment extends Command
{
    protected $signature = 'ops:preflight-env
        {--warn-only : Report problems without failing the process}';

    protected $description = 'Fail closed when production environment variables are unsafe or incomplete';

    /** @var list<string> */
    private array $errors = [];

    /** @var list<string> */
    private array $warnings = [];

    public function handle(): int
    {
        if (! app()->environment('production')) {
            $this->info('ops:preflight-env: non-production environment ('.app()->environment().'), checks skipped.');

            return self::SUCCESS;
        }

        $this->checkAppKey();
        $this->checkDebug();
        $this->checkUrlAndCookies();
        $this->checkCors();
        $this->checkDatabase();
        $this->checkConnectionPooling();
        $this->checkTrustedProxies();
        $this->checkStateStores();
        $this->checkUploads();
        $this->checkPaymentSecrets();

        foreach ($this->warnings as $warning) {
            $this->warn('⚠  '.$warning);
        }

        if ($this->errors === []) {
            $this->info('✅ ops:preflight-env passed ('.count($this->warnings).' warning(s)).');

            return self::SUCCESS;
        }

        foreach ($this->errors as $error) {
            $this->error('❌ '.$error);
        }

        if ($this->option('warn-only')) {
            $this->warn('--warn-only set: continuing despite '.count($this->errors).' error(s).');

            return self::SUCCESS;
        }

        $this->error('Preflight FAILED — refusing to start with an unsafe production configuration.');

        return self::FAILURE;
    }

    private function checkAppKey(): void
    {
        $key = (string) config('app.key');
        if ($key === '') {
            $this->errors[] = 'APP_KEY is not set. Encrypted auth cookies cannot be issued.';

            return;
        }
        // Base64 of 32 raw bytes for AES-256-CBC/GCM.
        $decoded = str_starts_with($key, 'base64:') ? base64_decode(substr($key, 7), true) : $key;
        if ($decoded === false || strlen((string) $decoded) < 32) {
            $this->errors[] = 'APP_KEY is too short for the configured cipher. Regenerate it with `php artisan key:generate --show`.';
        }
    }

    private function checkDebug(): void
    {
        // AppServiceProvider clamps app.debug to false in production and flags
        // that it had to; either signal means the platform variable is wrong.
        if (config('app.debug') || config('app.debug_forced_off')) {
            $this->errors[] = 'APP_DEBUG is true in production. It was forced off at runtime, but fix the environment variable.';
        }
    }

    private function checkUrlAndCookies(): void
    {
        $url = (string) config('app.url');
        if (! str_starts_with($url, 'https://')) {
            $this->errors[] = 'APP_URL must be an https:// origin in production (got "'.$url.'").';
        }

        if (! config('web-auth.secure')) {
            $this->errors[] = 'WEB_AUTH_COOKIE_SECURE must be true so auth cookies are never sent over plain HTTP.';
        }

        if (! config('session.secure')) {
            $this->errors[] = 'SESSION_SECURE_COOKIE must be true in production.';
        }

        $sameSite = strtolower((string) config('web-auth.same_site'));
        if (! in_array($sameSite, ['lax', 'strict', 'none'], true)) {
            $this->errors[] = 'WEB_AUTH_COOKIE_SAME_SITE must be one of lax, strict or none.';
        }
        if ($sameSite === 'none' && ! config('web-auth.secure')) {
            $this->errors[] = 'SameSite=None requires Secure cookies.';
        }
    }

    private function checkCors(): void
    {
        $origins = array_filter(array_map('trim', (array) config('cors.allowed_origins')));
        if ($origins === []) {
            $this->errors[] = 'CORS_ALLOWED_ORIGINS is empty; the browser client cannot call the API.';

            return;
        }

        foreach ($origins as $origin) {
            if ($origin === '*') {
                $this->errors[] = 'CORS_ALLOWED_ORIGINS contains "*", which is invalid with credentialed requests.';

                continue;
            }
            if (! preg_match('#^https://[^/]+$#', $origin)) {
                $this->errors[] = 'CORS origin "'.$origin.'" is not a bare https:// origin.';
            }
        }

        if (config('cors.allowed_origins_patterns') !== []) {
            $this->errors[] = 'CORS origin patterns must be empty in production.';
        }
    }

    private function checkDatabase(): void
    {
        $driver = (string) config('database.default');
        if ($driver === 'sqlite') {
            $this->errors[] = 'DB_CONNECTION=sqlite is not supported in production; use pgsql.';
        }
    }

    private function checkStateStores(): void
    {
        // `migrate --isolated` and every Cache::lock() call need a driver with
        // atomic locks. array/file leave concurrent deploys unserialized.
        $cache = (string) config('cache.default');
        if (in_array($cache, ['array', 'null'], true)) {
            $this->errors[] = 'CACHE_STORE="'.$cache.'" cannot hold locks; use redis or database.';
        }

        $queue = (string) config('queue.default');
        if ($queue === 'sync') {
            $this->warnings[] = 'QUEUE_CONNECTION=sync runs jobs inside the web request; notifications and exports will block users.';
        }

        $session = (string) config('session.driver');
        if ($session === 'array') {
            $this->warnings[] = 'SESSION_DRIVER=array keeps no session state across requests.';
        }

        $this->checkRedisKeyspace();
    }

    /**
     * Every Redis key is namespaced by a prefix that defaults to a slug of
     * APP_NAME. The web, worker and scheduler run as separate deployments, so
     * if their APP_NAME differs by even a character the worker polls a queue
     * nobody writes to: jobs accumulate, nothing is logged, no job is marked
     * failed, and the symptom is simply that mail and notifications stop.
     * Pinning REDIS_PREFIX explicitly removes the coupling to a display name.
     */
    private function checkRedisKeyspace(): void
    {
        $usesRedis = in_array('redis', [
            config('cache.default'),
            config('queue.default'),
            config('session.driver'),
        ], true);

        if (! $usesRedis) {
            return;
        }

        if (blank(env('REDIS_PREFIX'))) {
            $this->warnings[] = 'REDIS_PREFIX is not set, so the Redis keyspace is derived from APP_NAME ("'
                .config('app.name').'"). Every process role must then share that exact name or the queue worker '
                .'silently consumes a different queue. Set REDIS_PREFIX identically on the web, worker and '
                .'scheduler services.';
        }
    }

    private function checkUploads(): void
    {
        $disk = (string) config('filesystems.uploads_disk');
        $driver = (string) config('filesystems.disks.'.$disk.'.driver');

        if ($driver !== 'local') {
            return;
        }

        // A container filesystem does not survive a redeploy. Silently losing
        // every uploaded photo and document on the next release is not a
        // warning-level outcome, so this fails the boot unless the operator
        // states that a durable volume is mounted at storage/.
        if (filter_var(env('UPLOADS_LOCAL_PERSISTENT'), FILTER_VALIDATE_BOOLEAN)) {
            $this->warnings[] = 'Uploads disk "'.$disk.'" is local and UPLOADS_LOCAL_PERSISTENT=true. '
                .'A durable volume must be mounted at storage/ and included in backups.';

            return;
        }

        $this->errors[] = 'Uploads disk "'.$disk.'" is local, so uploads live on the container filesystem and are '
            .'destroyed by every redeploy. Set UPLOADS_DRIVER=s3 with a bucket, or mount a persistent volume and set '
            .'UPLOADS_LOCAL_PERSISTENT=true to acknowledge it.';
    }

    /**
     * The proxy headers decide whether the app believes it is on HTTPS and who
     * it thinks the client is. Trusting nothing breaks secure cookies and URL
     * generation; trusting the wrong thing lets a client spoof its address past
     * the rate limiter and into the audit log.
     */
    private function checkTrustedProxies(): void
    {
        $configured = trim((string) env('TRUSTED_PROXIES', '10.0.0.0/8,172.16.0.0/12,192.168.0.0/16'));

        if ($configured === '') {
            $this->errors[] = 'TRUSTED_PROXIES is empty. Behind a TLS-terminating edge the app would treat requests '
                .'as plain HTTP and emit insecure cookies and http:// URLs.';

            return;
        }

        if ($configured === '*') {
            // Correct on a platform whose containers have no public route, and
            // dangerous anywhere the app can be reached directly.
            $this->warnings[] = 'TRUSTED_PROXIES=* trusts X-Forwarded-* from any peer. This is only safe when the '
                .'container is reachable exclusively through the platform edge (Railway private networking).';

            return;
        }

        foreach (array_filter(array_map('trim', explode(',', $configured))) as $proxy) {
            $address = str_contains($proxy, '/') ? explode('/', $proxy)[0] : $proxy;
            if (filter_var($address, FILTER_VALIDATE_IP) === false) {
                $this->errors[] = 'TRUSTED_PROXIES entry "'.$proxy.'" is not an IP address or CIDR range. '
                    .'Hostname patterns are not evaluated by the proxy middleware and silently trust nothing.';
            }
        }
    }

    /**
     * php-fpm opens a PostgreSQL backend per request and a backend is an OS
     * process, so connection churn becomes the dominant database cost long
     * before max_connections is reached. A pooler is the fix.
     */
    private function checkConnectionPooling(): void
    {
        if (config('database.default') !== 'pgsql') {
            return;
        }

        $pooled = (string) (config('database.connections.pgsql.host') ?: '');
        $direct = (string) (config('database.connections.pgsql_direct.host') ?: '');

        if ($direct === '') {
            $this->errors[] = 'The pgsql_direct connection has no host. Migrations must have a route to PostgreSQL '
                .'that bypasses the pooler.';
        }

        if ($pooled !== '' && $pooled === $direct) {
            $this->warnings[] = 'Application traffic and migrations both target "'.$pooled.'". No connection pooler '
                .'appears to be in front of PostgreSQL; set DB_HOST to PgBouncer and DB_DIRECT_HOST to the database.';
        }
    }

    private function checkPaymentSecrets(): void
    {
        // The gateway is considered "in use" once a Stripe secret is present.
        // A deployment without one simply has no online-payment path, which is
        // a supported configuration (manual receipts still work).
        if (blank(config('services.payment.stripe.secret_key'))) {
            $this->warnings[] = 'STRIPE_SECRET_KEY is unset — online card payments are disabled for this deployment.';

            return;
        }

        if (blank(config('services.payment.stripe.webhook_secret'))) {
            $this->errors[] = 'STRIPE_SECRET_KEY is set but STRIPE_WEBHOOK_SECRET is missing; incoming webhooks cannot be signature-verified.';
        }
        if (str_starts_with((string) config('services.payment.stripe.secret_key'), 'sk_test_')) {
            $this->warnings[] = 'A Stripe test-mode secret key is configured in production.';
        }
    }
}
