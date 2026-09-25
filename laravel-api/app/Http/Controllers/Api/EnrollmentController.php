<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\StudentEnrollment;
use App\Services\AuditLogger;
use App\Services\EnrollmentService;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class EnrollmentController extends Controller
{
    public function __construct(private readonly EnrollmentService $enrollments) {}

    public function store(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => ['required', Rule::exists('users', 'id')->where('role', 'student')],
            'school_id' => 'sometimes|integer|exists:schools,id',
            'academic_year_id' => 'required|exists:academic_years,id',
            'class_room_id' => 'required|exists:class_rooms,id',
            'admission_date' => 'nullable|date',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'status' => 'sometimes|in:applicant,accepted,active,transferred,withdrawn,graduated',
            'entry_type' => 'sometimes|string|max:100',
            'previous_school' => 'nullable|string|max:255',
        ]);
        $enrollment = $this->enrollments->create($data, $request->user()->id);
        AuditLogger::log($request, 'create_enrollment', 'student_enrollment', $enrollment->id, $data);

        return response()->json($enrollment, 201);
    }

    public function transfer(Request $request, StudentEnrollment $enrollment)
    {
        $data = $request->validate([
            'school_id' => 'sometimes|integer|exists:schools,id',
            'academic_year_id' => 'required|exists:academic_years,id',
            'class_room_id' => 'required|exists:class_rooms,id',
            'start_date' => 'required|date',
            'version' => 'required|integer|min:1',
            'previous_school' => 'nullable|string|max:255',
            'next_school' => 'nullable|string|max:255',
        ]);
        $newEnrollment = $this->enrollments->transfer($enrollment, $data, $request->user()->id);
        AuditLogger::log($request, 'transfer_enrollment', 'student_enrollment', $enrollment->id, [
            'new_enrollment_id' => $newEnrollment->id,
            'transfer_date' => $data['start_date'],
        ]);

        return response()->json($newEnrollment, 201);
    }
}
