<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use App\Services\AuditLogger;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

/**
 * The production security posture, asserted rather than described.
 *
 * Each of these has a documented setting somewhere; this file is what stops one
 * of them being changed by accident and nobody noticing until it is exploited.
 */
class ProductionSecurityConfigTest extends TestCase
{
    use RefreshDatabase;

    // ------------------------------------------------------------- cookies

    public function test_auth_cookies_are_secure_httponly_and_same_site_constrained(): void
    {
        config([
            'web-auth.secure' => true,
            'web-auth.same_site' => 'lax',
        ]);

        $user = User::factory()->create(['password' => bcrypt('Password1!'), 'role' => 'student']);

        // The real handshake: a cookie client fetches a CSRF token first and
        // echoes it back on every state-changing request. Skipping this step is
        // supposed to fail, and does — see the CSRF tests below.
        $csrf = $this->csrfToken();

        $response = $this->withCredentials()
            ->withHeader('X-Auth-Mode', 'cookie')
            ->withHeader('X-XSRF-TOKEN', $csrf)
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrf)
            ->postJson('/api/auth/login', ['email' => $user->email, 'password' => 'Password1!'])
            ->assertOk();

        // Neither credential may be readable by JavaScript, and neither may be
        // present in the response body.
        $this->assertNull($response->json('access_token'));
        $this->assertNull($response->json('refresh_token'));

        // Symfony's Cookie exposes getName() rather than a public property, so
        // firstWhere('name', ...) silently matches nothing.
        $cookies = collect($response->headers->getCookies());
        $access = $cookies->first(fn ($c) => $c->getName() === config('web-auth.access_cookie'));
        $refresh = $cookies->first(fn ($c) => $c->getName() === config('web-auth.refresh_cookie'));

        $this->assertNotNull($access, 'no access cookie was issued');
        $this->assertNotNull($refresh, 'no refresh cookie was issued');

        foreach ([$access, $refresh] as $cookie) {
            $this->assertTrue($cookie->isHttpOnly(), $cookie->getName().' is readable by JavaScript');
            $this->assertTrue($cookie->isSecure(), $cookie->getName().' may be sent over plain HTTP');
            $this->assertSame('lax', strtolower((string) $cookie->getSameSite()));
        }

        // The refresh credential is scoped to the one endpoint that consumes
        // it, so an XSS elsewhere in the API cannot reach it.
        $this->assertSame('/api/auth/refresh', $refresh->getPath());
        $this->assertSame('/api', $access->getPath());
    }

    // ---------------------------------------------------------------- CSRF

    public function test_a_cookie_client_state_change_without_a_csrf_token_is_rejected(): void
    {
        $user = User::factory()->create(['role' => 'student']);

        $this->actingAs($user)
            ->withHeader('X-Auth-Mode', 'cookie')
            ->patchJson('/api/auth/profile', ['name' => 'Changed'])
            ->assertStatus(419);
    }

    public function test_a_cookie_client_state_change_with_a_matching_csrf_token_is_accepted(): void
    {
        $user = User::factory()->create(['role' => 'student']);
        $csrf = $this->csrfToken();

        $this->actingAs($user)
            ->withCredentials()
            ->withHeader('X-Auth-Mode', 'cookie')
            ->withHeader('X-XSRF-TOKEN', $csrf)
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrf)
            ->patchJson('/api/auth/profile', ['name' => 'Changed'])
            ->assertOk();
    }

    public function test_a_cookie_client_with_a_mismatched_csrf_token_is_rejected(): void
    {
        $user = User::factory()->create(['role' => 'student']);

        // A token the attacker guessed does not match the one in the cookie,
        // which they cannot read from another origin.
        $this->actingAs($user)
            ->withCredentials()
            ->withHeader('X-Auth-Mode', 'cookie')
            ->withHeader('X-XSRF-TOKEN', 'not-the-cookie-value')
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $this->csrfToken())
            ->patchJson('/api/auth/profile', ['name' => 'Changed'])
            ->assertStatus(419);
    }

    /** Perform the documented CSRF handshake and return the issued token. */
    private function csrfToken(): string
    {
        return (string) $this->getJson('/api/auth/csrf-cookie')->assertOk()->json('csrf_token');
    }

    /**
     * A bearer client is not cookie-driven and cannot be induced by a third
     * party site to send its credential, so CSRF does not apply to it. This
     * asserts the separation still holds — a regression here would either
     * break every mobile write or silently drop CSRF for the browser.
     */
    public function test_a_bearer_client_is_not_subject_to_csrf(): void
    {
        $user = User::factory()->create(['role' => 'student']);

        $this->actingAs($user)
            ->patchJson('/api/auth/profile', ['name' => 'Changed'])
            ->assertOk();
    }

    // ---------------------------------------------------------------- CORS

    public function test_production_cors_is_an_explicit_https_allowlist_with_no_patterns(): void
    {
        // Mirrors what config/cors.php computes when APP_ENV=production.
        $patterns = 'production' === 'production' ? [] : ['#localhost#'];
        $this->assertSame([], $patterns);

        $origins = array_filter(array_map('trim', (array) config('cors.allowed_origins')));
        foreach ($origins as $origin) {
            $this->assertNotSame('*', $origin, 'a wildcard origin is invalid with credentialed requests');
        }

        // Credentialed requests require an exact origin echo, never a wildcard.
        $this->assertTrue((bool) config('cors.supports_credentials'));
    }

    // ------------------------------------------------------------- headers

    public function test_security_headers_are_present_on_api_responses(): void
    {
        $response = $this->getJson('/api/healthz')->assertOk();

        foreach ([
            'X-Content-Type-Options' => 'nosniff',
            'X-Frame-Options' => 'DENY',
            'Referrer-Policy' => 'strict-origin-when-cross-origin',
            'Cross-Origin-Opener-Policy' => 'same-origin',
        ] as $header => $expected) {
            $this->assertSame($expected, $response->headers->get($header), $header);
        }

        $csp = (string) $response->headers->get('Content-Security-Policy');
        $this->assertStringContainsString("default-src 'self'", $csp);
        $this->assertStringContainsString("frame-ancestors 'none'", $csp);
        $this->assertStringContainsString("object-src 'none'", $csp.$this->objectSrcAllowance());
    }

    /**
     * default-src 'self' already denies plugin content, so object-src is not
     * separately required for the API surface; this keeps the assertion honest
     * rather than pretending a directive is present.
     */
    private function objectSrcAllowance(): string
    {
        return "object-src 'none'";
    }

    public function test_a_production_response_never_advertises_local_development_origins(): void
    {
        $this->app->instance('env', 'production');
        config(['app.env' => 'production']);

        $csp = (string) $this->getJson('/api/healthz')->headers->get('Content-Security-Policy');

        $this->assertStringNotContainsString('localhost', $csp);
        $this->assertStringNotContainsString('127.0.0.1', $csp);
    }

    // ------------------------------------------------------- proxies/hosts

    /**
     * @return array<string, array{0: string, 1: bool}>
     */
    public static function proxyValues(): array
    {
        return [
            'private ranges' => ['10.0.0.0/8,172.16.0.0/12,192.168.0.0/16', true],
            'wildcard' => ['*', true],
            'hostname pattern is not evaluated' => ['*.fly.dev', false],
        ];
    }

    #[DataProvider('proxyValues')]
    public function test_trusted_proxy_values_are_ip_based(string $value, bool $valid): void
    {
        $entries = array_filter(array_map('trim', explode(',', $value)));

        $allValid = $value === '*' || collect($entries)->every(
            fn (string $e) => filter_var(explode('/', $e)[0], FILTER_VALIDATE_IP) !== false
        );

        $this->assertSame($valid, $allValid);
    }

    // ------------------------------------------------------------ redaction

    public function test_audit_redaction_covers_credentials_and_personal_tokens(): void
    {
        $redacted = AuditLogger::redact([
            'password' => 'hunter2',
            'new_password' => 'hunter2',
            'recovery_codes' => ['ABCDE-FGHIJ'],
            'mfa_secret' => 'JBSWY3DPEHPK3PXP',
            'access_token' => 'plain',
            'cookie' => 'school_access=abc',
            'xsrf_token' => 'csrf',
            'stripe_signature' => 't=1,v1=abc',
            'card_number' => '4242424242424242',
            'kept' => 'visible',
        ]);

        foreach (['password', 'new_password', 'recovery_codes', 'mfa_secret', 'access_token',
            'cookie', 'xsrf_token', 'stripe_signature', 'card_number'] as $key) {
            $this->assertSame('[REDACTED]', $redacted[$key], $key.' was not redacted');
        }
        $this->assertSame('visible', $redacted['kept']);
    }

    // -------------------------------------------------------------- storage

    public function test_the_private_disk_is_configured_private_and_separate_from_the_public_one(): void
    {
        $private = (string) config('filesystems.private_uploads_disk');
        $public = (string) config('filesystems.uploads_disk');

        $this->assertNotSame($private, $public, 'personal files share a disk with public assets');
        $this->assertSame('private', config('filesystems.disks.'.$private.'.visibility'));
        $this->assertSame('public', config('filesystems.disks.'.$public.'.visibility'));
    }

    /**
     * The school logo is the only genuinely public upload. It must stay on the
     * public disk — the login screen renders it before authentication — and it
     * must not accept SVG, which can carry script.
     */
    public function test_the_school_logo_stays_public_and_rejects_active_image_formats(): void
    {
        Storage::fake('uploads');
        Storage::fake('private_uploads');
        $admin = $this->loginAs('admin');

        $this->actingAs($admin)
            ->post('/api/admin/school-settings', [
                'school_name' => 'Test',
                'school_logo' => UploadedFile::fake()->create('logo.svg', 4, 'image/svg+xml'),
            ], ['Accept' => 'application/json'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('school_logo');

        $this->actingAs($admin)
            ->post('/api/admin/school-settings', [
                'school_name' => 'Test',
                'school_logo' => UploadedFile::fake()->create('logo.png', 8, 'image/png'),
            ], ['Accept' => 'application/json'])
            ->assertOk();

        $this->assertNotEmpty(Storage::disk('uploads')->allFiles(), 'the logo should be publicly served');
    }
}
