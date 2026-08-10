<?php

/*
|--------------------------------------------------------------------------
| Operational Alerting
|--------------------------------------------------------------------------
|
| Thresholds live here rather than in the checking code so an on-call engineer
| can tune them without a deploy, and so the runbook and the code cannot drift
| apart — the runbook quotes these names.
|
| Every threshold has two levels. Warning means look at it during the working
| day; critical means someone is woken up. A monitor with only one level either
| pages too often and gets muted, or pages too late.
|
| Recipients are placeholders until real people are recorded in
| docs/production-policy-owners.md. A placeholder that is obviously a
| placeholder is safer than a plausible-looking address nobody reads.
|
*/

return [

    // Where alerts go. Channels are tried in order; the log channel is always
    // written so there is a local record even when delivery fails.
    'channels' => [
        // A generic JSON webhook — Slack, Teams, PagerDuty, Opsgenie and most
        // on-call tools accept one. Unset means "log only".
        'webhook_url' => env('ALERT_WEBHOOK_URL'),

        // Email fallback. Only used when mail is enabled and usable.
        'mail_to' => array_values(array_filter(array_map(
            'trim',
            explode(',', (string) env('ALERT_MAIL_TO', ''))
        ))),
    ],

    /*
     | Named ownership. These are PLACEHOLDERS: replace each with a real rota or
     | address and record the decision in docs/production-policy-owners.md.
     | Alerts still fire and are still logged while they are placeholders.
     */
    'owners' => [
        'platform' => env('ALERT_OWNER_PLATFORM', 'PLACEHOLDER-platform-on-call'),
        'data' => env('ALERT_OWNER_DATA', 'PLACEHOLDER-database-owner'),
        'finance' => env('ALERT_OWNER_FINANCE', 'PLACEHOLDER-finance-systems-owner'),
        'security' => env('ALERT_OWNER_SECURITY', 'PLACEHOLDER-security-owner'),
    ],

    'thresholds' => [
        // Queue: a failed job is never normal, but one transient failure is not
        // a page. Sustained growth is.
        'failed_jobs_warning' => (int) env('ALERT_FAILED_JOBS_WARNING', 1),
        'failed_jobs_critical' => (int) env('ALERT_FAILED_JOBS_CRITICAL', 10),

        // Queue backlog: work arriving faster than it is processed.
        'queue_depth_warning' => (int) env('ALERT_QUEUE_DEPTH_WARNING', 100),
        'queue_depth_critical' => (int) env('ALERT_QUEUE_DEPTH_CRITICAL', 1000),

        // Scheduler heartbeat: the scheduler writes a timestamp every run. No
        // heartbeat means reminders, contract checks and outbox delivery have
        // stopped, which is silent until somebody notices missing mail.
        'scheduler_heartbeat_warning_seconds' => (int) env('ALERT_SCHEDULER_WARNING_SECONDS', 300),
        'scheduler_heartbeat_critical_seconds' => (int) env('ALERT_SCHEDULER_CRITICAL_SECONDS', 900),

        // Database connection saturation, as a percentage of max_connections.
        // Reaching the ceiling refuses new connections outright.
        'db_connection_warning_pct' => (int) env('ALERT_DB_CONN_WARNING_PCT', 70),
        'db_connection_critical_pct' => (int) env('ALERT_DB_CONN_CRITICAL_PCT', 90),

        // Redis memory, as a percentage of maxmemory. The policy is noeviction
        // so queued jobs are never silently dropped — which means a full Redis
        // starts refusing writes instead.
        'redis_memory_warning_pct' => (int) env('ALERT_REDIS_MEM_WARNING_PCT', 70),
        'redis_memory_critical_pct' => (int) env('ALERT_REDIS_MEM_CRITICAL_PCT', 90),

        // Backups. Daily schedule, so a day and a bit is a warning and two days
        // is a page.
        'backup_age_warning_hours' => (int) env('ALERT_BACKUP_WARNING_HOURS', 26),
        'backup_age_critical_hours' => (int) env('ALERT_BACKUP_CRITICAL_HOURS', 48),

        // Payment webhooks that failed to process. Any is worth looking at,
        // several in an hour means money is not being recorded.
        'webhook_failures_warning' => (int) env('ALERT_WEBHOOK_FAILURES_WARNING', 1),
        'webhook_failures_critical' => (int) env('ALERT_WEBHOOK_FAILURES_CRITICAL', 3),

        // Transactional outbox pending backlog.
        'outbox_pending_warning' => (int) env('ALERT_OUTBOX_WARNING', 100),
        'outbox_pending_critical' => (int) env('ALERT_OUTBOX_CRITICAL', 500),
    ],

    // Which owner each monitor pages.
    'routing' => [
        'dependencies' => 'platform',
        'queue' => 'platform',
        'scheduler' => 'platform',
        'database' => 'data',
        'redis' => 'platform',
        'backup' => 'data',
        'payments' => 'finance',
    ],
];
