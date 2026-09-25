<?php

namespace Tests\Feature;

use App\Models\ChartOfAccount;
use App\Models\Invoice;
use App\Models\JournalBatch;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\PaymentReceipt;
use App\Models\StudentProfile;
use App\Models\User;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Tests\TestCase;

class FinancialWorkspaceTest extends TestCase
{
    use RefreshDatabase;

    private User $finance;

    private User $student;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(PermissionSeeder::class);
        $this->finance = User::factory()->create(['role' => 'finance', 'is_active' => true]);
        $this->student = User::factory()->create(['role' => 'student', 'is_active' => true, 'phone' => '+963999111222']);
        StudentProfile::factory()->create(['user_id' => $this->student->id, 'admission_no' => 'ST-9001']);
    }

    public function test_receipt_allocates_across_invoices_posts_balanced_journal_and_appears_in_statement(): void
    {
        $first = $this->invoice('INV-WS-001', 100, now()->subDay());
        $second = $this->invoice('INV-WS-002', 80, now()->addWeek());
        $key = (string) Str::uuid();

        $created = $this->actingAs($this->finance)->withHeader('Idempotency-Key', $key)
            ->postJson('/api/finance/receipts', [
                'student_user_id' => $this->student->id,
                'amount' => 150,
                'method' => 'cash',
                'receipt_date' => now()->toDateString(),
                'cash_account' => 'Main cashbox',
            ])->assertCreated()->assertJson(['status' => 'draft']);

        $receiptId = $created->json('id');
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/approve")
            ->assertOk()->assertJson(['status' => 'approved']);
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/post")
            ->assertOk()->assertJson(['status' => 'posted']);

        $this->assertSame(150.0, (float) PaymentReceipt::findOrFail($receiptId)->allocations()->sum('amount'));
        $this->assertSame(2, Payment::where('payment_receipt_id', $receiptId)->count());
        $this->assertSame('paid', $first->fresh()->status);
        $this->assertSame(50.0, (float) $second->fresh()->paid_amount);

        $batch = JournalBatch::where('source', 'student_receipt')->where('source_id', $receiptId)->firstOrFail();
        $this->assertSame('posted', $batch->status);
        $this->assertSame(
            (float) $batch->lines()->where('type', 'debit')->sum('amount'),
            (float) $batch->lines()->where('type', 'credit')->sum('amount')
        );

        $statement = $this->actingAs($this->finance)
            ->getJson("/api/finance/students/{$this->student->id}/statement")
            ->assertOk();
        $this->assertSame(180.0, (float) $statement->json('period_debit'));
        $this->assertSame(150.0, (float) $statement->json('period_credit'));
        $this->assertSame(30.0, (float) $statement->json('closing_balance'));
    }

    public function test_receipt_is_idempotent_and_rejects_changed_payload(): void
    {
        $this->invoice('INV-IDEM-1', 100, now()->addDay());
        $key = (string) Str::uuid();
        $payload = [
            'student_user_id' => $this->student->id, 'amount' => 40,
            'method' => 'cash', 'receipt_date' => now()->toDateString(),
        ];

        $firstId = $this->actingAs($this->finance)->withHeader('Idempotency-Key', $key)
            ->postJson('/api/finance/receipts', $payload)->assertCreated()->json('id');
        $secondId = $this->actingAs($this->finance)->withHeader('Idempotency-Key', $key)
            ->postJson('/api/finance/receipts', $payload)->assertOk()->json('id');
        $this->assertSame($firstId, $secondId);
        $this->assertSame(1, PaymentReceipt::count());

        $payload['amount'] = 41;
        $this->actingAs($this->finance)->withHeader('Idempotency-Key', $key)
            ->postJson('/api/finance/receipts', $payload)->assertStatus(409);
    }

    public function test_receipt_auto_allocation_updates_one_and_multiple_installments(): void
    {
        $invoice = $this->invoice('INV-INST-1', 300, now()->addMonth());
        $planId = $this->actingAs($this->finance)->postJson('/api/finance/installments/plans', [
            'student_user_id' => $this->student->id,
            'invoice_id' => $invoice->id,
            'total_amount' => 300,
            'num_installments' => 3,
            'start_date' => now()->toDateString(),
        ])->assertCreated()->json('id');

        $receiptId = $this->actingAs($this->finance)->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/finance/receipts', [
                'student_user_id' => $this->student->id, 'amount' => 150,
                'method' => 'cash', 'receipt_date' => now()->toDateString(),
            ])->assertCreated()->json('id');
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/approve")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/post")->assertOk();

        $installments = PaymentPlan::findOrFail($planId)->installments()->orderBy('sequence_no')->get();
        $this->assertSame('paid', $installments[0]->status);
        $this->assertSame(100.0, (float) $installments[0]->paid_amount);
        $this->assertSame('partial', $installments[1]->status);
        $this->assertSame(50.0, (float) $installments[1]->paid_amount);
        $this->assertSame('pending', $installments[2]->status);
    }

    public function test_posted_receipt_is_reversed_without_deleting_financial_records(): void
    {
        $invoice = $this->invoice('INV-REV-1', 100, now()->addDay());
        $receiptId = $this->actingAs($this->finance)->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/finance/receipts', [
                'student_user_id' => $this->student->id, 'amount' => 100,
                'method' => 'bank_transfer', 'receipt_date' => now()->toDateString(),
            ])->json('id');
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/approve")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/post")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/reverse", ['reason' => 'Duplicate bank notice'])
            ->assertOk()->assertJson(['status' => 'reversed']);

        $this->assertSame(1, Payment::where('payment_receipt_id', $receiptId)->count());
        $this->assertSame('reversed', Payment::where('payment_receipt_id', $receiptId)->value('status'));
        $this->assertSame(0.0, (float) $invoice->fresh()->paid_amount);
        $this->assertDatabaseHas('payment_reversals', ['reason' => 'Duplicate bank notice']);
        $this->assertDatabaseHas('journal_batches', ['source' => 'student_receipt_reversal', 'source_id' => $receiptId]);
    }

    public function test_discount_lifecycle_updates_the_same_student_financial_summary(): void
    {
        $invoice = $this->invoice('INV-DISC-1', 1000, now()->addMonth());
        $adjustmentId = $this->actingAs($this->finance)->postJson('/api/finance/adjustments', [
            'student_user_id' => $this->student->id,
            'invoice_id' => $invoice->id,
            'type' => 'discount', 'direction' => 'credit',
            'calculation_type' => 'percentage', 'value' => 10,
            'reason' => 'Sibling discount',
        ])->assertCreated()->json('id');
        $this->actingAs($this->finance)->postJson("/api/finance/adjustments/{$adjustmentId}/approve")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/finance/adjustments/{$adjustmentId}/post")->assertOk();

        $profile = $this->actingAs($this->finance)->getJson("/api/finance/students/{$this->student->id}")
            ->assertOk();
        $this->assertSame(100.0, (float) $profile->json('summary.discounts'));
        $this->assertSame(900.0, (float) $profile->json('summary.remaining'));
        $this->assertDatabaseHas('student_financial_adjustments', [
            'id' => $adjustmentId, 'amount' => 100, 'status' => 'posted',
        ]);
    }

    public function test_multi_line_journal_rejects_unbalanced_data_and_supports_post_and_reversal(): void
    {
        $cash = ChartOfAccount::create(['account_code' => '1000', 'account_name' => 'Cash', 'account_type' => 'asset']);
        $income = ChartOfAccount::create(['account_code' => '4000', 'account_name' => 'Income', 'account_type' => 'income']);
        $payload = [
            'entry_date' => now()->toDateString(), 'description' => 'Opening test',
            'lines' => [
                ['account_id' => $cash->id, 'debit' => 100, 'credit' => 0],
                ['account_id' => $income->id, 'debit' => 0, 'credit' => 90],
            ],
        ];
        $this->actingAs($this->finance)->postJson('/api/accounting/journal-batches', $payload)
            ->assertStatus(422)->assertJsonValidationErrors(['lines']);

        $payload['lines'][1]['credit'] = 100;
        $id = $this->actingAs($this->finance)->postJson('/api/accounting/journal-batches', $payload)
            ->assertCreated()->assertJson(['status' => 'draft'])->json('id');
        $this->actingAs($this->finance)->postJson("/api/accounting/journal-batches/{$id}/approve")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/accounting/journal-batches/{$id}/post")->assertOk();
        $reverseId = $this->actingAs($this->finance)->postJson("/api/accounting/journal-batches/{$id}/reverse", ['reason' => 'Correction'])
            ->assertCreated()->json('id');

        $this->assertSame('reversed', JournalBatch::findOrFail($id)->status);
        $this->assertSame('posted', JournalBatch::findOrFail($reverseId)->status);
        $this->assertSame(2, JournalBatch::findOrFail($reverseId)->lines()->count());
    }

    public function test_non_finance_user_cannot_access_financial_workspace(): void
    {
        $teacher = User::factory()->create(['role' => 'teacher', 'is_active' => true]);
        $this->actingAs($teacher)->getJson('/api/finance/students/search')->assertForbidden();
    }

    public function test_financial_reports_are_backend_paginated_and_reconcile_receipts_to_journals(): void
    {
        $this->invoice('INV-RPT-1', 250, now()->addDay());
        $receiptId = $this->actingAs($this->finance)->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/finance/receipts', [
                'student_user_id' => $this->student->id, 'amount' => 75,
                'method' => 'cash', 'receipt_date' => now()->toDateString(),
            ])->json('id');
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/approve")->assertOk();
        $this->actingAs($this->finance)->postJson("/api/finance/receipts/{$receiptId}/post")->assertOk();

        $balances = $this->actingAs($this->finance)
            ->getJson('/api/finance/workspace-reports/student-balances?per_page=10')
            ->assertOk()->assertJsonPath('per_page', 10);
        $this->assertSame(175.0, (float) $balances->json('data.0.balance'));

        $this->actingAs($this->finance)
            ->getJson('/api/finance/workspace-reports/reconciliation')
            ->assertOk()
            ->assertJsonPath('data.0.reconciliation_status', 'matched');
    }

    private function invoice(string $number, float $amount, $dueDate): Invoice
    {
        return Invoice::create([
            'student_user_id' => $this->student->id,
            'invoice_no' => $number,
            'description' => 'Tuition',
            'amount' => $amount,
            'due_date' => $dueDate,
        ]);
    }
}
