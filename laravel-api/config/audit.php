<?php

return [
    /*
    | Log channel for audit trail entries.
    | Set to null to disable file logging (database-only).
    | Supported: 'single', 'daily', 'stderr', 'syslog', null
    */
    'log_channel' => env('AUDIT_LOG_CHANNEL', 'daily'),

    /*
    | Default retention period (days) for audit logs.
    | Used by the audit:clean artisan command.
    */
    'retention_days' => env('AUDIT_RETENTION_DAYS', 90),
];
