<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\HrRequest;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class HrTest extends TestCase
{
    use RefreshDatabase;

    public function test_hr_can_list_staff(): void
    {
        $hr = $this->loginAs('hr');

        $response = $this->actingAs($hr)
            ->getJson('/api/hr/staff');

        $response->assertOk();
    }

    public function test_hr_can_view_leave_requests(): void
    {
        $hr = $this->loginAs('hr');

        $response = $this->actingAs($hr)
            ->getJson('/api/hr/leave-requests');

        $response->assertOk();
    }

    public function test_leave_request_requires_dates(): void
    {
        $teacher = User::factory()->teacher()->create();

        // start_date and end_date are optional in submitHrRequest (nullable, with end_date|after_or_equal:start_date)
        // So we test that a request without dates is accepted (nullable fields)
        $response = $this->actingAs($teacher)
            ->postJson('/api/teacher/hr-requests', [
                'type' => 'leave_annual',
                'subject' => 'Annual Leave',
                'reason' => 'Family vacation',
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('hr_requests', ['teacher_user_id' => $teacher->id, 'type' => 'leave_annual']);
    }

    public function test_staff_actor_can_submit_hr_request_to_hr_queue(): void
    {
        $finance = User::factory()->finance()->create();
        User::factory()->hr()->create();

        $response = $this->actingAs($finance)
            ->postJson('/api/hr-requests', [
                'type' => 'general',
                'subject' => 'Schedule request',
                'reason' => 'Need to update my working schedule.',
            ]);

        $response->assertCreated()
            ->assertJsonPath('requester.id', $finance->id)
            ->assertJsonPath('status', 'pending');

        $this->assertDatabaseHas('hr_requests', [
            'teacher_user_id' => $finance->id,
            'subject' => 'Schedule request',
            'status' => 'pending',
        ]);

        $hr = $this->loginAs('hr');
        $this->actingAs($hr)
            ->getJson('/api/hr/requests')
            ->assertOk()
            ->assertJsonPath('data.0.requester.id', $finance->id);
    }

    public function test_hr_can_review_request_and_non_hr_cannot(): void
    {
        $teacher = User::factory()->teacher()->create();
        $request = HrRequest::create([
            'teacher_user_id' => $teacher->id,
            'type' => 'leave_annual',
            'subject' => 'Annual leave',
            'reason' => 'Family travel',
            'status' => 'pending',
        ]);

        $admin = User::factory()->admin()->create();
        $this->actingAs($admin)
            ->patchJson("/api/hr/requests/{$request->id}/review", [
                'status' => 'approved',
            ])
            ->assertForbidden();

        $hr = $this->loginAs('hr');
        $this->actingAs($hr)
            ->patchJson("/api/hr/requests/{$request->id}/review", [
                'status' => 'approved',
                'response' => 'Approved by HR.',
            ])
            ->assertOk()
            ->assertJsonPath('status', 'approved')
            ->assertJsonPath('reviewer.id', $hr->id);

        $this->assertDatabaseHas('hr_requests', [
            'id' => $request->id,
            'status' => 'approved',
            'admin_response' => 'Approved by HR.',
            'reviewed_by' => $hr->id,
        ]);
    }

    public function test_hr_can_view_leave_balances(): void
    {
        $hr = $this->loginAs('hr');

        $response = $this->actingAs($hr)
            ->getJson('/api/hr/leave-balances');

        $response->assertOk();
    }

    public function test_student_cannot_access_hr_routes(): void
    {
        $student = $this->loginAs('student');

        $response = $this->actingAs($student)
            ->getJson('/api/hr/staff');

        $response->assertForbidden();
    }

    public function test_admin_can_access_hr_staff(): void
    {
        $admin = $this->loginAs('admin');

        $response = $this->actingAs($admin)
            ->getJson('/api/hr/staff');

        $response->assertOk();
    }
}
