<?php

declare(strict_types=1);

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Throwable;

/**
 * Delivers operational alerts.
 *
 * Two rules shape this:
 *
 * 1. An alert is always written to the log channel the platform collects, even
 *    when webhook delivery succeeds. A monitoring tool that is itself down must
 *    not take the record of the incident with it.
 * 2. Delivery failure is never fatal. The monitor that raised the alert has
 *    already done its job; if the webhook is unreachable that is itself logged,
 *    and the local record survives.
 *
 * Alert bodies carry counts, thresholds and component names — never a student,
 * a credential or a payment detail. They are scrubbed regardless, because an
 * exception message folded into a monitor result is exactly how personal data
 * ends up in a chat channel.
 */
final class AlertDispatcher
{
    public function __construct(private readonly TelemetryScrubber $scrubber) {}

    /**
     * @param  'warning'|'critical'  $severity
     * @param  array<string, mixed>  $context
     * @return array{delivered: list<string>, failed: list<string>}
     */
    public function send(string $monitor, string $severity, string $summary, array $context = []): array
    {
        $owner = $this->ownerFor($monitor);

        $alert = [
            'monitor' => $monitor,
            'severity' => $severity,
            'summary' => $this->scrubber->scrubString($summary),
            'owner' => $owner,
            'environment' => (string) config('app.env'),
            'release' => (string) config('app.release', 'unknown'),
            'timestamp' => now()->toIso8601String(),
            'context' => $this->scrubber->scrub($context),
        ];

        // Local record first, always.
        Log::channel(config('logging.default'))->log(
            $severity === 'critical' ? 'critical' : 'warning',
            "alert[$monitor/$severity] ".$alert['summary'],
            $alert
        );

        $delivered = ['log'];
        $failed = [];

        if (filled($url = config('alerting.channels.webhook_url'))) {
            try {
                Http::timeout(5)->connectTimeout(3)->post($url, $alert)->throw();
                $delivered[] = 'webhook';
            } catch (Throwable $e) {
                $failed[] = 'webhook';
                Log::error('Alert webhook delivery failed', [
                    'monitor' => $monitor,
                    'reason' => $this->scrubber->scrubString($e->getMessage()),
                ]);
            }
        }

        $recipients = (array) config('alerting.channels.mail_to');
        if ($recipients !== [] && app(IntegrationGate::class)->enabled(IntegrationGate::MAIL)) {
            try {
                $body = "{$alert['summary']}\n\n"
                    ."monitor: {$alert['monitor']}\n"
                    ."severity: {$alert['severity']}\n"
                    ."owner: {$alert['owner']}\n"
                    ."environment: {$alert['environment']}\n"
                    ."release: {$alert['release']}\n"
                    .'context: '.json_encode($alert['context'], JSON_THROW_ON_ERROR);

                Mail::raw($body, function ($message) use ($recipients, $alert) {
                    $message->to($recipients)
                        ->subject("[{$alert['severity']}] {$alert['monitor']} — {$alert['environment']}");
                });
                $delivered[] = 'mail';
            } catch (Throwable $e) {
                $failed[] = 'mail';
                Log::error('Alert mail delivery failed', [
                    'monitor' => $monitor,
                    'reason' => $this->scrubber->scrubString($e->getMessage()),
                ]);
            }
        }

        return ['delivered' => $delivered, 'failed' => $failed];
    }

    public function ownerFor(string $monitor): string
    {
        $key = (string) config("alerting.routing.$monitor", 'platform');

        return (string) config("alerting.owners.$key", 'PLACEHOLDER-unrouted');
    }
}
