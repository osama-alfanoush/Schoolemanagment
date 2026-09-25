<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\Assignment;
use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Tests\TestCase;

/**
 * Homework set from a phone, and the notices that go home.
 */
class TeacherPublishingTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        // Inside the school's hours, so a test run at midnight does not fail
        // for a reason that has nothing to do with what it is checking.
        Carbon::setTestNow(Carbon::today()->setTime(9, 0));
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        parent::tearDown();
    }

    /**
     * @return array{teacher: User, class: ClassRoom, subject: Subject, students: list<User>}
     */
    private function assignment(int $students = 2): array
    {
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create();
        $subject = Subject::factory()->create();

        DB::table('class_subject_teacher')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $roll = [];
        for ($i = 0; $i < $students; $i++) {
            $student = User::factory()->student()->create();
            StudentProfile::factory()->create([
                'user_id' => $student->id,
                'class_room_id' => $class->id,
            ]);
            $roll[] = $student;
        }

        return ['teacher' => $teacher, 'class' => $class, 'subject' => $subject, 'students' => $roll];
    }

    /** @return array<string, mixed> */
    private function draftBody(array $fixture): array
    {
        return [
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'title' => 'واجب الرياضيات',
            'instructions' => 'حل التمارين من ١ إلى ١٠.',
            'due_at' => now()->addDays(2)->toIso8601String(),
        ];
    }

    private function createDraft(array $fixture, ?string $key = null): int
    {
        return (int) $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key ?? (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/assignments', $this->draftBody($fixture))
            ->assertCreated()
            ->json('data.id');
    }

    /* ---------- drafts ---------- */

    public function test_a_new_assignment_is_a_draft_and_notifies_nobody(): void
    {
        // A half-written assignment that has already notified thirty families
        // is worse than no app at all.
        $fixture = $this->assignment();

        $data = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/assignments', $this->draftBody($fixture))
            ->assertCreated()
            ->json('data');

        $this->assertFalse($data['published']);
        $this->assertNull($data['published_at']);
        $this->assertSame(0, DB::table('notifications')->count());
    }

    public function test_the_same_key_creates_one_assignment(): void
    {
        $fixture = $this->assignment();
        $key = (string) Str::uuid();

        $first = $this->createDraft($fixture, $key);
        $second = (int) $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/assignments', $this->draftBody($fixture))
            ->assertOk()
            ->json('data.id');

        $this->assertSame($first, $second);
        $this->assertSame(1, Assignment::query()->count());
    }

    public function test_a_teacher_cannot_set_homework_for_a_class_they_do_not_teach(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/assignments', [
                'class_room_id' => $theirs['class']->id,
                'subject_id' => $theirs['subject']->id,
                'title' => 'x',
                'instructions' => 'y',
                'due_at' => now()->addDay()->toIso8601String(),
            ])
            ->assertForbidden();

        $this->assertSame(0, Assignment::query()->count());
        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $mine['teacher']->id,
            'action' => 'authorization_denied',
        ]);
    }

    /* ---------- publishing ---------- */

    public function test_publishing_notifies_the_class_once(): void
    {
        $fixture = $this->assignment();
        $id = $this->createDraft($fixture);

        $this->actingAs($fixture['teacher'])
            ->postJson("/api/mobile/v1/teacher/assignments/$id/publish")
            ->assertOk()
            ->assertJsonPath('data.published', true)
            ->assertJsonPath('data.published_now', true);

        $this->assertSame(2, DB::table('notifications')->count());

        // A second publish is a no-op, not a second round of notifications to
        // every family in the class.
        $this->actingAs($fixture['teacher'])
            ->postJson("/api/mobile/v1/teacher/assignments/$id/publish")
            ->assertOk()
            ->assertJsonPath('data.published_now', false);

        $this->assertSame(2, DB::table('notifications')->count());
    }

    public function test_another_teacher_cannot_publish_this_homework(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $id = $this->createDraft($mine);

        $this->actingAs($theirs['teacher'])
            ->postJson("/api/mobile/v1/teacher/assignments/$id/publish")
            ->assertForbidden();

        $this->assertNull(Assignment::query()->find($id)->published_at);
    }

    /* ---------- attachments ---------- */

    public function test_an_attachment_is_stored_and_the_assignment_says_so(): void
    {
        Storage::fake('private');
        $fixture = $this->assignment();
        $id = $this->createDraft($fixture);

        $this->actingAs($fixture['teacher'])
            ->post("/api/mobile/v1/teacher/assignments/$id/attachment", [
                'file' => UploadedFile::fake()->create('worksheet.pdf', 12, 'application/pdf'),
            ])
            ->assertOk()
            ->assertJsonPath('data.has_attachment', true);
    }

    public function test_a_rejected_upload_fails_visibly_and_keeps_the_assignment(): void
    {
        // The acceptance criterion: never silently. The homework survives, the
        // attachment is visibly absent, and the teacher can try again without
        // retyping anything.
        Storage::fake('private');
        $fixture = $this->assignment();
        $id = $this->createDraft($fixture);

        $this->actingAs($fixture['teacher'])
            ->post("/api/mobile/v1/teacher/assignments/$id/attachment", [
                'file' => UploadedFile::fake()->create('payload.exe', 4, 'application/x-msdownload'),
            ])
            ->assertStatus(422);

        $assignment = Assignment::query()->find($id);
        $this->assertNotNull($assignment);
        $this->assertNull($assignment->attachment_path);
        $this->assertSame('واجب الرياضيات', $assignment->title);
    }

    public function test_another_teacher_cannot_attach_to_this_homework(): void
    {
        Storage::fake('private');
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $id = $this->createDraft($mine);

        $this->actingAs($theirs['teacher'])
            ->post("/api/mobile/v1/teacher/assignments/$id/attachment", [
                'file' => UploadedFile::fake()->create('worksheet.pdf', 12, 'application/pdf'),
            ])
            ->assertForbidden();
    }

    /* ---------- submission status ---------- */

    public function test_submission_status_lists_the_whole_class_including_the_missing(): void
    {
        // The students with nothing against their name are the reason a
        // teacher opens this screen.
        $fixture = $this->assignment();
        $id = $this->createDraft($fixture);

        DB::table('submissions')->insert([
            'school_id' => $fixture['class']->school_id,
            'assignment_id' => $id,
            'student_user_id' => $fixture['students'][0]->id,
            'status' => 'submitted',
            'submitted_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $data = $this->actingAs($fixture['teacher'])
            ->getJson("/api/mobile/v1/teacher/assignments/$id/submissions")
            ->assertOk()
            ->json('data');

        $this->assertCount(2, $data['students']);
        $this->assertSame(
            ['submitted', 'pending'],
            collect($data['students'])
                ->sortBy(fn (array $row): int => $row['status'] === 'submitted' ? 0 : 1)
                ->pluck('status')
                ->values()
                ->all(),
        );
    }

    public function test_the_assignment_list_counts_hand_ins(): void
    {
        $fixture = $this->assignment();
        $id = $this->createDraft($fixture);

        DB::table('submissions')->insert([
            'school_id' => $fixture['class']->school_id,
            'assignment_id' => $id,
            'student_user_id' => $fixture['students'][0]->id,
            'status' => 'submitted',
            'submitted_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $row = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/assignments')
            ->assertOk()
            ->json('data.assignments.0');

        $this->assertSame(1, $row['submission_counts']['submitted']);
        $this->assertSame(2, $row['class_size']);
        $this->assertFalse($row['published']);
    }

    /* ---------- announcements ---------- */

    public function test_only_approved_templates_can_be_sent(): void
    {
        // One tap from a phone reaches thirty households. Free text on that
        // surface is a moderation obligation nobody here can carry.
        $fixture = $this->assignment();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'anything_i_like',
                'detail' => 'نص حر',
                'audience' => 'class:'.$fixture['class']->id,
            ])
            ->assertStatus(422);

        $this->assertSame(0, DB::table('announcements')->count());
    }

    public function test_a_class_notice_reaches_the_guardians(): void
    {
        $fixture = $this->assignment(1);
        $guardian = User::factory()->parentRole()->create();
        $fixture['students'][0]->parents()->attach($guardian);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'bring_materials',
                'detail' => 'مسطرة ومقص',
                'audience' => 'class:'.$fixture['class']->id,
            ])
            ->assertCreated();

        $this->assertSame(1, DB::table('announcements')->count());
        $this->assertDatabaseHas('notifications', [
            'user_id' => $guardian->id,
            'type' => 'announcement',
        ]);
    }

    public function test_the_detail_is_rendered_into_the_approved_wording(): void
    {
        $fixture = $this->assignment(1);

        $body = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'bring_materials',
                'detail' => 'مسطرة ومقص',
                'audience' => 'class:'.$fixture['class']->id,
            ])
            ->assertCreated()
            ->json('data.body');

        $this->assertStringContainsString('مسطرة ومقص', $body);
        $this->assertStringContainsString('المستلزمات', $body);
    }

    public function test_a_notice_outside_school_hours_is_refused_with_the_window(): void
    {
        // The acceptance criterion. A push at 23:40 wakes a household, and
        // doing that once costs the pilot more than the notice was worth.
        $fixture = $this->assignment(1);
        Carbon::setTestNow(Carbon::today()->setTime(23, 40));

        $response = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'bring_materials',
                'detail' => 'مسطرة',
                'audience' => 'class:'.$fixture['class']->id,
            ])
            ->assertStatus(409);

        $this->assertSame('07:00', $response->json('errors.window.from'));
        $this->assertSame('17:00', $response->json('errors.window.to'));
        $this->assertSame(0, DB::table('announcements')->count());
        $this->assertSame(0, DB::table('notifications')->count());
    }

    public function test_a_guardian_notice_opens_a_thread_the_family_may_answer(): void
    {
        $fixture = $this->assignment(1);
        $guardian = User::factory()->parentRole()->create();
        $fixture['students'][0]->parents()->attach($guardian);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'absence_followup',
                'detail' => 'غياب أمس',
                'audience' => 'guardian:'.$guardian->id,
            ])
            ->assertCreated();

        // Staff opened it, so the parent surface offers a reply. An
        // announcement would have left the family unable to answer.
        $this->assertDatabaseHas('messages', [
            'sender_user_id' => $fixture['teacher']->id,
            'recipient_user_id' => $guardian->id,
        ]);

        $this->app['auth']->forgetGuards();
        $this->actingAs($guardian)
            ->getJson('/api/mobile/v1/parent/messages/'.$fixture['teacher']->id)
            ->assertOk()
            ->assertJsonPath('data.can_reply', true);
    }

    public function test_a_teacher_cannot_message_a_guardian_outside_their_classes(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment(1);
        $stranger = User::factory()->parentRole()->create();
        $theirs['students'][0]->parents()->attach($stranger);

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'absence_followup',
                'detail' => 'غياب',
                'audience' => 'guardian:'.$stranger->id,
            ])
            ->assertForbidden();

        $this->assertSame(0, DB::table('messages')->count());
    }

    public function test_a_teacher_cannot_announce_to_a_class_they_do_not_teach(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/announcements', [
                'template_key' => 'bring_materials',
                'detail' => 'مسطرة',
                'audience' => 'class:'.$theirs['class']->id,
            ])
            ->assertForbidden();

        $this->assertSame(0, DB::table('announcements')->count());
    }

    public function test_the_same_key_sends_one_notice(): void
    {
        $fixture = $this->assignment(1);
        $key = (string) Str::uuid();
        $body = [
            'template_key' => 'bring_materials',
            'detail' => 'مسطرة',
            'audience' => 'class:'.$fixture['class']->id,
        ];

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/announcements', $body)
            ->assertCreated();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/announcements', $body)
            ->assertOk()
            ->assertJsonPath('data.created', false);

        $this->assertSame(1, DB::table('announcements')->count());
    }

    public function test_the_templates_and_the_window_are_readable(): void
    {
        $fixture = $this->assignment();

        $data = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/announcement-templates')
            ->assertOk()
            ->json('data');

        $this->assertContains('bring_materials', array_column($data['templates'], 'key'));
        $this->assertTrue($data['open_now']);
        $this->assertSame('07:00', $data['window']['from']);
    }

    public function test_a_parent_cannot_reach_the_publishing_surface(): void
    {
        $parent = User::factory()->parentRole()->create();

        $this->actingAs($parent)
            ->getJson('/api/mobile/v1/teacher/assignments')
            ->assertForbidden();
    }
}
