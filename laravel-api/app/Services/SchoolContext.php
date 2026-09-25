<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

final class SchoolContext
{
    public function forUser(User $user): int
    {
        $today = now()->toDateString();
        $ids = $user->schoolRoles()
            ->whereHas('school', fn (Builder $query) => $query->where('is_active', true))
            ->where(fn (Builder $q) => $q->whereNull('starts_on')->orWhereDate('starts_on', '<=', $today))
            ->where(fn (Builder $q) => $q->whereNull('ends_on')->orWhereDate('ends_on', '>=', $today))
            ->distinct()->pluck('school_id');

        if ($ids->count() !== 1) {
            throw new AccessDeniedHttpException($ids->isEmpty()
                ? 'No active school assignment is configured for this user.'
                : 'Select an authorised school context before accessing school data.');
        }

        return (int) $ids->first();
    }

    public function authorize(User $user, int $schoolId): int
    {
        $authorised = $this->forUser($user);
        if ($authorised !== $schoolId) {
            throw new AccessDeniedHttpException('This resource belongs to another school.');
        }

        return $authorised;
    }
}
