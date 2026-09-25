<?php

/*
|--------------------------------------------------------------------------
| External Integrations
|--------------------------------------------------------------------------
|
| Each external provider is explicitly enabled or disabled, and the default is
| off. An integration that is merely "configured" — a key present, a host set —
| is not the same as one somebody has verified end to end, and a half-configured
| provider is the worst of both worlds: it looks live, fails silently, and the
| failure surfaces as a parent never receiving a fee reminder.
|
| Two behaviours per integration:
|
|   enabled     Whether the application may talk to the provider at all.
|   fail_closed Whether an attempt to use a disabled or unconfigured provider
|               raises, or is skipped and recorded.
|
| fail_closed matters most for payments: silently skipping a webhook would let
| the system believe a payment succeeded when nothing was verified. For push
| notifications the opposite is true — a missing push should never break the
| request that triggered it, because the in-app and email channels still work.
|
*/

return [

    'mail' => [
        // Laravel's own MAIL_MAILER decides the transport; this decides whether
        // the application is willing to send at all. Turning it off leaves
        // in-app notifications working while suppressing outbound mail, which
        // is what a staging environment without a verified sending domain
        // should do rather than silently bouncing messages at real addresses.
        'enabled' => (bool) env('MAIL_ENABLED', true),

        // Refuse to queue mail rather than pretend it was sent.
        'fail_closed' => (bool) env('MAIL_FAIL_CLOSED', false),

        // Hard guard against a staging or pilot deployment mailing real
        // families. When set, every outbound recipient must match one of these
        // patterns or the message is dropped and recorded.
        'allowed_recipient_patterns' => array_values(array_filter(array_map(
            'trim',
            explode(',', (string) env('MAIL_ALLOWED_RECIPIENTS', ''))
        ))),
    ],

    'payments' => [
        // Online card payments. Disabled means the payment endpoints refuse
        // rather than half-work; manual receipts remain fully available, so a
        // school can operate without a payment provider at all.
        'enabled' => (bool) env('PAYMENTS_ENABLED', false),

        // Always fail closed. A payment path that silently no-ops can record
        // money that was never taken.
        'fail_closed' => (bool) env('PAYMENTS_FAIL_CLOSED', true),
    ],

    'push' => [
        // Push notifications are an enhancement over in-app and email
        // delivery, never the only channel.
        'enabled' => (bool) env('PUSH_ENABLED', false),

        // Deliberately open: a failed push must not break the request that
        // triggered it. The failure is still recorded on the delivery row.
        'fail_closed' => (bool) env('PUSH_FAIL_CLOSED', false),
    ],

    'error_reporting' => [
        // Sending telemetry to a third party is itself a data-protection
        // decision, so it is opt-in and off by default.
        'enabled' => (bool) env('ERROR_REPORTING_ENABLED', false),
        'dsn' => env('ERROR_REPORTING_DSN'),
        'traces_sample_rate' => (float) env('ERROR_REPORTING_TRACES_SAMPLE_RATE', 0.0),
    ],

];
