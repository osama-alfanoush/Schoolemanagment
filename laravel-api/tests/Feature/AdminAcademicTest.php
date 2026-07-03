<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\ClassRoom;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class AdminAcademicTest extends TestCase
{
    use RefreshDatabase;

    private User $admin;

    protected function setUp(): void
    {
        parent::setUp();
        $this->admin = User::factory()->admin()->create();
    }

    public function test_admin_can_create_list_update_delete_class(): void
    {
        $create = $this->actingAs($this->admin)->postJson('/api/admin/classes', [
            'name' => '10-A', 'grade' => '10', 'section' => 'A', 'capacity' => 30,
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/classes')->assertOk();
        $this->actingAs($this->admin)->patchJson("/api/admin/classes/{$id}", ['capacity' => 35])->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/classes/{$id}")->assertNoContent();
    }

    public function test_admin_can_manage_subjects(): void
    {
        $create = $this->actingAs($this->admin)->postJson('/api/admin/subjects', [
            'name' => 'Biology', 'code' => 'BIO101',
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/subjects')->assertOk();
        $this->actingAs($this->admin)->patchJson("/api/admin/subjects/{$id}", ['name' => 'Adv Biology'])->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/subjects/{$id}")->assertNoContent();
    }

    public function test_admin_can_assign_subject_teacher(): void
    {
        $class = ClassRoom::factory()->create();
        $subject = Subject::factory()->create();
        $teacher = User::factory()->teacher()->create();

        $this->actingAs($this->admin)->postJson("/api/admin/classes/{$class->id}/assign-subject-teacher", [
            'subject_id' => $subject->id, 'teacher_user_id' => $teacher->id,
        ])->assertOk();

        $this->assertDatabaseHas('class_subject_teacher', [
            'class_room_id' => $class->id, 'subject_id' => $subject->id, 'teacher_user_id' => $teacher->id,
        ]);
    }

    public function test_admin_can_manage_class_timetable(): void
    {
        $class = ClassRoom::factory()->create();
        $subject = Subject::factory()->create();
        $teacher = User::factory()->teacher()->create();

        $create = $this->actingAs($this->admin)->postJson("/api/admin/classes/{$class->id}/timetable", [
            'subject_id' => $subject->id, 'teacher_user_id' => $teacher->id,
            'day_of_week' => 1, 'start_time' => '08:00', 'end_time' => '09:00', 'room' => 'R1',
        ])->assertCreated();
        $entryId = $create->json('id');

        $this->actingAs($this->admin)->getJson("/api/admin/classes/{$class->id}/timetable")->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/classes/{$class->id}/timetable/{$entryId}")->assertNoContent();
    }

    public function test_admin_can_manage_exams(): void
    {
        $class = ClassRoom::factory()->create();
        $subject = Subject::factory()->create();

        $create = $this->actingAs($this->admin)->postJson('/api/admin/exams', [
            'class_room_id' => $class->id, 'subject_id' => $subject->id,
            'title' => 'Midterm', 'exam_date' => now()->addDays(10)->toDateString(),
            'start_time' => '09:00', 'end_time' => '11:00',
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/exams')->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/exams/{$id}")->assertNoContent();
    }

    public function test_admin_can_manage_academic_years(): void
    {
        $create = $this->actingAs($this->admin)->postJson('/api/admin/academic-years', [
            'name' => '2026/2027', 'start_date' => '2026-09-01', 'end_date' => '2027-06-30', 'is_current' => true,
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/academic-years')->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/academic-years/{$id}")->assertNoContent();
    }

    public function test_admin_can_manage_calendar(): void
    {
        $create = $this->actingAs($this->admin)->postJson('/api/admin/calendar', [
            'title' => 'Sports Day', 'type' => 'event', 'start_date' => now()->addDays(20)->toDateString(),
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($this->admin)->getJson('/api/admin/calendar')->assertOk();
        $this->actingAs($this->admin)->deleteJson("/api/admin/calendar/{$id}")->assertNoContent();
    }

    public function test_non_admin_cannot_access_admin_routes(): void
    {
        $teacher = User::factory()->teacher()->create();
        $this->actingAs($teacher)->getJson('/api/admin/classes')->assertStatus(403);
    }
}
