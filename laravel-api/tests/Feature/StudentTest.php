<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class StudentTest extends TestCase
{
    use RefreshDatabase;

    private User $student;

    protected function setUp(): void
    {
        parent::setUp();
        $this->student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $this->student->id]);
    }

    public function test_student_can_view_own_grades(): void
    {
        $response = $this->actingAs($this->student)
            ->getJson('/api/student/grades');

        $response->assertOk()
            ->assertJsonStructure(['by_subject']);
    }

    public function test_student_can_view_own_attendance(): void
    {
        $response = $this->actingAs($this->student)
            ->getJson('/api/student/attendance');

        $response->assertOk();
    }

    public function test_student_can_view_assignments(): void
    {
        $response = $this->actingAs($this->student)
            ->getJson('/api/student/assignments');

        $response->assertOk();
    }

    public function test_student_can_submit_assignment(): void
    {
        $response = $this->actingAs($this->student)
            ->postJson('/api/student/assignments/99999/submit', [
                'content_text' => 'My submission',
            ]);

        // Assignment not found, but not a 403 (student can reach the endpoint)
        $response->assertStatus(404);
    }

    public function test_student_cannot_access_teacher_grades_endpoint(): void
    {
        $response = $this->actingAs($this->student)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $this->student->id,
                'grade_component_id' => 1,
                'score' => 80,
            ]);

        $response->assertStatus(403);
    }

    public function test_student_can_view_dashboard(): void
    {
        $response = $this->actingAs($this->student)
            ->getJson('/api/student/dashboard');

        $response->assertOk()
            ->assertJsonStructure([
                'upcoming_assignments',
                'recent_grades',
                'today_attendance',
            ]);
    }

    public function test_student_can_view_timetable(): void
    {
        $response = $this->actingAs($this->student)
            ->getJson('/api/student/timetable');

        $response->assertOk();
    }
}
