<?php

namespace App\Services;

use App\Models\AcademicYear;
use App\Models\Announcement;
use App\Models\CalendarEvent;
use App\Models\ClassRoom;
use App\Models\Exam;
use App\Models\SchoolSetting;
use App\Models\Subject;
use App\Models\TimetableEntry;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class UserManagementService
{
    public function listUsers(Request $request): array
    {
        $q = User::query();
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
            ]);
            if ($data['role'] === 'student' && ! empty($data['student'])) {
                $u->studentProfile()->create(array_merge(
                    ['admission_no' => $data['student']['admission_no'] ?? ('ADM'.$u->id)],
                    array_intersect_key($data['student'], array_flip(['class_room_id', 'date_of_birth', 'gender', 'address', 'medical_notes', 'emergency_contact_name', 'emergency_contact_phone']))
                ));
            }
            if (in_array($data['role'], ['teacher', 'admin', 'finance', 'hr', 'warehouse']) && ! empty($data['staff'])) {
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
        $u = User::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string', 'email' => "sometimes|email:rfc,strict|unique:users,email,$id",
            'phone' => 'nullable|string', 'is_active' => 'sometimes|boolean',
            'password' => 'nullable|min:8',
        ]);
        $u->update(array_filter($data, fn ($v) => $v !== null));
        AuditLogger::log($request, 'update_user', 'user', $u->id, $data);

        return ['data' => $u];
    }

    public function deactivateUser(Request $request, int $id): void
    {
        $u = User::findOrFail($id);
        $u->update(['is_active' => false]);
        AuditLogger::log($request, 'deactivate_user', 'user', $id);
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
        DB::table('parent_student')->updateOrInsert(
            ['parent_user_id' => $data['parent_user_id'], 'student_user_id' => $data['student_user_id']],
            ['relation' => $data['relation'] ?? 'parent', 'created_at' => now(), 'updated_at' => now()]
        );
        AuditLogger::log($request, 'link_parent_student', 'parent_student', null, $data);

        return ['message' => 'Linked'];
    }

    public function bulkImportStudents(Request $request): array
    {
        $request->validate(['file' => 'required|file|mimes:csv,txt']);
        $rows = array_map('str_getcsv', file($request->file('file')->getRealPath()));
        $header = array_map('trim', array_shift($rows));
        $created = 0;
        $errors = [];
        DB::transaction(function () use ($rows, $header, &$created, &$errors) {
            foreach ($rows as $i => $row) {
                $r = array_combine($header, $row);
                try {
                    // Generate a secure random password instead of using a hardcoded default
                    $password = $r['password'] ?? Str::random(12).'A1!';
                    $u = User::create([
                        'name' => $r['name'], 'email' => $r['email'],
                        'password' => Hash::make($password),
                        'role' => 'student',
                        'must_change_password' => true,
                    ]);
                    $u->studentProfile()->create([
                        'admission_no' => $r['admission_no'] ?? ('ADM'.$u->id),
                        'class_room_id' => $r['class_room_id'] ?? null,
                        'gender' => $r['gender'] ?? null,
                    ]);
                    $created++;
                } catch (\Throwable $e) {
                    $errors[] = ['row' => $i + 2, 'error' => $e->getMessage()];
                }
            }
        });
        AuditLogger::log($request, 'bulk_import_students', 'user', null, ['created' => $created, 'errors' => count($errors)]);

        return ['created' => $created, 'errors' => $errors];
    }

    public function listClasses(Request $request): array
    {
        return ['data' => ClassRoom::with('homeroomTeacher:id,name')->orderBy('grade')->orderBy('section')->get()];
    }

    public function createClass(Request $request): array
    {
        $data = $request->validate([
            'name' => 'required', 'grade' => 'required', 'section' => 'nullable',
            'capacity' => 'nullable|integer', 'academic_year_id' => 'nullable|exists:academic_years,id',
            'homeroom_teacher_id' => 'nullable|exists:users,id',
        ]);
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
        DB::table('class_subject_teacher')->updateOrInsert(
            ['class_room_id' => $classId, 'subject_id' => $data['subject_id']],
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
            'start_time' => 'required', 'end_time' => 'required',
            'room' => 'nullable|string',
        ]);
        $entry = TimetableEntry::create(array_merge($data, ['class_room_id' => $classId]));
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
            $path = $request->file('school_logo')->store('school', 'public');
            $validated['school_logo'] = asset('storage/'.$path);
        } elseif ($removeLogo) {
            $validated['school_logo'] = null;
        }

        $settings = SchoolSetting::updateOrCreate(['id' => 1], $validated);

        return ['data' => $settings];
    }

    public function listSubjects(): array
    {
        return ['data' => Subject::orderBy('name')->get()];
    }

    public function createSubject(Request $request): array
    {
        $data = $request->validate(['name' => 'required', 'code' => 'required|unique:subjects,code']);

        return ['data' => Subject::create($data), 'status' => 201];
    }

    public function updateSubject(Request $request, int $id): array
    {
        $s = Subject::findOrFail($id);
        $data = $request->validate(['name' => 'sometimes|string', 'code' => "sometimes|unique:subjects,code,$id"]);
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

    public function updateClass(Request $request, int $id): array
    {
        $c = ClassRoom::findOrFail($id);
        $data = $request->validate([
            'name' => 'sometimes|string', 'grade' => 'sometimes|string', 'section' => 'nullable|string',
            'capacity' => 'nullable|integer', 'academic_year_id' => 'nullable|exists:academic_years,id',
            'homeroom_teacher_id' => 'nullable|exists:users,id',
        ]);
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
