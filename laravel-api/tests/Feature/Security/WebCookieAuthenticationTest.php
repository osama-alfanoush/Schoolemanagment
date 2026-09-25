<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class WebCookieAuthenticationTest extends TestCase
{
    use RefreshDatabase;

    public function test_web_login_uses_http_only_cookies_without_returning_tokens(): void
    {
        $user = User::factory()->create([
            'email' => 'cookie-user@school.test',
            'password' => bcrypt('Password123'),
            'is_active' => true,
        ]);

        $csrfToken = $this->csrfToken();

        $login = $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrfToken)
            ->withHeaders([
                'X-Auth-Mode' => 'cookie',
                'X-XSRF-TOKEN' => $csrfToken,
            ])->postJson('/api/auth/login', [
                'email' => $user->email,
                'password' => 'Password123',
            ]);

        $login->assertOk()
            ->assertJsonMissing(['access_token'])
            ->assertJsonMissing(['refresh_token'])
            ->assertCookie(config('web-auth.access_cookie'))
            ->assertCookie(config('web-auth.refresh_cookie'));

        $this->assertTrue($login->getCookie(config('web-auth.access_cookie'), false)->isHttpOnly());
        $this->assertTrue($login->getCookie(config('web-auth.refresh_cookie'), false)->isHttpOnly());

        $accessCookie = $login->getCookie(config('web-auth.access_cookie'), false)->getValue();
        $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.access_cookie'), $accessCookie)
            ->getJson('/api/auth/me')
            ->assertOk()
            ->assertJsonPath('user.id', $user->id);
    }

    public function test_cookie_refresh_rotates_cookies_without_exposing_tokens(): void
    {
        $user = User::factory()->create([
            'email' => 'refresh-cookie@school.test',
            'password' => bcrypt('Password123'),
            'is_active' => true,
        ]);
        $csrfToken = $this->csrfToken();
        $login = $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrfToken)
            ->withHeaders(['X-Auth-Mode' => 'cookie', 'X-XSRF-TOKEN' => $csrfToken])
            ->postJson('/api/auth/login', ['email' => $user->email, 'password' => 'Password123']);
        $refreshCookie = $login->getCookie(config('web-auth.refresh_cookie'), false)->getValue();

        $refresh = $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrfToken)
            ->withUnencryptedCookie(config('web-auth.refresh_cookie'), $refreshCookie)
            ->withHeaders(['X-Auth-Mode' => 'cookie', 'X-XSRF-TOKEN' => $csrfToken])
            ->postJson('/api/auth/refresh');

        $refresh->assertOk()
            ->assertJsonMissing(['access_token'])
            ->assertJsonMissing(['refresh_token'])
            ->assertCookie(config('web-auth.access_cookie'))
            ->assertCookie(config('web-auth.refresh_cookie'));
    }

    public function test_web_logout_revokes_the_session_and_expires_auth_cookies(): void
    {
        $user = User::factory()->create([
            'email' => 'logout-cookie@school.test',
            'password' => bcrypt('Password123'),
            'is_active' => true,
        ]);
        $csrfToken = $this->csrfToken();
        $login = $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrfToken)
            ->withHeaders(['X-Auth-Mode' => 'cookie', 'X-XSRF-TOKEN' => $csrfToken])
            ->postJson('/api/auth/login', ['email' => $user->email, 'password' => 'Password123'])
            ->assertOk();
        $accessCookie = $login->getCookie(config('web-auth.access_cookie'), false)->getValue();

        $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.csrf_cookie'), $csrfToken)
            ->withUnencryptedCookie(config('web-auth.access_cookie'), $accessCookie)
            ->withHeaders(['X-Auth-Mode' => 'cookie', 'X-XSRF-TOKEN' => $csrfToken])
            ->postJson('/api/auth/logout')
            ->assertOk()
            ->assertCookieExpired(config('web-auth.access_cookie'))
            ->assertCookieExpired(config('web-auth.refresh_cookie'));

        $this->assertDatabaseMissing('personal_access_tokens', [
            'tokenable_type' => User::class,
            'tokenable_id' => $user->id,
        ]);
        // The test application persists guard instances between synthetic
        // requests; a real HTTP request does not. Clear that cached principal
        // before proving the revoked cookie cannot authenticate again.
        $this->app['auth']->forgetGuards();

        $this->withCredentials()
            ->withUnencryptedCookie(config('web-auth.access_cookie'), $accessCookie)
            ->getJson('/api/auth/me')
            ->assertUnauthorized();
    }

    public function test_cookie_mode_rejects_state_changes_without_csrf_token(): void
    {
        User::factory()->create([
            'email' => 'csrf-user@school.test',
            'password' => bcrypt('Password123'),
            'is_active' => true,
        ]);

        $this->withHeader('X-Auth-Mode', 'cookie')
            ->postJson('/api/auth/login', [
                'email' => 'csrf-user@school.test',
                'password' => 'Password123',
            ])
            ->assertStatus(419);
    }

    public function test_mobile_login_contract_still_returns_bearer_tokens(): void
    {
        $user = User::factory()->create([
            'email' => 'mobile-user@school.test',
            'password' => bcrypt('Password123'),
            'is_active' => true,
        ]);

        $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'Password123',
            'device_name' => 'Android',
        ])->assertOk()->assertJsonStructure(['access_token', 'refresh_token']);
    }

    private function csrfToken(): string
    {
        $response = $this->getJson('/api/auth/csrf-cookie')->assertOk();
        $response->assertCookie(config('web-auth.csrf_cookie'));

        return (string) $response->json('csrf_token');
    }
}
