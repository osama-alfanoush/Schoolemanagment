<?php

namespace Tests\Feature;

use App\Models\BudgetPlan;
use App\Models\FinancialClosing;
use App\Models\Invoice;
use App\Models\JournalEntry;
use App\Models\NotificationTemplate;
use App\Models\Payment;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AccountingTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        NotificationTemplate::seedDefaults();
    }

    private function loginAccounting(): array
    {
        $user = User::factory()->create([
            'role' => 'finance',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        return ['user' => $user, 'token' => $response->json('access_token')];
    }

    public function test_accounting_user_can_create_journal_entry()
    {
        $auth = $this->loginAccounting();

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/accounting/journal-entries', [
                'entry_date' => now()->toDateString(),
                'description' => 'Test entry',
                'type' => 'debit',
                'account_code' => '1001',
                'account_name' => 'Cash',
                'amount' => 500.00,
                'source' => 'manual',
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('journal_entries', [
            'description' => 'Test entry',
            'account_code' => '1001',
            'type' => 'debit',
            'created_by' => $auth['user']->id,
        ]);
    }

    public function test_journal_entry_rejected_when_period_is_closed()
    {
        $auth = $this->loginAccounting();

        FinancialClosing::create([
            'month' => now()->month,
            'year' => now()->year,
            'status' => 'closed',
            'closed_by' => $auth['user']->id,
            'closed_at' => now(),
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/accounting/journal-entries', [
                'entry_date' => now()->toDateString(),
                'description' => 'Should fail',
                'type' => 'debit',
                'account_code' => '1001',
                'account_name' => 'Cash',
                'amount' => 100,
            ]);

        $response->assertStatus(422);
        $this->assertStringContainsString('closed', $response->json('message'));
    }

    public function test_non_accounting_user_cannot_access_accounting_routes()
    {
        $user = User::factory()->create([
            'role' => 'student',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$login->json('access_token'))
            ->getJson('/api/accounting/journal-entries');

        $response->assertStatus(403);
    }

    public function test_budget_sync_fires_notification_when_overrun()
    {
        $admin = User::factory()->create(['role' => 'admin', 'is_active' => true]);
        $accounting = User::factory()->create([
            'role' => 'finance',
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);

        BudgetPlan::create([
            'fiscal_year' => now()->year,
            'category' => 'operations',
            'planned_amount' => 1000,
            'actual_amount' => 0,
            'created_by' => $admin->id,
        ]);

        $invoice = Invoice::create([
            'student_user_id' => User::factory()->create(['role' => 'student'])->id,
            'invoice_no' => 'INV-TEST-001',
            'description' => 'Test',
            'amount' => 1000,
            'paid_amount' => 0,
            'due_date' => now()->addMonth(),
            'status' => 'pending',
        ]);

        Payment::create([
            'invoice_id' => $invoice->id,
            'amount' => 950,
            'method' => 'cash',
            'paid_at' => now(),
            'recorded_by' => $admin->id,
        ]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $accounting->email,
            'password' => 'password',
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$login->json('access_token'))
            ->postJson('/api/accounting/budget/sync-actuals', [
                'fiscal_year' => now()->year,
                'alert_threshold' => 90,
            ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('notifications', [
            'user_id' => $admin->id,
            'type' => 'budget_overrun',
        ]);
    }

    public function test_trial_balance_returns_correct_structure()
    {
        $auth = $this->loginAccounting();

        JournalEntry::create([
            'entry_date' => now()->toDateString(),
            'reference_no' => 'JE-'.now()->year.'-0001',
            'description' => 'Debit entry',
            'type' => 'debit',
            'account_code' => '1001',
            'account_name' => 'Cash',
            'amount' => 1000,
            'source' => 'manual',
            'created_by' => $auth['user']->id,
        ]);

        JournalEntry::create([
            'entry_date' => now()->toDateString(),
            'reference_no' => 'JE-'.now()->year.'-0002',
            'description' => 'Credit entry',
            'type' => 'credit',
            'account_code' => '2001',
            'account_name' => 'Revenue',
            'amount' => 800,
            'source' => 'manual',
            'created_by' => $auth['user']->id,
        ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->getJson('/api/accounting/reports/trial-balance?month='.now()->month.'&year='.now()->year);

        $response->assertStatus(200);
        $response->assertJsonStructure(['data']);
        $data = $response->json('data');
        foreach ($data as $item) {
            $this->assertArrayHasKey('account_code', $item);
            $this->assertArrayHasKey('total_debit', $item);
            $this->assertArrayHasKey('total_credit', $item);
            $this->assertArrayHasKey('balance', $item);
        }
    }

    public function test_closed_period_blocks_deletion_of_journal_entry()
    {
        $auth = $this->loginAccounting();

        $entry = JournalEntry::create([
            'entry_date' => now()->toDateString(),
            'reference_no' => 'JE-'.now()->year.'-0001',
            'description' => 'To be protected',
            'type' => 'debit',
            'account_code' => '1001',
            'account_name' => 'Cash',
            'amount' => 500,
            'source' => 'manual',
            'created_by' => $auth['user']->id,
        ]);

        $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->postJson('/api/accounting/closings', [
                'month' => now()->month,
                'year' => now()->year,
            ]);

        $response = $this->withHeader('Authorization', 'Bearer '.$auth['token'])
            ->deleteJson('/api/accounting/journal-entries/'.$entry->id);

        $response->assertStatus(422);
    }
}
