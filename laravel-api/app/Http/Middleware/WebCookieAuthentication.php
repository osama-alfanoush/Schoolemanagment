<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Contracts\Encryption\DecryptException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Symfony\Component\HttpFoundation\Cookie;
use Symfony\Component\HttpFoundation\Response;

class WebCookieAuthentication
{
    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->bearerToken()) {
            $cookieName = $request->is('api/auth/refresh')
                ? config('web-auth.refresh_cookie')
                : config('web-auth.access_cookie');
            $encryptedToken = $request->cookie($cookieName);

            if (is_string($encryptedToken) && $encryptedToken !== '') {
                try {
                    $request->headers->set(
                        'Authorization',
                        'Bearer '.Crypt::decryptString($encryptedToken)
                    );
                    $request->attributes->set('web_cookie_auth', true);
                } catch (DecryptException) {
                    // Invalid cookies fall through to Sanctum's normal JSON 401.
                }
            }
        }

        $response = $next($request);

        if ($response->getStatusCode() === 401 && $this->isCookieClient($request)) {
            $response->headers->setCookie($this->expiredCookie(config('web-auth.access_cookie'), '/api'));
            $response->headers->setCookie($this->expiredCookie(config('web-auth.refresh_cookie'), '/api/auth/refresh'));
        }

        return $response;
    }

    private function isCookieClient(Request $request): bool
    {
        return $request->header('X-Auth-Mode') === 'cookie'
            || $request->hasCookie(config('web-auth.access_cookie'))
            || $request->hasCookie(config('web-auth.refresh_cookie'));
    }

    private function expiredCookie(string $name, string $path): Cookie
    {
        return new Cookie(
            $name,
            '',
            1,
            $path,
            config('web-auth.domain'),
            (bool) config('web-auth.secure'),
            true,
            false,
            config('web-auth.same_site'),
        );
    }
}
