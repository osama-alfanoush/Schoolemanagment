<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('permissions', function (Blueprint $t) {
            $t->id();
            $t->string('key')->unique(); // e.g. finance.installments.approve
            $t->string('module'); // procurement, finance.procurement, finance.installments, finance.payroll
            $t->string('action'); // view, create, edit, delete, approve, receive
            $t->string('description')->nullable();
            $t->timestamps();

            $t->index(['module']);
        });

        Schema::create('role_permissions', function (Blueprint $t) {
            $t->id();
            $t->string('role'); // matches users.role values
            $t->foreignId('permission_id')->constrained('permissions')->cascadeOnDelete();
            $t->timestamps();

            $t->unique(['role', 'permission_id']);
            $t->index(['role']);
        });

        // Per-user overrides: grant or deny a single permission without a new role.
        Schema::create('user_permissions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('permission_id')->constrained('permissions')->cascadeOnDelete();
            $t->boolean('granted')->default(true); // false = explicit deny overriding role grant
            $t->timestamps();

            $t->unique(['user_id', 'permission_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_permissions');
        Schema::dropIfExists('role_permissions');
        Schema::dropIfExists('permissions');
    }
};
