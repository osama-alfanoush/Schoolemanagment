<?php

namespace App\Services;

use App\Models\AcademicYear;
use App\Models\Announcement;
use App\Models\CalendarEvent;
use App\Models\ClassRoom;
use App\Models\Exam;
use App\Models\SchoolSetting;
use App\Models\Semester;
use App\Models\Subject;
use App\Models\TimetableEntry;
use App\Models\User;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;
use Illuminate\Validation\ValidationException;

class UserManagementService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function listUsers(Request $request): array
    {
        $q = $this->usersInCurrentSchool();
        if ($r = $request->query('role')) {
            $q->where('role', $r);
        }
        if ($s = $request->query('q')) {
            $q->where(function ($x) use ($s) {
                $x->where(\DB::raw('LOWER(name)'), 'like', '%'.strtolower($s).'%')
                    ->orWhere(\DB::raw('LOWER(email)'), 'like', '%'.strtolower($s).'%');
            });
        }

        return ['data' => $q->with(['studentProfile', 'staffProfile'])->orderBy('name')->paginate(50)];
    }

    public function createUser(Request $request): array
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email:rfc,strict|unique:users,email',
            'password' => 'required|min:8',
            'role' => 'required|in:'.implode(',', User::ROLES),
            'phone' => 'nullable|string',
            'student' => 'nullable|array',
            'staff' => 'nullable|array',
        ]);

        $user = DB::transaction(function () use ($data, $request) {
            $u = User::create([
                'name' => $data['name'], 'email' => $data['email'], 'password' => $data['password'],
                'role' => $data['role'], 'phone' => $data['phone'] ?? null,
                // Admin-provisioned credentials are temporary by definition:
                // the account owner must set their own password on first login.
                'must_change_password' => true,
            ]);
            $schoolId = $this->currentSchool->id();
            $u->schoolRoles()->create(['school_id' => $schoolId, 'role' => $data['role']]);
            if ($data['role'] === 'student' && ! empty($data['student'])) {
                $u->studentProfile()->create(array_merge(
                    ['admission_no' => $data['student']['admission_no'] ?? ('ADM'.$u->id)],
                    array_intersect_key($data['student'], array_flip(['class_room_id', 'date_of_birth', 'gender', 'address', 'medical_notes', 'emergency_contact_name', 'emergency_contact_phone']))
                ));
            }
            if (in_array($data['role'], User::STAFF_ROLES) && ! empty($data['staff'])) {
                $u->staffProfile()->create(array_intersect_key($data['staff'],
                    array_flip(['department', 'position', 'hire_date', 'contract_type', 'contract_end', 'base_salary', 'qualifications', 'annual_leave_balance', 'sick_leave_balance'])));
            }
            AuditLogger::log($request, 'create_user', 'user', $u->id, ['role' => $u->role]);

            return $u;
        });

        return ['data' => $user->load(['studentProfile', 'staffProfile']), 'status' => 201];
    }

    public function updateUser(Request $request, int $id): array
    {
        $u = $this->usersInCurrentSchool()->findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string', 'email' => "sometimes|email:rfc,strict|unique:users,email,$id",
            'phone' => 'nullable|string', 'is_active' => 'sometimes|boolean',
            'password' => 'nullable|min:8',
            'deactivation_reason' => 'required_if:is_active,false|nullable|string|max:500',
            // Role changes are allowed between staff roles only (e.g. warehouse
            // → procurement). Students/parents have linked profiles and
            // relationships that a role swap would orphan.
            'role' => ['sometimes', Rule::in(User::STAFF_ROLES)],
        ]);
        if (isset($data['role']) && ! in_array($u->role, User::STAFF_ROLES, true)) {
            abort(422, 'Only staff accounts can change role.');
        }
        // An admin-set password is a reset: treat it as temporary and force
        // the owner to choose their own at next login.
        if (! empty($data['password'])) {
            $data['must_change_password'] = true;
        }
        $revokedSessions = DB::transaction(function () use ($u, $data, $request) {
            $securitySensitiveChange = isset($data['password'])
                || (isset($data['role']) && $data['role'] !== $u->role)
                || (array_key_exists('is_active', $data) && $data['is_active'] !== $u->is_active);

            if (array_key_exists('is_active', $data)) {
                if ($data['is_active'] === false) {
                    $data['deactivated_at'] = now();
                    $data['deactivated_by'] = $request->user()->id;
                } else {
                    $data['deactivated_at'] = null;
                    $data['deactivated_by'] = null;
                    $data['deactivation_reason'] = null;
                }
            }

            $u->update(array_filter($data, fn ($v) => $v !== null || array_key_exists('is_active', $data)));

            return $securitySensitiveChange ? $u->tokens()->delete() : 0;
        });
        AuditLogger::log($request, 'update_user', 'user', $u->id, $data + [
            'revoked_session_count' => $revokedSessions,
        ]);

        return ['data' => $u];
    }

    public function deactivateUser(Request $request, int $id): void
    {
        $u = $this->usersInCurrentSchool()->findOrFail($id);
        $data = $request->validate([
            'reason' => 'required|string|max:500',
        ]);

        $revokedSessions = DB::transaction(function () use ($u, $request, $data) {
            $u->update([
                'is_active' => false,
                'deactivated_at' => now(),
                'deactivated_by' => $request->user()->id,
                'deactivation_reason' => $data['reason'],
            ]);

            return $u->tokens()->delete();
        });
        AuditLogger::log($request, 'deactivate_user', 'user', $id, [
            'reason' => $data['reason'],
            'revoked_session_count' => $revokedSessions,
        ]);
    }

    public function linkParentStudent(Request $request): array
    {
        $data = $request->validate([
            // Enforce role compatibility so a parent link can only ever join an
            // actual parent account to an actual student account.
            'parent_user_id' => [
                'required',
                Rule::exists('users', 'id')->where('role', 'parent'),
            ],
            'student_user_id' => [
                'required',
                Rule::exists('users', 'id')->where('role', 'student'),
            ],
            'relation' => 'nullable|string',
        ]);
        $allowedUsers = $this->usersInCurrentSchool()
            ->whereIn('id', [$data['parent_user_id'], $data['student_user_id']])
            ->count();
        abort_unless($allowedUsers === 2, 422, 'Parent and student must belong to the current school.');
        DB::table('parent_student')->updateOrInsert(
            [
                'school_id' => $this->currentSchool->id(),
                'parent_user_id' => $data['parent_user_id'],
                'student_user_id' => $data['student_user_id'],
            ],
            ['relation' => $data['relation'] ?? 'parent', 'created_at' => now(), 'updated_at' => now()]
        );
        AuditLogger::log($request, 'link_parent_student', 'parent_student', null, $data);

        return ['message' => 'Linked'];
    }

    public function bulkImportStudents(Request $request): array
    {
        $request->validate(['file' => 'required|file|mimes:csv,txt|max:5120']);
        $csv = new \SplFileObject($request->file('file')->getRealPath(), 'rb');
        $csv->setFlags(\SplFileObject::READ_CSV | \SplFileObject::SKIP_EMPTY | \SplFileObject::DROP_NEW_LINE);
        $header = $csv->fgetcsv();
        $header = is_array($header)
            ? array_map(fn ($value) => trim((string) $value, " \t\n\r\0\x0B\xEF\xBB\xBF"), $header)
            : [];
        foreach (['name', 'email'] as $requiredColumn) {
            if (! in_array($requiredColumn, $header, true)) {
                throw ValidationException::withMessages(['file' => ["Missing required CSV column: {$requiredColumn}."]]);
            }
        }

        $created = 0;
        $errors = [];
        $schoolId = $this->currentSchool->id();
        $rowNumber = 1;
        while (! $csv->eof()) {
            $row = $csv->fgetcsv();
            $rowNumber++;
            if (! is_array($row) || $row === [null]) {
                continue;
            }
            if ($rowNumber > 5001) {
                $errors[] = ['row' => $rowNumber, 'error' => 'Import limit is 5,000 data rows.'];
                break;
            }
            if (count($row) !== count($header)) {
                $errors[] = ['row' => $rowNumber, 'error' => 'Column count does not match the CSV header.'];

                continue;
            }

            $record = array_combine($header, array_map(fn ($value) => is_string($value) ? trim($value) : $value, $row));
            $validator = Validator::make($record, [
                'name' => ['required', 'string', 'max:255'],
                'email' => ['required', 'email:rfc,strict', 'max:255', Rule::unique('users', 'email')],
                'password' => ['nullable', Password::min(12)->mixedCase()->numbers()->symbols()],
                'class_room_id' => ['nullable', 'integer'],
                'admission_no' => ['nullable', 'string', 'max:100', Rule::unique('student_profiles')->where('school_id', $schoolId)],
                'gender' => ['nullable', 'string', 'max:30'],
            ]);
            if ($validator->fails()) {
                $errors[] = ['row' => $rowNumber, 'error' => implode(' ', $validator->errors()->all())];

                continue;
            }
            $record = $validator->validated();

            try {
                DB::transaction(function () use ($record, $schoolId, &$created): void {
                    if (! empty($record['class_room_id']) && ! ClassRoom::whereKey($record['class_room_id'])->exists()) {
                        throw new \InvalidArgumentException('The selected class belongs to another school.');
                    }
                    $password = $record['password'] ?? Str::random(20).'Aa1!';
                    $u = User::create([
                        'name' => $record['name'], 'email' => Str::lower($record['email']),
                        'password' => Hash::make($password),
                        'role' => 'student',
                        'must_change_password' => true,
                    ]);
                    $u->schoolRoles()->create(['school_id' => $schoolId, 'role' => 'student']);
                    $u->studentProfile()->create([
                        'admission_no' => $record['admission_no'] ?? ('ADM'.$u->id),
                        'class_room_id' => $record['class_room_id'] ?? null,
                        'gender' => $record['gender'] ?? null,
                    ]);
                    $created++;
                });
            } catch (\Throwable $e) {
                $errors[] = ['row' => $rowNumber, 'error' => $e->getMessage()];
            }
        }
        AuditLogger::log($request, 'bulk_import_students', 'user', null, ['created' => $created, 'errors' => count($errors)]);

        return ['created' => $created, 'errors' => $errors];
    }

    public function listClasses(Request $request): array
    {
        return ['data' => ClassRoom::with('homeroomTeacher:id,name')
            ->withCount('students')
            ->orderBy('grade')
            ->orderBy('section')
            ->get()];
    }

    public function createClass(Request $request): array
    {
        $data = $request->validate([
            'name' => 'required', 'grade' => 'required', 'section' => 'nullable',
            'capacity' => 'nullable|integer', 'academic_year_id' => 'nullable|exists:academic_years,id',
            'homeroom_teacher_id' => 'nullable|exists:users,id',
        ]);
        $data['school_id'] = $this->currentSchool->id();
        if (! empty($data['homeroom_teacher_id'])) {
            $this->assertUserInCurrentSchool((int) $data['homeroom_teacher_id'], 'teacher');
        }
        $c = ClassRoom::create($data);
        AuditLogger::log($request, 'create_class', 'class_room', $c->id, $data);

        return ['data' => $c, 'status' => 201];
    }

    public function assignSubjectTeacher(Request $request, int $classId): array
    {
        $data = $request->validate([
            'subject_id' => 'required|exists:subjects,id',
            'teacher_user_id' => 'required|exists:users,id',
        ]);
        $class = ClassRoom::findOrFail($classId);
        $subject = Subject::findOrFail($data['subject_id']);
        abort_unless($subject->school_id === $class->school_id, 422, 'The subject belongs to another school.');
        $this->assertUserInCurrentSchool((int) $data['teacher_user_id'], 'teacher');
        DB::table('class_subject_teacher')->updateOrInsert(
            [
                'school_id' => $this->currentSchool->id(),
                'class_room_id' => $classId,
                'subject_id' => $data['subject_id'],
            ],
            ['teacher_user_id' => $data['teacher_user_id'], 'created_at' => now(), 'updated_at' => now()]
        );
        AuditLogger::log($request, 'assign_subject_teacher', 'class_room', $classId, $data);

        return ['message' => 'Assigned'];
    }

    public function listTimetable(Request $request, int $classId): array
    {
        return ['data' => TimetableEntry::where('class_room_id', $classId)
            ->with(['subject', 'teacher:id,name'])->get()];
    }

    public function createTimetableEntry(Request $request, int $classId): array
    {
        $data = $request->validate([
            'subject_id' => 'required|exists:subjects,id',
            'teacher_user_id' => 'required|exists:users,id',
            'day_of_week' => 'required|integer|between:1,7',
            'start_time' => 'required|date_format:H:i', 'end_time' => 'required|date_format:H:i|after:start_time',
            'room' => 'nullable|string',
            'term_id' => 'nullable|exists:terms,id',
            'course_section_id' => 'nullable|exists:course_sections,id',
            'effective_start' => 'nullable|date',
            'effective_end' => 'nullable|date|after_or_equal:effective_start',
            'week_pattern' => 'nullable|in:weekly,odd,even,rotation',
            'rotation_week' => 'nullable|integer|min:1|max:12',
        ]);
        $class = ClassRoom::findOrFail($classId);
        $teacher = $this->usersInCurrentSchool()->whereKey($data['teacher_user_id'])
            ->where('role', 'teacher')->where('is_active', true)->first();
        if (! $teacher) {
            throw ValidationException::withMessages(['teacher_user_id' => ['The selected user is not an active teacher.']]);
        }
        $assigned = DB::table('class_subject_teacher')->where([
            'school_id' => $this->currentSchool->id(),
            'class_room_id' => $classId, 'subject_id' => $data['subject_id'], 'teacher_user_id' => $teacher->id,
        ])->exists();
        if (! $assigned) {
            throw ValidationException::withMessages(['teacher_user_id' => ['The teacher is not assigned to this class and subject.']]);
        }
        [$startHour, $startMinute] = array_map('intval', explode(':', $data['start_time']));
        [$endHour, $endMinute] = array_map('intval', explode(':', $data['end_time']));
        $data += [
            'school_id' => $class->school_id,
            'week_pattern' => 'weekly', 'rotation_week' => 1,
            'start_minute' => $startHour * 60 + $startMinute,
            'end_minute' => $endHour * 60 + $endMinute,
        ];

        $overlap = TimetableEntry::query()
            ->where('school_id', $class->school_id)->where('day_of_week', $data['day_of_week'])
            ->where('week_pattern', $data['week_pattern'])->where('rotation_week', $data['rotation_week'])
            ->where('start_minute', '<', $data['end_minute'])->where('end_minute', '>', $data['start_minute'])
            ->where(fn ($q) => $q->where('class_room_id', $classId)
                ->orWhere('teacher_user_id', $teacher->id)
                ->when($data['room'] ?? null, fn ($roomQuery, $room) => $roomQuery->orWhere('room', $room)))
            ->when($data['effective_start'] ?? null, fn ($q, $start) => $q->where(fn ($dates) => $dates->whereNull('effective_end')->orWhere('effective_end', '>=', $start)))
            ->when($data['effective_end'] ?? null, fn ($q, $end) => $q->where(fn ($dates) => $dates->whereNull('effective_start')->orWhere('effective_start', '<=', $end)))
            ->exists();
        if ($overlap) {
            throw ValidationException::withMessages(['start_time' => ['This time conflicts with the teacher, class, or room schedule.']]);
        }

        try {
            $entry = TimetableEntry::create(array_merge($data, ['class_room_id' => $classId]));
        } catch (QueryException $exception) {
            if (in_array($exception->getCode(), ['23P01', '23000'], true)) {
                throw ValidationException::withMessages(['start_time' => ['This time conflicts with the teacher, class, or room schedule.']]);
            }
            throw $exception;
        }
        AuditLogger::log($request, 'create_timetable_entry', 'timetable_entry', $entry->id, $data + ['class_room_id' => $classId]);

        return ['data' => $entry, 'status' => 201];
    }

    public function listCalendar(): array
    {
        return ['data' => CalendarEvent::orderBy('start_date')->get()];
    }

    public function createCalendarEvent(Request $request): array
    {
        $data = $request->validate([
            'title' => 'required|string', 'description' => 'nullable|string',
            'type' => 'required|in:holiday,exam,event,semester_start,semester_end',
            'start_date' => 'required|date', 'end_date' => 'nullable|date',
        ]);

        return ['data' => CalendarEvent::create($data), 'status' => 201];
    }

    public function announce(Request $request): array
    {
        $data = $request->validate([
            'audience' => 'required|string',
            'title' => 'required|string', 'body' => 'required|string',
        ]);

        return ['data' => Announcement::create(array_merge($data, ['sender_user_id' => $request->user()->id])), 'status' => 201];
    }

    public function getAnnouncements(Request $request): array
    {
        $announcements = Announcement::query()
            ->when($request->search, fn ($q, $s) => $q->where('title', 'like', "%{$s}%"))
            ->when($request->audience, fn ($q, $a) => $q->where('audience', $a))
            ->latest()
            ->paginate($request->per_page ?? 20);

        return ['data' => $announcements];
    }

    public function getSchoolSettings(): array
    {
        $settings = SchoolSetting::first() ?? new SchoolSetting;

        return ['data' => $settings];
    }

    public function updateSchoolSettings(Request $request): array
    {
        foreach (['school_name', 'academic_year', 'primary_color', 'accent_color', 'sidebar_style', 'border_radius', 'font_style'] as $field) {
            if (! $request->has($field)) {
                continue;
            }

            $value = trim((string) $request->input($field));
            if ($value === '') {
                $request->request->remove($field);
            } else {
                $request->merge([$field => $value]);
            }
        }

        $validated = $request->validate([
            'school_name' => 'sometimes|string|max:255',
            'school_motto' => 'nullable|string|max:255',
            'academic_year' => 'sometimes|string|max:20',
            'address' => 'nullable|string',
            'primary_color' => 'sometimes|string|regex:/^#[0-9A-Fa-f]{6}$/',
            'accent_color' => 'sometimes|string|regex:/^#[0-9A-Fa-f]{6}$/',
            'sidebar_style' => 'sometimes|in:white,gradient,dark',
            'border_radius' => 'sometimes|in:sharp,medium,rounded',
            'font_style' => 'sometimes|in:modern,classic,friendly',
            'school_logo' => 'nullable|image|max:2048',
            'remove_school_logo' => 'sometimes|boolean',
        ]);

        $removeLogo = (bool) ($validated['remove_school_logo'] ?? false);
        unset($validated['remove_school_logo']);

        if ($request->hasFile('school_logo')) {
            $uploads = Storage::disk(config('filesystems.uploads_disk'));
            $path = $uploads->putFile('school', $request->file('school_logo'), 'public');
            $validated['school_logo'] = $uploads->url($path);
        } elseif ($removeLogo) {
            $validated['school_logo'] = null;
        }

        $settings = SchoolSetting::first() ?? new SchoolSetting;
        $settings->fill($validated);
        $settings->save();

        return ['data' => $settings];
    }

    public function listSubjects(): array
    {
        return ['data' => Subject::orderBy('name')->get()];
    }

    public function createSubject(Request $request): array
    {
        $data = $request->validate([
            'name' => 'required',
            'code' => ['required', Rule::unique('subjects')->where('school_id', $this->currentSchool->id())],
        ]);
        $data['school_id'] = $this->currentSchool->id();

        return ['data' => Subject::create($data), 'status' => 201];
    }

    public function updateSubject(Request $request, int $id): array
    {
        $s = Subject::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string',
            'code' => ['sometimes', Rule::unique('subjects')->where('school_id', $this->currentSchool->id())->ignore($s->id)],
        ]);
        $s->update($data);
        AuditLogger::log($request, 'update_subject', 'subject', $id, $data);

        return ['data' => $s];
    }

    public function deleteSubject(Request $request, int $id): void
    {
        Subject::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_subject', 'subject', $id);
    }

    public function listExams(): array
    {
        return ['data' => Exam::with(['classRoom', 'subject'])->orderBy('exam_date')->get()];
    }

    public function createExam(Request $request): array
    {
        $data = $request->validate([
            'class_room_id' => 'required|exists:class_rooms,id',
            'subject_id' => 'required|exists:subjects,id',
            'semester_id' => 'nullable|exists:semesters,id',
            'title' => 'required', 'exam_date' => 'required|date',
            'start_time' => 'required', 'end_time' => 'required',
            'room' => 'nullable',
        ]);
        ClassRoom::findOrFail($data['class_room_id']);
        Subject::findOrFail($data['subject_id']);
        if (! empty($data['semester_id'])) {
            Semester::findOrFail($data['semester_id']);
        }

        return ['data' => Exam::create($data), 'status' => 201];
    }

    public function updateExam(Request $request, int $id): array
    {
        $e = Exam::findOrFail($id);
        $data = $request->validate([
            'class_room_id' => 'sometimes|exists:class_rooms,id',
            'subject_id' => 'sometimes|exists:subjects,id',
            'title' => 'sometimes|string', 'exam_date' => 'sometimes|date',
            'start_time' => 'sometimes', 'end_time' => 'sometimes',
            'room' => 'nullable',
        ]);
        if (! empty($data['class_room_id'])) {
            ClassRoom::findOrFail($data['class_room_id']);
        }
        if (! empty($data['subject_id'])) {
            Subject::findOrFail($data['subject_id']);
        }
        $e->update($data);
        AuditLogger::log($request, 'update_exam', 'exam', $id, $data);

        return ['data' => $e->load(['classRoom', 'subject'])];
    }

    public function deleteExam(Request $request, int $id): void
    {
        Exam::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_exam', 'exam', $id);
    }

    public function listAcademicYears(): array
    {
        return ['data' => AcademicYear::with('semesters')->get()];
    }

    public function createAcademicYear(Request $request): array
    {
        $data = $request->validate([
            'name' => 'required', 'start_date' => 'required|date', 'end_date' => 'required|date',
            'is_current' => 'boolean',
        ]);
        $data['school_id'] = $this->currentSchool->id();
        if ($data['is_current'] ?? false) {
            AcademicYear::query()->update(['is_current' => false]);
        }

        return ['data' => AcademicYear::create($data), 'status' => 201];
    }

    public function updateAcademicYear(Request $request, int $id): array
    {
        $ay = AcademicYear::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string', 'start_date' => 'sometimes|date', 'end_date' => 'sometimes|date',
            'is_current' => 'sometimes|boolean',
        ]);
        if ($data['is_current'] ?? false) {
            AcademicYear::where('id', '!=', $id)->update(['is_current' => false]);
        }
        $ay->update($data);
        AuditLogger::log($request, 'update_academic_year', 'academic_year', $id, $data);

        return ['data' => $ay->load('semesters')];
    }

    public function deleteAcademicYear(Request $request, int $id): void
    {
        AcademicYear::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_academic_year', 'academic_year', $id);
    }

    private function usersInCurrentSchool()
    {
        $schoolId = $this->currentSchool->id();
        $today = now()->toDateString();

        return User::query()->whereHas('schoolRoles', fn ($query) => $query
            ->where('school_id', $schoolId)
            ->where(fn ($dates) => $dates->whereNull('starts_on')->orWhereDate('starts_on', '<=', $today))
            ->where(fn ($dates) => $dates->whereNull('ends_on')->orWhereDate('ends_on', '>=', $today)));
    }

    private function assertUserInCurrentSchool(int $userId, ?string $role = null): User
    {
        $query = $this->usersInCurrentSchool()->whereKey($userId);
        if ($role !== null) {
            $query->where('role', $role);
        }

        return $query->firstOrFail();
    }

    public function updateClass(Request $request, int $id): array
    {
        $c = ClassRoom::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string', 'grade' => 'sometimes|string', 'section' => 'nullable|string',
            'capacity' => 'nullable|integer', 'academic_year_id' => 'nullable|exists:academic_years,id',
            'homeroom_teacher_id' => 'nullable|exists:users,id',
        ]);
        if (! empty($data['academic_year_id'])) {
            AcademicYear::findOrFail($data['academic_year_id']);
        }
        if (! empty($data['homeroom_teacher_id'])) {
            $this->assertUserInCurrentSchool((int) $data['homeroom_teacher_id'], 'teacher');
        }
        $c->update($data);
        AuditLogger::log($request, 'update_class', 'class_room', $id, $data);

        return ['data' => $c->load('homeroomTeacher:id,name')];
    }

    public function deleteClass(Request $request, int $id): void
    {
        ClassRoom::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_class', 'class_room', $id);
    }

    public function deleteTimetableEntry(Request $request, int $classId, int $id): void
    {
        TimetableEntry::where('class_room_id', $classId)->where('id', $id)->firstOrFail()->delete();
        AuditLogger::log($request, 'delete_timetable_entry', 'timetable_entry', $id);
    }

    public function updateCalendarEvent(Request $request, int $id): array
    {
        $e = CalendarEvent::findOrFail($id);
        $data = $request->validate([
            'title' => 'sometimes|string', 'description' => 'nullable|string',
            'type' => 'sometimes|in:holiday,exam,event,semester_start,semester_end',
            'start_date' => 'sometimes|date', 'end_date' => 'nullable|date',
        ]);
        $e->update($data);
        AuditLogger::log($request, 'update_calendar_event', 'calendar_event', $id, $data);

        return ['data' => $e];
    }

    public function deleteCalendarEvent(Request $request, int $id): void
    {
        CalendarEvent::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_calendar_event', 'calendar_event', $id);
    }

    public function deleteAnnouncement(Request $request, int $id): void
    {
        Announcement::findOrFail($id)->delete();
        AuditLogger::log($request, 'delete_announcement', 'announcement', $id);
    }
}
