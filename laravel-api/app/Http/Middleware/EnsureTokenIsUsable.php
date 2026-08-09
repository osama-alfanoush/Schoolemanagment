<?php

namespace App\Http\Middleware;

use App\Models\PersonalAccessToken;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureTokenIsUsable
{
    public function handle(Request $request, Closure $next, string $requiredAbility = 'access'): Response
    {
        $token = $request->user()?->currentAccessToken();

        if ($token instanceof PersonalAccessToken) {
            if ($token->revoked_at !== null) {
                return response()->json(['message' => 'Unauthenticated.'], 401);
            }

            if (! $token->can($requiredAbility)) {
                return response()->json(['message' => 'Forbidden'], 403);
            }
        }

        return $next($request);
    }
}
