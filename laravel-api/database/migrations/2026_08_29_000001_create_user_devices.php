<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_devices', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->string('device_id', 255);
            $table->string('platform', 20);
            $table->text('push_token')->nullable();
            $table->string('app_version', 100)->nullable();
            $table->string('os_version', 100)->nullable();
            $table->timestamp('last_seen_at')->nullable();
            $table->timestamp('revoked_at')->nullable();
            $table->timestamps();

            $table->unique(['user_id', 'device_id']);
            $table->index(['school_id', 'user_id']);
            $table->index(['user_id', 'revoked_at']);
        });

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->string('device_id', 255)->nullable()->index();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_devices');

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->dropIndex(['device_id']);
            $table->dropColumn('device_id');
        });
    }
};
