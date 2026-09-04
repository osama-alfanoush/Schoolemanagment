<?php

declare(strict_types=1);

namespace App\Http\Resources\Mobile;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * One page of the mobile delta feed.
 */
class DeltaPageResource extends JsonResource
{
    /** @return array<string, mixed> */
    public function toArray(Request $request): array
    {
        return [
            /** Everything that changed, in cursor order. */
            'changes' => $this->changes(),
            /** Opaque position to send back as `since` on the next call. */
            'next_cursor' => $this->nextCursor(),
            /** True when more changes are waiting behind `next_cursor`. */
            'has_more' => $this->hasMore(),
            /** Entity types this page covered, comma separated. */
            'types' => $this->types(),
        ];
    }

    private function changes(): AnonymousResourceCollection
    {
        return DeltaChangeResource::collection($this->resource['changes']);
    }

    private function nextCursor(): string
    {
        return (string) $this->resource['next_cursor'];
    }

    private function hasMore(): bool
    {
        return (bool) $this->resource['has_more'];
    }

    /**
     * A comma-separated string rather than a JSON array, deliberately: it
     * mirrors exactly what the `types` query parameter accepts, so a client
     * that omitted the parameter can echo this value straight back to pin the
     * set it was served. It also keeps the generated contract honest — the
     * spec generator cannot infer the element type of a dynamic PHP list and
     * would otherwise publish an untyped array that the Dart client renders as
     * a list of opaque objects.
     */
    private function types(): string
    {
        return implode(',', array_map('strval', $this->resource['types']));
    }
}
