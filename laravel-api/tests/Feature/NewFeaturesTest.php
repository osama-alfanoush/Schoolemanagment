<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\FeeStructure;
use App\Models\LibraryBook;
use App\Models\LibraryBorrowing;
use App\Models\PayrollRecord;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class NewFeaturesTest extends TestCase
{
    use RefreshDatabase;

    // ── Library self-service borrowing ───────────────────────

    public function test_student_can_self_borrow_available_book(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $book = LibraryBook::create([
            'title' => 'Test Book', 'author' => 'Author',
            'total_copies' => 3, 'available_copies' => 3, 'is_active' => true,
        ]);

        $response = $this->actingAs($student)
            ->postJson("/api/student/library/books/{$book->id}/borrow");

        $response->assertCreated();
        $this->assertEquals(2, $book->fresh()->available_copies);
        $this->assertDatabaseHas('library_borrowings', [
            'book_id' => $book->id, 'student_user_id' => $student->id, 'is_returned' => false,
        ]);
    }

    public function test_student_cannot_borrow_unavailable_book(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $book = LibraryBook::create([
            'title' => 'Sold Out', 'author' => 'Author',
            'total_copies' => 1, 'available_copies' => 0, 'is_active' => true,
        ]);

        $this->actingAs($student)
            ->postJson("/api/student/library/books/{$book->id}/borrow")
            ->assertStatus(400);
    }

    public function test_student_cannot_borrow_same_book_twice(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $book = LibraryBook::create([
            'title' => 'Popular', 'author' => 'Author',
            'total_copies' => 5, 'available_copies' => 5, 'is_active' => true,
        ]);

        $this->actingAs($student)->postJson("/api/student/library/books/{$book->id}/borrow")->assertCreated();
        $this->actingAs($student)->postJson("/api/student/library/books/{$book->id}/borrow")->assertStatus(400);
    }

    public function test_student_can_return_borrowed_book(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $book = LibraryBook::create([
            'title' => 'Returnable', 'author' => 'Author',
            'total_copies' => 2, 'available_copies' => 1, 'is_active' => true,
        ]);
        $borrowing = LibraryBorrowing::create([
            'book_id' => $book->id, 'student_user_id' => $student->id, 'issued_by' => $student->id,
            'borrowed_date' => now(), 'due_date' => now()->addDays(14), 'is_returned' => false,
        ]);

        $this->actingAs($student)
            ->postJson("/api/student/library/borrowings/{$borrowing->id}/return")
            ->assertOk();

        $this->assertTrue($borrowing->fresh()->is_returned);
        $this->assertEquals(2, $book->fresh()->available_copies);
    }

    // ── Fee structure update / delete ────────────────────────

    public function test_finance_can_update_fee_structure(): void
    {
        $finance = User::factory()->finance()->create();
        $fs = FeeStructure::create([
            'name' => 'Tuition', 'grade' => '10', 'billing_cycle' => 'yearly',
            'amount' => 500, 'is_active' => true,
        ]);

        $this->actingAs($finance)
            ->patchJson("/api/finance/fee-structures/{$fs->id}", [
                'amount' => 750, 'billing_cycle' => 'monthly',
            ])
            ->assertOk();

        $fresh = $fs->fresh();
        $this->assertEquals('750.00', (string) $fresh->amount);
        $this->assertEquals('monthly', $fresh->billing_cycle);
    }

    public function test_finance_can_delete_fee_structure(): void
    {
        $finance = User::factory()->finance()->create();
        $fs = FeeStructure::create([
            'name' => 'Bus', 'billing_cycle' => 'monthly', 'amount' => 100, 'is_active' => true,
        ]);

        $this->actingAs($finance)
            ->deleteJson("/api/finance/fee-structures/{$fs->id}")
            ->assertNoContent();

        $this->assertDatabaseMissing('fee_structures', ['id' => $fs->id]);
    }

    // ── Unified Finance & Accounting role ────────────────────

    public function test_finance_role_can_access_both_finance_and_accounting(): void
    {
        $finance = User::factory()->finance()->create();

        $this->actingAs($finance)->getJson('/api/finance/invoices')->assertOk();
        $this->actingAs($finance)->getJson('/api/accounting/chart-of-accounts')->assertOk();
    }

    public function test_accounting_is_no_longer_a_valid_role(): void
    {
        $admin = User::factory()->admin()->create();

        $this->actingAs($admin)
            ->postJson('/api/admin/users', [
                'name' => 'Test', 'email' => 'acct@test.com',
                'password' => 'password123', 'role' => 'accounting',
            ])
            ->assertStatus(422);
    }

    // ── Payroll mark paid ────────────────────────────────────

    public function test_finance_can_mark_payroll_paid(): void
    {
        $finance = User::factory()->finance()->create();
        $staff = User::factory()->teacher()->create();
        $record = PayrollRecord::create([
            'staff_user_id' => $staff->id, 'year' => (int) now()->year, 'month' => (int) now()->month,
            'base_salary' => 1000, 'allowances' => 0, 'deductions' => 0,
            'advance_deduction' => 0, 'net_pay' => 1000, 'status' => 'processed',
        ]);

        $this->actingAs($finance)
            ->patchJson("/api/finance/payroll/{$record->id}/pay")
            ->assertOk();

        $this->assertEquals('paid', $record->fresh()->status);
    }
}
