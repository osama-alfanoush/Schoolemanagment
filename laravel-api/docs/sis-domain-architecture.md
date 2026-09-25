# SIS Domain Architecture Decisions

Status: Accepted for implementation baseline; school-specific policies remain approval gates.  
Last updated: 2026-07-16

## Organizational scope

- `organizations` own one or more `schools`.
- Every operational or education record resolves to exactly one school, directly or through its enrollment/section.
- `school_user_roles` is the authoritative scoped-role assignment. `users.role` remains a temporary compatibility projection until every client uses scoped assignments.
- The data migration creates one default organization and school and backfills all legacy records into it.
- Authorization is permission plus school scope; neither condition is sufficient alone.

## Enrollment

- `student_enrollments` is the authoritative, effective-dated placement record.
- `student_profiles.class_room_id` remains a read-only compatibility projection during migration.
- One student may have only one open `active` enrollment per school.
- Date ranges for accepted/active/transferred/withdrawn enrollment records may not overlap within a school.
- Transfer closes the old enrollment and creates the new enrollment in one transaction. Historical attendance, grades, invoices, and report cards continue to reference the old enrollment.
- Ambiguous legacy records are reported by a reconciliation command and are never guessed into a finalized state.

## Academic calendar

- Academic years belong to a school and contain typed terms (`semester`, `trimester`, `quarter`, or `custom`).
- Grading periods are effective-dated children of terms. Names and counts are configuration, not code constants.
- All dates are stored as dates or UTC timestamps. School timezone is an explicit `schools.timezone` value used for day boundaries and scheduled jobs.
- Periods must fall within their parent year and may not overlap unless the school marks them as an intentionally parallel custom period.

## Course delivery

- `courses` describe catalog subjects; `course_sections` represent a scheduled offering in a term.
- `section_teachers` supports co-teaching with effective dates and a designated responsibility type.
- `section_enrollments` is effective-dated and derives from an active school enrollment.
- New attendance and gradebook work references sections. Legacy class/subject columns remain compatibility projections until clients migrate.

## Gradebook lifecycle

- State transitions are `draft -> submitted -> approved -> finalized`; an approver may return a submitted book, and an authorized administrator may reopen a finalized book for a bounded correction window.
- Teachers may change scores only in `draft`, `returned`, or unexpired `reopened` gradebooks.
- Every score has an integer version. Updates use compare-and-swap and return HTTP 409 when the supplied version is stale.
- Finalized report cards are immutable issue snapshots. Corrections create a new issue version and preserve the original.
- Component weights are nonnegative and the configured period total must equal the school policy target before submission.

## Deletion and retention

- Education, attendance, conduct, health, invoice, payment, payroll, and accounting records are retained records and cannot be cascade-deleted from reference entities.
- Classes, subjects, courses, fee structures, and calendars are archived with actor, time, and reason; archive status prevents new use but does not change historical reports.
- Physical deletion is limited to approved maintenance after dependency preview, retention validation, legal-hold validation, and audited authorization.

## Required school approvals

- Grading scale, rounding, missing-work behavior, approval roles, and reopen window.
- Attendance day/period model, statuses, correction window, and holiday override policy.
- Retention schedule and legal-hold process.
- School timezone, academic calendar, and transfer/withdrawal reason dictionaries.

