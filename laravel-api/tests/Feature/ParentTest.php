<?php

declare(strict_types=1);

namespace Tests\Feature;

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
