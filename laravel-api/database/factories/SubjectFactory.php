<?php

namespace Database\Factories;

use App\Models\Subject;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Subject>
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
            'code' => strtoupper(substr($name, 0, 3)).$this->faker->numberBetween(10, 99),
        ];
    }
}
