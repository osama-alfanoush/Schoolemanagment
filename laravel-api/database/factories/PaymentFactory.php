<?php

namespace Database\Factories;

use App\Models\Invoice;
use App\Models\Payment;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Payment>
 */
class PaymentFactory extends Factory
{
    public function definition(): array
    {
        return [
            'invoice_id' => Invoice::factory(),
            'amount' => $this->faker->randomFloat(2, 100, 5000),
            'method' => $this->faker->randomElement(['cash', 'card', 'bank_transfer', 'online']),
            'reference' => $this->faker->optional()->numerify('REF-#####'),
            'recorded_by' => User::factory()->finance(),
            'paid_at' => now(),
            'note' => null,
        ];
    }
}
