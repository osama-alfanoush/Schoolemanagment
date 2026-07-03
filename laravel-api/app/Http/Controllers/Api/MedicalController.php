<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MedicalRecord;
use App\Models\MedicalVisit;
use App\Services\NotificationService;
use Illuminate\Http\Request;

class MedicalController extends Controller
{
    // Student routes
    public function myRecords(Request $request)
    {
        $record = MedicalRecord::with('visits')
            ->where('student_user_id', $request->user()->id)
            ->first();

        return response()->json($record);
    }

    // Parent routes
    public function childMedicalRecords(Request $request, int $studentId)
    {
        // Verify parent has access to this child
        $isMyChild = $request->user()->children()->where('users.id', $studentId)->exists();
        if (! $isMyChild) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $record = MedicalRecord::with(['visits' => fn ($q) => $q->orderBy('visit_date', 'desc')])
            ->where('student_user_id', $studentId)
            ->first();

        return response()->json($record);
    }

    public function childMedicalVisits(Request $request, int $studentId)
    {
        $isMyChild = $request->user()->children()->where('users.id', $studentId)->exists();
        if (! $isMyChild) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $visits = MedicalVisit::where('student_user_id', $studentId)
            ->orderBy('visit_date', 'desc')
            ->get();

        return response()->json($visits);
    }

    // Admin routes
    public function allRecords(Request $request)
    {
        $query = MedicalRecord::with('student');

        if ($search = $request->query('search')) {
            $query->whereHas('student', fn ($q) => $q->where('name', 'ilike', "%{$search}%"));
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    public function allVisits(Request $request)
    {
        $query = MedicalVisit::with(['student', 'attendant'])->orderBy('visit_date', 'desc');

        if ($request->query('today_only')) {
            $query->whereDate('visit_date', today());
        }

        if ($request->query('unnotified_only')) {
            $query->where('parent_notified', false);
        }

        return response()->json($query->paginate($request->query('per_page', 20)));
    }

    public function createOrUpdateRecord(Request $request, int $studentId)
    {
        $data = $request->validate([
            'allergies' => 'nullable|array',
            'chronic_conditions' => 'nullable|array',
            'medications' => 'nullable|array',
            'blood_type' => 'nullable|string|max:5',
            'primary_doctor_name' => 'nullable|string',
            'primary_doctor_phone' => 'nullable|string',
            'insurance_provider' => 'nullable|string',
            'insurance_policy_number' => 'nullable|string',
            'emergency_instructions' => 'nullable|string',
        ]);

        $record = MedicalRecord::updateOrCreate(
            ['student_user_id' => $studentId],
            $data
        );

        return response()->json($record);
    }

    public function recordVisit(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'symptoms' => 'required|string',
            'diagnosis' => 'nullable|string',
            'treatment' => 'nullable|string',
            'medications_given' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        $visit = MedicalVisit::create([
            ...$data,
            'visit_date' => now(),
            'attended_by' => $request->user()->id,
            'parent_notified' => false,
        ]);

        // Send notification to parents
        NotificationService::sendToParents(
            $data['student_user_id'],
            'medical_visit',
            [
                'student_name' => $visit->student->name,
                'visit_date' => $visit->visit_date->format('Y-m-d H:i'),
                'symptoms' => $data['symptoms'],
                'visit_id' => $visit->id,
            ]
        );

        return response()->json($visit, 201);
    }

    public function notifyParent(Request $request, int $visitId)
    {
        $visit = MedicalVisit::with('student')->findOrFail($visitId);

        if ($visit->parent_notified) {
            return response()->json(['message' => 'Parent already notified'], 400);
        }

        NotificationService::sendToParents(
            $visit->student_user_id,
            'medical_visit_follow_up',
            [
                'student_name' => $visit->student->name,
                'visit_date' => $visit->visit_date->format('Y-m-d H:i'),
                'symptoms' => $visit->symptoms,
                'diagnosis' => $visit->diagnosis,
                'treatment' => $visit->treatment,
                'visit_id' => $visit->id,
            ]
        );

        $visit->update([
            'parent_notified' => true,
            'notified_at' => now(),
        ]);

        return response()->json(['message' => 'Parent notified successfully']);
    }
}
