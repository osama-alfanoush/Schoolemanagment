<?php

namespace Database\Factories;

use App\Models\ClassRoom;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\AttendanceRecord>
 */
class AttendanceRecordFactory extends Factory
{
    public function definition(): array
    {
        return [
            'student_user_id' => User::factory()->student(),
            'class_room_id' => ClassRoom::factory(),
            'subject_id' => null,
            'date' => now()->toDateString(),
            'status' => $this->faker->randomElement(['present', 'absent', 'late', 'excused']),
            'marked_by' => User::factory()->teacher(),
            'note' => null,
        ];
    }

    public function present(): static
    {
        return $this->state(fn (array $attributes) => ['status' => 'present']);
    }

    public function absent(): static
    {
        return $this->state(fn (array $attributes) => ['status' => 'absent']);
    }

    public function late(): static
    {
        return $this->state(fn (array $attributes) => ['status' => 'late']);
    }

    public function excused(): static
    {
        return $this->state(fn (array $attributes) => ['status' => 'excused']);
    }
}