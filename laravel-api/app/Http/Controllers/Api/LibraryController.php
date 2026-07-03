<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LibraryBook;
use App\Models\LibraryBorrowing;
use App\Services\NotificationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
        $book = LibraryBook::findOrFail($id);

        if (! $book->isAvailable()) {
            return response()->json(['message' => 'This book is not available right now.'], 400);
        }

        $alreadyHas = LibraryBorrowing::where('book_id', $book->id)
            ->where('student_user_id', $student->id)
            ->where('is_returned', false)
            ->exists();
        if ($alreadyHas) {
            return response()->json(['message' => 'You already have this book borrowed.'], 400);
        }

        $activeCount = LibraryBorrowing::where('student_user_id', $student->id)
            ->where('is_returned', false)
            ->count();
        if ($activeCount >= 5) {
            return response()->json(['message' => 'You have reached the borrowing limit of 5 books.'], 400);
        }

        $borrowing = DB::transaction(function () use ($book, $student) {
            $book->decrement('available_copies');

            $borrowing = LibraryBorrowing::create([
                'book_id' => $book->id,
                'student_user_id' => $student->id,
                'borrowed_date' => now(),
                'due_date' => now()->addDays(14),
                'issued_by' => $student->id,
            ]);

            try {
                NotificationService::sendWithTemplate(
                    $student->id,
                    'book_borrowed',
                    [
                        'book_title' => $book->title,
                        'due_date' => $borrowing->due_date->toDateString(),
                        'borrowing_id' => $borrowing->id,
                    ]
                );
            } catch (\Throwable $e) {
                // Notification is best-effort; never block the loan on it.
            }

            return $borrowing;
        });

        return response()->json($borrowing->load('book'), 201);
    }

    /**
     * Self-service return for the authenticated student's own loan.
     */
    public function selfReturn(Request $request, int $borrowingId)
    {
        $borrowing = LibraryBorrowing::where('id', $borrowingId)
            ->where('student_user_id', $request->user()->id)
            ->firstOrFail();

        if ($borrowing->is_returned) {
            return response()->json(['message' => 'This book has already been returned.'], 400);
        }

        DB::transaction(function () use ($borrowing) {
            $borrowing->book->increment('available_copies');
            $borrowing->update([
                'is_returned' => true,
                'returned_date' => now(),
                'returned_to' => $borrowing->student_user_id,
                'fine_amount' => $borrowing->calculateFine(),
            ]);
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
                'isbn' => 'nullable|string|unique:library_books,isbn',
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

        if (isset($data['total_copies'])) {
            $diff = $data['total_copies'] - $book->total_copies;
            $data['available_copies'] = max(0, $book->available_copies + $diff);
        }

        $book->update($data);

        return response()->json($book);
    }

    public function borrowBook(Request $request)
    {
        $data = $request->validate([
            'book_id' => 'required|exists:library_books,id',
            'student_user_id' => 'required|exists:users,id',
            'due_date' => 'required|date|after:today',
        ]);

        $book = LibraryBook::findOrFail($data['book_id']);

        if ($book->available_copies <= 0) {
            return response()->json(['message' => 'Book not available'], 400);
        }

        $borrowing = DB::transaction(function () use ($data, $book) {
            $book->decrement('available_copies');

            $borrowing = LibraryBorrowing::create([
                'book_id' => $data['book_id'],
                'student_user_id' => $data['student_user_id'],
                'borrowed_date' => now(),
                'due_date' => $data['due_date'],
                'issued_by' => $request->user()->id,
            ]);

            NotificationService::sendWithTemplate(
                $data['student_user_id'],
                'book_borrowed',
                [
                    'book_title' => $book->title,
                    'due_date' => $data['due_date'],
                    'borrowing_id' => $borrowing->id,
                ]
            );

            return $borrowing;
        });

        return response()->json($borrowing, 201);
    }

    public function returnBook(Request $request, int $borrowingId)
    {
        $borrowing = LibraryBorrowing::findOrFail($borrowingId);

        if ($borrowing->is_returned) {
            return response()->json(['message' => 'Book already returned'], 400);
        }

        DB::transaction(function () use ($borrowing) {
            $borrowing->book->increment('available_copies');

            $borrowing->update([
                'is_returned' => true,
                'returned_date' => now(),
                'returned_to' => request()->user()->id,
                'fine_amount' => $borrowing->calculateFine(),
            ]);
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
