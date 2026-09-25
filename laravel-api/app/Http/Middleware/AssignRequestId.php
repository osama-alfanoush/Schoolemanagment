<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

/**
 * Correlation ID for every request.
 *
 * Without this, a 500 in the API logs cannot be tied to the browser request the
 * user complained about, nor to the queued job it spawned. The id is:
 *   - taken from an inbound X-Request-Id when a trusted proxy already assigned
 *     one (so a single id spans edge → app), otherwise generated;
 *   - pushed into the log context so every line emitted during the request
 *     carries it, including framework and exception logs;
 *   - echoed back on the response so support can quote it from a screenshot.
 *
 * Only the id, the authenticated user id and the tenant are added. Never any
 * request body, header, cookie or student personal data — logs and any error
 * reporter downstream must stay free of that.
 */
class AssignRequestId
{
    public const HEADER = 'X-Request-Id';

    /** An inbound id is only trusted if it looks like an id we would mint. */
    private const SAFE_ID = '/^[A-Za-z0-9._-]{8,128}$/';

    public function handle(Request $request, Closure $next): Response
    {
        $inbound = (string) $request->headers->get(self::HEADER, '');
        $requestId = preg_match(self::SAFE_ID, $inbound) === 1
            ? $inbound
            : (string) Str::uuid();

        $request->headers->set(self::HEADER, $requestId);
        $request->attributes->set('request_id', $requestId);

        Log::shareContext([
            'request_id' => $requestId,
            'release' => (string) config('app.release'),
        ]);

        $response = $next($request);
        $response->headers->set(self::HEADER, $requestId);

        return $response;
    }
}
