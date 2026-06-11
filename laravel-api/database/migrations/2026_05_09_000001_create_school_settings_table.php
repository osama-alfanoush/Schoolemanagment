<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('school_settings', function (Blueprint $table) {
            $table->id();
            $table->string('school_name')->default('School Suite');
            $table->string('school_motto')->nullable();
            $table->string('academic_year')->default('2025-2026');
            $table->text('address')->nullable();
            $table->string('primary_color', 7)->default('#6C63FF');
            $table->string('accent_color', 7)->default('#FF6584');
            $table->enum('sidebar_style', ['white', 'gradient', 'dark'])->default('white');
            $table->enum('border_radius', ['sharp', 'medium', 'rounded'])->default('rounded');
            $table->enum('font_style', ['modern', 'classic', 'friendly'])->default('modern');
            $table->string('school_logo')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('school_settings');
    }
};
