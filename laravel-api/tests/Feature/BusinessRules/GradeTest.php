<?php

declare(strict_types=1);

namespace Tests\Feature\BusinessRules;

use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class GradeTest extends TestCase
{
    use RefreshDatabase;

    private User $teacher;

    private User $student;

    private ClassRoom $classRoom;

    private Subject $subject;

    private GradeComponent $component;

    protected function setUp(): void
    {
        parent::setUp();

        $this->classRoom = ClassRoom::factory()->withHomeroom(
            $this->teacher = User::factory()->teacher()->create()
        )->create();

        $this->subject = Subject::factory()->create();

        $this->component = GradeComponent::factory()->create([
            'class_room_id' => $this->classRoom->id,
            'subject_id' => $this->subject->id,
            'max_score' => 100,
        ]);

        $this->student = User::factory()->student()->create();

        StudentProfile::factory()->create([
            'user_id' => $this->student->id,
            'class_room_id' => $this->classRoom->id,
        ]);

        DB::table('class_subject_teacher')->insert([
            'class_room_id' => $this->classRoom->id,
            'subject_id' => $this->subject->id,
            'teacher_user_id' => $this->teacher->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    public function test_teacher_can_enter_grade(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => $this->component->id,
                'score' => 85.5,
            ]);

        $response->assertOk();
        $this->assertDatabaseHas('grades', [
            'student_user_id' => $this->student->id,
            'grade_component_id' => $this->component->id,
            'score' => 85.5,
            'entered_by' => $this->teacher->id,
        ]);
    }

    public function test_grade_score_cannot_exceed_max_score(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => $this->component->id,
                'score' => 150,
            ]);

        $response->assertStatus(422)
            ->assertJson(['message' => 'Score exceeds component max_score']);
    }

    public function test_grade_score_cannot_be_negative(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => $this->component->id,
                'score' => -1,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['score']);
    }

    public function test_student_cannot_enter_grades(): void
    {
        $response = $this->actingAs($this->student)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => $this->component->id,
                'score' => 75,
            ]);

        $response->assertStatus(403);
    }

    public function test_teacher_can_update_grade(): void
    {
        $grade = Grade::factory()->create([
            'student_user_id' => $this->student->id,
            'grade_component_id' => $this->component->id,
            'score' => 70,
            'entered_by' => $this->teacher->id,
        ]);

        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => $this->component->id,
                'score' => 90,
            ]);

        $response->assertOk();
        $this->assertDatabaseHas('grades', [
            'student_user_id' => $this->student->id,
            'grade_component_id' => $this->component->id,
            'score' => 90,
        ]);
    }

    public function test_grade_requires_valid_component(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => 99999,
                'score' => 75,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['grade_component_id']);
    }

    public function test_grade_requires_valid_student(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => 99999,
                'grade_component_id' => $this->component->id,
                'score' => 75,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['student_user_id']);
    }
}
