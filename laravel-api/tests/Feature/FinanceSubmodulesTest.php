<?php

namespace Tests\Feature;

use App\Models\Installment;
use App\Models\Invoice;
use App\Models\JournalEntry;
use App\Models\NotificationTemplate;
use App\Models\PaymentPlan;
use App\Models\StaffProfile;
use App\Models\Supplier;
use App\Models\SupplierAccount;
use App\Models\SupplierInvoice;
use App\Models\User;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FinanceSubmodulesTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        NotificationTemplate::seedDefaults();
        $this->seed(PermissionSeeder::class);
    }

    private function login(string $role): array
    {
        $user = User::factory()->create([
            'role' => $role,
            'password' => bcrypt('password'),
            'is_active' => true,
        ]);
        $response = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ]);

        return ['user' => $user, 'token' => $response->json('access_token')];
    }

    private function authed(array $auth)
    {
        // Sanctum's guard caches the resolved user across requests within a
        // test; forget it so each call authenticates as the given token's user.
        $this->app['auth']->forgetGuards();

        return $this->withHeader('Authorization', 'Bearer '.$auth['token']);
    }

    private function makeSupplier(): Supplier
    {
        $supplier = Supplier::create([
            'code' => 'SUP-2026-0001', 'name' => 'Gulf Traders', 'phone' => '+971 4 111 1111',
        ]);
        SupplierAccount::create(['supplier_id' => $supplier->id]);

        return $supplier;
    }

    // ── Permission isolation: each sub-module rejects the other roles ──────

    public function test_hr_cannot_reach_ap_or_installments()
    {
        $hr = $this->login('hr');
        $this->authed($hr)->getJson('/api/finance/ap/supplier-invoices')->assertStatus(403);
        $this->authed($hr)->getJson('/api/finance/installments/plans')->assertStatus(403);
        // ...but payroll runs are HR's job.
        $this->authed($hr)->getJson('/api/finance/payroll/runs')->assertOk();
    }

    public function test_procurement_cannot_reach_installments_or_payroll()
    {
        $procurement = $this->login('procurement');
        $this->authed($procurement)->getJson('/api/finance/installments/plans')->assertStatus(403);
        $this->authed($procurement)->getJson('/api/finance/payroll/runs')->assertStatus(403);
        // ...but can view AP (registers supplier invoices).
        $this->authed($procurement)->getJson('/api/finance/ap/supplier-invoices')->assertOk();
    }

    public function test_finance_reaches_all_three_submodules()
    {
        $finance = $this->login('finance');
        $this->authed($finance)->getJson('/api/finance/ap/supplier-invoices')->assertOk();
        $this->authed($finance)->getJson('/api/finance/installments/plans')->assertOk();
        $this->authed($finance)->getJson('/api/finance/payroll/runs')->assertOk();
    }

    public function test_me_endpoint_exposes_permission_keys()
    {
        $hr = $this->login('hr');
        $keys = $this->authed($hr)->getJson('/api/auth/me')->json('permissions');
        $this->assertContains('finance.payroll.view', $keys);
        $this->assertNotContains('finance.installments.view', $keys);
    }

    // ── Installments ───────────────────────────────────────────────────────

    public function test_plan_generates_schedule_that_sums_exactly()
    {
        $finance = $this->login('finance');
        $student = User::factory()->create(['role' => 'student', 'is_active' => true]);

        $response = $this->authed($finance)->postJson('/api/finance/installments/plans', [
            'student_user_id' => $student->id,
            'total_amount' => 1000,
            'down_payment' => 100,
            'num_installments' => 7,
            'start_date' => now()->addDays(10)->toDateString(),
        ]);

        $response->assertStatus(201);
        $installments = $response->json('installments');
        $this->assertCount(7, $installments);
        $this->assertEquals(900.0, round(array_sum(array_column($installments, 'amount')), 2));
    }

    public function test_paying_installments_completes_plan_and_updates_invoice()
    {
        $finance = $this->login('finance');
        $student = User::factory()->create(['role' => 'student', 'is_active' => true]);
        $invoice = Invoice::create([
            'student_user_id' => $student->id, 'invoice_no' => 'INV-T-1',
            'description' => 'Tuition', 'amount' => 600, 'due_date' => now()->addMonth(),
        ]);

        $planId = $this->authed($finance)->postJson('/api/finance/installments/plans', [
            'student_user_id' => $student->id,
            'invoice_id' => $invoice->id,
            'total_amount' => 600,
            'num_installments' => 2,
            'start_date' => now()->toDateString(),
        ])->json('id');

        foreach (PaymentPlan::find($planId)->installments as $inst) {
            $this->authed($finance)->postJson("/api/finance/installments/installments/{$inst->id}/pay", [
                'amount' => (float) $inst->amount, 'method' => 'cash',
            ])->assertOk();
        }

        $this->assertEquals('completed', PaymentPlan::find($planId)->status);
        $invoice->refresh();
        $this->assertEquals('paid', $invoice->status);
        $this->assertEquals(600.0, (float) $invoice->paid_amount);
    }

    public function test_installment_overpayment_rejected()
    {
        $finance = $this->login('finance');
        $student = User::factory()->create(['role' => 'student', 'is_active' => true]);
        $planId = $this->authed($finance)->postJson('/api/finance/installments/plans', [
            'student_user_id' => $student->id,
            'total_amount' => 300, 'num_installments' => 3,
            'start_date' => now()->toDateString(),
        ])->json('id');

        $first = PaymentPlan::find($planId)->installments->first();
        $this->authed($finance)->postJson("/api/finance/installments/installments/{$first->id}/pay", [
            'amount' => 500, 'method' => 'cash',
        ])->assertStatus(422);
        $this->assertEquals('pending', $first->fresh()->status);
    }

    // ── Procurement finance (AP) ───────────────────────────────────────────

    public function test_supplier_payment_updates_invoice_balance_and_journal()
    {
        $finance = $this->login('finance');
        $supplier = $this->makeSupplier();

        $invoiceId = $this->authed($finance)->postJson('/api/finance/ap/supplier-invoices', [
            'supplier_id' => $supplier->id,
            'invoice_date' => now()->toDateString(),
            'due_date' => now()->addDays(30)->toDateString(),
            'amount' => 200,
        ])->json('id');

        $this->authed($finance)->postJson("/api/finance/ap/supplier-invoices/{$invoiceId}/payments", [
            'amount' => 200, 'method' => 'bank_transfer',
        ])->assertStatus(201);

        $this->assertEquals('paid', SupplierInvoice::find($invoiceId)->status);
        // Balance went down by the payment (started at 0 → -200 means prepaid;
        // in the full flow a goods receipt would have accrued +200 first).
        $this->assertEquals(-200.0, (float) $supplier->account->fresh()->balance);
        $this->assertCount(2, JournalEntry::where('source', 'supplier_payment')->get());
    }

    public function test_supplier_overpayment_rejected()
    {
        $finance = $this->login('finance');
        $supplier = $this->makeSupplier();
        $invoiceId = $this->authed($finance)->postJson('/api/finance/ap/supplier-invoices', [
            'supplier_id' => $supplier->id,
            'invoice_date' => now()->toDateString(),
            'due_date' => now()->addDays(30)->toDateString(),
            'amount' => 100,
        ])->json('id');

        $this->authed($finance)->postJson("/api/finance/ap/supplier-invoices/{$invoiceId}/payments", [
            'amount' => 150, 'method' => 'cash',
        ])->assertStatus(422);
    }

    // ── Payroll runs ───────────────────────────────────────────────────────

    public function test_payroll_run_lifecycle_with_hr_and_finance_split()
    {
        $hr = $this->login('hr');
        $finance = $this->login('finance');

        $teacher = User::factory()->create(['role' => 'teacher', 'is_active' => true]);
        StaffProfile::create(['user_id' => $teacher->id, 'base_salary' => 2000]);

        // HR drafts and processes the run…
        $runId = $this->authed($hr)->postJson('/api/finance/payroll/runs', [
            'year' => 2026, 'month' => 7,
        ])->assertStatus(201)->json('id');
        $this->authed($hr)->postJson("/api/finance/payroll/runs/{$runId}/process")->assertOk();

        // …but cannot approve or pay it (no finance.payroll.approve).
        $this->authed($hr)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertStatus(403);

        $this->authed($finance)->postJson("/api/finance/payroll/runs/{$runId}/approve")->assertOk();
        $this->authed($finance)->postJson("/api/finance/payroll/runs/{$runId}/pay")->assertOk();

        $this->assertDatabaseHas('payroll_records', [
            'staff_user_id' => $teacher->id, 'payroll_run_id' => $runId, 'status' => 'paid',
        ]);
        $this->assertCount(2, JournalEntry::where('source', 'payroll')->get());
    }

    public function test_duplicate_payroll_run_rejected()
    {
        $finance = $this->login('finance');
        $this->authed($finance)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 7])
            ->assertStatus(201);
        $this->authed($finance)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 7])
            ->assertStatus(422);
    }

    public function test_legacy_payroll_read_remains_and_writes_are_disabled()
    {
        $finance = $this->login('finance');
        $teacher = User::factory()->create(['role' => 'teacher', 'is_active' => true]);
        StaffProfile::create(['user_id' => $teacher->id, 'base_salary' => 2000]);

        $this->authed($finance)->postJson('/api/finance/payroll/process', [
            'year' => 2026, 'month' => 6,
        ])->assertStatus(410)->assertJsonPath('code', 'LEGACY_PAYROLL_WRITE_DISABLED');
        $this->authed($finance)->getJson('/api/finance/payroll?year=2026&month=6')->assertOk();
    }

    public function test_installment_reminders_sent_for_due_installments()
    {
        $finance = $this->login('finance');
        $student = User::factory()->create(['role' => 'student', 'is_active' => true]);
        $this->authed($finance)->postJson('/api/finance/installments/plans', [
            'student_user_id' => $student->id,
            'total_amount' => 300, 'num_installments' => 3,
            'start_date' => now()->addDay()->toDateString(),
        ])->assertStatus(201);

        $response = $this->authed($finance)->postJson('/api/finance/installments/send-reminders');
        $response->assertOk();
        $this->assertGreaterThanOrEqual(1, $response->json('reminders_sent'));
        $this->assertNotNull(Installment::first()->reminder_sent_at);
    }
}
