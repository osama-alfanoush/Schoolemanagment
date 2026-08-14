<?php

/*
|--------------------------------------------------------------------------
| School and Data Policy
|--------------------------------------------------------------------------
|
| Decisions that belong to the school, not to engineering: how long records are
| kept, who may approve what, when a correction window closes. They are
| collected here so they are visible, configurable and reviewable, rather than
| buried as literals across a dozen services.
|
| Three rules govern this file:
|
|  1. Nothing here invents a policy. Every value is either an engineering-safe
|     default that does nothing irreversible, or it is null and the feature that
|     depends on it refuses to run.
|  2. Anything destructive is gated behind an explicit approval flag. Retention
|     that deletes records stays off until a named owner turns it on, because
|     the cost of deleting a pupil's record too early is not recoverable and the
|     cost of keeping it too long is a conversation.
|  3. Defaults are chosen so that leaving them alone is safe, not so that the
|     software looks feature-complete.
|
| docs/decision-register.md carries the options, risks and required owner for
| each entry. `php artisan policy:status` reports which are still undecided.
|
*/

return [

    /*
    |----------------------------------------------------------------------
    | Record retention
    |----------------------------------------------------------------------
    |
    | Education, employment and financial records are subject to statutory
    | minimum retention periods that vary by jurisdiction. Engineering cannot
    | pick these. Until a schedule is approved, nothing expires.
    |
    | `approved` is the safety catch: while it is false, retention settings are
    | advisory and no scheduled job will delete anything, whatever the day
    | counts below say.
    */
    'retention' => [
        // Set true ONLY when a named owner has approved the schedule below and
        // recorded the approval in docs/decision-register.md.
        'approved' => (bool) env('RETENTION_POLICY_APPROVED', false),

        // Who approved it, for the audit trail. Free text, e.g. a role and date.
        'approved_by' => env('RETENTION_POLICY_APPROVED_BY'),

        // Days to keep each class of record. null means "keep indefinitely",
        // which is the safe default: over-retention is a policy problem,
        // premature deletion is an unrecoverable one.
        'audit_log_days' => env('RETENTION_AUDIT_LOG_DAYS') !== null
            ? (int) env('RETENTION_AUDIT_LOG_DAYS')
            : null,
        'student_record_days' => env('RETENTION_STUDENT_RECORD_DAYS') !== null
            ? (int) env('RETENTION_STUDENT_RECORD_DAYS')
            : null,
        'staff_record_days' => env('RETENTION_STAFF_RECORD_DAYS') !== null
            ? (int) env('RETENTION_STAFF_RECORD_DAYS')
            : null,
        'financial_record_days' => env('RETENTION_FINANCIAL_RECORD_DAYS') !== null
            ? (int) env('RETENTION_FINANCIAL_RECORD_DAYS')
            : null,
        'notification_days' => env('RETENTION_NOTIFICATION_DAYS') !== null
            ? (int) env('RETENTION_NOTIFICATION_DAYS')
            : null,
    ],

    /*
    |----------------------------------------------------------------------
    | Erasure, anonymisation and legal hold
    |----------------------------------------------------------------------
    |
    | Not implemented. A privacy request that erases a pupil also touches
    | attendance, grades, invoices and the audit trail, and which of those may
    | be erased versus must be retained is a legal question with a different
    | answer in each jurisdiction. Building it on an assumption would produce
    | either an unlawful deletion or a false promise to a parent.
    |
    | Until the rules are decided, the supported behaviour is deactivation,
    | which preserves the record and removes access.
    */
    'erasure' => [
        'enabled' => (bool) env('ERASURE_ENABLED', false),
        // When erasure is eventually built, a legal hold must veto it. The flag
        // exists now so the check has somewhere to read from.
        'legal_hold_blocks_erasure' => (bool) env('LEGAL_HOLD_BLOCKS_ERASURE', true),
    ],

    /*
    |----------------------------------------------------------------------
    | Payroll
    |----------------------------------------------------------------------
    */
    'payroll' => [
        // Segregation of duty: the person who drafts a run may not approve it.
        // Enforced today and defaulted on because removing it is the risky
        // direction — but a very small school may have only one finance user,
        // which is a business decision, not an engineering one.
        'creator_cannot_approve' => (bool) env('PAYROLL_CREATOR_CANNOT_APPROVE', true),

        // There is no `cancelled` state. An approved or paid run is unwound by
        // posting a reversing journal, which leaves both the original and the
        // correction visible. Whether the school also needs a true cancellation
        // for a run that was never paid is an accounting-policy question.
        'cancellation_supported' => false,
    ],

    /*
    |----------------------------------------------------------------------
    | Attendance
    |----------------------------------------------------------------------
    */
    'attendance' => [
        // Hours after the session during which a teacher may still record or
        // amend attendance. Past it the endpoint refuses and an administrator
        // must make the correction.
        'edit_window_hours' => (int) env('ATTENDANCE_EDIT_WINDOW_HOURS', 48),

        // Whether an administrator correction after the window must carry a
        // reason. Defaults on: a silent retrospective change to a legal
        // attendance record is exactly what an inspection would question.
        'admin_correction_requires_reason' => (bool) env('ATTENDANCE_CORRECTION_REQUIRES_REASON', true),
    ],

    /*
    |----------------------------------------------------------------------
    | Grades and report cards
    |----------------------------------------------------------------------
    */
    'grades' => [
        // A finalized gradebook can be reopened by an administrator. Every
        // change is versioned and written to grade_change_history regardless.
        'reopen_after_finalize' => (bool) env('GRADES_REOPEN_AFTER_FINALIZE', true),

        // Reissuing a report card already requires a correction reason. The
        // school decides whether reissue additionally needs a second approver.
        'reissue_requires_second_approver' => (bool) env('REPORT_CARD_REISSUE_SECOND_APPROVER', false),
    ],

    /*
    |----------------------------------------------------------------------
    | Multi-school users
    |----------------------------------------------------------------------
    |
    | A user with more than one active school assignment is denied rather than
    | guessed at. Switching that to a chooser requires a design that proves the
    | selected school is one the user is actually authorised for; until then,
    | fail closed.
    */
    'tenancy' => [
        'multi_school_users_allowed' => (bool) env('MULTI_SCHOOL_USERS_ALLOWED', false),
    ],

    /*
    |----------------------------------------------------------------------
    | Backup objectives
    |----------------------------------------------------------------------
    |
    | Targets, not mechanisms. ops:monitor alerts when the measured backup age
    | exceeds what the RPO implies, so setting these wrong makes the monitor
    | wrong rather than silently doing nothing.
    */
    'continuity' => [
        'rpo_minutes' => (int) env('BACKUP_RPO_MINUTES', 1440),
        'rto_minutes' => (int) env('RESTORE_RTO_MINUTES', 240),
        'backup_retention_days' => (int) env('BACKUP_RETENTION_DAYS', 14),
        // Whether backups are encrypted at rest by the storage layer. The
        // script does not encrypt; this records whether the destination does,
        // and policy:status reports it as undecided while null.
        'backups_encrypted_at_rest' => env('BACKUPS_ENCRYPTED_AT_REST') !== null
            ? (bool) env('BACKUPS_ENCRYPTED_AT_REST')
            : null,
        'offsite_location' => env('BACKUP_OFFSITE_LOCATION'),
    ],
];
