<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Subject>
 */
class SubjectFactory extends Factory
{
    public function definition(): array
    {
        $name = $this->faker->unique()->randomElement([
            'Mathematics', 'English', 'Physics', 'Chemistry', 'Biology',
            'History', 'Geography', 'Computer Science', 'Art', 'Music',
            'Physical Education', 'Swahili', 'French', 'Arabic', 'Agriculture',
        ]);
        return [
            'name' => $name,
            'code' => strtoupper(substr($name, 0, 3)) . $this->faker->numberBetween(10, 99),
        ];
    }
}