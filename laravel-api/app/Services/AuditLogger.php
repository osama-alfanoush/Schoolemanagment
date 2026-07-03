<?php

namespace App\Services;

use App\Models\AuditLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AuditLogger
{
    /**
     * Keys whose values must never be persisted in the audit trail (case-insensitive,
     * matched as substrings). Covers credentials, tokens, and payment secrets that
     * may appear in request payloads passed as `$changes`.
     */
    private const REDACTED_KEYS = [
        'password',
        'token',
        'secret',
        'authorization',
        'client_secret',
        'api_key',
        'apikey',
        'private_key',
        'webhook_secret',
        'card_number',
        'cvv',
    ];

    private const REDACTED_PLACEHOLDER = '[REDACTED]';

    public static function log(Request $request, string $action, ?string $entityType = null, ?int $entityId = null, array $changes = [], ?int $userId = null): void
    {
        $data = [
            'user_id' => $userId ?? $request->user()?->id,
            'action' => $action,
            'entity_type' => $entityType,
            'entity_id' => $entityId,
            'changes' => self::redact($changes),
            'ip' => $request->ip(),
            'user_agent' => substr((string) $request->userAgent(), 0, 500),
        ];

        $channel = config('audit.log_channel', 'daily');
        if ($channel && $channel !== 'database') {
            Log::channel($channel)->info('Audit: '.$action, $data);
        }

        AuditLog::create($data);
    }

    /**
     * Recursively replace the values of sensitive keys with a placeholder so secrets
     * are never written to the audit table or log files.
     */
    public static function redact(array $changes): array
    {
        foreach ($changes as $key => $value) {
            if (is_string($key) && self::isSensitiveKey($key)) {
                $changes[$key] = self::REDACTED_PLACEHOLDER;

                continue;
            }
            if (is_array($value)) {
                $changes[$key] = self::redact($value);
            }
        }

        return $changes;
    }

    private static function isSensitiveKey(string $key): bool
    {
        $key = strtolower($key);
        foreach (self::REDACTED_KEYS as $needle) {
            if (str_contains($key, $needle)) {
                return true;
            }
        }

        return false;
    }

    public static function clean(int $keepDays = 90): int
    {
        $cutoff = now()->subDays($keepDays);

        return AuditLog::where('created_at', '<', $cutoff)->delete();
    }
}
