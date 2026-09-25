# HR and Payroll Workspace

## Audit result

The retained module already had staff profiles, attendance, leave/HR requests, evaluations, recruitment, legacy payroll records, the `draft → processed → approved → paid` run workflow, separation of duties, `AuditLogger`, notifications, and `LedgerService`.

The old calculation was limited to `base salary + one manual allowance - one manual deduction - approved legacy advance request`. A contract was overwritten in `staff_profiles`, advances had no disbursement or installment ledger, social-insurance rates were absent, warnings did not exist, payroll had no immutable calculation lines, and the payment journal was only a salary-expense/cash pair.

## Data model

```text
users 1─1 staff_profiles
             ├─* employee_contracts ─* contract_alert_deliveries
             ├─* staff_payroll_components *─1 payroll_components
             ├─* disciplinary_warnings
             └─* employee_advances ─* employee_advance_installments ─0..1 payroll_records

social_insurance_schemes (scheme_code + effective_from versions)
hr_payroll_settings      (scope policy and contract thresholds)
payroll_account_settings (configurable account map)

payroll_runs 1─* payroll_records 1─* payroll_record_components
     ├─0..1 accrual journal_batch ─* journal_entries
     └─0..1 payment journal_batch ─* journal_entries
```

Legacy columns remain available. The migration copies a profile with a hire date into a `LEGACY-{profile_id}` historical contract and keeps approved legacy `salary_advance` requests in the calculation for their original reviewed month. No production row is deleted or renamed.

## Payroll formula

All arithmetic is normalized to integer cents inside the calculation service and persisted as decimals:

```text
gross = prorated base + recurring/one-time earnings
insurable wage = clamped configured insurance basis
employee insurance = rounded(insurable wage × effective employee rate)
employer insurance = rounded(insurable wage × effective employer rate)
net = gross - employee insurance - other deductions - due advance installments
employer cost = gross + employer insurance + other employer contributions
```

Example using configured values (these are an example, not legal defaults): base 1,000.00; insurable allowance 100.00; employee rate 5%; employer rate 10%; capped percentage deduction 60.00; employer contribution 30.00:

```text
gross                 1,100.00
insurable wage        1,100.00
employee insurance       55.00
other deduction          60.00
net                     985.00
employer insurance      110.00
employer contribution    30.00
employer cost          1,240.00
```

Every record stores contract, insurance, policy, amount, component-rule, effective-date, rounding, and account snapshots. Approved and paid records are not recalculated.

## Journals

Approval posts the accrual atomically:

- Debit salary expense for base and earnings.
- Debit employer insurance/contribution expenses.
- Credit payroll payable for net salary.
- Credit social-insurance payables for employee and employer shares.
- Credit configured deduction liabilities.
- Credit employee-advance receivables for collected installments.

Payment posts debit payroll payable / credit cash or bank. Advance disbursement posts debit employee-advance receivable / credit cash or bank. Early settlement reverses that receivable through cash. Component- and insurance-specific account codes override the global account map when configured. All generated batches carry a unique idempotency key. A payroll reversal creates opposite lines and restores reserved/collected installments.

## Permissions

- `hr.employees.view|edit`
- `hr.salary.view|edit`
- `hr.contracts.view|manage|override`
- `hr.warnings.view|create|approve|cancel`
- `hr.advances.view|request|approve|disburse|settle`
- `payroll.settings.view|manage`
- `payroll.runs.view|create|process|approve|pay|reverse`
- `payroll.payslips.view|print`
- `payroll.reports.view|export`

The deployed `finance.payroll.*` permissions and legacy endpoints remain operational. A run creator cannot approve the same run; an advance requester cannot approve it; and a warning issuer cannot approve the same warning. Finance cannot access warning endpoints.

## Reports and exports

The paginated report center exposes payroll summary and detail, social-insurance shares, component breakdown, employee cost, payroll-to-journal reconciliation, expiring/expired contracts, advances and balances, warnings, and active uninsured staff. Filters are applied server-side; flat results can be exported as UTF-8 CSV, while each payslip has a printable PDF generated from its stored snapshots.

## Deployment

```bash
cd laravel-api
php artisan migrate --force
php artisan db:seed --class=PermissionSeeder --force
php artisan hr:check-contracts
php artisan test

cd ../school-web
npm ci
npm run typecheck
npm run lint -- --quiet
npm test -- --run
npm run build
npm run test:e2e
```

The migration is reversible. Before migration, take the normal production backup. After migration, HR must review the generated `LEGACY-*` contracts and Finance must replace the configurable starter account map with the approved chart of accounts.

## Legislative decisions

No statutory insurance or tax percentage is hard-coded. Deployment owners must supply the country-specific, effective-dated employee and employer rates, wage floor/cap, included components, tax deductions, rounding policy, proration policy, currency, and the approved accounts. Absence/late deductions are ordinary disabled payroll components until an approved policy supplies their amounts.

## Manual verification

HR user:

1. Open a staff profile and verify contract days/status, insurance details, timeline, advances, and warnings.
2. Renew the contract and confirm the old contract remains in history.
3. Add an effective-dated insurance scheme/component, request an advance, and submit it.
4. Issue a warning and confirm payroll has no automatic warning deduction.

Finance user:

1. Approve and disburse the advance; verify the balanced disbursement journal and exact installment sum.
2. Process a payroll run and inspect the employee formula, component lines, insurance, installment, employer cost, and snapshots.
3. Approve with a different user, verify the accrual journal, pay once, open the payment journal and PDF payslip.
4. Attempt a second payment (must fail), then reverse the run and verify opposite journals and restored advance balance.
