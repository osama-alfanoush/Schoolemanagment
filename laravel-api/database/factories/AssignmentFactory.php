<?php

namespace Database\Factories;

use App\Models\ClassRoom;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Assignment>
 */
class AssignmentFactory extends Factory
{
    public function definition(): array
    {
        return [
            'teacher_user_id' => User::factory()->teacher(),
            'class_room_id' => ClassRoom::factory(),
            'subject_id' => Subject::factory(),
            'title' => $this->faker->sentence(4),
            'instructions' => $this->faker->paragraphs(2, true),
            'attachment_path' => null,
            'due_at' => now()->addDays($this->faker->numberBetween(7, 30)),
            'max_score' => 100,
        ];
    }

    public function past(): static
    {
        return $this->state(fn (array $attributes) => [
            'due_at' => now()->subDays($this->faker->numberBetween(1, 10)),
        ]);
    }
}