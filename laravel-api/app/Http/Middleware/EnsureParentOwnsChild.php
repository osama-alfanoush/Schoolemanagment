<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Ensures the authenticated parent user has a relationship with the child
 * referenced by the {id} or {studentId} route parameter.
 *
 * This prevents IDOR attacks where a parent could access another family's
 * child data by guessing student IDs.
 */
class EnsureParentOwnsChild
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (!$user || $user->role !== 'parent') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // Support both {id} and {studentId} route parameter names
        $childId = $request->route('id') ?? $request->route('studentId');

        if ($childId && !$user->children()->where('users.id', (int) $childId)->exists()) {
            return response()->json(['message' => 'You do not have access to this student.'], 403);
        }

        return $next($request);
    }
}
