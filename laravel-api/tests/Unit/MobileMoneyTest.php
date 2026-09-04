<?php

declare(strict_types=1);

namespace Tests\Unit;

use App\Services\Mobile\MobileMoney;
use InvalidArgumentException;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

class MobileMoneyTest extends TestCase
{
    /** @return list<array{0: string, 1: int, 2: int}> */
    public static function amounts(): array
    {
        return [
            'whole dinars' => ['150.00', 3, 150000],
            'half a dinar' => ['0.50', 3, 500],
            'one fil, written out' => ['0.001', 3, 1],
            'no fractional part at all' => ['12', 3, 12000],
            'leading zeros' => ['007.25', 3, 7250],
            'zero' => ['0.00', 3, 0],
            'a refund' => ['-25.50', 3, -25500],
            'a two-decimal currency' => ['25.50', 2, 2550],
            'no decimals at all' => ['1234', 0, 1234],
        ];
    }

    #[DataProvider('amounts')]
    public function test_a_decimal_string_scales_to_exact_minor_units(string $amount, int $decimals, int $expected): void
    {
        $this->assertSame($expected, MobileMoney::toMinor($amount, $decimals));
    }

    public function test_widening_two_decimals_to_three_does_not_move_the_value(): void
    {
        // 25.50 JOD is 25 500 fils, not 2 550. Getting this wrong divides every
        // balance in the app by ten and looks plausible on screen.
        $this->assertSame(25500, MobileMoney::toMinor('25.50', 3));
    }

    public function test_precision_beyond_the_currency_scale_is_refused_not_rounded(): void
    {
        $this->expectException(InvalidArgumentException::class);

        MobileMoney::toMinor('1.2345', 3);
    }

    public function test_trailing_zeros_beyond_the_scale_are_not_precision(): void
    {
        $this->assertSame(1234, MobileMoney::toMinor('1.23400', 3));
    }

    public function test_a_non_numeric_amount_is_refused_rather_than_treated_as_zero(): void
    {
        $this->expectException(InvalidArgumentException::class);

        MobileMoney::toMinor('not money', 3);
    }
}
