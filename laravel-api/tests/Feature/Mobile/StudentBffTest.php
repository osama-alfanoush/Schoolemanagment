<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Tests\TestCase;

/**
 * The student surface: self only, on every route.
 *
 * The cross-student cases are the point of this file. They are written one per
 * route rather than once, because "the endpoint takes no student id" is a
 * property of each route and is exactly the kind of thing a later change
 * quietly breaks on one of them.
 */
class StudentBffTest extends TestCase
{
    use RefreshDatabase;

    /** @return array{student: User, class: ClassRoom, subject: Subject, teacher: User} */
    private function enrolled(string $name = 'ليان'): array
    {
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create(['homeroom_teacher_id' => $teacher->id]);
        $subject = Subject::factory()->create();
        $student = User::factory()->student()->create(['name' => $name]);

        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $class->id,
        ]);

        return [
            'student' => $student,
            'class' => $class,
            'subject' => $subject,
            'teacher' => $teacher,
        ];
    }

    private function publishedAssignment(array $fixture, ?string $dueAt = null): Assignment
    {
        return Assignment::query()->create([
            'teacher_user_id' => $fixture['teacher']->id,
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'title' => 'واجب الرياضيات',
            'instructions' => 'حل التمارين.',
            'due_at' => $dueAt ?? now()->addDays(2),
            'published_at' => now(),
        ]);
    }

    /* ---------- self only ---------- */

    public function test_every_read_route_answers_for_the_caller_only(): void
    {
        // The whole point of the surface. Two enrolled students, and each one
        // must see themselves on every route.
        $mine = $this->enrolled('ليان');
        $theirs = $this->enrolled('سامي');

        $home = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/home')
            ->assertOk()
            ->json('data');

        $this->assertSame($mine['student']->id, $home['student_user_id']);
        $this->assertNotSame($theirs['student']->id, $home['student_user_id']);

        $this->app['auth']->forgetGuards();
        $timetable = $this->actingAs($theirs['student'])
            ->getJson('/api/mobile/v1/student/timetable')
            ->assertOk()
            ->json('data');

        $this->assertSame($theirs['student']->id, $timetable['student_user_id']);
    }

    public function test_a_forged_student_id_changes_nothing_on_any_route(): void
    {
        // There is no such parameter, so it cannot be honoured. Asserted per
        // route because "takes no student id" is a property of each one, and
        // asserted on the identifier the payload actually carries -- checking
        // for the other student's *name* would pass even with the rule broken,
        // because none of these payloads carry names.
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');

        // Something distinctive on the other student's record for each route,
        // so a leak has something to show up as.
        AttendanceRecord::create([
            'student_user_id' => $theirs['student']->id,
            'class_room_id' => $theirs['class']->id,
            'date' => now()->subDay()->toDateString(),
            'status' => 'absent',
            'marked_by' => $theirs['teacher']->id,
        ]);
        $this->finalizedGrade($theirs, 19.5);
        $theirAssignment = Assignment::query()->create([
            'teacher_user_id' => $theirs['teacher']->id,
            'class_room_id' => $theirs['class']->id,
            'subject_id' => $theirs['subject']->id,
            'title' => 'واجب صفٍّ آخر تمامًا',
            'instructions' => 'ليس لك.',
            'due_at' => now()->addDay(),
            'published_at' => now(),
        ]);

        $forgery = '?student_user_id='.$theirs['student']->id
            .'&student_id='.$theirs['student']->id
            .'&child_id='.$theirs['student']->id
            .'&user_id='.$theirs['student']->id
            .'&id='.$theirs['student']->id;

        // Every route that names a student in its payload must name the caller.
        foreach ([
            '/api/mobile/v1/student/home',
            '/api/mobile/v1/student/timetable',
            '/api/mobile/v1/student/attendance',
            '/api/mobile/v1/student/grades',
        ] as $path) {
            $data = $this->actingAs($mine['student'])
                ->getJson($path.$forgery)
                ->assertOk()
                ->json('data');

            $this->assertSame(
                $mine['student']->id,
                $data['student_user_id'],
                $path.' answered for someone else',
            );
        }

        // The other student is absent (their record), so their marks and their
        // absence cannot appear on the caller's screens.
        $attendance = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/attendance'.$forgery)
            ->assertOk()
            ->json('data');
        $this->assertSame(0, $attendance['summary']['recorded_days'] ?? 0);

        $grades = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/grades'.$forgery)
            ->assertOk()
            ->json('data');
        $this->assertSame([], $grades['subjects'] ?? []);

        // Assignments carry no student id, so the check is that the other
        // class's homework is not reachable through a forged one.
        $assignments = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/assignments'.$forgery)
            ->assertOk()
            ->json('data.assignments');

        $this->assertNotContains(
            $theirAssignment->id,
            array_column($assignments, 'id'),
        );
        $this->assertSame([], $assignments);
    }

    public function test_a_forged_student_id_cannot_hand_in_as_someone_else(): void
    {
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');
        $assignment = $this->publishedAssignment($theirs);

        $this->actingAs($mine['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson(
                "/api/mobile/v1/student/assignments/{$assignment->id}/submit"
                ."?student_user_id={$theirs['student']->id}",
                [
                    'content_text' => 'ليس عملي',
                    'student_user_id' => $theirs['student']->id,
                ],
            )
            ->assertNotFound();

        $this->assertSame(0, DB::table('submissions')->count());
    }

    public function test_a_student_cannot_read_another_students_attendance(): void
    {
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');

        AttendanceRecord::create([
            'student_user_id' => $theirs['student']->id,
            'class_room_id' => $theirs['class']->id,
            'date' => now()->subDay()->toDateString(),
            'status' => 'absent',
            'marked_by' => $theirs['teacher']->id,
        ]);

        $data = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/attendance')
            ->assertOk()
            ->json('data');

        $this->assertSame($mine['student']->id, $data['student_user_id']);
        $this->assertSame(0, $data['summary']['recorded_days'] ?? 0);
    }

    public function test_a_student_cannot_read_another_students_marks(): void
    {
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');
        $this->finalizedGrade($theirs, 19.5);

        $data = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/grades')
            ->assertOk()
            ->json('data');

        $this->assertSame($mine['student']->id, $data['student_user_id']);
        $this->assertSame([], $data['subjects'] ?? []);
    }

    public function test_a_student_cannot_read_another_classs_homework(): void
    {
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');
        $this->publishedAssignment($theirs);

        $data = $this->actingAs($mine['student'])
            ->getJson('/api/mobile/v1/student/assignments')
            ->assertOk()
            ->json('data');

        $this->assertSame([], $data['assignments']);
    }

    public function test_a_student_cannot_hand_in_to_another_classs_homework(): void
    {
        $mine = $this->enrolled();
        $theirs = $this->enrolled('سامي');
        $assignment = $this->publishedAssignment($theirs);

        $this->actingAs($mine['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'محاولة',
            ])
            ->assertNotFound();

        $this->assertSame(0, DB::table('submissions')->count());
    }

    public function test_a_parent_cannot_reach_the_student_surface(): void
    {
        $parent = User::factory()->parentRole()->create();

        $this->actingAs($parent)
            ->getJson('/api/mobile/v1/student/home')
            ->assertForbidden();
    }

    public function test_a_teacher_cannot_reach_the_student_surface(): void
    {
        $fixture = $this->enrolled();

        $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/student/grades')
            ->assertForbidden();
    }

    public function test_the_student_surface_needs_a_token(): void
    {
        $this->getJson('/api/mobile/v1/student/home')->assertUnauthorized();
    }

    /* ---------- what a student may see ---------- */

    public function test_home_carries_todays_lessons_and_the_next_thing_due(): void
    {
        $fixture = $this->enrolled();
        DB::table('timetable_entries')->insert([
            'school_id' => $fixture['class']->school_id,
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'teacher_user_id' => $fixture['teacher']->id,
            'day_of_week' => now()->dayOfWeekIso,
            'start_time' => '08:00:00',
            'end_time' => '08:45:00',
            'start_minute' => 480,
            'end_minute' => 525,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        $assignment = $this->publishedAssignment($fixture);

        $data = $this->actingAs($fixture['student'])
            ->getJson('/api/mobile/v1/student/home')
            ->assertOk()
            ->json('data');

        $this->assertCount(1, $data['today']);
        $this->assertSame($assignment->id, $data['next_due']['assignment_id']);
    }

    public function test_a_draft_assignment_is_invisible_to_the_student(): void
    {
        // A draft is a teacher's working note. A student who can see one is
        // reading over their shoulder.
        $fixture = $this->enrolled();
        Assignment::query()->create([
            'teacher_user_id' => $fixture['teacher']->id,
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'title' => 'مسودة',
            'instructions' => 'غير جاهز',
            'due_at' => now()->addDay(),
            'published_at' => null,
        ]);

        $data = $this->actingAs($fixture['student'])
            ->getJson('/api/mobile/v1/student/assignments')
            ->assertOk()
            ->json('data');

        $this->assertSame([], $data['assignments']);
    }

    public function test_a_draft_cannot_be_handed_in_to_either(): void
    {
        $fixture = $this->enrolled();
        $draft = Assignment::query()->create([
            'teacher_user_id' => $fixture['teacher']->id,
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'title' => 'مسودة',
            'instructions' => 'غير جاهز',
            'due_at' => now()->addDay(),
            'published_at' => null,
        ]);

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/student/assignments/{$draft->id}/submit", [
                'content_text' => 'x',
            ])
            ->assertNotFound();
    }

    public function test_an_unfinalized_mark_is_not_shown(): void
    {
        // The same rule the parent surface enforces, through the same service.
        $fixture = $this->enrolled();
        $this->finalizedGrade($fixture, 18.0, 'draft');

        $data = $this->actingAs($fixture['student'])
            ->getJson('/api/mobile/v1/student/grades')
            ->assertOk()
            ->json('data');

        $this->assertSame([], $data['subjects'] ?? []);
    }

    /* ---------- handing in ---------- */

    public function test_handing_in_records_the_work(): void
    {
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'الحل مرفق.',
            ])
            ->assertCreated()
            ->assertJsonPath('data.status', 'submitted');

        $this->assertDatabaseHas('submissions', [
            'assignment_id' => $assignment->id,
            'student_user_id' => $fixture['student']->id,
            'status' => 'submitted',
        ]);
    }

    public function test_the_same_key_hands_in_once(): void
    {
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);
        $key = (string) Str::uuid();

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'الحل.',
            ])
            ->assertCreated();

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'الحل.',
            ])
            ->assertOk()
            ->assertJsonPath('data.created', false);

        $this->assertSame(1, DB::table('submissions')->count());
    }

    public function test_handing_in_after_the_deadline_is_recorded_as_late(): void
    {
        // Late is recorded, not refused. A student who cannot hand in at all
        // hands in nothing, and the teacher loses the work rather than the
        // timestamp.
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment(
            $fixture,
            now()->subDay()->toDateTimeString(),
        );

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'متأخر.',
            ])
            ->assertCreated()
            ->assertJsonPath('data.status', 'late');
    }

    public function test_a_file_hand_in_is_stored(): void
    {
        Storage::fake('private');
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->post("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'file' => UploadedFile::fake()->create('homework.pdf', 8, 'application/pdf'),
            ])
            ->assertCreated()
            ->assertJsonPath('data.has_file', true);
    }

    public function test_a_refused_file_is_said_plainly_and_nothing_is_recorded(): void
    {
        Storage::fake('private');
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->post("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'file' => UploadedFile::fake()->create('payload.exe', 4, 'application/x-msdownload'),
            ])
            ->assertStatus(422);

        $this->assertSame(0, DB::table('submissions')->count());
    }

    public function test_an_empty_hand_in_is_refused(): void
    {
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);

        $this->actingAs($fixture['student'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [])
            ->assertStatus(422);
    }

    public function test_handing_in_without_an_idempotency_key_is_refused(): void
    {
        $fixture = $this->enrolled();
        $assignment = $this->publishedAssignment($fixture);

        $this->actingAs($fixture['student'])
            ->postJson("/api/mobile/v1/student/assignments/{$assignment->id}/submit", [
                'content_text' => 'x',
            ])
            ->assertStatus(422)
            ->assertJsonValidationErrors('idempotency_key');
    }

    /* ---------- what does not exist ---------- */

    public function test_there_is_no_route_that_lists_classmates(): void
    {
        // The absence is the product decision. Peer visibility is a
        // safeguarding surface with a moderation obligation nobody here is
        // staffed to carry, so no route offers one.
        $fixture = $this->enrolled();

        foreach ([
            '/api/mobile/v1/student/classmates',
            '/api/mobile/v1/student/roster',
            '/api/mobile/v1/student/leaderboard',
            '/api/mobile/v1/student/ranking',
            '/api/mobile/v1/student/messages',
        ] as $path) {
            $this->actingAs($fixture['student'])
                ->getJson($path)
                ->assertNotFound();
        }
    }

    /* ---------- fixtures ---------- */

    private function finalizedGrade(array $fixture, float $score, string $state = 'finalized'): Grade
    {
        $class = $fixture['class'];
        $yearId = DB::table('academic_years')->value('id')
            ?? DB::table('academic_years')->insertGetId([
                'school_id' => $class->school_id, 'name' => '2025-2026',
                'start_date' => now()->subMonths(3)->toDateString(),
                'end_date' => now()->addMonths(6)->toDateString(),
                'is_current' => true, 'created_at' => now(), 'updated_at' => now(),
            ]);
        $termId = DB::table('terms')->value('id')
            ?? DB::table('terms')->insertGetId([
                'school_id' => $class->school_id, 'academic_year_id' => $yearId,
                'name' => 'Term 1', 'type' => 'semester',
                'start_date' => now()->subMonths(2)->toDateString(),
                'end_date' => now()->addMonths(2)->toDateString(),
                'sequence' => 1, 'created_at' => now(), 'updated_at' => now(),
            ]);
        $periodId = DB::table('grading_periods')->insertGetId([
            'school_id' => $class->school_id, 'term_id' => $termId,
            'name' => 'Period '.Str::random(4),
            'start_date' => now()->subMonth()->toDateString(),
            'end_date' => now()->addMonth()->toDateString(),
            // smallint: PostgreSQL refuses anything past 32767.
            'sequence' => (int) DB::table('grading_periods')->where('term_id', $termId)->max('sequence') + 1,
            'created_at' => now(), 'updated_at' => now(),
        ]);
        $gradebookId = DB::table('gradebooks')->insertGetId([
            'school_id' => $class->school_id, 'class_room_id' => $class->id,
            'subject_id' => $fixture['subject']->id, 'grading_period_id' => $periodId,
            'state' => $state, 'created_at' => now(), 'updated_at' => now(),
        ]);

        $component = GradeComponent::factory()->create([
            'class_room_id' => $class->id,
            'subject_id' => $fixture['subject']->id,
            'max_score' => 20,
        ]);
        $component->forceFill(['gradebook_id' => $gradebookId])->save();

        return Grade::create([
            'student_user_id' => $fixture['student']->id,
            'grade_component_id' => $component->id,
            'score' => $score,
            'entered_by' => $fixture['teacher']->id,
        ]);
    }
}
