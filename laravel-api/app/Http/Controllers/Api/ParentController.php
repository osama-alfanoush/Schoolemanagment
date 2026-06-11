<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\ConductLog;
use App\Models\Grade;
use App\Models\Invoice;
use App\Models\Payment;
use Illuminate\Http\Request;

class ParentController extends Controller
{
    public function children(Request $request)
    {
        return ApiResponse::success(
            $request->user()->children()->with('studentProfile.classRoom')->get()
        );
    }

    public function childOverview(Request $request, int $studentId)
    {
        $student = \App\Models\User::with('studentProfile.classRoom')->findOrFail($studentId);
        $this->authorize('view', $student);

        $todayAttn = AttendanceRecord::where('student_user_id', $studentId)->whereDate('date', today())->first();
        $upcoming = Assignment::where('class_room_id', $student->studentProfile?->class_room_id)
            ->where('due_at', '>=', now())->orderBy('due_at')->limit(5)->with('subject')->get();
        $recentGrades = Grade::where('student_user_id', $studentId)->latest()->limit(5)->with('component.subject')->get();
        $unpaid = Invoice::where('student_user_id', $studentId)->whereIn('status', ['pending', 'partial', 'overdue'])->sum('amount');

        return response()->json(compact('student', 'todayAttn', 'upcoming', 'recentGrades', 'unpaid'));
    }

    public function childGrades(Request $request, int $studentId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        $grades = Grade::where('student_user_id', $studentId)->with('component.subject')->get();

        return ApiResponse::success($grades);
    }

    public function childAssignments(Request $request, int $studentId)
    {
        $student = \App\Models\User::with('studentProfile')->findOrFail($studentId);
        $this->authorize('view', $student);

        $assignments = Assignment::where('class_room_id', $student->studentProfile?->class_room_id)
            ->with(['subject', 'submissions' => fn($q) => $q->where('student_user_id', $studentId)])
            ->orderBy('due_at', 'desc')->paginate(20);

        return ApiResponse::paginate($assignments);
    }

    public function childAttendance(Request $request, int $studentId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        $records = AttendanceRecord::where('student_user_id', $studentId)
            ->orderBy('date', 'desc')->paginate(60);

        $month = AttendanceRecord::where('student_user_id', $studentId)
            ->whereMonth('date', now()->month)->whereYear('date', now()->year)
            ->selectRaw('status, count(*) as count')->groupBy('status')->pluck('count', 'status');

        return response()->json(['records' => $records, 'monthly_summary' => $month]);
    }

    public function childInvoices(Request $request, int $studentId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        $invoices = Invoice::where('student_user_id', $studentId)->with('payments')->latest()->get();
        $outstanding = $invoices->whereIn('status', ['pending', 'partial', 'overdue'])->sum(fn($i) => $i->amount - $i->paid_amount);

        return response()->json(['invoices' => $invoices, 'outstanding_total' => $outstanding]);
    }

    public function paymentHistory(Request $request, int $studentId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        $payments = Payment::whereHas('invoice', fn($q) => $q->where('student_user_id', $studentId))
            ->with('invoice')->latest('paid_at')->get();

        return ApiResponse::success($payments);
    }

    public function childConduct(Request $request, int $studentId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        return ApiResponse::paginate(
            ConductLog::where('student_user_id', $studentId)
                ->with('teacher:id,name')->latest()->paginate(30)
        );
    }

    public function invoiceReceipt(Request $request, int $studentId, int $invoiceId)
    {
        $student = \App\Models\User::findOrFail($studentId);
        $this->authorize('view', $student);

        $inv = Invoice::with(['student:id,name,email', 'payments', 'feeStructure'])
            ->where('student_user_id', $studentId)
            ->findOrFail($invoiceId);

        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('pdf.invoice-receipt', ['invoice' => $inv]);

        return $pdf->download("receipt-{$inv->invoice_no}.pdf");
    }

    public function announcements(Request $request)
    {
        return ApiResponse::paginate(
            Announcement::whereIn('audience', ['all', 'role:parent', 'parents'])->latest()->paginate(20)
        );
    }

    public function childReportCard(Request $request, int $childId)
    {
        $student = \App\Models\User::with('studentProfile.classRoom')->findOrFail($childId);
        $this->authorize('view', $student);

        $grades = $this->childGradesData($childId, $student);

        return response()->json([
            'student' => $student,
            'grades' => ['by_subject' => $grades],
            'generated_at' => now()->toIso8601String(),
        ]);
    }

    public function childReportCardPdf(Request $request, int $childId)
    {
        $student = \App\Models\User::with('studentProfile.classRoom')->findOrFail($childId);
        $this->authorize('view', $student);

        $bySubject = $this->childGradesData($childId, $student);

        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('pdf.report-card', [
            'student' => $student,
            'bySubject' => $bySubject,
        ]);

        return $pdf->download("report-card-{$childId}.pdf");
    }

    private function childGradesData(int $childId, $student): array
    {
        $grades = Grade::where('student_user_id', $childId)
            ->with('component.subject')->orderBy('created_at', 'desc')->get();

        $bySubject = [];

        foreach ($grades as $g) {
            $sub = $g->component->subject->name;
            $bySubject[$sub] ??= ['scores' => [], 'weighted_total' => 0, 'weight_total' => 0];
            $bySubject[$sub]['scores'][] = [
                'component' => $g->component->name,
                'type' => $g->component->type,
                'score' => $g->score,
                'max_score' => $g->component->max_score,
                'weight' => $g->component->weight,
            ];

            $pct = $g->component->max_score > 0 ? ($g->score / $g->component->max_score) : 0;
            $bySubject[$sub]['weighted_total'] += $pct * $g->component->weight;
            $bySubject[$sub]['weight_total'] += $g->component->weight;
        }

        foreach ($bySubject as &$row) {
            $row['cumulative_pct'] = $row['weight_total'] > 0
                ? round($row['weighted_total'] / $row['weight_total'] * 100, 2)
                : null;
        }

        unset($row);

        return $bySubject;
    }

    public function childPerformanceChart(Request $request, int $childId)
    {
        $student = \App\Models\User::with('studentProfile')->findOrFail($childId);
        $this->authorize('view', $student);

        $classRoomId = $student->studentProfile?->class_room_id;

        $labels = collect(range(5, 0))->map(fn($i) => now()->subMonths($i)->format('M'))->values()->toArray();

        $subjectIds = \App\Models\Subject::whereHas('gradeComponents', fn($q) => $q->where('class_room_id', $classRoomId))->get();

        $datasets = [];

        foreach ($subjectIds as $subject) {
            $data = [];

            foreach (range(5, 0) as $i) {
                $month = now()->subMonths($i);
                $avg = Grade::where('student_user_id', $childId)
                    ->whereHas('component', fn($q) => $q->where('subject_id', $subject->id)->where('class_room_id', $classRoomId))
                    ->whereYear('created_at', $month->year)
                    ->whereMonth('created_at', $month->month)
                    ->selectRaw('avg(score / nullif(max_score, 0) * 100) as avg_pct')
                    ->value('avg_pct');

                $data[] = $avg !== null ? round((float) $avg, 1) : null;
            }

            $datasets[] = ['subject' => $subject->name, 'data' => $data];
        }

        return response()->json(['labels' => $labels, 'datasets' => $datasets]);
    }
}