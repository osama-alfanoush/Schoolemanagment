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

    public function test_recipients_includes_authorized_user_sorted_after_first_100(): void
    {
        $teacher = $this->loginAs('teacher');

        // 150 other teachers the sender may NOT message (teacher -> teacher is
        // denied by canMessage), named to sort BEFORE the authorized recipient.
        User::factory()->teacher()->count(150)->sequence(fn ($s) => [
            'name' => 'AAA Teacher '.str_pad((string) $s->index, 3, '0', STR_PAD_LEFT),
            'email' => 'aaa.teacher.'.$s->index.'@school.test',
        ])->create();

        // An admin the teacher IS allowed to message, sorted last by name.
        $admin = User::factory()->admin()->create([
            'name' => 'ZZZ Admin Last',
            'email' => 'zzz.admin@school.test',
        ]);

        // Without a search term the authorized admin sorts past the first 100
        // rows; the endpoint must still return it (limit applied AFTER the
        // authorization filter, not before).
        $this->actingAs($teacher)
            ->getJson('/api/messages/recipients')
            ->assertOk()
            ->assertJsonFragment(['id' => $admin->id]);
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
