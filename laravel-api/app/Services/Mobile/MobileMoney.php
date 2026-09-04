<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use InvalidArgumentException;

/**
 * Converts the relational decimal columns into the integer minor units the
 * mobile clients speak.
 *
 * Everything here is string arithmetic. A float cannot represent 0.001 exactly,
 * so a single cast to float anywhere on this path is enough to make a fil
 * appear or disappear — and nobody notices until a parent's balance is wrong.
 */
final class MobileMoney
{
    /**
     * Scale of the relational money columns: `decimal(12, 2)` throughout.
     */
    private const COLUMN_SCALE = 2;

    /**
     * The wire shape every mobile money value takes.
     *
     * @return array{minor: int, currency: string, decimals: int}
     */
    public static function payload(int|float|string|null $amount): array
    {
        $currency = strtoupper((string) config('mobile.currency', 'JOD'));
        $decimals = (int) config('mobile.currency_decimals', 3);

        return [
            'minor' => self::toMinor(self::asExactDecimal($amount), $decimals),
            'currency' => $currency,
            'decimals' => $decimals,
        ];
    }

    /**
     * Normalise whatever the driver handed back into an exact decimal string.
     *
     * PostgreSQL returns `numeric` as a string, but PDO SQLite — which the test
     * suite runs on — has no decimal type and hands back a PHP float. That
     * float is not a choice this code made and cannot be refused, so it is
     * converted at the boundary at the column's own scale and the result is
     * checked to round-trip. `decimal(12, 2)` values sit far inside a double's
     * exact range, so a mismatch would mean the column is not what we think it
     * is; that throws rather than quietly rounding someone's balance.
     */
    private static function asExactDecimal(int|float|string|null $amount): string
    {
        if ($amount === null) {
            return '0';
        }

        if (! is_float($amount)) {
            return (string) $amount;
        }

        if (! is_finite($amount)) {
            throw new InvalidArgumentException('Not a finite amount.');
        }

        $formatted = sprintf('%.'.self::COLUMN_SCALE.'F', $amount);

        if ((float) $formatted !== $amount) {
            throw new InvalidArgumentException(
                'Amount carries more precision than the money column declares.'
            );
        }

        return $formatted;
    }

    /**
     * Scale a decimal string to integer minor units without touching a float.
     *
     * Widening (2 stored decimals to 3 JOD decimals) pads with zeros. Narrowing
     * is refused rather than rounded: silently dropping a significant digit is
     * how money goes missing.
     */
    public static function toMinor(int|string $amount, int $decimals): int
    {
        if ($decimals < 0) {
            throw new InvalidArgumentException('Currency decimals cannot be negative.');
        }

        $value = trim((string) $amount);

        if ($value === '') {
            $value = '0';
        }

        $negative = str_starts_with($value, '-');
        if ($negative || str_starts_with($value, '+')) {
            $value = substr($value, 1);
        }

        if (! preg_match('/^\d*(?:\.\d*)?$/', $value) || $value === '' || $value === '.') {
            throw new InvalidArgumentException('Not a decimal amount.');
        }

        [$whole, $fraction] = array_pad(explode('.', $value, 2), 2, '');
        $whole = $whole === '' ? '0' : $whole;

        if (strlen($fraction) > $decimals) {
            $dropped = substr($fraction, $decimals);
            if (rtrim($dropped, '0') !== '') {
                throw new InvalidArgumentException(
                    "Amount has more precision than {$decimals} decimals allows."
                );
            }
            $fraction = substr($fraction, 0, $decimals);
        }

        $minor = ltrim($whole.str_pad($fraction, $decimals, '0'), '0');
        $minor = $minor === '' ? '0' : $minor;

        return (int) ($negative ? '-'.$minor : $minor);
    }
}
