<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\ClassRoom;
use App\Models\Message;
use App\Models\Notification;
use App\Models\NotificationPreference;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tests\TestCase;

class ParentInboxTest extends TestCase
{
    use RefreshDatabase;

    private const PREFS = '/api/mobile/v1/notifications/preferences';

    protected function setUp(): void
    {
        parent::setUp();
        // Inside the reply window unless a test says otherwise.
        Carbon::setTestNow(Carbon::create(2026, 9, 7, 10, 0));
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        parent::tearDown();
    }

    /** @return array{parent: User, child: User, class: ClassRoom} */
    private function family(string $name = 'ليان'): array
    {
        $parent = User::factory()->parentRole()->create();
        $child = User::factory()->student()->create(['name' => $name]);
        $child->parents()->attach($parent);
        $class = ClassRoom::factory()->create();
        StudentProfile::factory()->create([
            'user_id' => $child->id,
            'class_room_id' => $class->id,
        ]);

        return ['parent' => $parent, 'child' => $child, 'class' => $class];
    }

    /* ---------- notification preferences ---------- */

    public function test_every_category_starts_on(): void
    {
        ['parent' => $parent] = $this->family();

        $categories = $this->actingAs($parent)->getJson(self::PREFS)
            ->assertOk()->json('data.categories');

        foreach ($categories as $category => $enabled) {
            $this->assertTrue($enabled, "{$category} should start on");
        }
    }

    public function test_muting_grades_does_not_mute_fee_reminders(): void
    {
        // The single most important line in this file. A parent who turns off
        // grade notifications must keep getting told about money.
        ['parent' => $parent] = $this->family();

        $categories = $this->actingAs($parent)
            ->patchJson(self::PREFS, ['categories' => ['grades' => false]])
            ->assertOk()
            ->json('data.categories');

        $this->assertFalse($categories['grades']);
        $this->assertTrue($categories['fees']);
        $this->assertTrue($categories['attendance']);
        $this->assertTrue($categories['messages']);
    }

    public function test_a_second_toggle_leaves_the_first_alone(): void
    {
        // A replace instead of a merge is how the second toggle silently
        // re-enables what the first turned off, or worse.
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->patchJson(self::PREFS, ['categories' => ['grades' => false]])
            ->assertOk();

        $categories = $this->actingAs($parent)
            ->patchJson(self::PREFS, ['categories' => ['announcements' => false]])
            ->assertOk()
            ->json('data.categories');

        $this->assertFalse($categories['grades']);
        $this->assertFalse($categories['announcements']);
        $this->assertTrue($categories['fees']);
    }

    public function test_the_emergency_category_cannot_be_muted(): void
    {
        // Refused rather than silently ignored: a switch that appears to work
        // and does not is worse than no switch.
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->patchJson(self::PREFS, ['categories' => ['emergency' => false]])
            ->assertStatus(422);

        $this->assertContains(
            'emergency',
            $this->actingAs($parent)->getJson(self::PREFS)->json('data.always_on'),
        );
    }

    public function test_an_unknown_category_is_refused(): void
    {
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->patchJson(self::PREFS, ['categories' => ['horoscopes' => false]])
            ->assertStatus(422);
    }

    public function test_preferences_are_per_account(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['parent' => $theirs] = $this->family('سلمى');

        $this->actingAs($mine)
            ->patchJson(self::PREFS, ['categories' => ['fees' => false]])
            ->assertOk();

        $this->app['auth']->forgetGuards();

        $this->assertTrue(
            $this->actingAs($theirs)->getJson(self::PREFS)->json('data.categories.fees'),
        );
    }

    /* ---------- notifications ---------- */

    public function test_a_parent_sees_only_their_own_notifications(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['parent' => $theirs] = $this->family('سلمى');

        $mineNotification = Notification::factory()->create(['user_id' => $mine->id]);
        $theirsNotification = Notification::factory()->create(['user_id' => $theirs->id]);

        $ids = array_column(
            $this->actingAs($mine)->getJson('/api/mobile/v1/notifications')
                ->assertOk()->json('data.notifications'),
            'id',
        );

        $this->assertSame([$mineNotification->id], $ids);
        $this->assertNotContains($theirsNotification->id, $ids);
    }

    public function test_read_state_is_the_same_column_the_web_writes(): void
    {
        // A notice read on the phone must not still be unread on the website.
        ['parent' => $parent] = $this->family();
        $notification = Notification::factory()->create([
            'user_id' => $parent->id,
            'read_at' => null,
        ]);

        $this->actingAs($parent)
            ->patchJson("/api/mobile/v1/notifications/{$notification->id}/read")
            ->assertOk();

        $this->assertNotNull($notification->fresh()->read_at);
        $this->assertSame(
            0,
            $this->actingAs($parent)->getJson('/api/mobile/v1/notifications')
                ->json('data.unread_count'),
        );
    }

    public function test_a_parent_cannot_mark_another_familys_notification_read(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['parent' => $theirs] = $this->family('سلمى');
        $notification = Notification::factory()->create([
            'user_id' => $theirs->id,
            'read_at' => null,
        ]);

        $this->actingAs($mine)
            ->patchJson("/api/mobile/v1/notifications/{$notification->id}/read")
            ->assertOk();

        // Answers the same either way, and changes nothing.
        $this->assertNull($notification->fresh()->read_at);
    }

    /* ---------- messages ---------- */

    private function teacherWhoMessaged(User $parent): User
    {
        $teacher = User::factory()->teacher()->create();
        Message::create([
            'sender_user_id' => $teacher->id,
            'recipient_user_id' => $parent->id,
            'body' => 'ليان نسيت دفترها اليوم.',
        ]);

        return $teacher;
    }

    private function reply(User $parent, int $otherId, string $body = 'شكرًا لك')
    {
        return $this->actingAs($parent)
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/parent/messages/{$otherId}/reply", ['body' => $body]);
    }

    public function test_a_parent_cannot_start_a_thread(): void
    {
        // The constraint the plan says must not be relaxed. Unconstrained
        // parent-initiated chat is how teachers come to hate the product.
        ['parent' => $parent] = $this->family();
        $teacher = User::factory()->teacher()->create();

        $this->reply($parent, $teacher->id)->assertStatus(403);

        $this->assertSame(0, Message::query()->count());
        $this->assertDatabaseHas('audit_logs', ['action' => 'message_initiation_refused']);
    }

    public function test_a_parent_may_reply_to_a_thread_the_school_opened(): void
    {
        ['parent' => $parent] = $this->family();
        $teacher = $this->teacherWhoMessaged($parent);

        $this->reply($parent, $teacher->id)->assertStatus(201);

        $this->assertSame(2, Message::query()->count());
    }

    public function test_a_thread_the_parent_started_elsewhere_is_still_reply_only_here(): void
    {
        // The web allows a parent to open a thread. This surface does not, and
        // it does not inherit one either: the first message decides.
        ['parent' => $parent] = $this->family();
        $teacher = User::factory()->teacher()->create();
        Message::create([
            'sender_user_id' => $parent->id,
            'recipient_user_id' => $teacher->id,
            'body' => 'مرحبًا',
        ]);

        $this->reply($parent, $teacher->id)->assertStatus(403);

        $thread = collect(
            $this->actingAs($parent)->getJson('/api/mobile/v1/parent/messages')
                ->json('data.threads')
        )->firstWhere('other_user_id', $teacher->id);

        $this->assertFalse($thread['can_reply']);
    }

    public function test_a_reply_outside_school_hours_is_refused(): void
    {
        // A message sent at 23:40 lands on a teacher's lock screen at 23:40.
        ['parent' => $parent] = $this->family();
        $teacher = $this->teacherWhoMessaged($parent);

        Carbon::setTestNow(Carbon::create(2026, 9, 7, 23, 40));

        $this->reply($parent, $teacher->id)->assertStatus(409);

        $this->assertSame(1, Message::query()->count());
    }

    public function test_a_retried_reply_posts_once(): void
    {
        ['parent' => $parent] = $this->family();
        $teacher = $this->teacherWhoMessaged($parent);
        $key = (string) Str::uuid();

        for ($i = 0; $i < 3; $i++) {
            $this->actingAs($parent)
                ->withHeader('Idempotency-Key', $key)
                ->postJson("/api/mobile/v1/parent/messages/{$teacher->id}/reply", [
                    'body' => 'شكرًا لك',
                ])
                ->assertSuccessful();
        }

        $this->assertSame(
            1,
            Message::query()->where('sender_user_id', $parent->id)->count(),
        );
    }

    public function test_reading_a_thread_marks_it_read(): void
    {
        ['parent' => $parent] = $this->family();
        $teacher = $this->teacherWhoMessaged($parent);

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/messages/{$teacher->id}")
            ->assertOk()
            ->assertJsonPath('data.can_reply', true);

        $this->assertNotNull(
            Message::query()->where('sender_user_id', $teacher->id)->first()->read_at,
        );
    }

    /* ---------- timetable ---------- */

    public function test_the_timetable_is_the_childs_class(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $teacher = User::factory()->teacher()->create();
        DB::table('timetable_entries')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => Subject::factory()->create()->id,
            'teacher_user_id' => $teacher->id,
            'day_of_week' => 1,
            'start_time' => '08:00',
            'end_time' => '09:00',
            'start_minute' => 480,
            'end_minute' => 540,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/timetable")
            ->assertOk()
            ->assertJsonCount(1, 'data.days.1');
    }

    public function test_a_parent_cannot_read_another_familys_timetable(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirs] = $this->family('سلمى');

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/children/{$theirs->id}/timetable")
            ->assertStatus(403);
    }

    /* ---------- profile correction ---------- */

    private function requestCorrection(User $parent, int $childId, string $key)
    {
        return $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson("/api/mobile/v1/parent/children/{$childId}/correction", [
                'field' => 'date_of_birth',
                'detail' => 'التاريخ الصحيح هو ٢٠١٥/٠٣/١١',
            ]);
    }

    public function test_a_correction_is_a_request_not_an_edit(): void
    {
        // An admission number or a date of birth a family can rewrite is not a
        // record anyone can rely on.
        ['parent' => $parent, 'child' => $child] = $this->family();
        $before = StudentProfile::query()->where('user_id', $child->id)->first();

        $this->requestCorrection($parent, $child->id, (string) Str::uuid())
            ->assertStatus(201);

        $this->assertEquals(
            $before->date_of_birth,
            StudentProfile::query()->where('user_id', $child->id)->first()->date_of_birth,
        );
        $this->assertDatabaseHas('profile_correction_requests', [
            'student_user_id' => $child->id,
            'status' => 'open',
        ]);
    }

    public function test_a_retried_correction_files_once(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        $key = (string) Str::uuid();

        $this->requestCorrection($parent, $child->id, $key)->assertStatus(201);
        $this->requestCorrection($parent, $child->id, $key)->assertStatus(200);

        $this->assertSame(1, DB::table('profile_correction_requests')->count());
    }

    public function test_a_parent_cannot_file_against_another_familys_child(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirs] = $this->family('سلمى');

        $this->requestCorrection($mine, $theirs->id, (string) Str::uuid())
            ->assertStatus(403);

        $this->assertSame(0, DB::table('profile_correction_requests')->count());
    }

    public function test_the_family_account_of_the_problem_stays_out_of_the_audit_log(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();

        $this->requestCorrection($parent, $child->id, (string) Str::uuid())
            ->assertStatus(201);

        $audit = (string) json_encode(DB::table('audit_logs')->get());
        $this->assertStringContainsString('profile_correction_requested', $audit);
        $this->assertStringContainsString('date_of_birth', $audit);
        // The field name is enough for an operator; the detail is the family's.
        $this->assertStringNotContainsString('التاريخ الصحيح', $audit);
    }
}
