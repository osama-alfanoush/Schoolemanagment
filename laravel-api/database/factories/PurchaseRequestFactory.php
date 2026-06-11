<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\WarehouseItem;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\PurchaseRequest>
 */
class PurchaseRequestFactory extends Factory
{
    public function definition(): array
    {
        return [
            'request_no' => 'PR-' . fake()->unique()->numerify('####'),
            'item_id' => WarehouseItem::factory(),
            'quantity_requested' => $this->faker->numberBetween(5, 100),
            'unit' => $this->faker->randomElement(['piece', 'box', 'pack']),
            'justification' => $this->faker->sentence(),
            'estimated_cost' => $this->faker->randomFloat(2, 100, 5000),
            'status' => 'pending',
            'admin_notes' => null,
            'requested_by' => User::factory()->warehouse(),
            'reviewed_by' => null,
            'reviewed_at' => null,
        ];
    }
}