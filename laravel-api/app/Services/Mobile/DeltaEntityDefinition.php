<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use Closure;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Query\Builder as QueryBuilder;

/**
 * One syncable entity type: who may read it, how a query is narrowed to that
 * audience, and what a row looks like on the wire.
 *
 * Scoping lives here rather than in the controller so that every read of the
 * type — live rows and tombstones alike — goes through the same predicate.
 * A type whose scope is defined in two places is a type that will eventually
 * be scoped correctly in only one of them.
 */
final class DeltaEntityDefinition
{
    /**
     * @param  list<string>  $roles  Roles permitted to request this type at all.
     * @param  Closure(Builder, DeltaAudience): ?Builder  $scope  Null means "this audience sees none".
     * @param  Closure(Model): array<string, mixed>  $payload
     * @param  Closure(QueryBuilder, DeltaAudience): ?QueryBuilder  $tombstoneScope
     * @param  Closure(Model): array{subject_user_id: ?int, class_room_id: ?int}  $tombstoneKeys
     */
    public function __construct(
        public readonly string $type,
        public readonly string $modelClass,
        public readonly array $roles,
        public readonly Closure $scope,
        public readonly Closure $payload,
        public readonly Closure $tombstoneScope,
        public readonly Closure $tombstoneKeys,
    ) {}

    public function readableBy(string $role): bool
    {
        return in_array($role, $this->roles, true);
    }

    public function scopedQuery(DeltaAudience $audience): ?Builder
    {
        /** @var Model $model */
        $model = new ($this->modelClass);

        $query = $model->newQuery()->where(
            $model->getTable().'.school_id',
            $audience->schoolId,
        );

        return ($this->scope)($query, $audience);
    }

    public function scopedTombstones(QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder
    {
        return ($this->tombstoneScope)($query, $audience);
    }

    /** @return array<string, mixed> */
    public function wire(Model $model): array
    {
        return ($this->payload)($model);
    }

    /** @return array{subject_user_id: ?int, class_room_id: ?int} */
    public function keysFor(Model $model): array
    {
        return ($this->tombstoneKeys)($model);
    }
}
