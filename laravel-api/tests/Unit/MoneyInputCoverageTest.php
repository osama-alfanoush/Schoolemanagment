<?php

declare(strict_types=1);

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use Tests\Unit\Concerns\ReadsMoneyColumns;

/**
 * Every money input is checked against the scale the columns can store.
 *
 * `numeric` bounds a value but not its precision. A money field validated
 * with it alone accepts 12.505, and the fil is then rounded away — by the
 * controller, or by PostgreSQL on store — with nothing telling the client.
 * The `money` rule turns that into a 422 naming the field. This file makes
 * sure it is on every money input, including the ones nobody has written yet:
 * a new endpoint with a bare `numeric` amount fails here rather than in a
 * parent's balance.
 *
 * Rules are read from the source with PHP's own tokenizer, so a pipe string,
 * an array of rules and a conditional `Rule::when(...)` are all seen.
 *
 * @see docs/finance/money-precision-audit.md
 */
final class MoneyInputCoverageTest extends TestCase
{
    use ReadsMoneyColumns;

    /**
     * Inputs validated as `numeric` that are not money, by their last key
     * segment. Adding a name here is a claim that the field is not currency;
     * that claim is what review should look at.
     */
    private const NOT_MONEY_INPUTS = [
        // Grades.
        'score', 'max_score', 'weight', 'overall_score',
        // Stock and procurement quantities.
        'quantity', 'quantity_ordered', 'quantity_received', 'quantity_requested',
        'min_stock_qty', 'physical_qty',
        // Payroll percentages. The amounts they produce are money; the rates
        // are not, and are stored at scale 6 on purpose.
        'rate', 'rate_override', 'employee_rate', 'employer_rate',
        // Coordinates.
        'latitude', 'longitude',
    ];

    /** Rules that only ever appear in a validation array. */
    private const PRESENCE_RULES = [
        'required', 'required_if', 'required_unless', 'required_with', 'required_with_all',
        'required_without', 'required_without_all', 'sometimes', 'nullable', 'present', 'filled',
    ];

    /** Places in the source a request's rules are written. */
    private const SCANNED = ['app', 'routes'];

    #[Test]
    public function every_numeric_input_is_money_checked_or_declared_not_money(): void
    {
        $this->assertSame(
            [],
            $this->bareNumeric($this->sourceEntries()),
            "These inputs are validated as numeric without the `money` rule, so an over-precise amount\n".
            "would be accepted and rounded instead of refused. Add `money` after `numeric`, or, if the\n".
            "field is genuinely not currency, add its name to NOT_MONEY_INPUTS with the reason.\n"
        );
    }

    #[Test]
    public function every_input_named_after_a_money_column_is_money_checked(): void
    {
        // The other way in: an amount validated as `required` alone, or as a
        // string, never says `numeric` and would slip past the check above.
        $this->assertSame(
            [],
            $this->uncheckedMoneyNames($this->sourceEntries()),
            "These inputs share a name with a money column but do not carry the `money` rule.\n"
        );
    }

    #[Test]
    public function a_money_checked_input_is_also_required_to_be_a_number(): void
    {
        // `money` leaves non-numbers to `numeric` so a bad value is reported
        // once. Without `numeric` beside it, "abc" would pass both.
        $this->assertSame(
            [],
            $this->moneyWithoutNumeric($this->sourceEntries()),
            "These inputs carry `money` without `numeric`, so a non-number would be accepted.\n"
        );
    }

    #[Test]
    public function the_scan_actually_found_the_money_inputs(): void
    {
        // Without this, a change to how rules are written would empty the
        // scan and every check above would pass by finding nothing — the
        // quiet way a guard stops guarding.
        $checked = array_filter(
            $this->sourceEntries(),
            fn (array $entry): bool => in_array('money', $entry['rules'], true),
        );

        $this->assertGreaterThanOrEqual(
            40,
            count($checked),
            'Expected the scan to find the known money inputs; it found almost none, which means it has '.
            'stopped reading the rules rather than that the inputs went away.'
        );

        $found = array_map(
            fn (array $entry): string => basename(strstr($entry['where'], ':', true)).' '.$entry['field'],
            $checked,
        );
        foreach ([
            'FinanceController.php amount',
            'InstallmentController.php total_amount',
            'JournalBatchService.php lines.*.debit',
            'ReceiptService.php allocations.*.amount',
            'StudentAdjustmentService.php value',
            'UserManagementService.php staff.base_salary',
        ] as $expected) {
            $this->assertContains($expected, $found, "The scan did not find {$expected} carrying `money`.");
        }
    }

    #[Test]
    public function the_scan_catches_a_money_input_without_the_rule(): void
    {
        // A standing negative control: the checks above are only worth
        // anything if they fail on the mistakes they exist for.
        $entries = $this->ruleEntries(<<<'PHP'
            <?php
            $request->validate([
                'tuition' => 'required|numeric|min:0',
                'lines.*.debit' => ['nullable', 'numeric', 'min:0'],
                'paid_amount' => ['required', 'min:0'],
                'fee' => 'required|money',
                'score' => 'required|numeric',
                'amount' => 'required|numeric|money|gt:0',
                'value' => ['required', 'numeric', Rule::when(fn ($input) => $input->kind === 'amount', 'money')],
            ]);
            PHP, 'fixture');

        $this->assertSame(['tuition at fixture:3', 'lines.*.debit at fixture:4'], $this->bareNumeric($entries));
        $this->assertSame(['paid_amount at fixture:5'], $this->uncheckedMoneyNames($entries));
        $this->assertSame(['fee at fixture:6'], $this->moneyWithoutNumeric($entries));
    }

    /**
     * @param  list<array{field: string, rules: list<string>, where: string}>  $entries
     * @return list<string>
     */
    private function bareNumeric(array $entries): array
    {
        return $this->describe(array_filter($entries, fn (array $entry): bool => in_array('numeric', $entry['rules'], true)
            && ! in_array('money', $entry['rules'], true)
            && ! in_array($this->leaf($entry['field']), self::NOT_MONEY_INPUTS, true)));
    }

    /**
     * @param  list<array{field: string, rules: list<string>, where: string}>  $entries
     * @return list<string>
     */
    private function uncheckedMoneyNames(array $entries): array
    {
        $moneyNames = array_unique(array_column($this->moneyColumns(), 1));

        return $this->describe(array_filter($entries, fn (array $entry): bool => in_array($this->leaf($entry['field']), $moneyNames, true)
            && array_intersect($entry['rules'], self::PRESENCE_RULES) !== []
            && ! in_array('money', $entry['rules'], true)));
    }

    /**
     * @param  list<array{field: string, rules: list<string>, where: string}>  $entries
     * @return list<string>
     */
    private function moneyWithoutNumeric(array $entries): array
    {
        return $this->describe(array_filter($entries, fn (array $entry): bool => in_array('money', $entry['rules'], true)
            && ! in_array('numeric', $entry['rules'], true)));
    }

    /**
     * @param  array<array{field: string, rules: list<string>, where: string}>  $entries
     * @return list<string>
     */
    private function describe(array $entries): array
    {
        return array_values(array_map(fn (array $entry): string => "{$entry['field']} at {$entry['where']}", $entries));
    }

    private function leaf(string $field): string
    {
        $segments = explode('.', $field);

        return end($segments);
    }

    /** @return list<array{field: string, rules: list<string>, where: string}> */
    private function sourceEntries(): array
    {
        $root = dirname(__DIR__, 2);
        $entries = [];

        foreach (self::SCANNED as $directory) {
            $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator("{$root}/{$directory}"));
            foreach ($files as $file) {
                if ($file->getExtension() !== 'php') {
                    continue;
                }
                $relative = substr($file->getPathname(), strlen($root) + 1);
                array_push($entries, ...$this->ruleEntries((string) file_get_contents($file->getPathname()), $relative));
            }
        }

        return $entries;
    }

    /**
     * Every `'key' => value` pair in the source, with the rule names its value
     * mentions — a pipe string split on `|`, or each string inside an array or
     * a call, which is how `Rule::when(..., 'money')` is seen.
     *
     * @return list<array{field: string, rules: list<string>, where: string}>
     */
    private function ruleEntries(string $source, string $where): array
    {
        $tokens = array_values(array_filter(
            token_get_all($source),
            fn (array|string $token): bool => ! is_array($token) || ! in_array($token[0], [T_WHITESPACE, T_COMMENT, T_DOC_COMMENT], true),
        ));
        $entries = [];

        foreach ($tokens as $i => $token) {
            $next = $tokens[$i + 1] ?? null;
            if (! is_array($token) || $token[0] !== T_CONSTANT_ENCAPSED_STRING
                || ! is_array($next) || $next[0] !== T_DOUBLE_ARROW) {
                continue;
            }

            $rules = [];
            $depth = 0;
            for ($j = $i + 2; isset($tokens[$j]); $j++) {
                $part = $tokens[$j];
                if (in_array($part, ['(', '[', '{'], true) || (is_array($part) && in_array($part[0], [T_CURLY_OPEN, T_DOLLAR_OPEN_CURLY_BRACES], true))) {
                    $depth++;
                } elseif (in_array($part, [')', ']', '}'], true)) {
                    if ($depth === 0) {
                        break;
                    }
                    $depth--;
                } elseif (($part === ',' || $part === ';') && $depth === 0) {
                    break;
                } elseif (is_array($part) && $part[0] === T_CONSTANT_ENCAPSED_STRING) {
                    foreach (explode('|', substr($part[1], 1, -1)) as $rule) {
                        $rules[] = strtolower(explode(':', $rule, 2)[0]);
                    }
                }
            }

            $entries[] = [
                'field' => substr($token[1], 1, -1),
                'rules' => $rules,
                'where' => "{$where}:{$token[2]}",
            ];
        }

        return $entries;
    }
}
