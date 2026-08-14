# Production policy ownership

Accountable roles until the deploying school names real people. **Every name
below is a placeholder.** Alerts and approvals still function while they are
placeholders — an unnamed owner is a routing gap, not a silence — but no
decision in `decision-register.md` can be closed by a placeholder.

`php artisan policy:status --stage=pilot|production` reports which decisions are
still open and exits non-zero while a blocking one remains.

## Named roles

| Role | Config key | Placeholder | Responsible for |
|---|---|---|---|
| Platform owner | `ALERT_OWNER_PLATFORM` | `PLACEHOLDER-platform-on-call` | Deployment, runtime, dependency and scheduler alerts; backup mechanism; RPO/RTO execution |
| Data owner | `ALERT_OWNER_DATA` | `PLACEHOLDER-database-owner` | Database health, backup and restore integrity, retention execution once approved |
| Finance systems owner | `ALERT_OWNER_FINANCE` | `PLACEHOLDER-finance-systems-owner` | Payment and webhook alerts, payroll approval policy, financial retention |
| Security owner | `ALERT_OWNER_SECURITY` | `PLACEHOLDER-security-owner` | Security exceptions, MFA recovery, incident command |
| Privacy officer | *(not yet an alert route)* | **unassigned** | Retention schedule, erasure and legal hold, subject-access requests, breach notification |
| Academic registrar | *(not an alert route)* | **unassigned** | Grade finalisation and reopening, report-card reissue authority |
| Attendance officer | *(not an alert route)* | **unassigned** | Attendance correction window and late-correction approval |
| School operations owner | *(not an alert route)* | **unassigned** | Incident command, support and escalation, naming the roles above |

## Decisions each role must close

| Decision | Register § | Accountable role | Blocks |
|---|---|---|---|
| Backup RPO/RTO | §1 | Platform + school operations | decided 2026-08-15 |
| Backup encryption, location, access | §2 | Platform + privacy | **PILOT** — decided, implementation outstanding |
| Record retention schedule | §3 | Privacy + legal (+ finance, registrar) | **PROD** — pilot answer recorded: keep everything |
| Erasure, anonymisation, legal hold | §4 | Privacy + legal | **PROD** |
| Payroll creator/approver separation | §5 | Finance | decided 2026-08-15 — keep enforced |
| Payroll cancellation semantics | §6 | Finance / school accountant | **USE** |
| Attendance correction window | §7 | Attendance officer | **USE** |
| Grade change after publication | §8 | Academic registrar | **USE** |
| Report-card reissue authority | §9 | Academic registrar | **USE** |
| Multi-school user behaviour | §10 | Platform | — |
| Subject-access requests | §11 | Privacy | **PROD** |
| Breach notification ownership | §12 | Operations + privacy + legal | **PILOT** |
| Named alert owners | §13 | School operations | **PILOT** |
| Pilot support and escalation | §14 | School operations | **PILOT** |

## Standing approvals still outstanding

| Item | Where | Status |
|---|---|---|
| Expo build-tool advisories EX-2026-001 | `security-exceptions.md` | Pending security owner; **expired 2026-08-15** — re-approve or remediate |
| Retention schedule | `decision-register.md` §3 | Deliberately not approved for the pilot; nothing expires. Required before general production |
| MFA recovery two-person rule | implemented and enforced | Confirm it matches the school's help-desk process |

## How to record a decision

1. Set the corresponding value in `config/policy.php` via its environment
   variable — never by editing the config default.
2. For retention, also set `RETENTION_POLICY_APPROVED=true` and
   `RETENTION_POLICY_APPROVED_BY` to the role and date. Nothing expires until
   both the flag and a period are set.
3. Record the decision, the approver and the date in `decision-register.md`.
4. Re-run `php artisan policy:status` and confirm the item is no longer listed.
