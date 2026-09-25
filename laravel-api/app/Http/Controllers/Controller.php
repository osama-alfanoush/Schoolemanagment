<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Http\Request;

abstract class Controller
{
    use AuthorizesRequests;

    /**
     * Largest page a client may ask for.
     *
     * Several endpoints passed `per_page` straight from the query string into
     * paginate(). A single request for `?per_page=1000000` then materialises
     * the whole table into memory — a denial of service that needs no
     * credentials beyond an ordinary login, and one that gets worse as a school
     * accumulates data.
     */
    public const MAX_PER_PAGE = 100;

    /**
     * A page size that is always within bounds.
     *
     * Clamped rather than rejected: a client asking for too much gets the
     * maximum instead of an error, which keeps existing integrations working
     * while removing the unbounded case. Values below 1 fall back to the
     * default, so `?per_page=0` and `?per_page=-5` cannot produce an
     * unpaginated query either.
     */
    protected function perPage(Request $request, int $default = 20): int
    {
        $requested = (int) $request->query('per_page', (string) $default);

        if ($requested < 1) {
            $requested = $default;
        }

        return min($requested, self::MAX_PER_PAGE);
    }
}
