<?php

declare(strict_types=1);

namespace App\Services;

use RuntimeException;

/**
 * The single decision point for "may we talk to this provider right now?".
 *
 * Three states, and the difference between the last two is the whole point:
 *
 *   enabled       configured and switched on — proceed.
 *   disabled      deliberately off. Skipped quietly, or refused loudly if the
 *                 integration is one where silence would be dangerous.
 *   misconfigured switched on but missing what it needs. Always an error,
 *                 never a silent skip, because someone believed it was working.
 *
 * A provider nobody has verified end to end stays off. That is the safe state:
 * manual receipts still work without a payment provider, in-app notifications
 * still work without push, and the application never reports success for an
 * external call it did not make.
 */
final class IntegrationGate
{
    public const MAIL = 'mail';

    public const PAYMENTS = 'payments';

    public const PUSH = 'push';

    public const ERROR_REPORTING = 'error_reporting';

    /**
     * Whether the integration may be used. Does not throw — callers that must
     * refuse loudly use ensureAvailable() instead.
     */
    public function enabled(string $integration): bool
    {
        return (bool) config("integrations.$integration.enabled", false)
            && $this->missingRequirement($integration) === null;
    }

    /**
     * Assert the integration is usable, or fail in the way that integration
     * has been configured to fail.
     *
     * @throws RuntimeException when the integration is unusable and fail_closed
     */
    public function ensureAvailable(string $integration): void
    {
        if (! config("integrations.$integration.enabled", false)) {
            if ($this->failsClosed($integration)) {
                throw new RuntimeException(
                    "The [$integration] integration is disabled. Enable it and supply its credentials, "
                    .'or use the manual workflow instead.'
                );
            }

            return;
        }

        // Enabled but incomplete is always an error: somebody switched this on
        // believing it worked.
        $missing = $this->missingRequirement($integration);
        if ($missing !== null) {
            throw new RuntimeException(
                "The [$integration] integration is enabled but not configured: $missing"
            );
        }
    }

    public function failsClosed(string $integration): bool
    {
        return (bool) config("integrations.$integration.fail_closed", false);
    }

    /**
     * What the integration still needs before it can be used, or null when it
     * is complete. Never returns a credential value.
     */
    public function missingRequirement(string $integration): ?string
    {
        return match ($integration) {
            self::PAYMENTS => match (true) {
                blank(config('services.payment.stripe.secret_key')) => 'STRIPE_SECRET_KEY is not set.',
                blank(config('services.payment.stripe.webhook_secret')) => 'STRIPE_WEBHOOK_SECRET is not set, so webhooks cannot be signature-verified.',
                default => null,
            },
            self::PUSH => blank(config('services.fcm.server_key'))
                ? 'FCM_SERVER_KEY is not set.'
                : null,
            self::ERROR_REPORTING => blank(config('integrations.error_reporting.dsn'))
                ? 'ERROR_REPORTING_DSN is not set.'
                : null,
            self::MAIL => match (true) {
                config('mail.default') === 'smtp' && blank(config('mail.mailers.smtp.host')) => 'MAIL_HOST is not set for the smtp transport.',
                blank(config('mail.from.address')) => 'MAIL_FROM_ADDRESS is not set.',
                default => null,
            },
            default => null,
        };
    }

    /**
     * A machine-readable status for every integration, for ops:smoke, the
     * health endpoint and the deployment preflight. Contains no secrets.
     *
     * @return array<string, array{enabled: bool, usable: bool, fail_closed: bool, detail: string}>
     */
    public function report(): array
    {
        $report = [];

        foreach ([self::MAIL, self::PAYMENTS, self::PUSH, self::ERROR_REPORTING] as $integration) {
            $switchedOn = (bool) config("integrations.$integration.enabled", false);
            $missing = $this->missingRequirement($integration);

            $report[$integration] = [
                'enabled' => $switchedOn,
                'usable' => $switchedOn && $missing === null,
                'fail_closed' => $this->failsClosed($integration),
                'detail' => match (true) {
                    $switchedOn && $missing !== null => 'misconfigured: '.$missing,
                    $switchedOn => 'enabled',
                    default => 'disabled',
                },
            ];
        }

        return $report;
    }
}
