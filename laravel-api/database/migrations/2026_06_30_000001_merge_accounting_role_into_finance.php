<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * Merge the legacy 'accounting' role into the unified 'finance'
 * (Finance & Accounting) role. Existing accounting users keep all their
 * access — they simply become finance users, which can now reach both the
 * finance and accounting modules.
 */
return new class extends Migration
{
    public function up(): void
    {
        DB::table('users')->where('role', 'accounting')->update(['role' => 'finance']);
    }

    public function down(): void
    {
        // Irreversible: once merged we cannot tell which finance users were
        // originally accounting. No-op so rollbacks of later migrations succeed.
    }
};
