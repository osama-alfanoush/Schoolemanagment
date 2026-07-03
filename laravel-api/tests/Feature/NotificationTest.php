<?php

namespace Tests\Feature;

use App\Models\DeviceToken;
use App\Models\Notification;
use App\Models\NotificationPreference;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NotificationTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_get_notifications()
    {
        $user = User::factory()->create(['role' => 'student']);

        Notification::factory()->count(5)->create([
            'user_id' => $user->id,
        ]);

        $response = $this->actingAs($user)
            ->getJson('/api/notifications');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    '*' => ['id', 'type', 'title', 'body', 'read_at', 'created_at'],
                ],
                'current_page',
                'last_page',
                'per_page',
                'total',
            ]);
    }

    public function test_user_can_filter_unread_notifications()
    {
        $user = User::factory()->create(['role' => 'student']);

        Notification::factory()->count(3)->create([
            'user_id' => $user->id,
            'read_at' => null,
        ]);

        Notification::factory()->count(2)->create([
            'user_id' => $user->id,
            'read_at' => now(),
        ]);

        $response = $this->actingAs($user)
            ->getJson('/api/notifications?unread_only=true');

        $response->assertStatus(200)
            ->assertJsonCount(3, 'data');
    }

    public function test_user_can_get_unread_count()
    {
        $user = User::factory()->create(['role' => 'student']);

        Notification::factory()->count(5)->create([
            'user_id' => $user->id,
            'read_at' => null,
        ]);

        Notification::factory()->highPriority()->count(1)->create([
            'user_id' => $user->id,
            'read_at' => null,
        ]);

        $response = $this->actingAs($user)
            ->getJson('/api/notifications/unread-count');

        $response->assertStatus(200)
            ->assertJson([
                'total_unread' => 6,
                'high_priority_unread' => 1,
            ]);
    }

    public function test_user_can_mark_notification_as_read()
    {
        $user = User::factory()->create(['role' => 'student']);
        $notification = Notification::factory()->create([
            'user_id' => $user->id,
            'read_at' => null,
        ]);

        $response = $this->actingAs($user)
            ->patchJson("/api/notifications/{$notification->id}/read");

        $response->assertStatus(200)
            ->assertJson(['message' => 'Marked as read']);

        $this->assertNotNull($notification->fresh()->read_at);
    }

    public function test_user_can_mark_all_notifications_as_read()
    {
        $user = User::factory()->create(['role' => 'student']);

        Notification::factory()->count(5)->create([
            'user_id' => $user->id,
            'read_at' => null,
        ]);

        $response = $this->actingAs($user)
            ->patchJson('/api/notifications/read-all');

        $response->assertStatus(200)
            ->assertJson([
                'message' => 'All notifications marked as read',
                'marked_count' => 5,
            ]);
    }

    public function test_user_can_get_notification_preferences()
    {
        $user = User::factory()->create(['role' => 'student']);

        NotificationPreference::create([
            'user_id' => $user->id,
            'push_enabled' => true,
            'email_enabled' => false,
        ]);

        $response = $this->actingAs($user)
            ->getJson('/api/notifications/preferences');

        $response->assertStatus(200)
            ->assertJson([
                'push_enabled' => true,
                'email_enabled' => false,
            ]);
    }

    public function test_user_can_update_notification_preferences()
    {
        $user = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($user)
            ->patchJson('/api/notifications/preferences', [
                'push_enabled' => false,
                'quiet_hours' => ['start' => '22:00', 'end' => '06:00'],
            ]);

        $response->assertStatus(200)
            ->assertJson([
                'push_enabled' => false,
                'quiet_hours' => ['start' => '22:00', 'end' => '06:00'],
            ]);
    }

    public function test_user_can_register_device_token()
    {
        $user = User::factory()->create(['role' => 'student']);

        $response = $this->actingAs($user)
            ->postJson('/api/notifications/register-device', [
                'token' => 'test_fcm_token_123',
                'platform' => 'ios',
                'device_name' => 'iPhone Test',
                'app_version' => '1.0.0',
            ]);

        $response->assertStatus(200)
            ->assertJsonStructure(['message', 'device_id']);

        $this->assertDatabaseHas('device_tokens', [
            'user_id' => $user->id,
            'token' => 'test_fcm_token_123',
        ]);
    }

    public function test_user_can_unregister_device()
    {
        $user = User::factory()->create(['role' => 'student']);

        DeviceToken::create([
            'user_id' => $user->id,
            'token' => 'token_to_remove',
            'platform' => 'android',
        ]);

        $response = $this->actingAs($user)
            ->postJson('/api/notifications/unregister-device', [
                'token' => 'token_to_remove',
            ]);

        $response->assertStatus(200)
            ->assertJson(['message' => 'Device unregistered']);

        $this->assertDatabaseMissing('device_tokens', [
            'token' => 'token_to_remove',
        ]);
    }
}
