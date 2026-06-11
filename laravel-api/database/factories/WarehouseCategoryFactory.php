<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\WarehouseCategory>
 */
class WarehouseCategoryFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => $this->faker->unique()->randomElement([
                'Office Supplies', 'Lab Equipment', 'Cleaning Supplies',
                'IT Hardware', 'Sports Equipment', 'Music Instruments',
                'Laboratory Materials', 'Canteen Supplies',
            ]),
            'description' => $this->faker->sentence(),
        ];
    }
}