<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsurePasswordChanged
{
    private const ALLOWED_ROUTES = [
        'api/auth/me',
        'api/auth/logout',
        'api/auth/change-password',
    ];

    public function handle(Request $request, Closure $next): Response
    {
        if ($request->user()?->must_change_password
            && ! in_array($request->path(), self::ALLOWED_ROUTES, true)) {
            return response()->json([
                'message' => 'Password change required.',
                'code' => 'PASSWORD_CHANGE_REQUIRED',
            ], 403);
        }

        return $next($request);
    }
}
