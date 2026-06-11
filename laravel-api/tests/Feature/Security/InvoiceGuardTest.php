<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\ClassRoom;
use App\Models\FeeStructure;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class InvoiceGuardTest extends TestCase
{
    use RefreshDatabase;

    public function test_generate_invoices_requires_student_or_class_filter(): void
    {
        $finance = $this->loginAs('finance');
        $feeStructure = FeeStructure::factory()->create();

        $response = $this->actingAs($finance)
            ->postJson('/api/finance/invoices/generate', [
                'fee_structure_id' => $feeStructure->id,
                'due_date' => now()->addDays(30)->toDateString(),
            ]);

        $response->assertStatus(422);
    }

    public function test_generate_invoices_accepts_student_filter(): void
    {
        $finance = $this->loginAs('finance');
        $feeStructure = FeeStructure::factory()->create();
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);

        $response = $this->actingAs($finance)
            ->postJson('/api/finance/invoices/generate', [
                'fee_structure_id' => $feeStructure->id,
                'due_date' => now()->addDays(30)->toDateString(),
                'student_user_ids' => [$student->id],
            ]);

        $response->assertStatus(201);
    }

    public function test_generate_invoices_accepts_class_filter(): void
    {
        $finance = $this->loginAs('finance');
        $feeStructure = FeeStructure::factory()->create();
        $class = ClassRoom::factory()->create();

        $response = $this->actingAs($finance)
            ->postJson('/api/finance/invoices/generate', [
                'fee_structure_id' => $feeStructure->id,
                'due_date' => now()->addDays(30)->toDateString(),
                'class_room_id' => $class->id,
            ]);

        $response->assertStatus(201);
    }
}
