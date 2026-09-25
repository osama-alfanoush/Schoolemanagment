<?php

declare(strict_types=1);

namespace Tests\Unit;

use App\Services\AuditLogger;
use PHPUnit\Framework\TestCase;

class AuditLoggerRedactTest extends TestCase
{
    public function test_it_redacts_sensitive_keys_recursively(): void
    {
        $redacted = AuditLogger::redact([
            'name' => 'Alice',
            'password' => 'secret123',
            'new_password' => 'hunter2',
            'client_secret' => 'cs_test_abc',
            'nested' => ['api_key' => 'abc', 'keep' => 'ok'],
        ]);

        $this->assertSame('Alice', $redacted['name']);
        $this->assertSame('[REDACTED]', $redacted['password']);
        $this->assertSame('[REDACTED]', $redacted['new_password']);
        $this->assertSame('[REDACTED]', $redacted['client_secret']);
        $this->assertSame('[REDACTED]', $redacted['nested']['api_key']);
        $this->assertSame('ok', $redacted['nested']['keep']);
    }

    public function test_it_leaves_non_sensitive_payloads_untouched(): void
    {
        $payload = ['role' => 'teacher', 'count' => 3, 'invoice_ids' => [1, 2, 3]];

        $this->assertSame($payload, AuditLogger::redact($payload));
    }

    /**
     * MFA recovery codes and session material are bearer credentials: anyone
     * able to read the audit trail could otherwise replay them.
     */
    public function test_it_redacts_mfa_and_session_credentials(): void
    {
        $redacted = AuditLogger::redact([
            'recovery_code' => 'ABCDE-FGHIJ',
            'recovery_codes' => ['ABCDE-FGHIJ', 'KLMNO-PQRST'],
            'mfa_secret' => 'JBSWY3DPEHPK3PXP',
            'otp' => '123456',
            'totp_code' => '654321',
            'cookie' => 'school_access=abc',
            'set_cookie' => 'school_refresh=def',
            'xsrf_token' => 'csrf-value',
            'csrf' => 'csrf-value',
            'stripe_signature' => 't=1,v1=abc',
            'credential' => 'raw',
            'iban' => 'DE89370400440532013000',
            'nested' => ['recovery_codes' => ['X'], 'action' => 'mfa_reset'],
        ]);

        foreach ([
            'recovery_code', 'recovery_codes', 'mfa_secret', 'otp', 'totp_code',
            'cookie', 'set_cookie', 'xsrf_token', 'csrf', 'stripe_signature',
            'credential', 'iban',
        ] as $key) {
            $this->assertSame('[REDACTED]', $redacted[$key], "$key was not redacted");
        }

        $this->assertSame('[REDACTED]', $redacted['nested']['recovery_codes']);
        $this->assertSame('mfa_reset', $redacted['nested']['action']);
    }
}
