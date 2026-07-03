<?php

namespace Database\Factories;

use App\Models\ClassRoom;
use App\Models\GradeComponent;
use App\Models\Subject;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<GradeComponent>
 */
class GradeComponentFactory extends Factory
{
    public function definition(): array
    {
        return [
            'class_room_id' => ClassRoom::factory(),
            'subject_id' => Subject::factory(),
            'semester_id' => null,
            'name' => $this->faker->randomElement(['Quiz 1', 'Midterm', 'Final Exam', 'Assignment 1', 'Project']),
            'type' => $this->faker->randomElement(['quiz', 'homework', 'exam', 'project']),
            'weight' => $this->faker->randomFloat(2, 10, 30),
            'max_score' => 100,
        ];
    }

    public function quiz(): static
    {
        return $this->state(fn (array $attributes) => [
            'name' => 'Quiz '.fake()->numberBetween(1, 5),
            'type' => 'quiz',
            'weight' => 10,
        ]);
    }

    public function exam(): static
    {
        return $this->state(fn (array $attributes) => [
            'name' => $this->faker->randomElement(['Midterm', 'Final Exam']),
            'type' => 'exam',
            'weight' => 30,
        ]);
    }

    public function homework(): static
    {
        return $this->state(fn (array $attributes) => [
            'name' => 'Homework '.fake()->numberBetween(1, 10),
            'type' => 'homework',
            'weight' => 20,
        ]);
    }
}
