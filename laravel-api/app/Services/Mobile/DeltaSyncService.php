<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\SyncTombstone;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * Builds one page of the mobile delta feed.
 *
 * Two properties matter more than anything else here:
 *
 *  - **Scope comes from the token.** Nothing in the request narrows or widens
 *    what a caller sees. `types` picks from what the role already allows and
 *    can only ever subtract.
 *  - **The cursor never runs ahead of the data.** A stream's position advances
 *    only over rows that are actually in the page being returned, so a client
 *    that drops the response and retries gets the same rows again rather than
 *    skipping them.
 */
final class DeltaSyncService
{
    public function __construct(private readonly DeltaEntityRegistry $registry) {}

    /**
     * @param  list<string>  $types
     * @return array{changes: list<array<string, mixed>>, next_cursor: string, has_more: bool, types: list<string>}
     */
    public function page(DeltaAudience $audience, array $types, ?string $since, int $limit): array
    {
        $cursor = DeltaCursor::decode($since, $audience->user->id, $audience->schoolId);

        sort($types);

        $changes = [];
        $hasMore = false;

        foreach ($types as $type) {
            $definition = $this->registry->find($type);

            if ($definition === null || ! $definition->readableBy($audience->role)) {
                continue;
            }

            $remaining = $limit - count($changes);
            if ($remaining <= 0) {
                $hasMore = true;
                break;
            }

            [$upserts, $moreUpserts, $cursor] = $this->upserts($definition, $audience, $cursor, $remaining);
            $changes = [...$changes, ...$upserts];

            if ($moreUpserts) {
                $hasMore = true;

                break;
            }

            $remaining = $limit - count($changes);
            if ($remaining <= 0) {
                $hasMore = true;
                break;
            }

            [$deletes, $moreDeletes, $cursor] = $this->tombstones($definition, $audience, $cursor, $remaining);
            $changes = [...$changes, ...$deletes];

            if ($moreDeletes) {
                $hasMore = true;

                break;
            }
        }

        return [
            'changes' => $changes,
            'next_cursor' => $cursor->encode(),
            'has_more' => $hasMore,
            'types' => array_values($types),
        ];
    }

    /**
     * @return array{0: list<array<string, mixed>>, 1: bool, 2: DeltaCursor}
     */
    private function upserts(
        DeltaEntityDefinition $definition,
        DeltaAudience $audience,
        DeltaCursor $cursor,
        int $remaining,
    ): array {
        $query = $definition->scopedQuery($audience);

        if ($query === null) {
            return [[], false, $cursor];
        }

        /** @var Model $model */
        $model = $query->getModel();
        $table = $model->getTable();
        $position = $cursor->positionFor($definition->type);

        if ($position !== null) {
            $query->where(function (Builder $keyset) use ($table, $position): void {
                $keyset
                    ->where($table.'.updated_at', '>', $position[0])
                    ->orWhere(fn (Builder $tie) => $tie
                        ->where($table.'.updated_at', '=', $position[0])
                        ->where($table.'.id', '>', $position[1]));
            });
        }

        // One extra row is the whole has-more detection: cheaper and more
        // honest than a COUNT, which would race with concurrent writes.
        $rows = $query
            ->orderBy($table.'.updated_at')
            ->orderBy($table.'.id')
            ->limit($remaining + 1)
            ->get();

        $hasMore = $rows->count() > $remaining;
        $rows = $rows->take($remaining);

        $changes = [];
        foreach ($rows as $row) {
            $payload = $definition->wire($row);
            $changes[] = [
                'type' => $definition->type,
                'id' => (string) $row->getKey(),
                'deleted' => false,
                'etag' => self::etag($payload),
                'payload' => $payload,
            ];

            $cursor = $cursor->advanced(
                $definition->type,
                (string) $row->fromDateTime($row->updated_at),
                (int) $row->getKey(),
            );
        }

        return [$changes, $hasMore, $cursor];
    }

    /**
     * @return array{0: list<array<string, mixed>>, 1: bool, 2: DeltaCursor}
     */
    private function tombstones(
        DeltaEntityDefinition $definition,
        DeltaAudience $audience,
        DeltaCursor $cursor,
        int $remaining,
    ): array {
        $base = DB::table(SyncTombstone::query()->getModel()->getTable())
            ->where('school_id', $audience->schoolId)
            ->where('entity_type', $definition->type);

        $query = $definition->scopedTombstones($base, $audience);

        if ($query === null) {
            return [[], false, $cursor];
        }

        $stream = self::tombstoneStream($definition->type);
        $position = $cursor->positionFor($stream);

        // The tombstone table is insert-only and its primary key is already
        // monotonic, so the position is the id alone; the timestamp half of the
        // pair is left empty rather than duplicated.
        if ($position !== null) {
            $query->where('id', '>', $position[1]);
        }

        $rows = $query
            ->orderBy('id')
            ->limit($remaining + 1)
            ->get(['id', 'entity_id']);

        $hasMore = $rows->count() > $remaining;
        $rows = $rows->take($remaining);

        $changes = [];
        foreach ($rows as $row) {
            $changes[] = [
                'type' => $definition->type,
                'id' => (string) $row->entity_id,
                'deleted' => true,
                'etag' => null,
                'payload' => null,
            ];

            $cursor = $cursor->advanced($stream, '', (int) $row->id);
        }

        return [$changes, $hasMore, $cursor];
    }

    private static function tombstoneStream(string $type): string
    {
        return $type.'#deleted';
    }

    /** @param array<string, mixed> $payload */
    private static function etag(array $payload): string
    {
        return '"'.substr(hash('sha256', (string) json_encode($payload)), 0, 32).'"';
    }
}
