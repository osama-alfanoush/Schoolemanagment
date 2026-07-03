<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\ChartOfAccount;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AccountingExtendedTest extends TestCase
{
    use RefreshDatabase;

    public function test_accounting_can_view_chart_of_accounts(): void
    {
        $accounting = $this->loginAs('accounting');
        ChartOfAccount::factory()->create(['account_type' => 'asset']);
        ChartOfAccount::factory()->create(['account_type' => 'liability']);

        $response = $this->actingAs($accounting)
            ->getJson('/api/accounting/chart-of-accounts');

        $response->assertOk()
            ->assertJsonStructure(['data']);
    }

    public function test_accounting_can_create_budget(): void
    {
        $accounting = $this->loginAs('accounting');

        $response = $this->actingAs($accounting)
            ->postJson('/api/accounting/budget', [
                'fiscal_year' => 2026,
                'category' => 'Salaries',
                'planned_amount' => 50000,
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('budget_plans', ['category' => 'Salaries', 'fiscal_year' => 2026]);
    }

    public function test_budget_requires_amount(): void
    {
        $accounting = $this->loginAs('accounting');

        $response = $this->actingAs($accounting)
            ->postJson('/api/accounting/budget', [
                'fiscal_year' => 2026,
                'category' => 'Salaries',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['planned_amount']);
    }

    public function test_accounting_can_view_trial_balance(): void
    {
        $accounting = $this->loginAs('accounting');

        $response = $this->actingAs($accounting)
            ->getJson('/api/accounting/reports/trial-balance?month=5&year=2026');

        $response->assertOk()
            ->assertJsonStructure(['data']);
    }

    public function test_teacher_cannot_create_journal_entry(): void
    {
        $teacher = $this->loginAs('teacher');

        $response = $this->actingAs($teacher)
            ->postJson('/api/accounting/journal-entries', [
                'entry_date' => now()->toDateString(),
                'description' => 'Test entry',
                'type' => 'debit',
                'account_code' => '5000',
                'account_name' => 'Test Account',
                'amount' => 100,
            ]);

        $response->assertForbidden();
    }
}
