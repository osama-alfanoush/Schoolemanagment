<?php

namespace App\Services;

use Closure;
use LogicException;

/**
 * Request-local tenant state used by school-owned Eloquent models.
 *
 * The HTTP middleware always clears the value in a finally block so long-lived
 * workers cannot leak one request's school into the next request.
 */
final class CurrentSchool
{
    private ?int $schoolId = null;

    public function set(int $schoolId): void
    {
        if ($schoolId < 1) {
            throw new LogicException('A valid school context is required.');
        }

        $this->schoolId = $schoolId;
    }

    public function clear(): void
    {
        $this->schoolId = null;
    }

    public function has(): bool
    {
        return $this->schoolId !== null;
    }

    public function id(): int
    {
        return $this->schoolId
            ?? throw new LogicException('No school context has been resolved.');
    }

    public function idOrNull(): ?int
    {
        return $this->schoolId;
    }

    public function run(int $schoolId, Closure $callback): mixed
    {
        $previous = $this->schoolId;
        $this->set($schoolId);

        try {
            return $callback();
        } finally {
            $this->schoolId = $previous;
        }
    }
}
