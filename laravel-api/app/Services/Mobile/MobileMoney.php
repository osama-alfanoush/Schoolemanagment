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
     * Scale of the relational money columns: `decimal(x, 2)` throughout.
     *
     * This is the single source of truth for how much precision the server
     * actually has, and it is what the wire reports. It is deliberately not a
     * config value: an operator who set `MOBILE_CURRENCY_DECIMALS=3` would not
     * gain a fil of precision, they would only make every payload claim one
     * the database cannot store.
     *
     * JOD is nominally a three-decimal currency — 1 JOD = 1000 fils — and the
     * columns cannot hold the third. Reporting 3 here would be a contract the
     * server cannot honour, so the wire reports what is actually stored and the
     * clients render exactly that. Widening the columns to fils is a separate,
     * larger change; when it happens this constant moves with them, and
     * `MoneyColumnScaleTest` fails until it does.
     */
    private const COLUMN_SCALE = 2;

    /**
     * Decimal places every mobile money payload declares.
     *
     * Equal to the column scale by construction. Callers outside this class
     * use this rather than reading config, so the wire cannot disagree with
     * the storage.
     */
    public static function decimals(): int
    {
        return self::COLUMN_SCALE;
    }

    /**
     * Whether a submitted amount can be stored without losing a digit.
     *
     * The input half of the contract `decimals()` declares. A money column
     * rounds anything finer than its scale on store — PostgreSQL does, SQLite
     * does not — so an amount that does not fit has to be refused at the edge,
     * while the client can still be told which field was wrong. Rounding it
     * instead would be the same silent loss one layer earlier.
     *
     * Trailing zeros are not precision: `12.500` fits, `12.505` does not. A
     * float is judged by value rather than by how PHP happens to print it, the
     * same round-trip `asExactDecimal()` applies on the way out.
     */
    public static function fitsColumnScale(int|float|string $amount): bool
    {
        if (is_int($amount)) {
            return true;
        }

        if (is_float($amount)) {
            return is_finite($amount)
                && (float) sprintf('%.'.self::COLUMN_SCALE.'F', $amount) === $amount;
        }

        try {
            self::toMinor($amount, self::COLUMN_SCALE);
        } catch (InvalidArgumentException) {
            return false;
        }

        return true;
    }

    /**
     * The wire shape every mobile money value takes.
     *
     * @return array{minor: int, currency: string, decimals: int}
     */
    public static function payload(int|float|string|null $amount): array
    {
        return [
            'minor' => self::toMinor(self::asExactDecimal($amount), self::COLUMN_SCALE),
            'currency' => self::currency(),
            'decimals' => self::COLUMN_SCALE,
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
     * A relational money column as integer minor units.
     *
     * The one-line form of `payload()` for code that needs to add amounts up
     * before shaping them for the wire. Arithmetic on the result is integer
     * arithmetic; that is the point.
     */
    public static function minorOf(int|float|string|null $amount): int
    {
        return self::toMinor(self::asExactDecimal($amount), self::COLUMN_SCALE);
    }

    /** The ISO 4217 code every mobile money payload declares. */
    public static function currency(): string
    {
        return strtoupper((string) config('mobile.currency', 'JOD'));
    }

    /**
     * Scale a decimal string to integer minor units without touching a float.
     *
     * Widening pads with zeros. Narrowing is refused rather than rounded:
     * silently dropping a significant digit is how money goes missing.
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
