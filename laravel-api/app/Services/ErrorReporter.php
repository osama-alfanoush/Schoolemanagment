<?php

declare(strict_types=1);

namespace App\Services;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Throwable;

/**
 * Error reporting, deliberately provider-agnostic.
 *
 * The project has no error-reporting account yet, and inventing a dependency on
 * one would either commit a DSN or leave a dead integration. Instead this
 * builds the event — with the context an on-call engineer actually needs — and
 * either posts it to a configured endpoint or writes it to the log channel the
 * platform already collects. Pointing it at Sentry later is a DSN and nothing
 * else; the event shape is already Sentry-compatible.
 *
 * Every event carries:
 *   environment  which deployment this came from
 *   release      the exact commit, so a regression is bisectable
 *   request_id   the correlation id echoed to the user, so a support ticket
 *                quoting it lands on the precise request
 *
 * Everything else passes through TelemetryScrubber first.
 */
final class ErrorReporter
{
    public function __construct(
        private readonly IntegrationGate $gate,
        private readonly TelemetryScrubber $scrubber,
    ) {}

    public function report(Throwable $exception, ?Request $request = null, array $extra = []): void
    {
        // Reporting must never become the cause of an outage.
        try {
            $event = $this->buildEvent($exception, $request, $extra);

            if (! $this->gate->enabled(IntegrationGate::ERROR_REPORTING)) {
                // No provider configured: the event still reaches the platform
                // log stream, which is collected and searchable.
                Log::channel(config('logging.default'))->error(
                    'error-event: '.$event['exception']['type'],
                    $event
                );

                return;
            }

            $this->deliver($event);
        } catch (Throwable $reportingFailure) {
            Log::warning('Error reporting failed', [
                'reason' => $reportingFailure->getMessage(),
            ]);
        }
    }

    /**
     * @return array<string, mixed>
     */
    public function buildEvent(Throwable $exception, ?Request $request = null, array $extra = []): array
    {
        $request ??= app()->bound('request') ? app('request') : null;

        $event = [
            'environment' => (string) config('app.env'),
            'release' => (string) config('app.release', 'unknown'),
            'timestamp' => now()->toIso8601String(),
            'level' => 'error',
            'exception' => [
                'type' => $exception::class,
                // The message may embed a query, a token or an email address.
                'value' => $this->scrubber->scrubString($exception->getMessage()),
                // File and line are internal paths, useful and not personal;
                // the project root is stripped so absolute layout is not
                // disclosed to a third party.
                'file' => str_replace(base_path().DIRECTORY_SEPARATOR, '', $exception->getFile()),
                'line' => $exception->getLine(),
            ],
            'extra' => $this->scrubber->scrub($extra),
        ];

        if ($request instanceof Request) {
            $event['request_id'] = (string) $request->headers->get('X-Request-Id', '');
            $event['request'] = [
                'method' => $request->method(),
                'url' => $this->scrubber->scrubUrl($request->fullUrl()),
                // Never the body, never the headers: both routinely carry
                // credentials and student data, and neither is worth the risk.
            ];

            // Identity by id only — never a name or an email address.
            $user = $request->user();
            if ($user) {
                $event['user'] = ['id' => $user->id, 'role' => $user->role];
            }

            $school = app(CurrentSchool::class);
            if ($school->has()) {
                $event['tenant'] = ['school_id' => $school->id()];
            }
        }

        return $event;
    }

    private function deliver(array $event): void
    {
        $dsn = (string) config('integrations.error_reporting.dsn');

        // A short timeout and no retry: a slow collector must not hold a worker
        // or a web request open.
        Http::timeout(3)->connectTimeout(2)->post($dsn, $event);
    }
}
