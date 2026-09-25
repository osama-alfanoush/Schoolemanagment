<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tests\TestCase;

/**
 * The teacher BFF: assigned classes only, an enforced attendance window, and
 * two writes that survive being sent twice.
 */
class TeacherBffTest extends TestCase
{
    use RefreshDatabase;

    /* ---------- fixtures ---------- */

    /**
     * A teacher with one class they teach one subject in.
     *
     * @return array{teacher: User, class: ClassRoom, subject: Subject, students: list<User>}
     */
    private function assignment(int $students = 2, bool $homeroom = false): array
    {
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create(
            $homeroom ? ['homeroom_teacher_id' => $teacher->id] : []
        );
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

    /** A grade component whose gradebook is in [$state]. */
    private function gradeItem(ClassRoom $class, Subject $subject, string $state = 'draft'): GradeComponent
    {
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
            'subject_id' => $subject->id, 'grading_period_id' => $periodId,
            'state' => $state, 'created_at' => now(), 'updated_at' => now(),
        ]);

        $component = GradeComponent::factory()->create([
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'max_score' => 100,
        ]);
        $component->forceFill(['gradebook_id' => $gradebookId])->save();

        return $component->fresh();
    }

    private function period(ClassRoom $class, Subject $subject, User $teacher, Carbon $day): void
    {
        DB::table('timetable_entries')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
            'day_of_week' => $day->dayOfWeekIso,
            'start_time' => '08:00:00',
            'end_time' => '08:45:00',
            // Written directly, so the minutes TimetableEntry derives on save
            // are set here; PostgreSQL's overlap constraints read them.
            'start_minute' => 480,
            'end_minute' => 525,
            // One room per class: two classes in one room at 08:00 is a
            // conflict PostgreSQL refuses, and not what these tests are about.
            'room' => 'R'.$class->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    /** @param list<User> $students @return array<string, mixed> */
    private function attendancePayload(ClassRoom $class, array $students, string $date, string $status = 'present'): array
    {
        return [
            'class_room_id' => $class->id,
            'date' => $date,
            'records' => array_map(static fn (User $s): array => [
                'student_user_id' => $s->id,
                'status' => $status,
            ], $students),
        ];
    }

    /* ---------- today ---------- */

    public function test_today_lists_only_this_teachers_own_periods(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $today = Carbon::today();

        $this->period($mine['class'], $mine['subject'], $mine['teacher'], $today);
        $this->period($theirs['class'], $theirs['subject'], $theirs['teacher'], $today);

        $data = $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/today')
            ->assertOk()
            ->json('data');

        $this->assertCount(1, $data['periods']);
        $this->assertSame($mine['class']->id, $data['periods'][0]['class_room_id']);
        $this->assertSame(
            [$mine['class']->id],
            array_column($data['classes'], 'id'),
            'a teacher must not see another teacher\'s class in their own list',
        );
    }

    public function test_today_says_which_periods_still_need_marking(): void
    {
        // The point of the screen. A teacher who cannot see at a glance which
        // period is outstanding marks one class twice and misses another.
        $fixture = $this->assignment();
        $today = Carbon::today();
        $this->period($fixture['class'], $fixture['subject'], $fixture['teacher'], $today);

        $before = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/today')
            ->assertOk()
            ->json('data.periods.0.attendance_taken');

        $this->assertFalse($before);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $today->toDateString(),
            ))
            ->assertOk();

        $after = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/today')
            ->assertOk()
            ->json('data.periods.0.attendance_taken');

        $this->assertTrue($after);
    }

    /* ---------- roster scope ---------- */

    public function test_a_teacher_cannot_read_another_sections_roster(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();

        $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$theirs['class']->id)
            ->assertForbidden();

        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $mine['teacher']->id,
            'action' => 'authorization_denied',
            'entity_type' => 'class_room',
            'entity_id' => $theirs['class']->id,
        ]);
    }

    public function test_a_roster_refusal_does_not_leak_the_other_class(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $stranger = $theirs['students'][0];

        $body = $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$theirs['class']->id)
            ->assertForbidden()
            ->getContent();

        $this->assertStringNotContainsString($stranger->name, (string) $body);
        $this->assertStringNotContainsString($theirs['class']->name, (string) $body);
    }

    public function test_a_homeroom_teacher_reads_their_class_without_a_subject_pairing(): void
    {
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create(['homeroom_teacher_id' => $teacher->id]);
        $student = User::factory()->student()->create(['name' => 'ليان']);
        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $class->id,
        ]);

        $data = $this->actingAs($teacher)
            ->getJson('/api/mobile/v1/teacher/roster/'.$class->id)
            ->assertOk()
            ->json('data');

        $this->assertSame([$student->id], array_column($data['students'], 'student_user_id'));
    }

    public function test_a_roster_carries_the_marks_already_recorded(): void
    {
        // So the phone opens the form pre-filled and offline. An empty form on
        // a day already marked is how duplicates happen.
        $fixture = $this->assignment();
        $today = Carbon::today()->toDateString();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $today, 'late',
            ))
            ->assertOk();

        $students = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id)
            ->assertOk()
            ->json('data.students');

        $this->assertSame(['late', 'late'], array_column($students, 'status'));
    }

    public function test_a_roster_carries_the_guardians_a_teacher_would_call(): void
    {
        // The one thing a teacher needs a phone for mid-lesson. A contact that
        // requires a connection is a contact they do not have when they need it.
        $fixture = $this->assignment(1);
        $guardian = User::factory()->parentRole()->create([
            'name' => 'أم ليان',
            'phone' => '0790000000',
        ]);
        $fixture['students'][0]->parents()->attach($guardian);

        $students = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id)
            ->assertOk()
            ->json('data.students');

        $this->assertSame('0790000000', $students[0]['guardians'][0]['phone']);
        $this->assertSame('أم ليان', $students[0]['guardians'][0]['name']);
        $this->assertFalse($students[0]['has_photo']);
    }

    public function test_guardian_numbers_are_unreachable_through_an_unassigned_class(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment(1);
        $guardian = User::factory()->parentRole()->create(['phone' => '0791111111']);
        $theirs['students'][0]->parents()->attach($guardian);

        $body = (string) $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$theirs['class']->id)
            ->assertForbidden()
            ->getContent();

        $this->assertStringNotContainsString('0791111111', $body);
    }

    public function test_a_guardian_number_is_never_written_to_the_audit_log(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment(1);
        $guardian = User::factory()->parentRole()->create(['phone' => '0792222222']);
        $theirs['students'][0]->parents()->attach($guardian);

        $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$theirs['class']->id)
            ->assertForbidden();

        foreach (DB::table('audit_logs')->pluck('changes') as $changes) {
            $this->assertStringNotContainsString('0792222222', (string) $changes);
        }
    }

    /* ---------- attendance batch ---------- */

    public function test_a_batch_replayed_with_the_same_key_produces_one_submission(): void
    {
        $fixture = $this->assignment();
        $today = Carbon::today()->toDateString();
        $key = (string) Str::uuid();
        $payload = $this->attendancePayload($fixture['class'], $fixture['students'], $today);

        $first = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $payload)
            ->assertOk()
            ->json('data.batch_id');

        $second = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $payload)
            ->assertOk()
            ->json('data.batch_id');

        $this->assertSame($first, $second);
        $this->assertSame(1, DB::table('attendance_submission_batches')->count());
        $this->assertSame(
            count($fixture['students']),
            DB::table('attendance_records')->count(),
        );
    }

    public function test_the_same_key_with_different_marks_is_refused(): void
    {
        // Answering the first payload to a second, different one would silently
        // drop the correction the teacher just made.
        $fixture = $this->assignment();
        $today = Carbon::today()->toDateString();
        $key = (string) Str::uuid();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $today, 'present',
            ))
            ->assertOk();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $today, 'absent',
            ))
            ->assertStatus(409);
    }

    public function test_a_batch_without_an_idempotency_key_is_refused(): void
    {
        $fixture = $this->assignment();

        $this->actingAs($fixture['teacher'])
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], Carbon::today()->toDateString(),
            ))
            ->assertStatus(422)
            ->assertJsonValidationErrors('idempotency_key');
    }

    public function test_submitting_outside_the_edit_window_is_rejected_with_a_readable_reason(): void
    {
        config()->set('policy.attendance.edit_window_hours', 48);

        $fixture = $this->assignment();
        $stale = Carbon::today()->subDays(7)->toDateString();

        $response = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $stale,
            ))
            ->assertStatus(422);

        // A reason the client can display, not a bare status the app has to
        // guess at.
        $this->assertStringContainsString('48h edit window', $response->json('message'));
        $this->assertFalse($response->json('errors.attendance_window.open'));
        $this->assertSame(48, $response->json('errors.attendance_window.hours'));
        $this->assertSame(0, DB::table('attendance_records')->count());
    }

    public function test_the_window_state_the_client_is_shown_is_the_one_enforced(): void
    {
        // Two copies of this arithmetic is how a teacher comes to see an open
        // form that refuses the submission.
        config()->set('policy.attendance.edit_window_hours', 48);

        $fixture = $this->assignment();
        $stale = Carbon::today()->subDays(7)->toDateString();

        $window = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id.'?date='.$stale)
            ->assertOk()
            ->json('data.attendance_window');

        $this->assertFalse($window['open']);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $fixture['class'], $fixture['students'], $stale,
            ))
            ->assertStatus(422);
    }

    public function test_a_teacher_cannot_submit_attendance_for_a_class_they_do_not_teach(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/attendance/batch', $this->attendancePayload(
                $theirs['class'], $theirs['students'], Carbon::today()->toDateString(),
            ))
            ->assertForbidden();

        $this->assertSame(0, DB::table('attendance_records')->count());
        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $mine['teacher']->id,
            'action' => 'authorization_denied',
            'entity_type' => 'class_room',
            'entity_id' => $theirs['class']->id,
        ]);
    }

    /* ---------- gradebook ---------- */

    public function test_the_mark_sheet_carries_the_workflow_state_and_versions(): void
    {
        $fixture = $this->assignment(1);
        $component = $this->gradeItem($fixture['class'], $fixture['subject']);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'grades' => [[
                    'grade_component_id' => $component->id,
                    'student_user_id' => $fixture['students'][0]->id,
                    'score' => 18.5,
                ]],
            ])
            ->assertOk();

        $data = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/gradebook/'.$fixture['class']->id.'/'.$fixture['subject']->id)
            ->assertOk()
            ->json('data');

        $this->assertSame('draft', $data['gradebook']['state']);
        $this->assertTrue($data['gradebook']['editable']);
        $this->assertSame($component->id, $data['components'][0]['id']);

        $grade = $data['students'][0]['grades'][0];
        $this->assertSame($component->id, $grade['grade_component_id']);
        $this->assertSame('18.50', $grade['score']);
        $this->assertSame(1, $grade['version']);
    }

    public function test_a_finalized_sheet_reports_itself_as_not_editable(): void
    {
        // The client must not work this out for itself: the reopen window is a
        // timestamp, and a phone clock a day out would offer an editable sheet
        // the server refuses.
        $fixture = $this->assignment(1);
        $this->gradeItem($fixture['class'], $fixture['subject'], 'finalized');

        $gradebook = $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/gradebook/'.$fixture['class']->id.'/'.$fixture['subject']->id)
            ->assertOk()
            ->json('data.gradebook');

        $this->assertSame('finalized', $gradebook['state']);
        $this->assertFalse($gradebook['editable']);
    }

    public function test_a_teacher_cannot_read_another_subjects_mark_sheet(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment(1);
        $this->gradeItem($theirs['class'], $theirs['subject']);

        $this->actingAs($mine['teacher'])
            ->getJson('/api/mobile/v1/teacher/gradebook/'.$theirs['class']->id.'/'.$theirs['subject']->id)
            ->assertForbidden();

        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $mine['teacher']->id,
            'action' => 'authorization_denied',
            'entity_type' => 'class_room',
            'entity_id' => $theirs['class']->id,
        ]);
    }

    public function test_a_subject_teacher_cannot_read_a_subject_they_do_not_teach(): void
    {
        // Homeroom covers the class for attendance; a subject pairing does not
        // widen to another subject's marks.
        $fixture = $this->assignment(1);
        $other = Subject::factory()->create();
        $this->gradeItem($fixture['class'], $other);

        $this->actingAs($fixture['teacher'])
            ->getJson('/api/mobile/v1/teacher/gradebook/'.$fixture['class']->id.'/'.$other->id)
            ->assertForbidden();
    }

    /* ---------- grades batch ---------- */

    public function test_a_grade_batch_replayed_with_the_same_key_writes_once(): void
    {
        $fixture = $this->assignment();
        $component = $this->gradeItem($fixture['class'], $fixture['subject']);
        $key = (string) Str::uuid();
        $payload = [
            'class_room_id' => $fixture['class']->id,
            'subject_id' => $fixture['subject']->id,
            'grades' => [[
                'grade_component_id' => $component->id,
                'student_user_id' => $fixture['students'][0]->id,
                'score' => 18.5,
            ]],
        ];

        $first = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/grades/batch', $payload)
            ->assertOk()
            ->json('data');

        $second = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/mobile/v1/teacher/grades/batch', $payload)
            ->assertOk()
            ->json('data');

        $this->assertFalse($first['replayed']);
        $this->assertTrue($second['replayed']);
        $this->assertSame($first['batch_id'], $second['batch_id']);
        $this->assertSame(1, DB::table('teacher_grade_batches')->count());
        $this->assertSame(1, Grade::query()->count());

        // The replay must not have bumped the optimistic version: a second
        // write would make every queued edit on another device stale.
        $this->assertSame(1, (int) Grade::query()->first()->version);
    }

    public function test_a_grade_batch_is_refused_when_the_gradebook_is_finalized(): void
    {
        $fixture = $this->assignment();
        $component = $this->gradeItem($fixture['class'], $fixture['subject'], 'finalized');

        $response = $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'grades' => [[
                    'grade_component_id' => $component->id,
                    'student_user_id' => $fixture['students'][0]->id,
                    'score' => 20,
                ]],
            ])
            ->assertStatus(409);

        $this->assertStringContainsString('finalized', (string) $response->json('message'));
        $this->assertSame(0, Grade::query()->count());
    }

    public function test_a_component_from_another_class_cannot_be_written_through_an_assigned_one(): void
    {
        // The class id on the route is checked; the component id in the body is
        // not covered by that check and has to be verified separately.
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $foreign = $this->gradeItem($theirs['class'], $theirs['subject']);

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $mine['class']->id,
                'subject_id' => $mine['subject']->id,
                'grades' => [[
                    'grade_component_id' => $foreign->id,
                    'student_user_id' => $theirs['students'][0]->id,
                    'score' => 20,
                ]],
            ])
            ->assertStatus(422);

        $this->assertSame(0, Grade::query()->count());
    }

    public function test_a_stale_version_aborts_the_whole_batch(): void
    {
        // All-or-nothing: a phone that queued a column offline cannot tell
        // which half of a partial success landed.
        $fixture = $this->assignment();
        $component = $this->gradeItem($fixture['class'], $fixture['subject']);

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'grades' => [[
                    'grade_component_id' => $component->id,
                    'student_user_id' => $fixture['students'][0]->id,
                    'score' => 10,
                ]],
            ])
            ->assertOk();

        $this->actingAs($fixture['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'grades' => [
                    [
                        'grade_component_id' => $component->id,
                        'student_user_id' => $fixture['students'][0]->id,
                        'score' => 15,
                        'version' => 99,
                    ],
                    [
                        'grade_component_id' => $component->id,
                        'student_user_id' => $fixture['students'][1]->id,
                        'score' => 15,
                    ],
                ],
            ])
            ->assertStatus(409);

        // Neither row landed, and the first student's mark is untouched.
        $this->assertSame(1, Grade::query()->count());
        $this->assertSame('10.00', (string) Grade::query()->first()->score);
    }

    public function test_a_teacher_cannot_post_grades_for_a_class_they_do_not_teach(): void
    {
        $mine = $this->assignment();
        $theirs = $this->assignment();
        $component = $this->gradeItem($theirs['class'], $theirs['subject']);

        $this->actingAs($mine['teacher'])
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/mobile/v1/teacher/grades/batch', [
                'class_room_id' => $theirs['class']->id,
                'subject_id' => $theirs['subject']->id,
                'grades' => [[
                    'grade_component_id' => $component->id,
                    'student_user_id' => $theirs['students'][0]->id,
                    'score' => 20,
                ]],
            ])
            ->assertForbidden();

        $this->assertSame(0, Grade::query()->count());
        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $mine['teacher']->id,
            'action' => 'authorization_denied',
            'entity_type' => 'class_room',
            'entity_id' => $theirs['class']->id,
        ]);
    }

    /* ---------- role ---------- */

    public function test_a_parent_cannot_reach_the_teacher_surface(): void
    {
        $fixture = $this->assignment();
        $parent = User::factory()->parentRole()->create();

        $this->actingAs($parent)
            ->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id)
            ->assertForbidden();
    }

    public function test_the_teacher_surface_needs_a_token(): void
    {
        $fixture = $this->assignment();

        $this->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id)
            ->assertUnauthorized();
    }
}
