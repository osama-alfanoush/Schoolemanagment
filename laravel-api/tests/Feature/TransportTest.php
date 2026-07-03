<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\StudentProfile;
use App\Models\TransportAssignment;
use App\Models\TransportRoute;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TransportTest extends TestCase
{
    use RefreshDatabase;

    private function route(): TransportRoute
    {
        return TransportRoute::create([
            'name' => 'Route A', 'departure_time' => '07:00', 'return_time' => '15:00',
            'fee' => 100, 'capacity' => 40, 'is_active' => true,
        ]);
    }

    public function test_admin_can_create_and_list_routes(): void
    {
        $admin = User::factory()->admin()->create();

        $this->actingAs($admin)->postJson('/api/admin/transport/routes', [
            'name' => 'North Route', 'departure_time' => '07:30', 'return_time' => '15:30',
            'fee' => 150, 'capacity' => 30,
        ])->assertCreated();

        $this->actingAs($admin)->getJson('/api/admin/transport/routes')->assertOk();
    }

    public function test_admin_can_create_and_list_vehicles(): void
    {
        $admin = User::factory()->admin()->create();
        $route = $this->route();

        $this->actingAs($admin)->postJson('/api/admin/transport/vehicles', [
            'registration_number' => 'KAA-123', 'model' => 'Toyota Coaster',
            'type' => 'bus', 'capacity' => 33, 'route_id' => $route->id,
        ])->assertCreated();

        $this->actingAs($admin)->getJson('/api/admin/transport/vehicles')->assertOk();
    }

    public function test_admin_can_create_and_list_stops(): void
    {
        $admin = User::factory()->admin()->create();
        $route = $this->route();

        $this->actingAs($admin)->postJson('/api/admin/transport/stops', [
            'route_id' => $route->id, 'name' => 'Main Gate', 'address' => '123 St',
            'pickup_time' => '07:10', 'dropoff_time' => '15:10', 'sequence_number' => 1,
        ])->assertCreated();

        $this->actingAs($admin)->getJson('/api/admin/transport/stops')->assertOk();
    }

    public function test_admin_can_list_assignments(): void
    {
        $admin = User::factory()->admin()->create();
        $this->actingAs($admin)->getJson('/api/admin/transport/assignments')->assertOk();
    }

    public function test_route_creation_requires_valid_times(): void
    {
        $admin = User::factory()->admin()->create();
        $this->actingAs($admin)->postJson('/api/admin/transport/routes', [
            'name' => 'Bad', 'departure_time' => 'not-a-time', 'return_time' => '15:00',
            'fee' => 100, 'capacity' => 10,
        ])->assertStatus(422);
    }

    public function test_student_can_view_own_route(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $route = $this->route();
        TransportAssignment::create([
            'student_user_id' => $student->id, 'route_id' => $route->id,
            'start_date' => now()->toDateString(), 'is_active' => true,
        ]);

        $this->actingAs($student)->getJson('/api/student/transport/my-route')->assertOk();
    }

    public function test_non_admin_cannot_manage_transport(): void
    {
        $teacher = User::factory()->teacher()->create();
        $this->actingAs($teacher)->getJson('/api/admin/transport/routes')->assertStatus(403);
    }
}
