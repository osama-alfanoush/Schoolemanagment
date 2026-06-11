<?php

namespace Database\Factories;

use App\Models\WarehouseCategory;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\WarehouseItem>
 */
class WarehouseItemFactory extends Factory
{
    public function definition(): array
    {
        return [
            'sku' => strtoupper($this->faker->unique()->bothify('???-####')),
            'name' => $this->faker->unique()->randomElement([
                'Whiteboard Marker', 'A4 Paper Ream', 'Ballpoint Pens',
                'Desk Calculator', 'Scientific Calculator', 'Lab Coat',
                'Cleaning Spray', 'Floor Mop', 'USB Cable',
                'Ethernet Cable', 'HDMI Cable', 'Sports Ball',
                'Music Stand', 'First Aid Kit', 'Fire Extinguisher',
            ]),
            'description' => $this->faker->sentence(),
            'category_id' => WarehouseCategory::factory(),
            'unit' => $this->faker->randomElement(['piece', 'box', 'pack', 'ream', 'set']),
            'current_qty' => $this->faker->numberBetween(0, 500),
            'min_stock_qty' => $this->faker->numberBetween(5, 50),
            'location' => $this->faker->randomElement(['Shelf A1', 'Shelf B2', 'Cabinet C3', 'Room 101']),
            'is_active' => true,
        ];
    }
}