<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use RuntimeException;

/** The client sent a cursor this server did not issue, or one it cannot read. */
final class InvalidDeltaCursor extends RuntimeException {}
