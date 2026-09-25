<?php

declare(strict_types=1);

namespace Tests\Unit\Concerns;

/**
 * The money columns, read out of the migrations rather than out of a list.
 *
 * Shared by the tests that hold the schema, the wire and the inputs to one
 * scale, so all three are judged against the same inventory.
 */
trait ReadsMoneyColumns
{
    /**
     * Decimal columns that hold something other than money.
     *
     * Scores, weights, quantities and rates are genuinely not currency and
     * have their own scales for their own reasons.
     */
    private const NOT_MONEY_COLUMNS = [
        'max_score', 'score', 'old_score', 'new_score', 'weight', 'credits',
        'latitude', 'longitude', 'overall_score',
        'current_qty', 'min_stock_qty', 'quantity', 'qty_before', 'qty_after',
        'quantity_requested', 'system_qty', 'physical_qty',
        'quantity_ordered', 'quantity_received',
        'rate', 'employee_rate', 'employer_rate', 'rate_override',
        // A percentage-or-amount input for an adjustment, not a stored
        // balance; it is scale 4 on purpose so a fractional percentage can be
        // expressed. The resulting `amount` IS money and is checked.
        'value',
    ];

    /**
     * Money columns declared anywhere in the migration set.
     *
     * @return list<array{0: string, 1: string, 2: int, 3: int, 4: string}>
     */
    private function moneyColumns(): array
    {
        $found = [];
        $files = glob(__DIR__.'/../../../database/migrations/*.php');
        sort($files);

        foreach ($files as $file) {
            $table = '?';
            $lines = explode("\n", (string) file_get_contents($file));

            foreach ($lines as $index => $line) {
                if (preg_match("/Schema::(?:create|table)\(\s*'([a-z0-9_]+)'/", $line, $t)) {
                    $table = $t[1];
                }

                if (! preg_match("/decimal\(\s*'([a-z0-9_]+)'\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/", $line, $d)) {
                    continue;
                }

                if (in_array($d[1], self::NOT_MONEY_COLUMNS, true)) {
                    continue;
                }

                $found[] = [
                    $table,
                    $d[1],
                    (int) $d[2],
                    (int) $d[3],
                    basename($file).':'.($index + 1),
                ];
            }
        }

        return $found;
    }
}
