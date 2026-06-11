<?php

declare(strict_types=1);

namespace Tests\Feature\BusinessRules;

use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AttendanceTest extends TestCase
{
    use RefreshDatabase;

    private User $teacher;
    private User $student;
    private ClassRoom $classRoom;
    private Subject $subject;

    protected function setUp(): void
    {
        parent::setUp();

        $this->classRoom = ClassRoom::factory()->withHomeroom(
            $this->teacher = User::factory()->teacher()->create()
        )->create();

        $this->subject = Subject::factory()->create();

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

    public function test_teacher_can_mark_attendance(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->classRoom->id,
                'subject_id' => $this->subject->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'present'],
                ],
            ]);

        $response->assertStatus(200)
            ->assertJson(['message' => 'Attendance saved']);
        $this->assertDatabaseHas('attendance_records', [
            'student_user_id' => $this->student->id,
            'class_room_id' => $this->classRoom->id,
            'status' => 'present',
        ]);
    }

    public function test_attendance_status_must_be_valid(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->classRoom->id,
                'subject_id' => $this->subject->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'invalid_status'],
                ],
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['records.0.status']);
    }

    public function test_attendance_date_is_required(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->classRoom->id,
                'subject_id' => $this->subject->id,
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'present'],
                ],
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['date']);
    }

    public function test_parent_cannot_mark_attendance(): void
    {
        $response = $this->actingAs(User::factory()->parentRole()->create())
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->classRoom->id,
                'subject_id' => $this->subject->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'present'],
                ],
            ]);

        $response->assertStatus(403);
    }

    public function test_attendance_requires_valid_class(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => 99999,
                'subject_id' => $this->subject->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'present'],
                ],
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['class_room_id']);
    }

    public function test_teacher_can_mark_attendance_without_subject(): void
    {
        $response = $this->actingAs($this->teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $this->classRoom->id,
                'date' => now()->toDateString(),
                'records' => [
                    ['student_user_id' => $this->student->id, 'status' => 'late'],
                ],
            ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('attendance_records', [
            'student_user_id' => $this->student->id,
            'class_room_id' => $this->classRoom->id,
            'status' => 'late',
        ]);
    }
}