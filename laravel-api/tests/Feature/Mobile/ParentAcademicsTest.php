<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tests\TestCase;

class ParentAcademicsTest extends TestCase
{
    use RefreshDatabase;

    /* ---------- fixtures ---------- */

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

    private function schoolId(): int
    {
        return (int) DB::table('schools')->value('id');
    }

    private function attendance(
        User $child,
        ClassRoom $class,
        string $date,
        string $status,
    ): AttendanceRecord {
        return AttendanceRecord::create([
            'student_user_id' => $child->id,
            'class_room_id' => $class->id,
            'date' => $date,
            'status' => $status,
            'marked_by' => $child->id,
        ]);
    }

    /** A grade whose gradebook is in [$state]. */
    private function gradeFor(
        User $child,
        ClassRoom $class,
        float $score,
        string $state = 'finalized',
    ): Grade {
        $subject = Subject::factory()->create();
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
            'sequence' => random_int(1, 100000),
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

        return Grade::create([
            'student_user_id' => $child->id,
            'grade_component_id' => $component->id,
            'score' => $score,
            'entered_by' => $child->id,
        ]);
    }

    /** An issued report card for [$child]. */
    private function issueReportCard(User $child, ClassRoom $class, int $version = 1): int
    {
        $yearId = DB::table('academic_years')->value('id')
            ?? DB::table('academic_years')->insertGetId([
                'school_id' => $class->school_id, 'name' => '2025-2026',
                'start_date' => now()->subMonths(3)->toDateString(),
                'end_date' => now()->addMonths(6)->toDateString(),
                'is_current' => true, 'created_at' => now(), 'updated_at' => now(),
            ]);
        $enrollmentId = DB::table('student_enrollments')
            ->where('student_user_id', $child->id)
            ->value('id')
            ?? DB::table('student_enrollments')->insertGetId([
                'student_user_id' => $child->id, 'school_id' => $class->school_id,
                'academic_year_id' => $yearId, 'class_room_id' => $class->id,
                'start_date' => now()->subMonths(2)->toDateString(),
                'status' => 'active', 'entry_type' => 'new',
                'created_at' => now(), 'updated_at' => now(),
            ]);
        $termId = DB::table('terms')->value('id')
            ?? DB::table('terms')->insertGetId([
                'school_id' => $class->school_id, 'academic_year_id' => $yearId,
                'name' => 'Term 1', 'type' => 'semester',
                'start_date' => now()->subMonths(2)->toDateString(),
                'end_date' => now()->addMonths(2)->toDateString(),
                'sequence' => 1, 'created_at' => now(), 'updated_at' => now(),
            ]);
        $periodId = DB::table('grading_periods')->value('id')
            ?? DB::table('grading_periods')->insertGetId([
                'school_id' => $class->school_id, 'term_id' => $termId,
                'name' => 'Term 1', 'start_date' => now()->subMonth()->toDateString(),
                'end_date' => now()->addMonth()->toDateString(), 'sequence' => 1,
                'created_at' => now(), 'updated_at' => now(),
            ]);

        return DB::table('report_card_issues')->insertGetId([
            'school_id' => $class->school_id,
            'student_enrollment_id' => $enrollmentId,
            'grading_period_id' => $periodId,
            'issue_version' => $version,
            'snapshot' => json_encode(['by_subject' => []]),
            'issued_by' => $child->id,
            'issued_at' => now()->subDays($version === 1 ? 10 : 1),
            'created_at' => now(), 'updated_at' => now(),
        ]);
    }

    /* ---------- attendance ---------- */

    public function test_attendance_reports_the_detail_a_parent_asks_about(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->attendance($child, $class, now()->subDays(3)->toDateString(), 'present');
        $this->attendance($child, $class, now()->subDays(2)->toDateString(), 'absent');
        $this->attendance($child, $class, now()->subDay()->toDateString(), 'late');

        $data = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/attendance")
            ->assertOk()
            ->json('data');

        $this->assertSame(3, $data['recorded_days']);
        $this->assertSame(1, $data['absent_days']);
        $this->assertSame(1, $data['late_days']);
        $this->assertSame(67, $data['present_percent']);
        $this->assertCount(3, $data['days']);
    }

    public function test_a_window_with_no_register_is_not_a_perfect_window(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/attendance")
            ->assertOk()
            ->assertJsonPath('data.present_percent', null);
    }

    public function test_a_backwards_window_is_refused_rather_than_silently_empty(): void
    {
        // Returning nothing would read as perfect attendance on the client.
        ['parent' => $parent, 'child' => $child] = $this->family();

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/attendance?from=2026-09-30&to=2026-09-01")
            ->assertStatus(422);
    }

    public function test_a_parent_cannot_read_another_familys_attendance(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirs] = $this->family('سلمى');

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/children/{$theirs->id}/attendance")
            ->assertStatus(403);
    }

    /* ---------- explaining an absence ---------- */

    private function explain(User $parent, int $recordId, string $key, string $reason = 'حرارة مرتفعة')
    {
        return $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson("/api/mobile/v1/parent/attendance/{$recordId}/explain", [
                'reason' => $reason,
            ]);
    }

    public function test_a_guardian_explains_an_absence_without_changing_it(): void
    {
        // Only the school decides whether an absence becomes excused. This is
        // the message that asks.
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendance($child, $class, now()->subDay()->toDateString(), 'absent');

        $this->explain($parent, $record->id, (string) Str::uuid())->assertStatus(201);

        $this->assertSame('absent', $record->fresh()->status);
        $this->assertDatabaseHas('attendance_explanations', [
            'attendance_record_id' => $record->id,
        ]);
    }

    public function test_the_teachers_note_is_never_overwritten_by_a_parent(): void
    {
        // The note is what the teacher observed; the explanation is what the
        // parent says. Different claims by different people.
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendance($child, $class, now()->subDay()->toDateString(), 'absent');
        $record->update(['note' => 'Not in registration']);

        $this->explain($parent, $record->id, (string) Str::uuid())->assertStatus(201);

        $this->assertSame('Not in registration', $record->fresh()->note);

        $day = collect(
            $this->actingAs($parent)
                ->getJson("/api/mobile/v1/parent/children/{$child->id}/attendance")
                ->json('data.days')
        )->firstWhere('id', $record->id);

        $this->assertSame('Not in registration', $day['note']);
        $this->assertSame('حرارة مرتفعة', $day['explanation']);
    }

    public function test_a_replayed_explanation_files_once(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendance($child, $class, now()->subDay()->toDateString(), 'absent');
        $key = (string) Str::uuid();

        $this->explain($parent, $record->id, $key)->assertStatus(201);
        $this->explain($parent, $record->id, $key)->assertStatus(200);

        $this->assertSame(1, DB::table('attendance_explanations')->count());
    }

    public function test_an_explanation_without_an_idempotency_key_is_refused(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendance($child, $class, now()->subDay()->toDateString(), 'absent');

        $this->actingAs($parent)
            ->postJson("/api/mobile/v1/parent/attendance/{$record->id}/explain", [
                'reason' => 'حرارة مرتفعة',
            ])
            ->assertStatus(422);

        $this->assertSame(0, DB::table('attendance_explanations')->count());
    }

    public function test_a_guardian_cannot_explain_another_familys_absence(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild, 'class' => $theirClass] = $this->family('سلمى');
        $record = $this->attendance($theirChild, $theirClass, now()->subDay()->toDateString(), 'absent');

        $this->explain($mine, $record->id, (string) Str::uuid())->assertStatus(403);

        $this->assertSame(0, DB::table('attendance_explanations')->count());
    }

    /* ---------- grades ---------- */

    public function test_only_finalized_marks_reach_a_parent(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->gradeFor($child, $class, 88, 'finalized');
        $this->gradeFor($child, $class, 41, 'draft');
        $this->gradeFor($child, $class, 55, 'submitted');

        $subjects = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/grades")
            ->assertOk()
            ->json('data.subjects');

        $this->assertCount(1, $subjects);
        $this->assertSame('88.00', $subjects[0]['components'][0]['score']);

        // And the unpublished scores are nowhere in the payload at all.
        $body = (string) json_encode($subjects);
        $this->assertStringNotContainsString('41.00', $body);
        $this->assertStringNotContainsString('55.00', $body);
    }

    public function test_a_subject_percentage_is_computed_without_float_drift(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->gradeFor($child, $class, 33.33);

        $subject = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/grades")
            ->assertOk()
            ->json('data.subjects.0');

        $this->assertSame(33, $subject['percent']);
        $this->assertIsInt($subject['percent']);
    }

    public function test_a_parent_cannot_read_another_familys_marks(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirs, 'class' => $theirClass] = $this->family('سلمى');
        $this->gradeFor($theirs, $theirClass, 90);

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/children/{$theirs->id}/grades")
            ->assertStatus(403);
    }

    /* ---------- report cards ---------- */

    public function test_only_issued_report_cards_are_listed(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();

        // Marks exist, but nothing has been issued.
        $this->gradeFor($child, $class, 88);

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/report-cards")
            ->assertOk()
            ->assertJsonPath('data.report_cards', []);

        $this->issueReportCard($child, $class);

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/report-cards")
            ->assertOk()
            ->assertJsonCount(1, 'data.report_cards');
    }

    public function test_a_reissued_report_card_supersedes_the_version_before_it(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->issueReportCard($child, $class, 1);
        $this->issueReportCard($child, $class, 2);

        $cards = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/report-cards")
            ->assertOk()
            ->json('data.report_cards');

        // One period, one card: the version in force. A superseded correction
        // is not offered alongside the one that replaced it.
        $this->assertCount(1, $cards);
        $this->assertSame(2, $cards[0]['version']);
    }

    public function test_an_unissued_report_card_is_not_reachable_at_all(): void
    {
        // Not merely hidden from the list: there is no row, so the PDF route
        // has nothing to render and nothing to leak.
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->gradeFor($child, $class, 88);

        $this->actingAs($parent)
            ->get('/api/mobile/v1/parent/report-cards/999999/pdf')
            ->assertStatus(403);
    }

    public function test_a_guardian_downloads_their_own_issued_report_card(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $issueId = $this->issueReportCard($child, $class);

        $response = $this->actingAs($parent)
            ->get("/api/mobile/v1/parent/report-cards/{$issueId}/pdf");

        $response->assertOk();
        $this->assertStringContainsString(
            'application/pdf',
            (string) $response->headers->get('Content-Type'),
        );
    }

    public function test_another_familys_report_card_is_refused_and_logged(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild, 'class' => $theirClass] = $this->family('سلمى');
        $issueId = $this->issueReportCard($theirChild, $theirClass);

        $this->actingAs($mine)
            ->get("/api/mobile/v1/parent/report-cards/{$issueId}/pdf")
            ->assertStatus(403);

        $this->assertDatabaseHas('audit_logs', ['action' => 'authorization_denied']);
    }

    /* ---------- conditional GET ---------- */

    public function test_unchanged_academics_answer_304(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->attendance($child, $class, now()->subDay()->toDateString(), 'present');

        $url = "/api/mobile/v1/parent/children/{$child->id}/attendance";
        $etag = $this->actingAs($parent)->getJson($url)->assertOk()->headers->get('ETag');

        $this->actingAs($parent)
            ->withHeader('If-None-Match', $etag)
            ->getJson($url)
            ->assertStatus(304);
    }
}
