<?php

namespace Tests\Postgres;

use App\Services\Mobile\MobileMoney;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

/**
 * What PostgreSQL actually does with a money column, observed, not cited.
 *
 * The money-precision audit quoted the SQL standard for both of these because
 * no PostgreSQL was reachable. SQLite enforces neither, so only this suite can
 * see them. Probes run on temporary tables, typed from the live schema, and
 * leave nothing behind.
 *
 * @see docs/finance/money-precision-audit.md
 */
class MoneyColumnBehaviourTest extends TestCase
{
    public function test_the_live_money_columns_have_the_scale_the_wire_declares(): void
    {
        // MoneyColumnScaleTest reads the migrations; this reads what they built.
        $scales = DB::table('information_schema.columns')
            ->where('table_schema', DB::raw('current_schema()'))
            ->whereIn('table_name', ['invoices', 'payments', 'installments', 'journal_entries', 'payroll_records'])
            ->whereIn('column_name', ['amount', 'paid_amount', 'net_pay'])
            ->pluck('numeric_scale')
            ->map(fn ($scale): int => (int) $scale)
            ->unique()
            ->values()
            ->all();

        $this->assertSame([MobileMoney::decimals()], $scales);
    }

    public function test_a_money_column_rounds_an_extra_decimal_on_store_rather_than_refusing_it(): void
    {
        // Why the `money` input rule exists: PostgreSQL does not reject 12.505,
        // it stores 12.51 and says nothing. Half away from zero, both signs.
        DB::statement('CREATE TEMP TABLE money_probe (amount '.$this->moneyType().')');
        DB::table('money_probe')->insert([['amount' => '33.334'], ['amount' => '12.505'], ['amount' => '-12.505']]);

        $this->assertSame(
            ['-12.51', '12.51', '33.33'],
            DB::table('money_probe')->orderBy('amount')->pluck('amount')->map(fn ($v): string => (string) $v)->all(),
        );

        DB::statement('DROP TABLE money_probe');
    }

    public function test_widening_the_scale_rewrites_the_table_but_widening_precision_does_not(): void
    {
        // The audit said widening numeric(12,2) to (14,3) was metadata-only.
        // It is not: a scale change rewrites every row under an ACCESS
        // EXCLUSIVE lock, which is what any migration to fils has to plan for.
        DB::statement('CREATE TEMP TABLE money_probe (amount '.$this->moneyType().')');
        DB::table('money_probe')->insert(['amount' => '100.00']);
        $filenode = fn (): int => (int) DB::selectOne("SELECT pg_relation_filenode('money_probe') AS node")->node;

        $original = $filenode();
        DB::statement('ALTER TABLE money_probe ALTER COLUMN amount TYPE numeric(16,'.MobileMoney::decimals().')');
        $this->assertSame($original, $filenode(), 'Widening precision alone should not rewrite the table.');

        DB::statement('ALTER TABLE money_probe ALTER COLUMN amount TYPE numeric(16,'.(MobileMoney::decimals() + 1).')');
        $this->assertNotSame($original, $filenode(), 'Widening the scale rewrites the table.');

        DB::statement('DROP TABLE money_probe');
    }

    /** The declared type of a real money column, so the probe cannot drift from it. */
    private function moneyType(): string
    {
        $column = DB::table('information_schema.columns')
            ->where('table_schema', DB::raw('current_schema()'))
            ->where('table_name', 'invoices')
            ->where('column_name', 'amount')
            ->first(['numeric_precision', 'numeric_scale']);

        return "numeric({$column->numeric_precision},{$column->numeric_scale})";
    }
}
