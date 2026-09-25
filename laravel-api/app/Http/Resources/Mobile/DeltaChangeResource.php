<?php

declare(strict_types=1);

namespace App\Http\Resources\Mobile;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * One entry in a delta page: an upsert or a tombstone.
 *
 * Written as a resource rather than a bare array so the generated contract —
 * and therefore the generated Dart client — describes the shape instead of
 * guessing it from a spread expression.
 */
class DeltaChangeResource extends JsonResource
{
    public static $wrap = null;

    /** @return array<string, mixed> */
    public function toArray(Request $request): array
    {
        return [
            /** Entity type, e.g. `attendance_record`. */
            'type' => $this->entityType(),
            /** Server id of the entity, as a string so clients need not care about width. */
            'id' => $this->entityId(),
            /** True for a tombstone: drop this entity from the local cache. */
            'deleted' => $this->isDeleted(),
            /** Digest of the payload, for conditional handling. Null on a tombstone. */
            'etag' => $this->etag(),
            /** The entity itself, shaped per type. Empty on a tombstone — read `deleted`, not this. */
            'payload' => $this->payload(),
        ];
    }

    private function entityType(): string
    {
        return (string) $this->resource['type'];
    }

    private function entityId(): string
    {
        return (string) $this->resource['id'];
    }

    private function isDeleted(): bool
    {
        return (bool) $this->resource['deleted'];
    }

    private function etag(): ?string
    {
        $etag = $this->resource['etag'] ?? null;

        return $etag === null ? null : (string) $etag;
    }

    /**
     * The entity body, or an empty object on a tombstone.
     *
     * Empty rather than null on purpose. OpenAPI can say `object | null`, but
     * the Dart generator drops the null half for object-typed properties and
     * emits a non-nullable `BuiltMap`, so a null here would deserialise into a
     * crash on the one path — a deletion — that most needs to work. `deleted`
     * is the signal; this field is never the thing to test.
     *
     * @return array<string, mixed>
     */
    private function payload(): array
    {
        $payload = $this->resource['payload'] ?? null;

        return is_array($payload) ? $payload : [];
    }
}
