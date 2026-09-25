<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use RuntimeException;

/**
 * The code cannot be redeemed.
 *
 * Deliberately one exception for every reason — unknown, spent, expired,
 * too many attempts, account unavailable. The caller is told the same thing
 * each time, so the endpoint cannot be used to discover which codes exist or
 * which guardians have already activated.
 */
final class InvalidInviteCode extends RuntimeException
{
    public function __construct()
    {
        parent::__construct('This activation code cannot be used.');
    }
}
