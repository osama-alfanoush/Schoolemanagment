<?php

declare(strict_types=1);

namespace App\Services;

/**
 * Scrubs anything that must never leave the system inside telemetry.
 *
 * Error reporting sends data to a third party, so what it carries is a
 * data-protection decision rather than a debugging convenience. This is an
 * allow-by-shape scrubber over the whole event: keys whose NAME suggests a
 * credential or personal data are replaced, and free text is scanned for
 * patterns that look like a credential even when the key is innocuous
 * (a message body, an exception string, a URL query).
 *
 * Deliberately aggressive. A redacted field costs a few minutes of debugging;
 * a student's name or a bearer token in a third-party dashboard is a breach.
 */
final class TelemetryScrubber
{
    public const PLACEHOLDER = '[REDACTED]';

    /**
     * Key fragments whose values are always removed, matched case-insensitively
     * as substrings. Shares its intent with AuditLogger but is broader: audit
     * records are internal, telemetry leaves the building.
     *
     * @var list<string>
     */
    private const SENSITIVE_KEYS = [
        // Credentials and session material.
        'password', 'passwd', 'secret', 'token', 'authorization', 'auth',
        'api_key', 'apikey', 'private_key', 'credential', 'signature',
        'cookie', 'csrf', 'xsrf', 'session', 'bearer', 'otp', 'totp',
        'recovery_code', 'recovery_codes', 'mfa',
        // Payment instruments.
        'card_number', 'cardholder', 'card_expiry', 'cvv', 'cvc', 'iban',
        'account_number', 'sort_code', 'routing_number',
        // Personal data about students, families and staff.
        'email', 'phone', 'address', 'date_of_birth', 'dob', 'national_id',
        'admission_no', 'employee_no', 'medical', 'allergies', 'diagnosis',
        'guardian', 'emergency_contact', 'photo_path', 'first_name',
        'last_name', 'full_name',
    ];

    /**
     * Patterns that identify a credential wherever it appears, including inside
     * free text where the key name gives nothing away.
     *
     * @var list<string>
     */
    private const SENSITIVE_PATTERNS = [
        '/\b[A-Za-z0-9_-]*sk_(?:live|test)_[A-Za-z0-9]{8,}/',   // Stripe secret keys
        '/\bwhsec_[A-Za-z0-9]{8,}/',                             // Stripe signing secrets
        '/\bAKIA[0-9A-Z]{16}\b/',                                // AWS access key ids
        '/\bghp_[A-Za-z0-9]{20,}/',                              // GitHub tokens
        '/\bey[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}/', // JWTs
        '/\bBearer\s+[A-Za-z0-9._~+\/-]{10,}=*/i',               // bearer credentials
        '/\b\d{1,4}\|[A-Za-z0-9]{32,}\b/',                       // Sanctum plaintext tokens
        '/\b(?:\d[ -]*?){13,19}\b/',                             // card-shaped digit runs
        '/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/',      // email addresses
    ];

    /**
     * Scrub an arbitrary structure. Keys are matched by name; every string
     * value is additionally pattern-scanned.
     *
     * @param  array<array-key, mixed>  $data
     * @return array<array-key, mixed>
     */
    public function scrub(array $data, int $depth = 0): array
    {
        // Bound the walk: a deeply nested or self-referential payload must not
        // turn error reporting into an outage of its own.
        if ($depth > 12) {
            return [self::PLACEHOLDER];
        }

        foreach ($data as $key => $value) {
            if (is_string($key) && $this->isSensitiveKey($key)) {
                $data[$key] = self::PLACEHOLDER;

                continue;
            }

            $data[$key] = match (true) {
                is_array($value) => $this->scrub($value, $depth + 1),
                is_string($value) => $this->scrubString($value),
                default => $value,
            };
        }

        return $data;
    }

    public function scrubString(string $value): string
    {
        foreach (self::SENSITIVE_PATTERNS as $pattern) {
            $value = (string) preg_replace($pattern, self::PLACEHOLDER, $value);
        }

        return $value;
    }

    /**
     * A URL may carry credentials in its query string; the path is kept because
     * it is what makes an error report useful.
     */
    public function scrubUrl(string $url): string
    {
        $parts = parse_url($url);
        if ($parts === false) {
            return self::PLACEHOLDER;
        }

        $rebuilt = ($parts['scheme'] ?? 'https').'://'.($parts['host'] ?? 'unknown');
        if (isset($parts['port'])) {
            $rebuilt .= ':'.$parts['port'];
        }
        $rebuilt .= $parts['path'] ?? '';

        if (isset($parts['query'])) {
            parse_str($parts['query'], $query);
            $scrubbed = $this->scrub($query);
            $rebuilt .= '?'.http_build_query($scrubbed);
        }

        return $rebuilt;
    }

    public function isSensitiveKey(string $key): bool
    {
        $key = strtolower($key);

        foreach (self::SENSITIVE_KEYS as $needle) {
            if (str_contains($key, $needle)) {
                return true;
            }
        }

        return false;
    }
}
