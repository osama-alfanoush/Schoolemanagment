<?php

namespace App\Http\Middleware;

use App\Services\CurrentSchool;
use App\Services\SchoolContext;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

final class ResolveSchoolContext
{
    public function __construct(
        private SchoolContext $schools,
        private CurrentSchool $currentSchool,
    ) {}

    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();
        if (! $user) {
            return $next($request);
        }

        $schoolId = $this->schools->forUser($user);
        $this->currentSchool->set($schoolId);
        $request->attributes->set('school_id', $schoolId);

        try {
            return $next($request);
        } finally {
            $this->currentSchool->clear();
        }
    }
}
