<?php

namespace Database\Factories;

use App\Models\ClassRoom;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<ClassRoom>
 */
class ClassRoomFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => 'Grade '.$this->faker->numberBetween(1, 12).'-'.$this->faker->randomLetter(),
            'grade' => (string) $this->faker->numberBetween(1, 12),
            'section' => $this->faker->randomElement(['A', 'B', 'C', 'D']),
            'capacity' => $this->faker->numberBetween(20, 40),
        ];
    }

    public function withHomeroom(User $teacher): static
    {
        return $this->state(fn (array $attributes) => ['homeroom_teacher_id' => $teacher->id]);
    }
}
