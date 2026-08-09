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
    }

    private function checkUploads(): void
    {
        $disk = (string) config('filesystems.uploads_disk');
        $driver = (string) config('filesystems.disks.'.$disk.'.driver');
        if ($driver === 'local') {
            $this->warnings[] = 'Uploads disk "'.$disk.'" is local. On a platform with an ephemeral filesystem every '
                .'redeploy discards user uploads — set UPLOADS_DRIVER=s3 with a bucket, or mount a persistent volume.';
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
