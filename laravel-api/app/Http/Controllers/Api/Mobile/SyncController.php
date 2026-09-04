<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Resources\Mobile\DeltaPageResource;
use App\Http\Responses\ApiResponse;
use App\Services\Mobile\DeltaAudience;
use App\Services\Mobile\DeltaEntityRegistry;
use App\Services\Mobile\DeltaSyncService;
use App\Services\Mobile\InvalidDeltaCursor;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SyncController extends Controller
{
    public function __construct(
        private readonly DeltaEntityRegistry $registry,
        private readonly DeltaSyncService $delta,
    ) {}

    /**
     * Mobile delta sync.
     *
     * Returns everything that changed for the authenticated user since
     * `since`, plus tombstones for what was deleted, plus the cursor to
     * resume from. Omit `since` for a first full pull.
     *
     * The response is scoped entirely from the token: a parent sees only their
     * own children's records, a teacher only their assigned classes, a student
     * only themselves. `types` selects from what the role already allows and
     * can only narrow that set, never widen it.
     */
    public function delta(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'since' => ['nullable', 'string', 'max:4096'],
            'types' => ['nullable', 'string', 'max:512'],
            'limit' => ['nullable', 'integer', 'min:1', 'max:'.(int) config('mobile.delta.max_page_size', 500)],
        ]);

        $user = $request->user();
        // Server-side, from the resolved tenant context. Never from the client.
        $schoolId = (int) $request->attributes->get('school_id');

        $allowed = $this->registry->typesFor((string) $user->role);

        if ($allowed === []) {
            return ApiResponse::error('This role has no mobile sync feed.', 403);
        }

        $requested = $this->requestedTypes($validated['types'] ?? null, $allowed);

        if ($requested === null) {
            return ApiResponse::validationError([
                'types' => ['Unknown or unavailable entity type for this role.'],
            ]);
        }

        $audience = DeltaAudience::resolve($user, $schoolId);

        try {
            $page = $this->delta->page(
                $audience,
                $requested,
                $validated['since'] ?? null,
                (int) ($validated['limit'] ?? config('mobile.delta.page_size', 200)),
            );
        } catch (InvalidDeltaCursor $e) {
            // A cursor this server did not issue. The client's recovery is to
            // drop it and re-pull from the start, so say so rather than 500.
            return ApiResponse::error('Invalid sync cursor. Restart the sync without one.', 422);
        }

        return DeltaPageResource::make($page)->response();
    }

    /**
     * The entity types this call should read.
     *
     * @param  list<string>  $allowed
     * @return list<string>|null  Null when the client named a type it may not have.
     */
    private function requestedTypes(?string $types, array $allowed): ?array
    {
        if ($types === null || trim($types) === '') {
            return $allowed;
        }

        $requested = array_values(array_filter(array_map(
            'trim',
            explode(',', $types),
        ), fn (string $type): bool => $type !== ''));

        if ($requested === []) {
            return $allowed;
        }

        // Naming a type the role cannot read is a client bug, not a silent
        // no-op: answering 200 with an empty page would hide it for months.
        foreach ($requested as $type) {
            if (! in_array($type, $allowed, true)) {
                return null;
            }
        }

        return array_values(array_unique($requested));
    }
}
