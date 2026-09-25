# Money column precision audit

**Order 8.1 · read-only investigation · 2026-09-25**

Every claim below cites `file:line` in the repository as it stands at commit
`0c988b0`. Nothing outside this file was changed.

---

## Verdict in one paragraph

**No fils are being lost to column truncation, because no fil is ever
computed.** The backend's internal minor unit is the **qirsh (1/100 JOD), not
the fil (1/1000 JOD)** — every service that converts money to integers
multiplies by 100, and every one of the 70 money-bearing decimal columns is
scale 2. The system is internally consistent and its ledger balances. The
defect is not lost data; it is that **JOD's third decimal does not exist
anywhere in the server**, while the mobile API declares `decimals: 3` to every
client. Two sites do compute a third decimal and round it away, and those are
real losses. Separately, and more urgently than the scale itself: **the test
suite physically cannot catch this class of bug**, because SQLite does not
enforce decimal scale and PostgreSQL does.

---

## 1. Column inventory

70 money-bearing decimal columns across 27 tables. **All are scale 2.** No
later migration widens any of them — the only `->change()` calls in the
migration set touch `school_id` nullability
(`database/migrations/2026_08_03_000001_harden_school_scoped_hr_payroll.php:102,223`).

Non-money decimals (`score`, `weight`, `quantity`, `rate`, `latitude`,
`credits`) are excluded throughout.

### Student finance — reachable from the mobile app

| Table | Column | Type | Declared at |
|---|---|---|---|
| `fee_structures` | `amount` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:195` |
| `invoices` | `amount` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:206` |
| `invoices` | `paid_amount` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:207` |
| `payments` | `amount` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:216` |
| `payment_plans` | `total_amount` | `decimal(12,2)` | `database/migrations/2026_07_12_000004_create_installments_module.php:16` |
| `payment_plans` | `down_payment` | `decimal(12,2)` | `database/migrations/2026_07_12_000004_create_installments_module.php:17` |
| `installments` | `amount` | `decimal(12,2)` | `database/migrations/2026_07_12_000004_create_installments_module.php:35` |
| `installments` | `paid_amount` | `decimal(12,2)` | `database/migrations/2026_07_12_000004_create_installments_module.php:36` |
| `payment_allocations` | `amount` | `decimal(12,2)` | `database/migrations/2026_07_16_000008_harden_payment_idempotency_and_reconciliation.php:23` |
| `payment_reversals` | `amount` | `decimal(12,2)` | `database/migrations/2026_07_16_000008_harden_payment_idempotency_and_reconciliation.php:30` |
| `payment_receipts` | `amount` | `decimal(12,2)` | `database/migrations/2026_08_02_000001_complete_student_finance_workspace.php:15` |
| `payment_receipt_allocations` | `amount` | `decimal(12,2)` | `database/migrations/2026_08_02_000001_complete_student_finance_workspace.php:43` |
| `student_financial_adjustments` | `value` | `decimal(12,4)` | `database/migrations/2026_08_02_000001_complete_student_finance_workspace.php:64` |
| `student_financial_adjustments` | `amount` | `decimal(12,2)` | `database/migrations/2026_08_02_000001_complete_student_finance_workspace.php:65` |
| `payment_transactions` | `amount` | `decimal(12,2)` | `database/migrations/2026_04_27_000002_create_payment_and_missing_tables.php:17` |
| `payment_transactions` | `refunded_amount` | `decimal(12,2)` | `database/migrations/2026_04_27_000002_create_payment_and_missing_tables.php:23` |
| `library_borrowings` | `fine_amount` | `decimal(8,2)` | `database/migrations/2026_04_27_000002_create_payment_and_missing_tables.php:55` |
| `transport_routes` | `fee` | `decimal(10,2)` | `database/migrations/2026_04_27_000002_create_payment_and_missing_tables.php:73` |

### Accounting ledger

| Table | Column | Type | Declared at |
|---|---|---|---|
| `journal_entries` | `amount` | `decimal(12,2)` | `database/migrations/2026_05_05_000001_create_accounting_module.php:19` |
| `budget_plans` | `planned_amount` | `decimal(12,2)` | `database/migrations/2026_05_05_000001_create_accounting_module.php:46` |
| `budget_plans` | `actual_amount` | `decimal(12,2)` | `database/migrations/2026_05_05_000001_create_accounting_module.php:47` |

### Payroll and HR

| Table | Column | Type | Declared at |
|---|---|---|---|
| `staff_profiles` | `base_salary` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:78` |
| `payroll_records` | `base_salary` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:232` |
| `payroll_records` | `allowances` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:233` |
| `payroll_records` | `deductions` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:234` |
| `payroll_records` | `advance_deduction` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:235` |
| `payroll_records` | `net_pay` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:236` |
| `payroll_records` | `total_earnings` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:267` |
| `payroll_records` | `gross_salary` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:268` |
| `payroll_records` | `insurable_wage` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:269` |
| `payroll_records` | `employee_social_insurance` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:270` |
| `payroll_records` | `employer_social_insurance` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:271` |
| `payroll_records` | `employer_contributions` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:272` |
| `payroll_records` | `other_deductions` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:273` |
| `payroll_records` | `employer_cost` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:274` |
| `payroll_record_components` | `base_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:289` |
| `payroll_record_components` | `amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:291` |
| `payroll_runs` | `total_gross` | `decimal(14,2)` | `database/migrations/2026_07_12_000006_create_payroll_runs.php:18` |
| `payroll_runs` | `total_deductions` | `decimal(14,2)` | `database/migrations/2026_07_12_000006_create_payroll_runs.php:19` |
| `payroll_runs` | `total_net` | `decimal(14,2)` | `database/migrations/2026_07_12_000006_create_payroll_runs.php:20` |
| `payroll_components` | `amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:93` |
| `payroll_components` | `minimum_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:95` |
| `payroll_components` | `maximum_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:96` |
| `staff_payroll_components` | `amount_override` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:143` |
| `social_insurance_schemes` | `minimum_wage` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:123` |
| `social_insurance_schemes` | `maximum_wage` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:124` |
| `employee_contracts` | `base_salary` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:48` |
| `employee_advances` | `original_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:184` |
| `employee_advances` | `remaining_balance` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:185` |
| `employee_advances` | `installment_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:192` |
| `employee_advance_installments` | `amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:213` |
| `employee_advance_installments` | `collected_amount` | `decimal(14,2)` | `database/migrations/2026_08_02_000002_complete_hr_payroll_workspace.php:214` |
| `hr_requests` | `amount` | `decimal(12,2)` | `database/migrations/2026_04_17_100000_create_school_schema.php:249` |

### Procurement and warehouse

| Table | Column | Type | Declared at |
|---|---|---|---|
| `supplier_accounts` | `balance` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:31` |
| `supplier_accounts` | `credit_limit` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:32` |
| `supplier_transactions` | `amount` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:42` |
| `supplier_transactions` | `balance_after` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:43` |
| `purchase_orders` | `subtotal` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:64` |
| `purchase_orders` | `tax` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:65` |
| `purchase_orders` | `total` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:66` |
| `purchase_order_items` | `unit_cost` | `decimal(12,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:88` |
| `purchase_order_items` | `line_total` | `decimal(14,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:89` |
| `goods_receipt_items` | `unit_cost` | `decimal(12,2)` | `database/migrations/2026_07_12_000001_create_procurement_module.php:115` |
| `supplier_invoices` | `amount` | `decimal(14,2)` | `database/migrations/2026_07_12_000005_create_procurement_finance_module.php:19` |
| `supplier_invoices` | `paid_amount` | `decimal(14,2)` | `database/migrations/2026_07_12_000005_create_procurement_finance_module.php:20` |
| `supplier_payments` | `amount` | `decimal(14,2)` | `database/migrations/2026_07_12_000005_create_procurement_finance_module.php:34` |
| `purchase_requests` | `estimated_cost` | `decimal(12,2)` | `database/migrations/2026_05_05_000002_create_warehouse_module.php:60` |
| `warehouse_items` | `unit_cost` | `decimal(12,2)` | `database/migrations/2026_07_12_000002_add_costing_to_warehouse.php:12` |
| `warehouse_items` | `last_unit_cost` | `decimal(12,2)` | `database/migrations/2026_07_12_000002_add_costing_to_warehouse.php:13` |
| `stock_movements` | `unit_cost` | `decimal(12,2)` | `database/migrations/2026_07_12_000002_add_costing_to_warehouse.php:19` |

### The one exception

`mobile_payment_intents` already stores integer minor units and carries its own
scale:

- `amount_minor` `unsignedBigInteger` — `database/migrations/2026_09_04_000003_create_mobile_payment_intents_table.php:41`
- `decimals` `unsignedTinyInteger` — `database/migrations/2026_09_04_000003_create_mobile_payment_intents_table.php:43`

It is the only table in the schema that can express a fil. It is also the only
money table written by an order that treated JOD as a three-decimal currency.

---

## 2. Verdict per column

Rather than repeat 70 near-identical rows, the columns fall into four classes.

### Class A — unreachable by a third decimal (the large majority)

Every column whose only writer converts through a `* 100` integer helper, or
copies a value that already passed through one. A third decimal cannot reach
them because none is ever produced upstream. The helpers:

- `EmployeeAdvanceService::cents()` — `app/Services/EmployeeAdvanceService.php:110`
- `PayrollAccountingService` — `app/Services/PayrollAccountingService.php:102`
- `PayrollCalculationService` — `app/Services/PayrollCalculationService.php:267`
- `ReceiptService` — `app/Services/ReceiptService.php:362`
- `JournalBatchService` — `app/Services/JournalBatchService.php:166,167`
- `PaymentGatewayService` — `app/Services/PaymentGatewayService.php:65` (comment reads `// cents`)

**Verdict: safe at the column, wrong at the unit.** These are faithful stores
of a value that was quantised to the qirsh before it arrived. Nothing is lost
in the write; the precision was discarded a layer earlier, deliberately.

### Class B — truncating: a third decimal is computed and rounded away

Two sites, both confirmed by execution (§3).

1. **Percentage adjustments** — `app/Services/StudentAdjustmentService.php:41`

   ```php
   $amount = $data['calculation_type'] === 'percentage'
       ? round((float) $invoice->amount * (float) $data['value'] / 100, 2)
   ```

   `student_financial_adjustments.value` is `decimal(12,4)`
   (`database/migrations/2026_08_02_000001_complete_student_finance_workspace.php:64`), so a
   scholarship of 33.3333 % is storable. The resulting amount is rounded to 2.
   **This is a genuine loss of fils, on a student-facing discount.**

2. **Weighted-average stock costing** — `app/Services/ProcurementService.php:101`

   ```php
   'unit_cost' => round($newAvg, 2),
   ```

   A moving average over non-round quantities produces arbitrarily many
   decimals. Rounding to 2 is defensible for a unit cost, but it is a real
   loss and it compounds across receipts.

### Class C — accepted at any scale, silently re-scaled by the database

Every money input is validated as `numeric`, which bounds the value but **not
its scale**. There is no `decimal:` rule anywhere in the controllers or form
requests. A client may legitimately post `12.505`:

- `app/Http/Controllers/Api/FinanceController.php:31,154`
- `app/Http/Controllers/Api/InstallmentController.php:180`
- `app/Http/Controllers/Api/ProcurementFinanceController.php:52,114`
- `app/Services/JournalService.php:44`
- `app/Services/ReceiptService.php:31`

**Verdict: truncating under PostgreSQL, accepted under SQLite.** See §6 — this
is where the two drivers diverge, and it is the most dangerous class because
the test suite cannot see it.

### Class D — the schedule generators

`installments.amount` and `employee_advance_installments.amount` are written by
loops that quantise to the qirsh and then force the schedule to sum exactly:

- `app/Http/Controllers/Api/InstallmentController.php:79-89`
- `app/Services/EmployeeAdvanceService.php:81-103` — with an explicit
  reconciliation guard at `:102` that throws if the schedule does not sum to
  the advance.

**Verdict: safe, lossless, and 10× coarser than the currency.** Worked through
in §3.

---

## 3. Worked examples — actual values, executed

Both were run against the real code paths rather than reasoned about.

### 3a. A 100.000 JOD plan split three ways

Reproducing `app/Http/Controllers/Api/InstallmentController.php:79-86` exactly:

```
server split of 100.000 JOD / 3 : 33.330 | 33.330 | 33.340
  as fils                        : 33330 | 33330 | 33340
  sum                            : 100.000
  exact fils allocate()          : 33334 | 33333 | 33333
  per-installment difference     :    -4 |    -3 |    +7  fils
```

The server's schedule **sums exactly** — no money is created or destroyed. But
compare it with what `Money.allocate` does on the client
(`school-mobile/lib/core/i18n/money.dart:179-200`), which distributes the
remainder one fil at a time: the exact split is 33.334 / 33.333 / 33.333.

The server cannot express that. Its remainder lands entirely on the final
instalment, which is **7 fils heavier than it should be**, while the first two
are 4 and 3 fils lighter. At JOD scale that is 0.007 JOD on a 100 JOD plan —
immaterial as money, material as a statement about what the system can
represent. On a plan of 1,000 JOD over 36 months the same mechanism moves up
to 35 qirsh onto the last instalment.

**This directly answers the order's question:** a 100.000 JOD plan split three
ways stores **33.33 / 33.33 / 33.34**, not 33.334 / 33.333 / 33.333.

### 3b. A 33.3333 % scholarship — a real loss

```
33.3333% scholarship on 100.000 -> stored 33.33 (exact would be 33.333) : 3 fils lost
```

Here the third decimal genuinely exists, is computed, and is discarded by
`round(..., 2)` at `app/Services/StudentAdjustmentService.php:41`. Three fils per invoice,
per term, per student. This is the clearest case of the audit.

---

## 4. Domain-by-domain

| Domain | Internal unit | Third decimal reachable? | Notes |
|---|---|---|---|
| Invoices / payments | qirsh (`*100`) | No | `app/Services/PaymentGatewayService.php:65` labels its own unit `// cents` |
| Installments | qirsh | No | Sums exactly; §3a |
| Receipts | qirsh | No | `app/Services/ReceiptService.php:362` |
| Adjustments | qirsh | **Yes — rounded away** | `app/Services/StudentAdjustmentService.php:41` |
| Accounting ledger | qirsh | No | `app/Services/LedgerService.php:73`, `app/Services/JournalBatchService.php:166` |
| Payroll | qirsh | No | Insurance rates are `decimal(12,6)` but the product is rounded to cents at `app/Services/PayrollCalculationService.php:194,195` |
| Employee advances | qirsh | No | Reconciliation guard at `app/Services/EmployeeAdvanceService.php:102` |
| Procurement | qirsh | **Yes — rounded away** | `app/Services/ProcurementService.php:101` |
| Warehouse costing | qirsh | **Yes — rounded away** | Same site |
| Mobile payment intents | **fil** | n/a | The only fil-capable table |

---

## 5. Would a scale change break the ledger balance check?

**Yes — and this is the finding that should govern the decision.**

Both balance checks reduce to integer cents by multiplying a float by 100:

```php
// app/Services/JournalBatchService.php:195-196
$debits  = (int) round((float) $batch->lines()->where('type','debit')->sum('amount') * 100);
$credits = (int) round((float) $batch->lines()->where('type','credit')->sum('amount') * 100);
abort_if($debits === 0 || $debits !== $credits, 422, 'Journal entry is not balanced.');
```

and

```php
// app/Services/LedgerService.php:122-123
if ($debits <= 0 || $debits !== $credits) {
    throw ValidationException::withMessages(['journal' => 'The payroll journal is not balanced.']);
}
```

If `journal_entries.amount` were widened to scale 3 **without changing this
arithmetic**, a debit of 33.334 and a credit of 33.333 would both reduce to
`3333` and the batch would be declared balanced. **The guard would not fail
loudly — it would silently stop detecting a one-fil imbalance.** A validation
that quietly weakens is worse than one that breaks, because nothing tells you.

`app/Services/LedgerService.php:73` compounds this: it writes `'amount' => round($amount, 2)`
directly, so the ledger would keep rounding to the qirsh even after a widening.

**Any scale migration must change `LedgerService`, `JournalBatchService` and
every `* 100` helper in the same change, or not happen at all.**

---

## 6. PostgreSQL vs SQLite — the test suite is blind here

Executed, in memory, touching nothing:

```
SQLite decimal(12,2) given 33.334 -> float(33.334)
```

SQLite has no decimal type. `decimal(12,2)` gives the column NUMERIC affinity
and **the declared scale is not enforced** — the value is stored as given.
PostgreSQL implements `numeric(12,2)` to the SQL standard and rounds on store,
yielding `33.33`.

Consequences, both directions:

- **Production truncates where tests do not.** A Class C input of `12.505`
  round-trips intact through the entire SQLite suite and is silently rounded
  in production. No test can currently fail on this.
- **Tests can 500 where production would not.** `MobileMoney::asExactDecimal`
  (`app/Services/Mobile/MobileMoney.php:52-73`) re-formats at
  `COLUMN_SCALE = 2` and throws *“Amount carries more precision than the money
  column declares”* if the round-trip mismatches. Given the SQLite-stored
  33.334 it throws; given the PostgreSQL-stored 33.33 it does not. A bug of
  this class surfaces as an exception in CI and as quiet data loss in
  production.

That asymmetry is worth fixing regardless of which option below is chosen.

---

## 7. Options

### Option A — widen the money columns to `decimal(14,3)`

**Tables affected:** all 27 above; 70 columns. Plus every `* 100` helper (six
services, §2 Class A), both balance checks (§5), `MobileMoney::COLUMN_SCALE`
(`app/Services/Mobile/MobileMoney.php:20`), and every service that calls `round($x, 2)` on a money
value.

**Migration risk: moderate on PostgreSQL, high on SQLite.** Widening
`numeric(12,2)` → `numeric(14,3)` in PostgreSQL is a metadata-level change and
does not rewrite rows; existing values gain a trailing zero and are unchanged
in magnitude. On SQLite, Laravel's `->change()` rebuilds the whole table —
which is how the codebase already behaves at
`database/migrations/2026_08_03_000001_harden_school_scoped_hr_payroll.php:104`, whose comment
records the rebuild. For local and CI databases that is slow but safe.

**Rollback:** narrowing `numeric(14,3)` → `numeric(12,2)` in PostgreSQL
*does* rewrite and *will* round. Rollback is therefore lossy the moment any
genuine third decimal has been written. The practical rollback is
restore-from-backup, not a `down()` migration.

**What breaks in accounting:** the balance checks, silently, per §5 — unless
they are converted to fils in the same change. This is the main hazard.

**What breaks in `school-web`:** nothing loudly. The web app has **no central
money formatter**; it calls `Intl.NumberFormat` ad hoc, and several call sites
are hard-coded to 2 fraction digits or to USD:

- `school-web/src/lib/tableHelpers.tsx:195`
- `school-web/src/pages/hr/Advances.tsx:20` — `maximumFractionDigits: 2`
- `school-web/src/pages/accounting/Dashboard.tsx:15` — `currency: "USD"`
- `school-web/src/pages/accounting/Budget.tsx:86` — `currency: "USD"`
- `school-web/src/pages/procurement/shared.tsx:6` — `currency: "USD"`

So a third decimal would be stored, returned, and then **silently rounded away
in the browser**. The web would under-report balances rather than error. That
is its own bug and it exists today for a different reason.

### Option B — convert money to integer minor units (fils)

**Tables affected:** the same 70 columns, each becoming `bigint` alongside a
currency/scale, following the shape `mobile_payment_intents` already uses
(`database/migrations/2026_09_04_000003_create_mobile_payment_intents_table.php:41,43`).

**Migration risk: high.** Every read, write, sum, cast, validation rule and
Eloquent accessor touching money changes. `SUM()` aggregates in reports change
meaning. Every one of the 697 backend tests that asserts a money value changes.
This is a multi-week change across finance, payroll, procurement, warehouse,
accounting and both clients.

**Rollback:** clean in principle — the integer is lossless, so a `down()` can
divide back to `decimal(12,2)` and lose only what scale 2 could never hold
anyway. In practice the code rollback is the hard part, not the data.

**What breaks in accounting:** everything, loudly, at compile and test time.
That is a point in its favour over Option A: nothing weakens silently.

**What breaks in `school-web`:** every money display, because the wire shape
changes from a decimal string to `{minor, currency, decimals}`. Loud, and it
would force the central formatter the web is currently missing.

---

## 8. Recommendation

**Do neither yet. Do the three things that are strictly smaller than both, in
this order.**

1. **Fix the two real losses (Class B) now.** `app/Services/StudentAdjustmentService.php:41`
   and `app/Services/ProcurementService.php:101` are the only places a computed third
   decimal is discarded. Neither needs a migration — the adjustment can be
   derived in fils and allocated, the same way the client's
   `Money.allocate` does. Small, contained, and it removes the only
   student-visible loss in the system.

2. **Close the SQLite/PostgreSQL blindness (§6).** Add a `decimal:0,2`
   validation rule to the seven money inputs listed in Class C. This makes
   over-precise input a 422 on both drivers instead of silent rounding on one,
   and it makes the behaviour testable. It is a handful of lines and it is the
   highest value-per-risk item in this audit.

3. **Then decide A or B deliberately — and if either, choose B.** Option A's
   defect is that it weakens the ledger balance check without any signal (§5);
   that is precisely the failure mode a finance system must not have. Option B
   is far more work but every breakage is loud, and it converges on the shape
   the mobile layer and `mobile_payment_intents` already use. A half-done
   Option A is more dangerous than no change; a half-done Option B does not
   compile.

**Do not widen the columns without converting the balance checks in the same
commit.** If only one sentence of this document survives, that is the one.

---

## 9. What could not be determined without database access

**No production-shaped data was inspected, and no claim here describes what a
migration would do to real rows.**

- Docker is installed but its daemon is not running, and `psql` is not on the
  PATH. **No PostgreSQL instance was reachable, so the PostgreSQL rounding
  behaviour described in §6 is the documented SQL-standard behaviour of
  `numeric(p,s)`, not an observed result.** The SQLite half of §6 *was*
  executed and is quoted verbatim.
- Whether any existing production row already holds a value that a widening
  would alter **cannot be determined from this repository.** Nothing here reads
  a production database. The local `database/database.sqlite` holds seeded demo
  data only and is not evidence about production.
- §7's claim that widening is metadata-only on PostgreSQL is from the
  PostgreSQL documentation, not from an observed migration on this schema. It
  should be confirmed against a restored production snapshot before any
  migration is scheduled.

---

## Appendix — method

- Column inventory generated by parsing every file in
  `laravel-api/database/migrations/` for `decimal(name, p, s)` and attributing
  each to the nearest enclosing `Schema::create`/`Schema::table`. 98 decimal
  columns found, 28 excluded as non-money (`score`, `weight`, `quantity`,
  `rate`, `latitude`, `credits`), leaving 70.
- Write paths traced from `app/Services/` and `app/Http/Controllers/Api/`.
- §3 executed with PHP against transcriptions of the real code paths.
- §6 executed against an in-memory SQLite database.
- Read-only throughout: `git status --porcelain` shows only this file.

---

## Addendum — order 8.4 · correction

§2 Class C and §6 said an over-precise input "round-trips intact through the
entire SQLite suite and is silently rounded in production". That holds for
three of the seven sites listed, which store the value as given: fee
structures, supplier invoices and manual journal entries. **The other four
round in PHP before the database sees the value** — `round((float) $data['amount'], 2)`
in the payment, installment-payment and supplier-payment controllers, and
`ReceiptService::cents()` for receipts — so on those paths the third decimal
was lost on every driver, the test suite's included. Observed under SQLite
before 8.4, not reasoned about:

```
payment 12.505          -> 201, stored 12.51
receipt 9.995           -> 201, stored 9.99   (rounded down, the other way)
fixed adjustment 12.505 -> 201, stored 12.51
fee structure 1200.005  -> 201, stored 1200.005 (PostgreSQL would round)
```

The list of seven was also incomplete. There are 42 money inputs, and one of
them, `staff.base_salary` on user creation, had no rule of any kind: a
non-number reached the column and the request failed with a 500.

All 42 now carry the `money` rule and are refused with a 422 naming the field.
`MoneyInputCoverageTest` fails for any future money input that lacks it.

---

## Addendum — PostgreSQL, observed

§9 said the PostgreSQL behaviour in §6 and §7 was cited, not observed. It has
now been observed on PostgreSQL 16, and one claim was wrong.

- **§6 holds.** A `numeric(12,2)` column rounds on store rather than refusing,
  half away from zero: `33.334 -> 33.33`, `12.505 -> 12.51`,
  `-12.505 -> -12.51`.
- **§7 was wrong about widening.** Changing only the precision,
  `numeric(12,2) -> numeric(16,2)`, keeps the same file on disk, so it is
  metadata-only. Changing the scale, `numeric(12,2) -> numeric(14,3)`, gives
  the table a new file. That is a **full rewrite of every row under an ACCESS
  EXCLUSIVE lock**. Option A is therefore not the cheap migration §7
  described. Option B's `bigint` conversion rewrites too, so either one has to
  be planned table by table as a locking operation.

Both are asserted on every CI run by `tests/Postgres/MoneyColumnBehaviourTest.php`,
which types its probe tables from the live schema. The whole Unit and Feature
suite now also runs on PostgreSQL in CI.
