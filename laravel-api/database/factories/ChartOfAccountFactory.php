<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\ChartOfAccount>
 */
class ChartOfAccountFactory extends Factory
{
    public function definition(): array
    {
        return [
            'account_code' => $this->faker->unique()->numerify('####'),
            'account_name' => $this->faker->unique()->randomElement([
                'Cash', 'Bank Account', 'Accounts Receivable', 'Inventory',
                'Accounts Payable', 'Salaries Payable', 'Revenue',
                'Tuition Income', 'Exam Fee Income', 'Transport Income',
                'Rent Expense', 'Utilities Expense', 'Salaries Expense',
                'Office Supplies Expense', 'Maintenance Expense',
            ]),
            'account_type' => $this->faker->randomElement(['asset', 'liability', 'equity', 'income', 'expense']),
            'description' => $this->faker->sentence(),
            'is_active' => true,
        ];
    }
}