<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Models\User;
use App\Services\Mobile\MobileBootstrapService;
use App\Services\Mobile\ParentHomeService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ParentHomeController extends Controller
{
    public function __construct(
        private readonly MobileBootstrapService $bootstrap,
        private readonly ParentHomeService $home,
    ) {}

    /**
     * Everything the app needs before its first screen.
     *
     * One call rather than five, because five on a cold start over 3G is a
     * home screen that assembles itself in stages while a parent watches.
     *
     * Answers 304 when the client's copy is still current.
     */
    public function bootstrap(Request $request): JsonResponse
    {
        $user = $request->user();
        // Server-side, from the resolved tenant context. Never from the client.
        $schoolId = (int) $request->attributes->get('school_id');

        return CachedPayload::respond(
            $request,
            $this->bootstrap->forUser($user, $schoolId),
        );
    }

    /**
     * The parent home screen: one card's worth of data per child.
     */
    public function home(Request $request): JsonResponse
    {
        $user = $request->user();
        $schoolId = (int) $request->attributes->get('school_id');

        return CachedPayload::respond(
            $request,
            $this->home->home($user, $this->childIdsOf($user, $schoolId), $schoolId),
        );
    }

    /**
     * One child in detail.
     *
     * `EnsureParentOwnsChild` has already refused anyone else's child by the
     * time this runs. The ownership check is repeated here anyway: this method
     * is one route registration away from being reachable without that
     * middleware, and the cost of the second check is one array lookup.
     */
    public function childOverview(Request $request, int $id): JsonResponse
    {
        $user = $request->user();
        $schoolId = (int) $request->attributes->get('school_id');
        $childIds = $this->childIdsOf($user, $schoolId);

        if (! in_array($id, $childIds, true)) {
            return ApiResponse::error('You do not have access to this student.', 403);
        }

        $payload = $this->home->home($user, [$id], $schoolId);
        $child = $payload['children'][0] ?? null;

        if ($child === null) {
            return ApiResponse::notFound('Student not found.');
        }

        return CachedPayload::respond($request, $child);
    }

    /**
     * The children this guardian is linked to, in this school.
     *
     * Read from the school-scoped pivot rather than from a request parameter,
     * so nothing a client sends can widen it.
     *
     * @return list<int>
     */
    private function childIdsOf(User $user, int $schoolId): array
    {
        return DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->where('parent_user_id', $user->id)
            ->pluck('student_user_id')
            ->map(static fn ($id): int => (int) $id)
            ->all();
    }
}
