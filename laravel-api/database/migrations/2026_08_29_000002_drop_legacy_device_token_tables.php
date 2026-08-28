<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::dropIfExists('device_tokens');
        Schema::dropIfExists('push_tokens');
    }

    public function down(): void
    {
        Schema::create('push_tokens', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('token');
            $table->string('platform');
            $table->timestamps();
            $table->unique(['user_id', 'token']);
        });

        Schema::create('device_tokens', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('token')->index();
            $table->string('platform');
            $table->string('device_name')->nullable();
            $table->string('app_version')->nullable();
            $table->timestamp('last_used_at')->nullable();
            $table->timestamp('verified_at')->nullable();
            $table->timestamps();
            $table->unique(['user_id', 'token']);
        });
    }
};
