<?php

namespace Database\Factories;

use App\Models\Invoice;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Invoice>
 */
class InvoiceFactory extends Factory
{
    public function definition(): array
    {
        return [
            'student_user_id' => User::factory()->student(),
            'fee_structure_id' => null,
            'invoice_no' => 'INV-'.$this->faker->unique()->numerify('#####'),
            'description' => $this->faker->randomElement(['Tuition Fee', 'Activity Fee', 'Exam Fee', 'Transport Fee', 'Library Fee']),
            'amount' => $this->faker->randomFloat(2, 500, 5000),
            'paid_amount' => 0,
            'due_date' => now()->addDays(30)->toDateString(),
            'status' => 'pending',
        ];
    }

    public function pending(): static
    {
        return $this->state(fn (array $attributes) => [
            'paid_amount' => 0,
            'due_date' => now()->addDays(30)->toDateString(),
            'status' => 'pending',
        ]);
    }

    public function partial(): static
    {
        return $this->state(fn (array $attributes) => [
            'paid_amount' => (float) $attributes['amount'] * 0.5,
            'due_date' => now()->addDays(30)->toDateString(),
            'status' => 'partial',
        ]);
    }

    public function paid(): static
    {
        return $this->state(fn (array $attributes) => [
            'paid_amount' => $attributes['amount'],
            'due_date' => now()->addDays(30)->toDateString(),
            'status' => 'paid',
        ]);
    }

    public function overdue(): static
    {
        return $this->state(fn (array $attributes) => [
            'paid_amount' => 0,
            'due_date' => now()->subDays($this->faker->numberBetween(1, 30))->toDateString(),
            'status' => 'overdue',
        ]);
    }
}
