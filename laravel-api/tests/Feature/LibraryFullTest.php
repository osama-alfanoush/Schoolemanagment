<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\LibraryBook;
use App\Models\LibraryBorrowing;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class LibraryFullTest extends TestCase
{
    use RefreshDatabase;

    private function book(int $available = 3): LibraryBook
    {
        return LibraryBook::create([
            'title' => 'Book '.uniqid(), 'author' => 'Author',
            'total_copies' => 3, 'available_copies' => $available, 'is_active' => true,
        ]);
    }

    public function test_admin_can_create_list_and_update_books(): void
    {
        $admin = User::factory()->admin()->create();

        $create = $this->actingAs($admin)->postJson('/api/admin/library/books', [
            'title' => 'Clean Code', 'author' => 'Robert Martin', 'total_copies' => 5,
        ])->assertCreated();
        $id = $create->json('id');

        $this->actingAs($admin)->getJson('/api/admin/library/books')->assertOk();
        $this->actingAs($admin)->patchJson("/api/admin/library/books/{$id}", ['total_copies' => 8])->assertOk();
    }

    public function test_admin_can_view_borrowings_and_overdue(): void
    {
        $admin = User::factory()->admin()->create();
        $this->actingAs($admin)->getJson('/api/admin/library/borrowings')->assertOk();
        $this->actingAs($admin)->getJson('/api/admin/library/overdue')->assertOk();
    }

    public function test_student_can_browse_books(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $this->book();

        $this->actingAs($student)->getJson('/api/student/library/books')->assertOk();
    }

    public function test_student_can_view_my_borrowings(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);

        $this->actingAs($student)->getJson('/api/student/library/my-borrowings')
            ->assertOk()->assertJsonStructure(['borrowings', 'active_count', 'overdue_count']);
    }

    public function test_student_borrow_and_return_flow(): void
    {
        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id]);
        $book = $this->book(2);

        $borrow = $this->actingAs($student)
            ->postJson("/api/student/library/books/{$book->id}/borrow")->assertCreated();
        $this->assertEquals(1, $book->fresh()->available_copies);

        // Find the borrowing id and return it.
        $borrowingId = LibraryBorrowing::where('student_user_id', $student->id)->value('id');
        $this->actingAs($student)
            ->postJson("/api/student/library/borrowings/{$borrowingId}/return")->assertOk();
        $this->assertEquals(2, $book->fresh()->available_copies);
    }

    public function test_non_admin_cannot_create_books(): void
    {
        $teacher = User::factory()->teacher()->create();
        $this->actingAs($teacher)->postJson('/api/admin/library/books', [
            'title' => 'X', 'author' => 'Y', 'total_copies' => 1,
        ])->assertStatus(403);
    }
}
