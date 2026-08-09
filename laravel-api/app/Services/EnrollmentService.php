<?php

namespace App\Services;

use App\Models\AcademicYear;
use App\Models\ClassRoom;
use App\Models\StudentEnrollment;
use App\Models\User;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class EnrollmentService
{
    public function __construct(private readonly CurrentSchool $currentSchool) {}

    public function create(array $data, int $actorId): StudentEnrollment
    {
        return DB::transaction(function () use ($data, $actorId) {
            $schoolId = $this->currentSchool->id();
            if (isset($data['school_id']) && (int) $data['school_id'] !== $schoolId) {
                throw ValidationException::withMessages([
                    'school_id' => ['The enrollment school must match the authenticated school context.'],
                ]);
            }
            $data['school_id'] = $schoolId;

            $student = User::whereKey($data['student_user_id'])->where('role', 'student')
                ->whereHas('schoolRoles', fn ($query) => $query->where('school_id', $schoolId))
                ->firstOrFail();
            $classRoom = ClassRoom::whereKey($data['class_room_id'])
                ->where('school_id', $schoolId)->firstOrFail();
            abort_unless(
                AcademicYear::query()->whereKey($data['academic_year_id'])->exists(),
                422,
                'The academic year belongs to another school.',
            );
            $this->assertNoOverlap($student->id, $schoolId, $data['start_date'], $data['end_date'] ?? null);

            $enrollment = StudentEnrollment::create($data + [
                'created_by' => $actorId,
                'approved_by' => $actorId,
                'status' => $data['status'] ?? 'active',
            ]);
            if ($enrollment->status === 'active') {
                $student->studentProfile()->update(['class_room_id' => $classRoom->id]);
            }

            return $enrollment;
        });
    }

    public function transfer(StudentEnrollment $current, array $data, int $actorId): StudentEnrollment
    {
        return DB::transaction(function () use ($current, $data, $actorId) {
            $locked = StudentEnrollment::lockForUpdate()->findOrFail($current->id);
            if ($locked->status !== 'active' || $locked->end_date !== null) {
                throw ValidationException::withMessages(['enrollment' => ['Only an open active enrollment can be transferred.']]);
            }
            if (isset($data['version']) && (int) $data['version'] !== $locked->version) {
                abort(409, 'Enrollment was changed by another user.');
            }

            $transferDate = CarbonImmutable::parse($data['start_date']);
            if ($transferDate->lte($locked->start_date)) {
                throw ValidationException::withMessages(['start_date' => ['Transfer date must be after the current enrollment start date.']]);
            }

            $locked->update([
                'end_date' => $transferDate->subDay(),
                'status' => 'transferred',
                'exit_type' => 'transfer',
                'next_school' => $data['next_school'] ?? null,
                'version' => $locked->version + 1,
            ]);

            return $this->create([
                'student_user_id' => $locked->student_user_id,
                'school_id' => $data['school_id'],
                'academic_year_id' => $data['academic_year_id'],
                'class_room_id' => $data['class_room_id'],
                'admission_date' => $transferDate,
                'start_date' => $transferDate,
                'status' => 'active',
                'entry_type' => 'transfer',
                'previous_school' => $data['previous_school'] ?? null,
            ], $actorId);
        });
    }

    private function assertNoOverlap(int $studentId, int $schoolId, string $startDate, ?string $endDate): void
    {
        $overlap = StudentEnrollment::where('student_user_id', $studentId)
            ->where('school_id', $schoolId)
            ->where('start_date', '<=', $endDate ?? '9999-12-31')
            ->where(fn ($query) => $query->whereNull('end_date')->orWhere('end_date', '>=', $startDate))
            ->exists();

        if ($overlap) {
            throw ValidationException::withMessages(['start_date' => ['Enrollment dates overlap an existing enrollment.']]);
        }
    }
}
