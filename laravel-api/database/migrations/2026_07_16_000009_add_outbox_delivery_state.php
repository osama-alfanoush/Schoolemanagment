<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('outbox_events', function (Blueprint $table) {
            $table->string('status')->default('pending')->index();
            $table->unsignedSmallInteger('max_attempts')->default(8);
            $table->uuid('locked_by')->nullable();
            $table->timestamp('locked_at')->nullable();
            $table->timestamp('dead_lettered_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('outbox_events', fn (Blueprint $table) => $table->dropColumn([
            'status', 'max_attempts', 'locked_by', 'locked_at', 'dead_lettered_at',
        ]));
    }
};
