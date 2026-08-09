<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LibraryBook;
use App\Models\LibraryBorrowing;
use App\Models\User;
use App\Services\NotificationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class LibraryController extends Controller
{
    // Student/Parent routes
    public function availableBooks(Request $request)
    {
        $query = LibraryBook::available();

        if ($search = $request->query('search')) {
            $query->search($search);
        }

        if ($category = $request->query('category')) {
            $query->where('category', $category);
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    public function myBorrowings(Request $request)
    {
        $borrowings = LibraryBorrowing::where('student_user_id', $request->user()->id)
            ->with('book')
            ->orderBy('borrowed_date', 'desc')
            ->get();

        return response()->json([
            'borrowings' => $borrowings,
            'active_count' => $borrowings->where('is_returned', false)->count(),
            'overdue_count' => $borrowings->where('is_returned', false)->where('due_date', '<', now())->count(),
        ]);
    }

    /**
     * Self-service borrow for the authenticated student.
     * Enforces availability, a per-student concurrent limit, and no duplicate
     * active loan of the same title. Due date defaults to 14 days out.
     */
    public function selfBorrow(Request $request, int $id)
    {
        $student = $request->user();
        $borrowing = DB::transaction(function () use ($id, $student) {
            $book = LibraryBook::query()->lockForUpdate()->findOrFail($id);
            abort_unless($book->isAvailable(), 409, 'This book is not available right now.');
            abort_if(
                LibraryBorrowing::where('book_id', $book->id)->where('student_user_id', $student->id)
                    ->where('is_returned', false)->exists(),
                409,
                'You already have this book borrowed.',
            );
            abort_if(
                LibraryBorrowing::where('student_user_id', $student->id)->where('is_returned', false)->count() >= 5,
                409,
                'You have reached the borrowing limit of 5 books.',
            );

            $book->decrement('available_copies');

            $borrowing = LibraryBorrowing::create([
                'book_id' => $book->id,
                'student_user_id' => $student->id,
                'borrowed_date' => now(),
                'due_date' => now()->addDays(14),
                'issued_by' => $student->id,
            ]);

            DB::afterCommit(function () use ($student, $book, $borrowing): void {
                NotificationService::sendWithTemplate(
                    $student->id,
                    'book_borrowed',
                    [
                        'book_title' => $book->title,
                        'due_date' => $borrowing->due_date->toDateString(),
                        'borrowing_id' => $borrowing->id,
                    ]
                );
            });

            return $borrowing;
        });

        return response()->json($borrowing->load('book'), 201);
    }

    /**
     * Self-service return for the authenticated student's own loan.
     */
    public function selfReturn(Request $request, int $borrowingId)
    {
        $studentId = $request->user()->id;
        $borrowing = DB::transaction(function () use ($borrowingId, $studentId) {
            $borrowing = LibraryBorrowing::query()->where('student_user_id', $studentId)
                ->lockForUpdate()->findOrFail($borrowingId);
            abort_if($borrowing->is_returned, 409, 'This book has already been returned.');

            LibraryBook::query()->whereKey($borrowing->book_id)->lockForUpdate()->firstOrFail()
                ->increment('available_copies');
            $borrowing->update([
                'is_returned' => true,
                'returned_date' => now(),
                'returned_to' => $studentId,
                'fine_amount' => $borrowing->calculateFine(),
            ]);

            return $borrowing->fresh();
        });

        return response()->json([
            'message' => 'Book returned successfully.',
            'fine_amount' => $borrowing->fine_amount,
        ]);
    }

    // Admin routes
    public function books(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'isbn' => ['nullable', 'string', Rule::unique('library_books')->where('school_id', $request->attributes->get('school_id'))],
                'title' => 'required|string',
                'author' => 'required|string',
                'publisher' => 'nullable|string',
                'publication_year' => 'nullable|integer',
                'category' => 'nullable|string',
                'description' => 'nullable|string',
                'total_copies' => 'required|integer|min:1',
                'location' => 'nullable|string',
            ]);

            $data['available_copies'] = $data['total_copies'];
            $book = LibraryBook::create($data);

            return response()->json($book, 201);
        }

        $query = LibraryBook::query();

        if ($search = $request->query('search')) {
            $query->search($search);
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    public function updateBook(Request $request, int $id)
    {
        $book = LibraryBook::findOrFail($id);

        $data = $request->validate([
            'title' => 'sometimes|string',
            'author' => 'sometimes|string',
            'total_copies' => 'sometimes|integer|min:1',
            'is_active' => 'sometimes|boolean',
        ]);

        $book = DB::transaction(function () use ($book, $data) {
            $locked = LibraryBook::query()->lockForUpdate()->findOrFail($book->id);
            if (isset($data['total_copies'])) {
                $borrowed = $locked->borrowings()->where('is_returned', false)->count();
                abort_if($data['total_copies'] < $borrowed, 422, 'Total copies cannot be below active borrowings.');
                $data['available_copies'] = $data['total_copies'] - $borrowed;
            }
            $locked->update($data);

            return $locked->fresh();
        });

        return response()->json($book);
    }

    public function borrowBook(Request $request)
    {
        $data = $request->validate([
            'book_id' => 'required|exists:library_books,id',
            'student_user_id' => 'required|exists:users,id',
            'due_date' => 'required|date|after:today',
        ]);

        abort_unless(User::query()->whereKey($data['student_user_id'])->where('role', 'student')
            ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $request->attributes->get('school_id')))
            ->exists(), 422, 'The student belongs to another school.');

        $actorId = $request->user()->id;
        $borrowing = DB::transaction(function () use ($data, $actorId) {
            $book = LibraryBook::query()->lockForUpdate()->findOrFail($data['book_id']);
            abort_unless($book->isAvailable(), 409, 'Book not available.');
            $book->decrement('available_copies');

            $borrowing = LibraryBorrowing::create([
                'book_id' => $data['book_id'],
                'student_user_id' => $data['student_user_id'],
                'borrowed_date' => now(),
                'due_date' => $data['due_date'],
                'issued_by' => $actorId,
            ]);

            DB::afterCommit(fn () => NotificationService::sendWithTemplate(
                $data['student_user_id'], 'book_borrowed', [
                    'book_title' => $book->title,
                    'due_date' => $data['due_date'],
                    'borrowing_id' => $borrowing->id,
                ],
            ));

            return $borrowing;
        });

        return response()->json($borrowing, 201);
    }

    public function returnBook(Request $request, int $borrowingId)
    {
        $actorId = $request->user()->id;
        $borrowing = DB::transaction(function () use ($borrowingId, $actorId) {
            $borrowing = LibraryBorrowing::query()->lockForUpdate()->findOrFail($borrowingId);
            abort_if($borrowing->is_returned, 409, 'Book already returned.');
            LibraryBook::query()->whereKey($borrowing->book_id)->lockForUpdate()->firstOrFail()
                ->increment('available_copies');
            $borrowing->update([
                'is_returned' => true,
                'returned_date' => now(),
                'returned_to' => $actorId,
                'fine_amount' => $borrowing->calculateFine(),
            ]);

            return $borrowing->fresh();
        });

        return response()->json([
            'message' => 'Book returned successfully',
            'fine_amount' => $borrowing->fine_amount,
        ]);
    }

    public function allBorrowings(Request $request)
    {
        $query = LibraryBorrowing::with(['book', 'student']);

        if ($request->query('active_only')) {
            $query->where('is_returned', false);
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    public function overdueBooks(Request $request)
    {
        $overdue = LibraryBorrowing::overdue()
            ->with(['book', 'student'])
            ->paginate($request->query('per_page', 20));

        return response()->json($overdue);
    }
}
