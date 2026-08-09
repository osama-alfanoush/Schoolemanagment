# Foreign-Key Retention Inventory

Status: Migration design input  
Last updated: 2026-07-16

| Parent or domain | Representative dependent records | Classification | Required delete behavior |
|---|---|---|---|
| Users: students | profile, enrollments, attendance, grades, submissions, conduct, medical, invoices, payments, report cards | Legally/operationally retained | Deactivate user; restrict physical delete |
| Users: staff | assignments, attendance marks, grade changes, payroll, approvals, audit events | Retained accountability | Deactivate user; retain actor references or null only where actor is independently snapshotted |
| Academic years/terms | classes, sections, gradebooks, exams, reports | Historical academic | Archive/restrict |
| Classes/sections | enrollments, schedules, attendance, assignments, grades | Historical academic | Archive/restrict |
| Subjects/courses | sections, components, exams, grades | Historical academic | Archive/restrict |
| Assignments/components | submissions and grades | Student education record | Archive/restrict; never cascade grades |
| Fee structures | invoices and billing batches | Financial configuration/history | Archive; retain invoice snapshot |
| Invoices | payments, allocations, installments, receipts, journal sources | Financial retained | Cancel/reverse; restrict delete |
| Payments | allocations, gateway transactions, receipts, journal entries | Financial retained | Reverse with new event; prohibit delete |
| Suppliers/purchase orders | invoices, receipts, stock and ledger entries | Financial/operational retained | Archive/cancel; restrict delete after submission |
| Library/transport configuration | borrowings/assignments | Operational history | Archive; restrict while referenced |
| Notifications/messages | delivery attempts, disclosure evidence | Communication/privacy record | Retention-policy expiry, not parent cascade |
| Audit logs | all audited entities | Security/compliance | Append-only external retention; never application delete |

## Known destructive legacy constraints

The original schema uses `cascadeOnDelete()` on student users, parent links, class/subject teacher assignments, timetable entries, attendance, assignments, submissions, grade components, grades, conduct, invoices/payments, payroll, HR, announcements/messages, and several library/transport/medical records. New migrations must replace those constraints in small table groups and verify them against PostgreSQL. SQLite-only migration success is not sufficient evidence.

## Migration sequence

1. Add archive metadata and immutable snapshots before constraint changes.
2. Backfill enrollment, school, and section references and produce exception rows.
3. Add new restricted foreign keys under temporary names and validate them.
4. Remove legacy cascade constraints only after reconciliation is zero-loss.
5. Exercise delete/archive/restore behavior in PostgreSQL integration tests.
6. Rehearse rollback from a database snapshot and previous application image.

