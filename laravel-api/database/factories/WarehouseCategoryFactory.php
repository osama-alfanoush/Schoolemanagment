<?php

namespace Database\Factories;

use App\Models\WarehouseCategory;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<WarehouseCategory>
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
