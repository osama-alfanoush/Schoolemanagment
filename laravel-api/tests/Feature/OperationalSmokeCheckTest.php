<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class OperationalSmokeCheckTest extends TestCase
{
    public function test_operational_smoke_check_verifies_all_configured_dependencies(): void
    {
        Storage::fake('local');
        Storage::fake('uploads');

        $exitCode = Artisan::call('ops:smoke', ['--json' => true]);
        $result = json_decode(Artisan::output(), true, flags: JSON_THROW_ON_ERROR);

        $this->assertSame(0, $exitCode);
        $this->assertSame('ok', $result['status']);
        $this->assertSame('ok', $result['checks']['private_storage']['status']);
        $this->assertSame('ok', $result['checks']['public_upload_storage']['status']);
    }
}
