<?php

declare(strict_types=1);

namespace Tests\Feature\BusinessRules;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ParentStudentLinkTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_link_a_parent_to_a_student(): void
    {
        $admin = $this->loginAs('admin');
        $parent = User::factory()->parentRole()->create();
        $student = User::factory()->student()->create();

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users/link-parent', [
                'parent_user_id' => $parent->id,
                'student_user_id' => $student->id,
            ]);

        $response->assertOk();
        $this->assertDatabaseHas('parent_student', [
            'parent_user_id' => $parent->id,
            'student_user_id' => $student->id,
        ]);
    }

    public function test_linking_rejects_non_parent_in_parent_slot(): void
    {
        $admin = $this->loginAs('admin');
        $notParent = User::factory()->teacher()->create();
        $student = User::factory()->student()->create();

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users/link-parent', [
                'parent_user_id' => $notParent->id,
                'student_user_id' => $student->id,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['parent_user_id']);
    }

    public function test_linking_rejects_non_student_in_student_slot(): void
    {
        $admin = $this->loginAs('admin');
        $parent = User::factory()->parentRole()->create();
        $notStudent = User::factory()->teacher()->create();

        $response = $this->actingAs($admin)
            ->postJson('/api/admin/users/link-parent', [
                'parent_user_id' => $parent->id,
                'student_user_id' => $notStudent->id,
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['student_user_id']);
    }
}
