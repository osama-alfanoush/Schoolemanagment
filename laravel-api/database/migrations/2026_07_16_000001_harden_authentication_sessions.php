<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->timestamp('deactivated_at')->nullable()->index();
            $table->foreignId('deactivated_by')->nullable()->constrained('users')->nullOnDelete();
            $table->string('deactivation_reason', 500)->nullable();
        });

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->uuid('token_family')->nullable()->index();
            $table->string('device_name', 255)->nullable();
            $table->timestamp('rotated_at')->nullable();
            $table->timestamp('revoked_at')->nullable()->index();
            $table->index(['tokenable_type', 'tokenable_id', 'token_family'], 'pat_owner_family_index');
        });
    }

    public function down(): void
    {
        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->dropIndex('pat_owner_family_index');
            $table->dropIndex(['token_family']);
            $table->dropIndex(['revoked_at']);
            $table->dropColumn(['token_family', 'device_name', 'rotated_at', 'revoked_at']);
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['deactivated_by']);
            $table->dropIndex(['deactivated_at']);
            $table->dropColumn(['deactivated_at', 'deactivated_by', 'deactivation_reason']);
        });
    }
};
