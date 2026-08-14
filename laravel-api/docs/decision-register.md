# Decision register — business policy, privacy and ownership

Status: **4 of 14 decided; 10 open**. Last reviewed 2026-08-15.

| Decided | Decision | Approved by | Date |
|---|---|---|---|
| §1 | RPO 24 h / RTO 4 h for the pilot | Project owner | 2026-08-15 |
| §2 | Encrypt backups before they leave the host; store off-host | Project owner | 2026-08-15 |
| §3 | Retain everything; no expiry until a schedule is approved | Project owner | 2026-08-15 |
| §5 | Keep payroll creator/approver separation enforced | Project owner | 2026-08-15 |

§2 is **decided but not yet implemented** — the backup script still does not
encrypt and still writes beside the database. The pilot remains blocked on that
implementation, not on the decision.

Engineering decided none of these. Each entry records
what the software does **today**, what goes wrong if the question stays open,
what the realistic options are, and the safest default to adopt if no other
answer is forthcoming. A recommendation is not a decision — it is what
engineering would pick under protest, and it needs a named owner's approval.

Where a value could be made configurable without prejudging the answer, it has
been: see `config/policy.php`. Where the answer changes what the software must
*do* rather than how it is tuned, nothing has been built.

Live status: `php artisan policy:status --stage=pilot|production`
(exit 1 while a blocking item is undecided).

Legend for **Blocks**: `PILOT` — must be settled before real data is imported;
`PROD` — must be settled before general production; `USE` — must be settled
before that specific module is used in anger; `—` — no launch dependency.

---

## 1. Backup RPO and RTO

| | |
|---|---|
| **Today** | Backups run every `BACKUP_INTERVAL_SECONDS` (default 86 400 = daily), so worst-case loss is ~24 h. A restore drill was executed and completed in **73 s** against a 7 200 s target. `config/policy.php` holds `rpo_minutes=1440`, `rto_minutes=240` as *engineering defaults*, and `ops:monitor` alerts on backup age derived from them. |
| **Risk if undecided** | A school that assumes "nothing is ever lost" discovers after an incident that a day of attendance, payments and grade entry is gone. The number is only knowable in advance if someone states it. |
| **Options** | (a) Daily dump — RPO ≈ 24 h, no extra cost. (b) Continuous WAL archiving / PITR — RPO minutes, needs archive storage and a managed or self-run PITR setup. (c) Managed provider with built-in PITR — lowest effort, highest running cost. |
| **Recommended default** | RPO 24 h and RTO 4 h **for the pilot only**, because the measured restore is far inside it. For general production with live fee collection, (b) or (c) — a day of lost payment records is not recoverable by re-keying. |
| **Owner** | Platform owner + school operations owner |
| **DECIDED 2026-08-15** | RPO 24 h, RTO 4 h, for the pilot only. Revisit before general production with live fee collection. |
| **Blocks** | resolved for pilot |

## 2. Backup retention, encryption, location and access

| | |
|---|---|
| **Today** | Retention 14 days (`BACKUP_RETENTION_DAYS`). Dumps are written with a SHA-256 digest and a per-table count manifest to `laravel-api/backups`, **on the same host as the database**. The backup script performs **no encryption**. Access is whoever can read the volume. `policy:status` reports `backups_encrypted_at_rest` and `offsite_location` as **unknown/none**. |
| **Risk if undecided** | A backup is a complete copy of every pupil, staff and financial record. Unencrypted and co-located, it is simultaneously the highest-value target in the system and useless against the failure it is meant to survive — losing the host loses the backups. |
| **Options** | (a) Encrypted object storage off-host with versioning and a separate credential (age/gpg or provider-side SSE). (b) Provider-managed encrypted backups. (c) Status quo — accepted only for a pilot on synthetic data. |
| **Recommended default** | (a). Encrypt before it leaves the host, store off-host, restrict read access to the database owner role, and record who may restore. |
| **Owner** | Platform owner (execution) + privacy officer (access rules) |
| **DECIDED 2026-08-15** | Option (a): encrypt before leaving the host, store off-host with versioning and a separate credential. |
| **Blocks** | **PILOT — implementation outstanding.** The decision is made; the script does not yet encrypt or copy off-host. |

## 3. Student, staff, audit and financial record retention

| | |
|---|---|
| **Today** | **Nothing expires.** All periods are `null` and `retention.approved` is `false`. **This was not previously true:** `audit:clean` was scheduled daily and hard-deleted audit entries older than 90 days on a framework default, contradicting this project's own retention inventory ("append-only … never application delete"). That job now refuses to delete anything until a period is approved. |
| **Risk if undecided** | Both directions are real. Deleting too early destroys evidence needed for a safeguarding investigation, a fee dispute or an inspection, and is unrecoverable. Keeping everything forever conflicts with data-minimisation duties. The former is worse, which is why the default is now "keep". |
| **Options** | Per class of record, a statutory minimum then deletion or anonymisation. Typical shapes: education records retained years past leaving age; financial records to the tax statute; audit logs long enough to cover an investigation window. **The actual numbers are jurisdiction-specific and engineering cannot supply them.** |
| **Recommended default** | Keep indefinitely until a schedule is approved — the current behaviour. Approve per class, not globally. |
| **Owner** | Privacy officer + legal reviewer; finance owner for financial records; registrar for education records |
| **DECIDED 2026-08-15** | Keep everything; retention stays unapproved so nothing expires. Sufficient for a time-boxed pilot. |
| **Blocks** | **PROD** — a schedule is still required before general production. |

## 4. Deletion, anonymisation and legal hold

| | |
|---|---|
| **Today** | **Not implemented.** The only supported operation is deactivation: `is_active=false` plus `deactivated_at/by`, which revokes access and preserves the record. Foreign keys are `RESTRICT`, so a hard delete of a pupil is refused by the database. There is no anonymisation routine and no legal-hold flag. |
| **Risk if undecided** | An erasure request will arrive and there is no lawful, tested way to answer it. Worse would be building one on a guess: erasing a pupil touches attendance, grades, invoices and the audit trail, and which of those may be erased versus must be retained is exactly the legal question. A wrong implementation is an unlawful deletion. |
| **Options** | (a) Deactivation only, with erasure handled as a documented manual procedure under legal supervision. (b) Build anonymisation that scrubs direct identifiers while preserving statistical and financial rows. (c) Full erasure with a legal-hold veto. |
| **Recommended default** | (a) for pilot. Then (b) once the retention schedule in item 3 exists, because anonymisation rules are derived from it. `policy.erasure.legal_hold_blocks_erasure` is already `true` so the veto has somewhere to read from when built. |
| **Owner** | Privacy officer + legal reviewer |
| **Blocks** | **PROD** |

## 5. Payroll creator/approver separation

| | |
|---|---|
| **Today** | **Enforced.** The user who drafted or processed a run cannot approve it (HTTP 422). Now readable from `policy.payroll.creator_cannot_approve`, defaulting to `true` — behaviour is unchanged. |
| **Risk if undecided** | Low, and the risk runs the other way: this control exists and works. The open question is whether a school small enough to have one finance user can operate at all with it on. |
| **Options** | (a) Keep enforced; the school must nominate a second approver (an administrator qualifies). (b) Allow self-approval for named single-user schools. |
| **Recommended default** | (a). This is a standard segregation of duty over money leaving the organisation; relaxing it should be an explicit, recorded exception. |
| **Owner** | Finance owner |
| **DECIDED 2026-08-15** | Keep enforced. The school nominates a second approver; an administrator qualifies. |
| **Blocks** | resolved — confirm the nominated approver exists before the first run. |

## 6. Payroll cancellation and reversal semantics

| | |
|---|---|
| **Today** | States are `draft → processed → approved → paid`, with `reverse` allowed from `approved` or `paid`. **There is no `cancelled` state.** Reversal posts a compensating journal, leaving both the original and the correction visible. Reversal is refused inside a `closed` or `audited` accounting period. |
| **Risk if undecided** | A run created in error is unwound by reversing it, which leaves a paired entry in the ledger. If the school's accounting policy expects an erroneous unpaid run to vanish rather than be reversed, the books will not match their expectation — and inventing a cancellation that deletes ledger history would be worse. |
| **Options** | (a) Reversal only (current). (b) Add a true `cancelled` state for runs that were never approved or paid, with no ledger effect. (c) Reversal plus a void-before-approval shortcut. |
| **Recommended default** | (a) unchanged until an accounting owner defines cancellation semantics. `policy.payroll.cancellation_supported` is `false` so the gap is stated rather than implied. |
| **Owner** | Finance owner / school accountant |
| **Blocks** | **USE** (payroll) |

## 7. Attendance correction windows and approvers

| | |
|---|---|
| **Today** | Teachers may record or amend attendance for **48 hours** after the session (`policy.attendance.edit_window_hours`); afterwards the endpoint returns 422 and an administrator must make the change. 48 is an engineering default, not a school's choice. `admin_correction_requires_reason` defaults `true`. |
| **Risk if undecided** | Attendance is a legal record and, in many jurisdictions, evidence in safeguarding and welfare processes. Too short a window and teachers cannot fix honest errors, so registers get falsified elsewhere; too long and a register can be rewritten well after the fact. |
| **Options** | 24 h / 48 h / 72 h / end of week, with or without a mandatory reason on late corrections, and optionally a second approver for changes older than a term. |
| **Recommended default** | Keep 48 h with a mandatory reason for administrator corrections. Confirm against the school's attendance policy before the first term. |
| **Owner** | Attendance officer |
| **Blocks** | **USE** (attendance) |

## 8. Grade changes after publication

| | |
|---|---|
| **Today** | A gradebook moves `draft → submitted → approved → finalized`. An administrator may `reopen` a finalized gradebook. Every score change is versioned and written to `grade_change_history` with actor and reason — including the initial entry — so history is complete regardless of the policy chosen. |
| **Risk if undecided** | Without a stated rule, a published mark can be changed by any administrator with no second pair of eyes. The change is fully auditable, but auditable is not the same as authorised. |
| **Options** | (a) Administrators may reopen (current). (b) Finalized is immutable; corrections only via a reissued report card. (c) Reopen requires a second approver. |
| **Recommended default** | (a) for pilot, since the audit trail is complete and reversible. Move to (c) before results are used for progression or reporting to an authority. |
| **Owner** | Academic registrar |
| **Blocks** | **USE** (grading) |

## 9. Report-card reissue authority

| | |
|---|---|
| **Today** | Reissue is an **administrator** route. A correction reason is **required** whenever a prior version exists. Each issue stores an immutable snapshot with a checksum and an incrementing `issue_version`, so superseded report cards remain reconstructable. |
| **Risk if undecided** | A reissued report card is what a family and a receiving school rely on. Without a stated authority, whoever holds an admin account can supersede a published result. |
| **Options** | (a) Any administrator (current). (b) Registrar role only. (c) Two-person approval for reissue after distribution. |
| **Recommended default** | (b) — narrow to the registrar. `policy.grades.reissue_requires_second_approver` exists (default `false`) for (c) when required; the enforcement is not built, so choosing (c) is a development request, not a config change. |
| **Owner** | Academic registrar |
| **Blocks** | **USE** (grading) |

## 10. Multi-school user behaviour

| | |
|---|---|
| **Today** | **Fails closed.** A user with more than one active school assignment is denied access entirely, and no token is issued at login. `policy.tenancy.multi_school_users_allowed` is `false`. |
| **Risk if undecided** | Low for correctness — the failure is safe. The cost is operational: a genuinely shared member of staff (a peripatetic teacher, a group finance officer) cannot use the system at all, and the error message will read as a bug to them. |
| **Options** | (a) Keep fail-closed; give shared staff one account per school. (b) Build an explicit school-selection step that re-authorises on every switch. |
| **Recommended default** | (a). (b) is a design task touching the tenant boundary and must not be improvised. |
| **Owner** | Platform owner |
| **Blocks** | — (but tell the school before onboarding shared staff) |

## 11. Privacy requests and data exports

| | |
|---|---|
| **Today** | **No subject-access export exists.** There is no endpoint or command that assembles everything held about one person. Operational exports exist but are scoped to a class, a period or a report — not to an individual. |
| **Risk if undecided** | A subject-access request would be answered by hand from the database, which is slow, error-prone and itself a privacy risk. It also risks over-disclosure: a naive dump includes other pupils' data in shared records such as messages and class registers. |
| **Options** | (a) Manual procedure, documented, with a named responder. (b) Build a per-subject export that assembles the record and redacts third parties. (c) Provider tooling. |
| **Recommended default** | (a) for pilot with a documented runbook and a response-time commitment; (b) before general production. |
| **Owner** | Privacy officer |
| **Blocks** | **PROD** |

## 12. Security incident and breach-notification ownership

| | |
|---|---|
| **Today** | The runbook has a severity scale, a first-five-minutes checklist and a suspected-exposure procedure (freeze deploys, preserve evidence, scope with read-only assertions, revoke sessions). Alerts route to four **placeholder** owners. **No notification deadline, no regulator, and no named human are recorded.** |
| **Risk if undecided** | Breach notification is usually time-bound in law. Discovering at 2 a.m. that nobody knows who declares a breach, or to whom, burns the window itself. |
| **Options** | Name a primary and deputy; record the regulator and statutory deadline; decide who informs families and who may speak publicly. |
| **Recommended default** | None available — engineering cannot infer a regulator or a deadline. This must be supplied. |
| **Owner** | School operations owner + privacy officer + legal reviewer |
| **Blocks** | **PILOT** — a pilot processes real data and can suffer a real breach. |

## 13. Deployment, database, finance, security and support owners

| | |
|---|---|
| **Today** | Four placeholders exist and alerts route to them: `ALERT_OWNER_PLATFORM`, `ALERT_OWNER_DATA`, `ALERT_OWNER_FINANCE`, `ALERT_OWNER_SECURITY`. Alerts fire and are logged regardless, so a placeholder is a routing gap rather than silence. |
| **Risk if undecided** | Every monitor fires into a channel nobody owns. The system is well instrumented and completely unattended, which is arguably worse than no monitoring, because it produces false confidence. |
| **Options** | Name individuals, or a rota, or an on-call tool integration per role. |
| **Recommended default** | Name one person and one deputy per role before the pilot; a rota can come later. |
| **Owner** | School operations owner |
| **Blocks** | **PILOT** |

## 14. Pilot support and escalation contacts

| | |
|---|---|
| **Today** | Nothing recorded. No support hours, no escalation path, no contact route for a teacher who cannot log in on results day. |
| **Risk if undecided** | Pilot problems surface as staff quietly abandoning the system and reverting to spreadsheets, which produces a false verdict on the pilot itself. |
| **Options** | Named school-side champion plus a supplier contact; agreed hours; a severity-to-response-time table. |
| **Recommended default** | A named champion per module (attendance, grading, finance), a single escalation contact, and support hours covering the school day for the pilot's duration. |
| **Owner** | School operations owner |
| **Blocks** | **PILOT** |

---

## What is blocking, in order

Before a pilot with real data:

1. **§2** backup encryption and off-host copy — *decided, implementation outstanding*
2. **§12** breach-notification owner, regulator and statutory deadline — **open**
3. **§13** real names behind the four alert placeholders — **open**
4. **§14** support and escalation contacts — **open**

~~§1 RPO/RTO~~ — decided 2026-08-15.

Additionally before general production: **§3** retention schedule, **§4** erasure
and legal-hold behaviour, **§11** subject-access process.

Before first use of each module: **§5**/**§6** payroll, **§7** attendance,
**§8**/**§9** grading.

## What engineering changed, and what it deliberately did not

Changed — configuration and safety only:

- `config/policy.php` collects every open decision with safe defaults.
- `audit:clean` no longer deletes on an unapproved default. This is a **fix**:
  it was destroying compliance records daily.
- Payroll separation and the attendance window read from policy config;
  behaviour and defaults are unchanged.
- `policy:status` reports undecided items and exits non-zero when one blocks the
  requested stage.
- 14 tests pin the safe defaults so a refactor cannot quietly restore the old
  behaviour.

Deliberately not built, because each encodes a decision that is not
engineering's to make: erasure and anonymisation (§4), subject-access export
(§11), payroll cancellation (§6), second-approver enforcement for reissue (§9),
multi-school selection (§10), and any retention period (§3).
