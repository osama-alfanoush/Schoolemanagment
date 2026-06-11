<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\Message;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MessagingTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_find_allowed_recipient_send_and_read_message(): void
    {
        $admin = $this->loginAs('admin');
        $teacher = User::factory()->teacher()->create([
            'name' => 'Teacher One',
            'email' => 'teacher.one@school.test',
        ]);

        $this->actingAs($admin)
            ->getJson('/api/messages/recipients?search=Teacher')
            ->assertOk()
            ->assertJsonFragment([
                'id' => $teacher->id,
                'name' => 'Teacher One',
            ]);

        $this->actingAs($admin)
            ->postJson('/api/messages', [
                'recipient_user_id' => $teacher->id,
                'body' => 'Hello from admin',
            ])
            ->assertCreated()
            ->assertJsonPath('body', 'Hello from admin')
            ->assertJsonPath('is_mine', true);

        $this->assertDatabaseHas('messages', [
            'sender_user_id' => $admin->id,
            'recipient_user_id' => $teacher->id,
            'body' => 'Hello from admin',
        ]);

        $this->actingAs($admin)
            ->getJson('/api/messages/threads')
            ->assertOk()
            ->assertJsonPath('0.other_user.id', $teacher->id)
            ->assertJsonPath('0.last_message.body', 'Hello from admin');

        $this->actingAs($teacher)
            ->getJson("/api/messages/conversation/{$admin->id}")
            ->assertOk()
            ->assertJsonPath('0.body', 'Hello from admin')
            ->assertJsonPath('0.is_mine', false);

        $this->assertNotNull(Message::first()?->read_at);
    }

    public function test_message_body_cannot_be_blank(): void
    {
        $admin = $this->loginAs('admin');
        $teacher = User::factory()->teacher()->create();

        $this->actingAs($admin)
            ->postJson('/api/messages', [
                'recipient_user_id' => $teacher->id,
                'body' => '   ',
            ])
            ->assertStatus(422)
            ->assertJsonValidationErrors(['body']);
    }
}
