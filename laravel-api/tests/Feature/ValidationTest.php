<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\ClassRoom;
use App\Models\FeeStructure;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ValidationTest extends TestCase
{
    use RefreshDatabase;

    public function test_login_rejects_invalid_email_format(): void
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'notanemail',
            'password' => 'password',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_login_rejects_empty_password(): void
    {
        $response = $this->postJson('/api/auth/login', [
            'email' => 'test@school.test',
            'password' => '',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['password']);
    }

    public function test_register_requires_all_fields(): void
    {
        $response = $this->postJson('/api/auth/login', []);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email', 'password']);
    }

    public function test_create_user_rejects_invalid_email(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'Bad Email User',
                'email' => 'bad',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_create_user_rejects_short_password(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'Short Password User',
                'email' => 'shortpw@school.test',
                'password' => '123',
                'role' => 'student',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['password']);
    }

    public function test_create_user_rejects_missing_name(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'email' => 'noname@school.test',
                'password' => 'password123',
                'role' => 'student',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['name']);
    }

    public function test_grade_requires_score_field(): void
    {
        $teacher = User::factory()->teacher()->create();
        $classRoom = ClassRoom::factory()->withHomeroom($teacher)->create();
        $subject = Subject::factory()->create();
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $classRoom->id,
        ]);
        $component = GradeComponent::factory()->create([
            'class_room_id' => $classRoom->id,
            'subject_id' => $subject->id,
        ]);
        DB::table('class_subject_teacher')->insert([
            'class_room_id' => $classRoom->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $response = $this->actingAs($teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $student->id,
                'grade_component_id' => $component->id,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['score']);
    }

    public function test_grade_score_must_be_numeric(): void
    {
        $teacher = User::factory()->teacher()->create();
        $classRoom = ClassRoom::factory()->withHomeroom($teacher)->create();
        $subject = Subject::factory()->create();
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $classRoom->id,
        ]);
        $component = GradeComponent::factory()->create([
            'class_room_id' => $classRoom->id,
            'subject_id' => $subject->id,
        ]);
        DB::table('class_subject_teacher')->insert([
            'class_room_id' => $classRoom->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $response = $this->actingAs($teacher)
            ->postJson('/api/teacher/grades', [
                'student_user_id' => $student->id,
                'grade_component_id' => $component->id,
                'score' => 'abc',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['score']);
    }

    public function test_attendance_requires_records_array(): void
    {
        $teacher = User::factory()->teacher()->create();
        $classRoom = ClassRoom::factory()->withHomeroom($teacher)->create();

        $response = $this->actingAs($teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $classRoom->id,
                'date' => now()->toDateString(),
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['records']);
    }

    public function test_attendance_date_must_be_valid_date(): void
    {
        $teacher = User::factory()->teacher()->create();
        $classRoom = ClassRoom::factory()->withHomeroom($teacher)->create();
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $classRoom->id,
        ]);

        $response = $this->actingAs($teacher)
            ->postJson('/api/teacher/attendance', [
                'class_room_id' => $classRoom->id,
                'date' => 'not-a-date',
                'records' => [
                    ['student_user_id' => $student->id, 'status' => 'present'],
                ],
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['date']);
    }

    public function test_invoice_generation_requires_fee_structure(): void
    {
        $finance = $this->loginAs('finance');

        $response = $this->actingAs($finance)
            ->postJson('/api/finance/invoices/generate', [
                'due_date' => now()->addDays(30)->toDateString(),
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['fee_structure_id']);
    }
}