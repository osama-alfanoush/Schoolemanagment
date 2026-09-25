<?php

return [
    /*
    | Log channel for the audit trail's log-stream mirror.
    |
    | The `audit_logs` table is the authoritative trail; this is the copy that
    | goes to log aggregation. It defaults to the application's own log channel
    | rather than 'daily' on purpose: in a container LOG_CHANNEL is stderr, and
    | a hard-coded 'daily' wrote audit events to a container-local file that no
    | collector reads and that is destroyed on the next redeploy.
    |
    | Set to null to disable the mirror entirely (database-only).
    | Supported: 'stack', 'single', 'daily', 'stderr', 'syslog', null
    */
    'log_channel' => env('AUDIT_LOG_CHANNEL', env('LOG_CHANNEL', 'daily')),

    /*
    | Default retention period (days) for audit logs.
    | Used by the audit:clean artisan command.
    */
    'retention_days' => env('AUDIT_RETENTION_DAYS', 90),
];
