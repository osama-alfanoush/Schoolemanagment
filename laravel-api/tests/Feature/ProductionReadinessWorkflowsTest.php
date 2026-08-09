<?php

namespace Tests\Feature;

use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\Gradebook;
use App\Models\GradeComponent;
use App\Models\Invoice;
use App\Models\Subject;
use App\Models\User;
use App\Services\OutboxProcessor;
use Illuminate\Database\QueryException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tests\TestCase;

class ProductionReadinessWorkflowsTest extends TestCase
{
    use RefreshDatabase;

    public function test_gradebook_lifecycle_requires_exact_weights_and_reissues_immutable_report_card(): void
    {
        $admin = User::factory()->admin()->create();
        $teacher = User::factory()->teacher()->create();
        $student = User::factory()->student()->create();
        $school = (int) DB::table('schools')->value('id');
        $year = DB::table('academic_years')->insertGetId(['school_id' => $school, 'name' => '2026-27', 'start_date' => '2026-09-01', 'end_date' => '2027-06-30', 'is_current' => true, 'created_at' => now(), 'updated_at' => now()]);
        $class = ClassRoom::factory()->create(['school_id' => $school, 'academic_year_id' => $year]);
        $subject = Subject::factory()->create(['school_id' => $school]);
        DB::table('class_subject_teacher')->insert(['school_id' => $school, 'class_room_id' => $class->id, 'subject_id' => $subject->id, 'teacher_user_id' => $teacher->id, 'created_at' => now(), 'updated_at' => now()]);
        $term = DB::table('terms')->insertGetId(['school_id' => $school, 'academic_year_id' => $year, 'name' => 'Term 1', 'type' => 'semester', 'start_date' => '2026-09-01', 'end_date' => '2027-01-31', 'sequence' => 1, 'created_at' => now(), 'updated_at' => now()]);
        $period = DB::table('grading_periods')->insertGetId(['school_id' => $school, 'term_id' => $term, 'name' => 'Final', 'start_date' => '2026-09-01', 'end_date' => '2027-01-31', 'sequence' => 1, 'is_final' => true, 'created_at' => now(), 'updated_at' => now()]);
        $enrollment = DB::table('student_enrollments')->insertGetId(['student_user_id' => $student->id, 'school_id' => $school, 'academic_year_id' => $year, 'class_room_id' => $class->id, 'start_date' => '2026-09-01', 'status' => 'active', 'entry_type' => 'new', 'version' => 1, 'created_at' => now(), 'updated_at' => now()]);
        $book = Gradebook::create(['school_id' => $school, 'class_room_id' => $class->id, 'subject_id' => $subject->id, 'grading_period_id' => $period]);
        $component = GradeComponent::create(['class_room_id' => $class->id, 'subject_id' => $subject->id, 'gradebook_id' => $book->id, 'grading_period_id' => $period, 'name' => 'Exam', 'type' => 'exam', 'weight' => 60, 'max_score' => 100]);

        $this->actingAs($teacher)->postJson("/api/teacher/gradebooks/{$book->id}/submit", ['version' => 1])
            ->assertUnprocessable()->assertJsonValidationErrors('components');
        $component->update(['weight' => 100]);
        $submitted = $this->actingAs($teacher)->postJson("/api/teacher/gradebooks/{$book->id}/submit", ['version' => 1])->assertOk();
        $this->actingAs($admin)->postJson("/api/admin/gradebooks/{$book->id}/approve", ['version' => $submitted->json('data.version')])->assertOk();
        $finalized = $this->actingAs($admin)->postJson("/api/admin/gradebooks/{$book->id}/finalize", ['version' => 3])->assertOk()->assertJsonPath('data.state', 'finalized');
        $this->actingAs($admin)->postJson("/api/admin/gradebooks/{$book->id}/finalize", ['version' => $finalized->json('data.version')])->assertStatus(409);

        Grade::create(['student_user_id' => $student->id, 'grade_component_id' => $component->id, 'score' => 91, 'entered_by' => $teacher->id, 'version' => 1]);
        $first = $this->actingAs($admin)->postJson('/api/admin/report-cards/issue', ['student_enrollment_id' => $enrollment, 'grading_period_id' => $period])->assertCreated();
        $this->actingAs($admin)->postJson('/api/admin/report-cards/issue', ['student_enrollment_id' => $enrollment, 'grading_period_id' => $period])->assertUnprocessable();
        $second = $this->actingAs($admin)->postJson('/api/admin/report-cards/issue', ['student_enrollment_id' => $enrollment, 'grading_period_id' => $period, 'correction_reason' => 'Approved correction'])->assertCreated();
        $this->assertSame(1, $first->json('data.issue_version'));
        $this->assertSame(2, $second->json('data.issue_version'));
        $this->assertNotEmpty($first->json('data.checksum'));
    }

    public function test_manual_payment_is_idempotent_and_reconciles(): void
    {
        $finance = User::factory()->finance()->create();
        $invoice = Invoice::factory()->pending()->create(['amount' => 500, 'paid_amount' => 0]);
        $key = (string) Str::uuid();
        $payload = ['amount' => 200, 'method' => 'cash'];
        $this->actingAs($finance)->withHeader('Idempotency-Key', $key)->postJson("/api/finance/invoices/{$invoice->id}/payments", $payload)->assertCreated();
        $this->actingAs($finance)->withHeader('Idempotency-Key', $key)->postJson("/api/finance/invoices/{$invoice->id}/payments", $payload)->assertOk();
        $this->assertSame(1, DB::table('payments')->where('invoice_id', $invoice->id)->count());
        $this->assertSame(1, DB::table('payment_allocations')->where('invoice_id', $invoice->id)->count());
        $this->actingAs($finance)->postJson('/api/finance/payments/reconcile')->assertOk()->assertJsonPath('data.mismatch_count', 0);
    }

    public function test_outbox_retries_dead_letters_and_can_be_requeued(): void
    {
        DB::table('outbox_events')->insert([
            'school_id' => (int) DB::table('schools')->value('id'),
            'event_id' => $id = (string) Str::uuid(), 'type' => 'unknown.event', 'aggregate_type' => 'test', 'aggregate_id' => 1,
            'payload' => '{}', 'deduplication_key' => "test:$id", 'attempts' => 0, 'max_attempts' => 1,
            'status' => 'pending', 'available_at' => now(), 'created_at' => now(), 'updated_at' => now(),
        ]);
        $result = app(OutboxProcessor::class)->processBatch();
        $this->assertSame(1, $result['dead_lettered']);
        $this->assertDatabaseHas('outbox_events', ['event_id' => $id, 'status' => 'dead_lettered']);
        $this->assertTrue(app(OutboxProcessor::class)->retry($id));
        $this->assertDatabaseHas('outbox_events', ['event_id' => $id, 'status' => 'pending', 'attempts' => 0]);
    }

    public function test_timetable_overlap_is_rejected_and_retained_grade_cannot_cascade_delete(): void
    {
        $admin = User::factory()->admin()->create();
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create();
        $subject = Subject::factory()->create();
        DB::table('class_subject_teacher')->insert(['school_id' => $class->school_id, 'class_room_id' => $class->id, 'subject_id' => $subject->id, 'teacher_user_id' => $teacher->id, 'created_at' => now(), 'updated_at' => now()]);
        $payload = ['subject_id' => $subject->id, 'teacher_user_id' => $teacher->id, 'day_of_week' => 2, 'start_time' => '09:00', 'end_time' => '10:00', 'room' => 'R2'];
        $this->actingAs($admin)->postJson("/api/admin/classes/{$class->id}/timetable", $payload)->assertCreated();
        $this->actingAs($admin)->postJson("/api/admin/classes/{$class->id}/timetable", array_merge($payload, ['start_time' => '09:30', 'end_time' => '10:30']))->assertUnprocessable();

        $component = GradeComponent::create(['class_room_id' => $class->id, 'subject_id' => $subject->id, 'name' => 'Exam', 'type' => 'exam', 'weight' => 100, 'max_score' => 100]);
        Grade::create(['student_user_id' => User::factory()->student()->create()->id, 'grade_component_id' => $component->id, 'score' => 80, 'entered_by' => $teacher->id]);
        try {
            $component->delete();
            $this->fail('A retained grade component was physically deleted.');
        } catch (QueryException) {
            $this->assertDatabaseHas('grade_components', ['id' => $component->id]);
        }
    }
}
