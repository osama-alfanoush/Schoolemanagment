<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use RuntimeException;

/**
 * The idempotency key has already been used, with a different request body.
 *
 * Same key and same body is the retry the key exists to absorb. Same key and a
 * different body would mean paying a different amount under a spent key, which
 * is the exact failure idempotency is there to prevent.
 */
final class IdempotencyConflict extends RuntimeException
{
    public function __construct()
    {
        parent::__construct('This idempotency key was already used for a different request.');
    }
}
