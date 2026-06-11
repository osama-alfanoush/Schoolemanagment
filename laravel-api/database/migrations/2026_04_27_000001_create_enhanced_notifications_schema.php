<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Add new columns to existing notifications table
        Schema::table('notifications', function (Blueprint $t) {
            if (!Schema::hasColumn('notifications', 'category')) {
                $t->string('category')->after('type')->default('general');
            }
            if (!Schema::hasColumn('notifications', 'priority')) {
                $t->string('priority')->after('category')->default('normal');
            }
            if (!Schema::hasColumn('notifications', 'action_url')) {
                $t->string('action_url')->nullable()->after('data');
            }
            if (!Schema::hasColumn('notifications', 'icon')) {
                $t->string('icon')->nullable()->after('action_url');
            }
            if (!Schema::hasColumn('notifications', 'clicked_at')) {
                $t->timestamp('clicked_at')->nullable()->after('read_at');
            }
            if (!Schema::hasColumn('notifications', 'scheduled_at')) {
                $t->timestamp('scheduled_at')->nullable()->after('clicked_at');
            }
            if (!Schema::hasColumn('notifications', 'expires_at')) {
                $t->timestamp('expires_at')->nullable()->after('scheduled_at');
            }
            if (!Schema::hasColumn('notifications', 'source_type')) {
                $t->string('source_type')->nullable()->after('expires_at');
            }
            if (!Schema::hasColumn('notifications', 'source_id')) {
                $t->unsignedBigInteger('source_id')->nullable()->after('source_type');
            }

        });

        // Notification preferences per user
        Schema::create('notification_preferences', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->unique()->constrained()->cascadeOnDelete();
            $t->boolean('push_enabled')->default(true);
            $t->boolean('email_enabled')->default(true);
            $t->boolean('in_app_enabled')->default(true);
            $t->json('type_preferences')->nullable(); // per-type settings
            $t->json('quiet_hours')->nullable(); // {start: '22:00', end: '07:00'}
            $t->timestamps();
        });

        // Notification templates for consistent messaging
        Schema::create('notification_templates', function (Blueprint $t) {
            $t->id();
            $t->string('key')->unique(); // assignment_created, grade_posted, etc.
            $t->string('category');
            $t->string('title_template');
            $t->text('body_template');
            $t->string('default_priority')->default('normal');
            $t->string('action_url_template')->nullable();
            $t->boolean('requires_action')->default(false);
            $t->timestamps();
        });

        // Push tokens with better tracking
        Schema::create('device_tokens', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->constrained()->cascadeOnDelete();
            $t->string('token')->index();
            $t->string('platform'); // ios, android, web
            $t->string('device_name')->nullable();
            $t->string('app_version')->nullable();
            $t->timestamp('last_used_at')->nullable();
            $t->timestamp('verified_at')->nullable();
            $t->timestamps();
            $t->unique(['user_id', 'token']);
        });

        // Notification delivery logs
        Schema::create('notification_deliveries', function (Blueprint $t) {
            $t->id();
            $t->foreignId('notification_id')->constrained()->cascadeOnDelete();
            $t->string('channel'); // push, email, in_app
            $t->string('status'); // pending, sent, delivered, failed, read
            $t->text('error_message')->nullable();
            $t->timestamp('sent_at')->nullable();
            $t->timestamp('delivered_at')->nullable();
            $t->timestamp('failed_at')->nullable();
            $t->string('external_id')->nullable(); // FCM message ID, etc.
            $t->timestamps();

            $t->index(['notification_id', 'channel']);
            $t->index(['status', 'created_at']);
        });

        // User notification settings per type
        Schema::create('notification_type_settings', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->constrained()->cascadeOnDelete();
            $t->string('type'); // assignment, grade, attendance, etc.
            $t->boolean('push')->default(true);
            $t->boolean('email')->default(false);
            $t->boolean('in_app')->default(true);
            $t->timestamps();
            $t->unique(['user_id', 'type']);
        });

        // Scheduled/bulk notifications queue
        Schema::create('scheduled_notifications', function (Blueprint $t) {
            $t->id();
            $t->foreignId('sender_id')->constrained('users')->cascadeOnDelete();
            $t->string('template_key');
            $t->json('template_data');
            $t->json('target_filter'); // {role: 'parent', class_id: 5}
            $t->timestamp('scheduled_at');
            $t->timestamp('processed_at')->nullable();
            $t->integer('recipient_count')->nullable();
            $t->integer('sent_count')->default(0);
            $t->string('status')->default('pending'); // pending, processing, completed, failed
            $t->text('error_log')->nullable();
            $t->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('scheduled_notifications');
        Schema::dropIfExists('notification_type_settings');
        Schema::dropIfExists('notification_deliveries');
        Schema::dropIfExists('device_tokens');
        Schema::dropIfExists('notification_templates');
        Schema::dropIfExists('notification_preferences');
        Schema::dropIfExists('notifications');
    }
};
