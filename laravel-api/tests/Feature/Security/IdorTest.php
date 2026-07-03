<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class IdorTest extends TestCase
{
    use RefreshDatabase;

    public function test_parent_cannot_access_other_childs_grades(): void
    {
        $parent1 = $this->loginAs('parentRole');
        $student1 = User::factory()->student()->create();
        $student1->parents()->attach($parent1);

        $student2 = User::factory()->student()->create();

        $this->getJson("/api/parent/children/{$student2->id}/grades")
            ->assertForbidden();
    }

    public function test_parent_cannot_access_other_child_attendance(): void
    {
        $parent1 = $this->loginAs('parentRole');
        $student1 = User::factory()->student()->create();
        $student1->parents()->attach($parent1);

        $student2 = User::factory()->student()->create();

        $this->getJson("/api/parent/children/{$student2->id}/attendance")
            ->assertForbidden();
    }

    public function test_parent_cannot_access_other_child_invoices(): void
    {
        $parent1 = $this->loginAs('parentRole');
        $student1 = User::factory()->student()->create();
        $student1->parents()->attach($parent1);

        $student2 = User::factory()->student()->create();

        $this->getJson("/api/parent/children/{$student2->id}/invoices")
            ->assertForbidden();
    }

    public function test_parent_cannot_access_other_child_assignments(): void
    {
        $parent1 = $this->loginAs('parentRole');
        $student1 = User::factory()->student()->create();
        $student1->parents()->attach($parent1);

        $student2 = User::factory()->student()->create();

        $this->getJson("/api/parent/children/{$student2->id}/assignments")
            ->assertForbidden();
    }

    public function test_parent_can_view_own_child_grades(): void
    {
        $parent = $this->loginAs('parentRole');
        $student = User::factory()->student()->create();
        $student->parents()->attach($parent);

        $this->getJson("/api/parent/children/{$student->id}/grades")
            ->assertOk();
    }

    public function test_student_cannot_access_parent_routes(): void
    {
        $student = $this->loginAs('student');

        $response = $this->getJson('/api/parent/children');
        $response->assertForbidden();
    }

    public function test_teacher_cannot_access_finance_routes(): void
    {
        $teacher = $this->loginAs('teacher');

        $response = $this->getJson('/api/finance/invoices');
        $response->assertForbidden();
    }

    public function test_finance_cannot_access_hr_routes(): void
    {
        $finance = $this->loginAs('finance');

        $response = $this->getJson('/api/hr/staff');
        $response->assertForbidden();
    }

    public function test_warehouse_cannot_access_accounting_routes(): void
    {
        $warehouse = $this->loginAs('warehouse');

        $response = $this->getJson('/api/accounting/journal-entries');
        $response->assertForbidden();
    }
}
