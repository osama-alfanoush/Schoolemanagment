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
}
