<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class VerifyWebCsrfToken
{
    /** @var list<string> */
    private array $safeMethods = ['GET', 'HEAD', 'OPTIONS'];

    public function handle(Request $request, Closure $next): Response
    {
        if (in_array($request->method(), $this->safeMethods, true) || ! $this->isCookieClient($request)) {
            return $next($request);
        }

        $cookie = $request->cookie(config('web-auth.csrf_cookie'));
        $header = $request->header('X-XSRF-TOKEN');

        if (! is_string($cookie) || ! is_string($header) || ! hash_equals($cookie, $header)) {
            return response()->json(['message' => 'CSRF token mismatch.'], 419);
        }

        return $next($request);
    }

    private function isCookieClient(Request $request): bool
    {
        return $request->header('X-Auth-Mode') === 'cookie'
            || $request->hasCookie(config('web-auth.access_cookie'))
            || $request->hasCookie(config('web-auth.refresh_cookie'));
    }
}
