<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\FeeStructure;
use App\Models\Invoice;
use App\Models\StaffProfile;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FinanceFullTest extends TestCase
{
    use RefreshDatabase;

    private User $finance;

    protected function setUp(): void
    {
        parent::setUp();
        $this->finance = User::factory()->finance()->create();
    }

    public function test_finance_can_create_and_list_fee_structures(): void
    {
        $this->actingAs($this->finance)->postJson('/api/finance/fee-structures', [
            'name' => 'Tuition', 'billing_cycle' => 'yearly', 'amount' => 1200, 'grade' => '10',
        ])->assertCreated();

        $this->actingAs($this->finance)->getJson('/api/finance/fee-structures')->assertOk();
    }

    public function test_finance_can_generate_invoices_for_class(): void
    {
        $class = \App\Models\ClassRoom::factory()->create();
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id, 'class_room_id' => $class->id]);
        $fee = FeeStructure::factory()->create();

        $this->actingAs($this->finance)->postJson('/api/finance/invoices/generate', [
            'fee_structure_id' => $fee->id,
            'due_date' => now()->addDays(30)->toDateString(),
            'class_room_id' => $class->id,
        ])->assertCreated();

        $this->assertDatabaseHas('invoices', ['student_user_id' => $student->id]);
    }

    public function test_finance_can_record_payment(): void
    {
        $student = User::factory()->student()->create();
        $invoice = Invoice::factory()->create([
            'student_user_id' => $student->id, 'amount' => 1000, 'paid_amount' => 0, 'status' => 'pending',
        ]);

        $this->actingAs($this->finance)->postJson("/api/finance/invoices/{$invoice->id}/payments", [
            'amount' => 1000, 'method' => 'cash',
        ])->assertCreated();

        $this->assertEquals('paid', $invoice->fresh()->status);
    }

    public function test_payment_cannot_exceed_balance(): void
    {
        $invoice = Invoice::factory()->create(['amount' => 500, 'paid_amount' => 0, 'status' => 'pending']);

        $this->actingAs($this->finance)->postJson("/api/finance/invoices/{$invoice->id}/payments", [
            'amount' => 9999, 'method' => 'cash',
        ])->assertStatus(422);
    }

    public function test_finance_can_list_invoices_and_outstanding(): void
    {
        Invoice::factory()->create(['status' => 'pending']);
        $this->actingAs($this->finance)->getJson('/api/finance/invoices')->assertOk();
        $this->actingAs($this->finance)->getJson('/api/finance/outstanding')->assertOk();
    }

    public function test_finance_can_send_reminders(): void
    {
        $this->actingAs($this->finance)->postJson('/api/finance/invoices/send-reminders')->assertOk();
    }

    public function test_finance_can_process_and_pay_payroll(): void
    {
        $teacher = User::factory()->teacher()->create();
        StaffProfile::create(['user_id' => $teacher->id, 'base_salary' => 2000]);

        $process = $this->actingAs($this->finance)->postJson('/api/finance/payroll/process', [
            'year' => (int) now()->year, 'month' => (int) now()->month,
        ])->assertOk();
        $this->assertGreaterThanOrEqual(1, $process->json('processed'));

        $record = \App\Models\PayrollRecord::where('staff_user_id', $teacher->id)->firstOrFail();
        $this->actingAs($this->finance)->patchJson("/api/finance/payroll/{$record->id}/pay")->assertOk();
        $this->assertEquals('paid', $record->fresh()->status);
    }

    public function test_finance_can_view_reports(): void
    {
        $this->actingAs($this->finance)->getJson('/api/finance/reports')
            ->assertOk()->assertJsonStructure(['total_collected', 'total_billed', 'net']);
    }

    public function test_non_finance_cannot_access_finance(): void
    {
        $teacher = User::factory()->teacher()->create();
        $this->actingAs($teacher)->getJson('/api/finance/invoices')->assertStatus(403);
    }
}
