<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\ChartOfAccount;
use App\Models\Invoice;
use App\Models\JournalBatch;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\PaymentReceipt;
use App\Models\StaffProfile;
use App\Models\StudentFinancialAdjustment;
use App\Models\StudentProfile;
use App\Models\User;
use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Illuminate\Testing\TestResponse;
use Tests\TestCase;

/**
 * An amount finer than the money columns can hold is refused, by name.
 *
 * Before the `money` rule these requests were accepted and the third decimal
 * disappeared: rounded in PHP by the controllers that call round(..., 2) —
 * on every driver, SQLite included — and by PostgreSQL on store where they do
 * not. Nobody was told. Each case here asserts the three things that make the
 * refusal visible rather than silent: a 422, the offending field named in
 * `errors`, and nothing written. Each also sends the same request at two
 * decimals and expects it to succeed, so the refusal is shown to be about the
 * extra digit and nothing else in the payload.
 *
 * Every input carrying the rule is enforced statically by
 * MoneyInputCoverageTest; these are the paths that exercise each way a rule
 * is written — a plain field, a wildcard line, a nested array, a condition.
 */
class OverPreciseMoneyInputTest extends TestCase
{
    use RefreshDatabase;

    private const REFUSED = 'must not have more than 2 decimal places';

    private User $finance;

    private User $student;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(PermissionSeeder::class);
        $this->finance = User::factory()->create(['role' => 'finance', 'is_active' => true]);
        $this->student = User::factory()->create(['role' => 'student', 'is_active' => true]);
        StudentProfile::factory()->create(['user_id' => $this->student->id]);
    }

    public function test_a_payment_with_a_third_decimal_is_refused_and_nothing_is_recorded(): void
    {
        $invoice = $this->invoice(100);

        $this->pay($invoice, 12.505)
            ->assertStatus(422)
            ->assertJsonValidationErrors(['amount' => self::REFUSED]);
        $this->assertSame(0, Payment::count());
        $this->assertSame(0.0, (float) $invoice->fresh()->paid_amount);

        $this->pay($invoice, 12.50)->assertCreated();
        $this->assertSame(12.5, (float) $invoice->fresh()->paid_amount);
    }

    public function test_trailing_zeros_are_not_precision_and_are_accepted(): void
    {
        $invoice = $this->invoice(100);

        $this->pay($invoice, '12.500')->assertCreated();

        $this->assertSame(12.5, (float) $invoice->fresh()->paid_amount);
    }

    public function test_an_installment_plan_total_with_a_third_decimal_is_refused(): void
    {
        $plan = fn (string $total): TestResponse => $this->actingAs($this->finance)
            ->postJson('/api/finance/installments/plans', [
                'student_user_id' => $this->student->id,
                'total_amount' => $total,
                'num_installments' => 3,
                'start_date' => now()->toDateString(),
            ]);

        $plan('100.005')
            ->assertStatus(422)
            ->assertJsonValidationErrors(['total_amount' => self::REFUSED]);
        $this->assertSame(0, PaymentPlan::count());

        $plan('100.00')->assertCreated();
    }

    public function test_a_receipt_allocation_is_refused_by_its_line(): void
    {
        $invoice = $this->invoice(100);
        $receipt = fn (float $allocated): TestResponse => $this->actingAs($this->finance)
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson('/api/finance/receipts', [
                'student_user_id' => $this->student->id,
                'amount' => $allocated,
                'method' => 'cash',
                'receipt_date' => now()->toDateString(),
                'allocations' => [['invoice_id' => $invoice->id, 'amount' => $allocated]],
            ]);

        $receipt(9.995)
            ->assertStatus(422)
            ->assertJsonValidationErrors([
                'amount' => self::REFUSED,
                'allocations.0.amount' => self::REFUSED,
            ]);
        $this->assertSame(0, PaymentReceipt::count());

        $receipt(10.00)->assertCreated();
    }

    public function test_a_journal_that_balances_only_in_fils_is_refused_line_by_line(): void
    {
        // Both sides carry the same third decimal, so the batch balances as
        // submitted. Rounded, it would still balance — and the ledger would
        // record a different amount than the one the accountant entered.
        $cash = ChartOfAccount::create(['account_code' => '1000', 'account_name' => 'Cash', 'account_type' => 'asset']);
        $income = ChartOfAccount::create(['account_code' => '4000', 'account_name' => 'Income', 'account_type' => 'income']);
        $journal = fn (float $amount): TestResponse => $this->actingAs($this->finance)
            ->postJson('/api/accounting/journal-batches', [
                'entry_date' => now()->toDateString(),
                'description' => 'Opening balance',
                'lines' => [
                    ['account_id' => $cash->id, 'debit' => $amount, 'credit' => 0],
                    ['account_id' => $income->id, 'debit' => 0, 'credit' => $amount],
                ],
            ]);

        $journal(100.005)
            ->assertStatus(422)
            ->assertJsonValidationErrors([
                'lines.0.debit' => self::REFUSED,
                'lines.1.credit' => self::REFUSED,
            ]);
        $this->assertSame(0, JournalBatch::count());

        $journal(100.00)->assertCreated();
    }

    public function test_a_fixed_adjustment_is_money_but_a_percentage_is_not(): void
    {
        $invoice = $this->invoice(1000);
        $adjust = fn (string $type, float $value): TestResponse => $this->actingAs($this->finance)
            ->postJson('/api/finance/adjustments', [
                'student_user_id' => $this->student->id,
                'invoice_id' => $invoice->id,
                'type' => 'discount',
                'direction' => 'credit',
                'calculation_type' => $type,
                'value' => $value,
                'reason' => 'Scholarship',
            ]);

        // Was accepted and stored as 12.51 by round((float) $value, 2).
        $adjust('amount', 12.505)
            ->assertStatus(422)
            ->assertJsonValidationErrors(['value' => self::REFUSED]);
        $this->assertSame(0, StudentFinancialAdjustment::count());

        // A percentage is not an amount; its own column holds four decimals.
        $adjust('percentage', 33.3333)->assertCreated();
        $adjust('amount', 12.50)->assertCreated();
    }

    public function test_a_staff_salary_is_validated_rather_than_copied_through(): void
    {
        // `staff` was accepted as an opaque array and its base_salary copied
        // straight into staff_profiles, with no rule of any kind.
        $admin = User::factory()->create(['role' => 'admin', 'is_active' => true]);
        $create = fn (string $email, mixed $salary): TestResponse => $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'New Accountant',
                'email' => $email,
                'password' => 'secret-password',
                'role' => 'finance',
                'staff' => ['department' => 'Finance', 'position' => 'Accountant', 'base_salary' => $salary],
            ]);

        $create('first@school.test', 850.505)
            ->assertStatus(422)
            ->assertJsonValidationErrors(['staff.base_salary' => self::REFUSED]);
        $create('second@school.test', 'eight hundred')
            ->assertStatus(422)
            ->assertJsonValidationErrors(['staff.base_salary']);
        $this->assertDatabaseMissing('users', ['email' => 'first@school.test']);
        $this->assertDatabaseMissing('users', ['email' => 'second@school.test']);

        // Validating the salary must not cost the rest of the profile.
        $id = $create('third@school.test', 850.50)->assertCreated()->json('id');
        $profile = StaffProfile::where('user_id', $id)->firstOrFail();
        $this->assertSame('Finance', $profile->department);
        $this->assertSame('Accountant', $profile->position);
        $this->assertSame(850.5, (float) $profile->base_salary);
    }

    private function invoice(float $amount): Invoice
    {
        return Invoice::create([
            'student_user_id' => $this->student->id,
            'invoice_no' => 'INV-'.Str::upper(Str::random(8)),
            'description' => 'Tuition',
            'amount' => $amount,
            'due_date' => now()->addMonth(),
        ]);
    }

    private function pay(Invoice $invoice, float|string $amount): TestResponse
    {
        return $this->actingAs($this->finance)
            ->withHeader('Idempotency-Key', (string) Str::uuid())
            ->postJson("/api/finance/invoices/{$invoice->id}/payments", [
                'amount' => $amount,
                'method' => 'cash',
            ]);
    }
}
