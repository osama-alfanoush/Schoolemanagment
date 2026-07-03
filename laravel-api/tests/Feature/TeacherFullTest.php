<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\Assignment;
use App\Models\ClassRoom;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\Submission;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TeacherFullTest extends TestCase
{
    use RefreshDatabase;

    private User $teacher;
    private ClassRoom $class;
    private Subject $subject;

    protected function setUp(): void
    {
        parent::setUp();
        $this->teacher = User::factory()->teacher()->create();
        $this->subject = Subject::factory()->create();
        $this->class = ClassRoom::factory()->create(['homeroom_teacher_id' => $this->teacher->id]);
        // Link teacher to the class+subject so subject-scoped endpoints authorize.
        DB::table('class_subject_teacher')->insert([
            'class_room_id' => $this->class->id,
            'subject_id' => $this->subject->id,
            'teacher_user_id' => $this->teacher->id,
        ]);
    }

    private function studentInClass(): User
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id, 'class_room_id' => $this->class->id]);

        return $student;
    }

    public function test_teacher_can_list_classes(): void
    {
        $this->actingAs($this->teacher)->getJson('/api/teacher/classes')->assertOk();
    }

    public function test_teacher_can_view_timetable(): void
    {
        $this->actingAs($this->teacher)->getJson('/api/teacher/timetable')->assertOk();
    }

    public function test_teacher_can_view_class_students(): void
    {
        $this->studentInClass();
        $this->actingAs($this->teacher)
            ->getJson("/api/teacher/classes/{$this->class->id}/students")
            ->assertOk();
    }

    public function test_teacher_cannot_view_students_of_unassigned_class(): void
    {
        $other = ClassRoom::factory()->create();
        $this->actingAs($this->teacher)
            ->getJson("/api/teacher/classes/{$other->id}/students")
            ->assertStatus(403);
    }

    public function test_teacher_can_create_assignment(): void
    {
        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/assignments', [
                'class_room_ids' => [$this->class->id],
                'subject_id' => $this->subject->id,
                'title' => 'Homework 1',
                'instructions' => 'Do pages 1-5',
                'due_at' => now()->addDays(7)->toDateString(),
                'max_score' => 100,
            ])
            ->assertCreated();
    }

    public function test_teacher_can_mark_attendance(): void
    {
        $student = $this->studentInClass();
        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->class->id,
                'subject_id' => $this->subject->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $student->id, 'status' => 'present'],
                ],
            ])
            ->assertOk();
    }

    public function test_teacher_can_create_and_list_grade_components(): void
    {
        $this->actingAs($this->teacher)
            ->postJson("/api/teacher/grade-components/{$this->class->id}/{$this->subject->id}", [
                'name' => 'Quiz 1', 'type' => 'quiz', 'weight' => 20, 'max_score' => 100,
            ])
            ->assertCreated();

        $this->actingAs($this->teacher)
            ->getJson("/api/teacher/grade-components/{$this->class->id}/{$this->subject->id}")
            ->assertOk();
    }

    public function test_teacher_can_enter_grade(): void
    {
        $student = $this->studentInClass();
        $component = GradeComponent::factory()->create([
            'class_room_id' => $this->class->id,
            'subject_id' => $this->subject->id,
            'max_score' => 100,
        ]);

        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $student->id,
                'grade_component_id' => $component->id,
                'score' => 85,
            ])
            ->assertOk();
    }

    public function test_teacher_cannot_enter_grade_above_max(): void
    {
        $student = $this->studentInClass();
        $component = GradeComponent::factory()->create([
            'class_room_id' => $this->class->id, 'subject_id' => $this->subject->id, 'max_score' => 100,
        ]);

        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $student->id,
                'grade_component_id' => $component->id,
                'score' => 150,
            ])
            ->assertStatus(422);
    }

    public function test_teacher_can_grade_submission(): void
    {
        $student = $this->studentInClass();
        $assignment = Assignment::create([
            'teacher_user_id' => $this->teacher->id,
            'class_room_id' => $this->class->id,
            'subject_id' => $this->subject->id,
            'title' => 'Essay', 'instructions' => 'Write an essay',
            'due_at' => now()->addDays(3), 'max_score' => 100,
        ]);
        $submission = Submission::create([
            'assignment_id' => $assignment->id,
            'student_user_id' => $student->id,
            'content_text' => 'My work',
            'submitted_at' => now(),
            'status' => 'submitted',
        ]);

        $this->actingAs($this->teacher)
            ->patchJson("/api/teacher/submissions/{$submission->id}/grade", [
                'score' => 90, 'feedback' => 'Great work',
            ])
            ->assertOk();
    }

    public function test_teacher_can_log_conduct(): void
    {
        $student = $this->studentInClass();
        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/conduct', [
                'student_user_id' => $student->id,
                'category' => 'positive',
                'title' => 'Helped a classmate',
                'note' => 'Showed great teamwork',
            ])
            ->assertCreated();
    }

    public function test_teacher_can_announce_to_class(): void
    {
        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/announcements', [
                'class_room_id' => $this->class->id,
                'title' => 'Test reminder',
                'body' => 'Bring your books tomorrow',
            ])
            ->assertCreated();
    }

    public function test_teacher_can_submit_and_list_hr_requests(): void
    {
        $this->actingAs($this->teacher)
            ->postJson('/api/teacher/hr-requests', [
                'type' => 'leave_annual', 'subject' => 'Vacation', 'reason' => 'Family trip',
            ])
            ->assertCreated();

        $this->actingAs($this->teacher)
            ->getJson('/api/teacher/hr-requests')
            ->assertOk();
    }

    public function test_student_cannot_access_teacher_routes(): void
    {
        $student = User::factory()->student()->create();
        $this->actingAs($student)->getJson('/api/teacher/classes')->assertStatus(403);
    }
}
