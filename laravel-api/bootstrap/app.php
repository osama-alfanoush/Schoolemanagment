<?php

use App\Http\Middleware\AssignRequestId;
use App\Http\Middleware\EnsureAccountIsActive;
use App\Http\Middleware\EnsurePasswordChanged;
use App\Http\Middleware\EnsureTokenIsUsable;
use App\Http\Middleware\PermissionMiddleware;
use App\Http\Middleware\ResolveSchoolContext;
use App\Http\Middleware\RoleMiddleware;
use App\Http\Middleware\SecurityHeaders;
use App\Http\Middleware\VerifyWebCsrfToken;
use App\Http\Middleware\WebCookieAuthentication;
use App\Providers\AuthServiceProvider;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Routing\Middleware\ThrottleRequests;
use Illuminate\Validation\ValidationException;
use Laravel\Sanctum\Http\Middleware\CheckAbilities;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        // Stateless Bearer-token API: clients send Sanctum personal access tokens
        // in the Authorization header, not session cookies. statefulApi() is
        // intentionally NOT enabled — it would treat same-origin SPA requests as
        // "stateful" and apply session + CSRF validation that the token client
        // never satisfies, causing 419s on POST/PATCH/DELETE in production.

        // Laravel's withMiddleware() installs a default guest redirect of
        // `route('login')`. This application is API-only and has no such named
        // route, so every unauthenticated request that did not send
        // `Accept: application/json` (curl, uptime probes, crawlers, a mobile
        // client that forgot the header) blew up with RouteNotFoundException
        // and returned 500 plus a logged stack trace instead of a clean 401.
        // Returning null keeps the AuthenticationException redirect-free, and
        // the shouldRenderJsonWhen rule below renders it as JSON 401.
        $middleware->redirectGuestsTo(fn () => null);

        $middleware->alias([
            'role' => RoleMiddleware::class,
            'perm' => PermissionMiddleware::class,
            'school.context' => ResolveSchoolContext::class,
            'account.active' => EnsureAccountIsActive::class,
            'password.changed' => EnsurePasswordChanged::class,
            'token.usable' => EnsureTokenIsUsable::class,
            'abilities' => CheckAbilities::class,
            'security.headers' => SecurityHeaders::class,
            'request.id' => AssignRequestId::class,
            'throttle' => ThrottleRequests::class,
        ]);

        // Trusted proxies for HTTPS awareness behind load balancers
        $middleware->trustProxies(at: [
            '10.0.0.0/8',
            '172.16.0.0/12',
            '192.168.0.0/16',
            '*.fly.dev',
        ]);

        // Apply security headers to all API routes
        $middleware->api(prepend: [
            // First in the chain so that even a rejected request (rate limit,
            // CSRF failure, 401) is logged and answered with a correlation id.
            AssignRequestId::class,
            SecurityHeaders::class,
            VerifyWebCsrfToken::class,
            WebCookieAuthentication::class,
        ]);
    })
    ->withProviders([
        AuthServiceProvider::class,
    ])
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(function (Request $request) {
            return $request->is('api/*') || $request->expectsJson();
        });

        $exceptions->render(function (ValidationException $e, Request $request) {
            if ($request->is('api/*') || $request->expectsJson()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $e->errors(),
                ], 422);
            }
        });

        $exceptions->render(function (NotFoundHttpException $e, Request $request) {
            if ($request->is('api/*') || $request->expectsJson()) {
                return response()->json([
                    'message' => 'Resource not found',
                ], 404);
            }
        });

        $exceptions->render(function (HttpException $e, Request $request) {
            if ($e->getStatusCode() === 403 && ($request->is('api/*') || $request->expectsJson())) {
                return response()->json([
                    'message' => 'Forbidden',
                ], 403);
            }
        });
    })->create();
