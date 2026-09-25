<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use RuntimeException;

/** The installment is settled, waived or cancelled, so there is nothing to pay. */
final class UnpayableInstallment extends RuntimeException
{
    public function __construct()
    {
        parent::__construct('This installment has nothing outstanding to pay.');
    }
}
