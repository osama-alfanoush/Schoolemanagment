-- Integrity assertions run against a RESTORED database.
--
-- Matching table counts prove the dump transferred rows; these queries prove
-- the rows are still usable: tenant ownership intact, no cross-school leakage
-- through a foreign key, financial documents still balanced, and the audit
-- trail still attributable. Any violation raises and fails the restore drill.
--
-- Safe to run repeatedly; performs no writes.

\set ON_ERROR_STOP on

DO $$
DECLARE
    violation_count bigint;
    detail text;
BEGIN
    -- 1. Every school-owned row must still carry a school that exists.
    SELECT count(*) INTO violation_count
    FROM invoices i LEFT JOIN schools s ON s.id = i.school_id WHERE s.id IS NULL;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % invoice(s) reference a missing school', violation_count;
    END IF;

    -- 2. Cross-school leakage: a child row must live in the same school as its
    --    parent. These are the joins the application relies on for isolation.
    SELECT count(*) INTO violation_count
    FROM payments p JOIN invoices i ON i.id = p.invoice_id
    WHERE p.school_id <> i.school_id;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % payment(s) belong to a different school than their invoice', violation_count;
    END IF;

    SELECT count(*) INTO violation_count
    FROM grades g JOIN grade_components gc ON gc.id = g.grade_component_id
    WHERE g.school_id <> gc.school_id;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % grade(s) belong to a different school than their component', violation_count;
    END IF;

    SELECT count(*) INTO violation_count
    FROM attendance_records a JOIN class_rooms c ON c.id = a.class_room_id
    WHERE a.school_id <> c.school_id;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % attendance record(s) belong to a different school than their class', violation_count;
    END IF;

    -- 3. Users must only be reachable through a membership row, and every
    --    membership must point at a real user and a real school.
    SELECT count(*) INTO violation_count
    FROM school_user_roles r
    LEFT JOIN users u ON u.id = r.user_id
    LEFT JOIN schools s ON s.id = r.school_id
    WHERE u.id IS NULL OR s.id IS NULL;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % school membership row(s) are orphaned', violation_count;
    END IF;

    -- 4. Parent/child links must not cross a school boundary.
    SELECT count(*) INTO violation_count
    FROM parent_student ps
    JOIN school_user_roles pr ON pr.user_id = ps.parent_user_id AND pr.school_id = ps.school_id
    RIGHT JOIN parent_student ps2 ON ps2.id = ps.id
    WHERE pr.id IS NULL;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % parent link(s) reference a parent outside the linked school', violation_count;
    END IF;

    -- 5. Double-entry invariant. Entries are one row per side, tagged
    --    type='debit'/'credit'; a batch (or, for system pairs posted without a
    --    batch, a source+source_id group) must have equal totals on both sides.
    SELECT count(*), coalesce(string_agg(DISTINCT batch_id::text, ','), '')
      INTO violation_count, detail
    FROM (
        SELECT je.journal_batch_id AS batch_id,
               round(sum(je.amount) FILTER (WHERE je.type = 'debit'), 2) AS d,
               round(sum(je.amount) FILTER (WHERE je.type = 'credit'), 2) AS c
        FROM journal_entries je
        WHERE je.journal_batch_id IS NOT NULL AND je.deleted_at IS NULL
        GROUP BY je.journal_batch_id
    ) b
    WHERE coalesce(b.d, 0) <> coalesce(b.c, 0);
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % journal batch(es) do not balance (batches: %)', violation_count, detail;
    END IF;

    SELECT count(*) INTO violation_count
    FROM (
        SELECT je.source, je.source_id,
               round(sum(je.amount) FILTER (WHERE je.type = 'debit'), 2) AS d,
               round(sum(je.amount) FILTER (WHERE je.type = 'credit'), 2) AS c
        FROM journal_entries je
        WHERE je.journal_batch_id IS NULL AND je.source_id IS NOT NULL AND je.deleted_at IS NULL
        GROUP BY je.source, je.source_id
    ) b
    WHERE coalesce(b.d, 0) <> coalesce(b.c, 0);
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % system-posted journal pair(s) do not balance', violation_count;
    END IF;

    -- 6. Payments must never exceed what was invoiced for a student invoice.
    SELECT count(*) INTO violation_count
    FROM (
        SELECT i.id, i.amount, coalesce(sum(p.amount), 0) AS paid
        FROM invoices i LEFT JOIN payments p ON p.invoice_id = i.id
        GROUP BY i.id, i.amount
    ) t
    WHERE t.paid > t.amount + 0.01;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % invoice(s) are over-paid', violation_count;
    END IF;

    -- 7. Payroll records must belong to a run in the same school.
    SELECT count(*) INTO violation_count
    FROM payroll_records pr JOIN payroll_runs run ON run.id = pr.payroll_run_id
    WHERE pr.school_id <> run.school_id;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % payroll record(s) belong to a different school than their run', violation_count;
    END IF;

    -- 8. The audit trail must remain attributable to a surviving school.
    SELECT count(*) INTO violation_count
    FROM audit_logs a LEFT JOIN schools s ON s.id = a.school_id
    WHERE s.id IS NULL;
    IF violation_count > 0 THEN
        RAISE EXCEPTION 'RESTORE ASSERTION FAILED: % audit log(s) reference a missing school', violation_count;
    END IF;

    RAISE NOTICE 'All restore integrity assertions passed.';
END
$$;

-- Per-school row distribution, printed as evidence that both tenants survived.
SELECT s.id AS school_id,
       s.code,
       (SELECT count(*) FROM school_user_roles r WHERE r.school_id = s.id) AS memberships,
       (SELECT count(*) FROM invoices i WHERE i.school_id = s.id) AS invoices,
       (SELECT count(*) FROM payments p WHERE p.school_id = s.id) AS payments,
       (SELECT count(*) FROM grades g WHERE g.school_id = s.id) AS grades,
       (SELECT count(*) FROM attendance_records a WHERE a.school_id = s.id) AS attendance,
       (SELECT count(*) FROM journal_entries j WHERE j.school_id = s.id) AS journal_entries,
       (SELECT count(*) FROM payroll_records pr WHERE pr.school_id = s.id) AS payroll_records,
       (SELECT count(*) FROM audit_logs al WHERE al.school_id = s.id) AS audit_logs
FROM schools s
ORDER BY s.id;
