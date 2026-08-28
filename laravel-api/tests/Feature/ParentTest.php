<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ParentTest extends TestCase
{
    use RefreshDatabase;

    public function test_parent_can_view_own_children(): void
    {
        $parent = $this->loginAs('parentRole');
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);

        $response = $this->actingAs($parent)
            ->getJson('/api/parent/children');

        $response->assertOk();
        $response->assertJsonCount(1, 'data');
    }

    public function test_children_listing_carries_the_summary_stats_the_cards_render(): void
    {
        // The children cards read attendance_rate / average_grade /
        // pending_assignments; the endpoint never returned them, so every
        // child showed "-%" and a zeroed performance bar.
        $parent = $this->loginAs('parentRole');
        $classRoom = ClassRoom::factory()->create();
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);
        StudentProfile::factory()->create(['user_id' => $child->id, 'class_room_id' => $classRoom->id]);

        foreach (['present', 'present', 'present', 'absent'] as $i => $status) {
            AttendanceRecord::create([
                'student_user_id' => $child->id,
                'class_room_id' => $classRoom->id,
                'date' => now()->subDays($i + 1)->toDateString(),
                'status' => $status,
                'marked_by' => $parent->id,
            ]);
        }

        $component = GradeComponent::factory()->create(['class_room_id' => $classRoom->id, 'max_score' => 100]);
        Grade::create([
            'student_user_id' => $child->id,
            'grade_component_id' => $component->id,
            'score' => 80,
            'entered_by' => $parent->id,
        ]);

        // Due in the future and unsubmitted → pending.
        Assignment::create([
            'teacher_user_id' => $parent->id,
            'class_room_id' => $classRoom->id,
            'subject_id' => Subject::factory()->create()->id,
            'title' => 'Chapter 4 problems',
            'instructions' => 'Solve 1-10.',
            'due_at' => now()->addWeek(),
            'max_score' => 100,
        ]);

        $response = $this->actingAs($parent)->getJson('/api/parent/children');

        $response->assertOk()
            ->assertJsonPath('data.0.attendance_rate', 75)
            ->assertJsonPath('data.0.average_grade', 80)
            ->assertJsonPath('data.0.pending_assignments', 1);
    }

    public function test_parent_can_view_own_child_grades(): void
    {
        $parent = $this->loginAs('parentRole');
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);

        $response = $this->actingAs($parent)
            ->getJson("/api/parent/children/{$child->id}/grades");

        $response->assertOk();
    }

    public function test_parent_can_view_own_child_attendance(): void
    {
        $parent = $this->loginAs('parentRole');
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);

        $response = $this->actingAs($parent)
            ->getJson("/api/parent/children/{$child->id}/attendance");

        $response->assertOk();
    }

    public function test_parent_can_view_own_child_invoices(): void
    {
        $parent = $this->loginAs('parentRole');
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);

        $response = $this->actingAs($parent)
            ->getJson("/api/parent/children/{$child->id}/invoices");

        $response->assertOk();
    }

    public function test_parent_cannot_view_unrelated_child_grades(): void
    {
        $parent = $this->loginAs('parentRole');
        $ownChild = User::factory()->student()->create();
        $ownChild->parents()->attach($parent);

        $unrelatedChild = User::factory()->student()->create();

        $response = $this->actingAs($parent)
            ->getJson("/api/parent/children/{$unrelatedChild->id}/grades");

        $response->assertForbidden();
    }
}
