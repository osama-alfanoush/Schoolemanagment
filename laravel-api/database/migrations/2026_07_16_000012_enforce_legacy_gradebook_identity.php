<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('gradebooks', fn (Blueprint $table) => $table->unique(
            ['class_room_id', 'subject_id', 'grading_period_id'], 'legacy_gradebook_unique'
        ));
    }

    public function down(): void
    {
        Schema::table('gradebooks', fn (Blueprint $table) => $table->dropUnique('legacy_gradebook_unique'));
    }
};
