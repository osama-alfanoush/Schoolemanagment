<?php

declare(strict_types=1);

namespace Tests\Feature\BusinessRules;

use App\Models\FeeStructure;
use App\Models\Invoice;
use App\Models\Payment;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FinanceTest extends TestCase
{
    use RefreshDatabase;

    public function test_finance_can_view_invoices(): void
    {
        $finance = $this->loginAs('finance');

        $response = $this->actingAs($finance)
            ->getJson('/api/finance/invoices');

        $response->assertOk();
    }

    public function test_payment_amount_must_be_positive(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create();

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => -50,
                'method' => 'cash',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['amount']);
    }

    public function test_payment_amount_must_be_numeric(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create();

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 'abc',
                'method' => 'cash',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['amount']);
    }

    public function test_payment_method_must_be_valid(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create();

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 500,
                'method' => 'bitcoin',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['method']);
    }

    public function test_finance_can_record_payment(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create(['amount' => 1000]);

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 500,
                'method' => 'cash',
            ]);

        $response->assertStatus(201);
        $this->assertDatabaseHas('payments', [
            'invoice_id' => $invoice->id,
            'amount' => 500,
        ]);
    }

    public function test_zero_payment_is_rejected(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create(['amount' => 1000]);

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 0,
                'method' => 'cash',
            ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['amount']);
    }

    public function test_overpayment_is_rejected(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create(['amount' => 1000, 'paid_amount' => 0]);

        $response = $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 1500,
                'method' => 'cash',
            ]);

        $response->assertStatus(422);
        $this->assertDatabaseMissing('payments', [
            'invoice_id' => $invoice->id,
            'amount' => 1500,
        ]);
    }

    public function test_exact_payment_marks_invoice_paid(): void
    {
        $finance = $this->loginAs('finance');
        $invoice = Invoice::factory()->pending()->create(['amount' => 1000, 'paid_amount' => 0]);

        $this->actingAs($finance)
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => 1000,
                'method' => 'cash',
            ])->assertStatus(201);

        $this->assertDatabaseHas('invoices', [
            'id' => $invoice->id,
            'status' => 'paid',
        ]);
    }

    public function test_gateway_payment_can_have_null_recorder(): void
    {
        // Stripe/system-recorded payments have no human recorder.
        $invoice = Invoice::factory()->pending()->create(['amount' => 500]);
        $payment = Payment::create([
            'invoice_id' => $invoice->id,
            'amount' => 100,
            'method' => 'online',
            'reference' => 'pi_test_'.uniqid(),
            'recorded_by' => null,
            'paid_at' => now(),
            'note' => 'Paid via Stripe',
        ]);

        $this->assertNull($payment->fresh()->recorded_by);
        $this->assertDatabaseHas('payments', [
            'id' => $payment->id,
            'recorded_by' => null,
        ]);
    }

    public function test_finance_can_generate_invoices(): void
    {
        $finance = $this->loginAs('finance');
        $feeStructure = FeeStructure::factory()->create([
            'name' => 'Tuition',
            'amount' => 2000,
            'billing_cycle' => 'yearly',
        ]);
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);

        $response = $this->actingAs($finance)
            ->postJson('/api/finance/invoices/generate', [
                'fee_structure_id' => $feeStructure->id,
                'due_date' => now()->addDays(30)->toDateString(),
                'student_user_ids' => [$student->id],
            ]);

        $response->assertStatus(201)
            ->assertJsonStructure(['created']);
    }

    public function test_student_cannot_access_finance_routes(): void
    {
        $student = $this->loginAs('student');

        $response = $this->actingAs($student)
            ->getJson('/api/finance/invoices');

        $response->assertForbidden();
    }
}
