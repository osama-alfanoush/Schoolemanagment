<?php

declare(strict_types=1);

namespace Tests\Unit;

use App\Services\Mobile\MobileMoney;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

/**
 * The wire's declared scale and the database's actual scale cannot drift.
 *
 * The mobile API tells every client how many decimals a money value has. If
 * that number is larger than the column can store, the app renders precision
 * the server never had — a parent sees 33.334 JOD on an amount the database
 * rounded to 33.33, and believes the extra digit. That is a contract lie, and
 * it is the defect this file exists to prevent recurring.
 *
 * The columns are read out of the migrations rather than out of a constant,
 * so widening a column without moving `MobileMoney::decimals()` fails here,
 * and moving `MobileMoney::decimals()` without widening the columns fails too.
 *
 * @see docs/finance/money-precision-audit.md
 */
final class MoneyColumnScaleTest extends TestCase
{
    /**
     * Decimal columns that hold something other than money.
     *
     * Scores, weights, quantities and rates are genuinely not currency and
     * have their own scales for their own reasons.
     */
    private const NOT_MONEY = [
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

    #[Test]
    public function every_money_column_has_the_scale_the_wire_declares(): void
    {
        $declared = MobileMoney::decimals();
        $wrong = [];

        foreach ($this->moneyColumns() as [$table, $column, $precision, $scale, $where]) {
            if ($scale !== $declared) {
                $wrong[] = "{$table}.{$column} is decimal({$precision},{$scale}) at {$where}";
            }
        }

        $this->assertSame(
            [],
            $wrong,
            "The mobile API declares {$declared} decimals, but these money columns disagree.\n".
            "Either the columns moved and MobileMoney::decimals() did not, or the reverse.\n".
            implode("\n", $wrong)
        );
    }

    #[Test]
    public function the_inventory_actually_found_the_money_columns(): void
    {
        // Without this, a change to the migration format would empty the list
        // above and the scale test would pass by finding nothing to check —
        // the quiet way a guard stops guarding.
        $columns = $this->moneyColumns();

        $this->assertGreaterThan(
            50,
            count($columns),
            'Expected the migrations to yield the known money columns; the parser found almost none, '.
            'which means it has stopped matching the schema rather than that the schema shrank.'
        );

        $tables = array_unique(array_column($columns, 0));
        foreach (['invoices', 'payments', 'installments', 'journal_entries', 'payroll_records'] as $expected) {
            $this->assertContains(
                $expected,
                $tables,
                "The parser did not find {$expected}, so it is no longer reading the schema correctly."
            );
        }
    }

    #[Test]
    public function a_value_the_columns_cannot_hold_is_refused_rather_than_rounded(): void
    {
        // The other half of the contract: the wire declares 2, so a value
        // carrying a third decimal must be refused, not silently truncated.
        // Truncating here is exactly how a fil goes missing without a trace.
        $this->expectExceptionMessage('more precision than 2 decimals allows');

        MobileMoney::toMinor('12.505', MobileMoney::decimals());
    }

    #[Test]
    public function a_storable_value_survives_the_round_trip_exactly(): void
    {
        $this->assertSame(1250, MobileMoney::toMinor('12.50', MobileMoney::decimals()));
        $this->assertSame(1250, MobileMoney::toMinor('12.5', MobileMoney::decimals()));
        $this->assertSame(-1250, MobileMoney::toMinor('-12.50', MobileMoney::decimals()));
    }

    /**
     * Money columns declared anywhere in the migration set.
     *
     * @return list<array{0: string, 1: string, 2: int, 3: int, 4: string}>
     */
    private function moneyColumns(): array
    {
        $found = [];
        $files = glob(__DIR__.'/../../database/migrations/*.php');
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

                if (in_array($d[1], self::NOT_MONEY, true)) {
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
