<?php

namespace Database\Factories;

use App\Models\FeeStructure;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<FeeStructure>
 */
class FeeStructureFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => $this->faker->randomElement(['Tuition Fee', 'Activity Fee', 'Exam Fee', 'Transport Fee', 'Library Fee']),
            'grade' => $this->faker->optional()->randomElement(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']),
            'billing_cycle' => $this->faker->randomElement(['monthly', 'semester', 'yearly', 'one-time']),
            'amount' => $this->faker->randomFloat(2, 500, 2000),
            'is_active' => true,
        ];
    }
}
