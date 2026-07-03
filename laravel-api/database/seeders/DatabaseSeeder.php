<?php

namespace Database\Seeders;

use App\Models\AcademicYear;
use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\CalendarEvent;
use App\Models\ClassRoom;
use App\Models\ConductLog;
use App\Models\FeeStructure;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\Invoice;
use App\Models\Semester;
use App\Models\StaffProfile;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\Submission;
use App\Models\TimetableEntry;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Academic year + semesters
        $year = AcademicYear::create([
            'name' => '2025-2026', 'start_date' => '2025-09-01', 'end_date' => '2026-06-30', 'is_current' => true,
        ]);
        $sem1 = Semester::create(['academic_year_id' => $year->id, 'name' => 'Semester 1', 'start_date' => '2025-09-01', 'end_date' => '2026-01-15']);
        Semester::create(['academic_year_id' => $year->id, 'name' => 'Semester 2', 'start_date' => '2026-01-16', 'end_date' => '2026-06-30']);

        // Subjects
        $subjects = collect([
            ['name' => 'Mathematics', 'code' => 'MATH'],
            ['name' => 'English', 'code' => 'ENG'],
            ['name' => 'Science', 'code' => 'SCI'],
            ['name' => 'Arabic', 'code' => 'ARA'],
            ['name' => 'History', 'code' => 'HIS'],
            ['name' => 'Physical Education', 'code' => 'PE'],
        ])->map(fn ($s) => Subject::create($s));

        // Admin and operational demo users
        $admin = $this->makeUser('Sara Admin', 'admin@school.test', 'admin');
        $this->makeUser('Fadi Finance', 'finance@school.test', 'finance');
        $this->makeUser('Hala HR', 'hr@school.test', 'hr');
        // 'accounting' role merged into 'finance' (unified Finance & Accounting).
        $this->makeUser('Amina Accountant', 'accounting@school.test', 'finance');
        $this->makeUser('Omar Warehouse', 'warehouse@school.test', 'warehouse');

        // Teachers
        $teachers = collect();
        foreach (['Mr. Khaled Math', 'Ms. Layla English', 'Dr. Omar Science', 'Ms. Noor Arabic', 'Mr. Tarek History'] as $i => $name) {
            $t = $this->makeUser($name, 'teacher'.($i + 1).'@school.test', 'teacher');
            StaffProfile::create([
                'user_id' => $t->id, 'department' => 'Academics', 'position' => 'Teacher',
                'hire_date' => now()->subYears(rand(1, 8)), 'contract_type' => 'full-time',
                'base_salary' => rand(2500, 5000), 'annual_leave_balance' => 20, 'sick_leave_balance' => 10,
            ]);
            $teachers->push($t);
        }

        // Class rooms
        $class1 = ClassRoom::create(['name' => 'Grade 5 - A', 'grade' => '5', 'section' => 'A', 'capacity' => 30, 'academic_year_id' => $year->id, 'homeroom_teacher_id' => $teachers[0]->id]);
        $class2 = ClassRoom::create(['name' => 'Grade 5 - B', 'grade' => '5', 'section' => 'B', 'capacity' => 30, 'academic_year_id' => $year->id, 'homeroom_teacher_id' => $teachers[1]->id]);
        $class3 = ClassRoom::create(['name' => 'Grade 6 - A', 'grade' => '6', 'section' => 'A', 'capacity' => 30, 'academic_year_id' => $year->id, 'homeroom_teacher_id' => $teachers[2]->id]);

        // Assign subjects to teachers per class
        foreach ([$class1, $class2, $class3] as $cls) {
            foreach ($subjects as $i => $subj) {
                DB::table('class_subject_teacher')->insert([
                    'class_room_id' => $cls->id, 'subject_id' => $subj->id,
                    'teacher_user_id' => $teachers[$i % $teachers->count()]->id,
                    'created_at' => now(), 'updated_at' => now(),
                ]);
            }
        }

        // Timetable for class1 (Mon-Fri, 6 periods)
        $startTimes = [['08:00', '08:50'], ['09:00', '09:50'], ['10:00', '10:50'], ['11:00', '11:50'], ['12:30', '13:20'], ['13:30', '14:20']];
        foreach (range(1, 5) as $day) {
            foreach ($startTimes as $i => [$st, $et]) {
                $subj = $subjects[$i % $subjects->count()];
                TimetableEntry::create([
                    'class_room_id' => $class1->id, 'subject_id' => $subj->id,
                    'teacher_user_id' => $teachers[$i % $teachers->count()]->id,
                    'day_of_week' => $day, 'start_time' => $st, 'end_time' => $et,
                    'room' => 'Room '.(101 + ($i % 5)),
                ]);
            }
        }

        // Parents & students with linkages
        $parents = collect();
        for ($i = 1; $i <= 6; $i++) {
            $p = $this->makeUser("Parent $i", "parent$i@school.test", 'parent');
            $parents->push($p);
        }

        $students = collect();
        $studentNames = ['Ali', 'Mariam', 'Omar', 'Fatima', 'Yousef', 'Aisha', 'Hassan', 'Layla', 'Karim', 'Zainab', 'Mohamed', 'Sara'];
        foreach ($studentNames as $idx => $name) {
            $email = strtolower($name).($idx + 1).'@school.test';
            $u = $this->makeUser("$name Student", $email, 'student');
            $cls = [$class1, $class2, $class3][$idx % 3];
            StudentProfile::create([
                'user_id' => $u->id, 'class_room_id' => $cls->id,
                'admission_no' => 'ADM'.str_pad((string) (1000 + $u->id), 5, '0', STR_PAD_LEFT),
                'date_of_birth' => now()->subYears(11)->subDays(rand(1, 1500)),
                'gender' => $idx % 2 === 0 ? 'M' : 'F',
                'emergency_contact_name' => 'Family',
                'emergency_contact_phone' => '+971 50 000 0000',
            ]);
            // Link to a parent
            DB::table('parent_student')->insert([
                'parent_user_id' => $parents[$idx % $parents->count()]->id,
                'student_user_id' => $u->id,
                'relation' => $idx % 2 === 0 ? 'father' : 'mother',
                'created_at' => now(), 'updated_at' => now(),
            ]);
            $students->push($u);
        }

        // Attendance for last 14 days
        foreach ($students as $s) {
            for ($d = 0; $d < 14; $d++) {
                $date = now()->subDays($d)->format('Y-m-d');
                if (now()->subDays($d)->isWeekend()) {
                    continue;
                }
                $statuses = ['present', 'present', 'present', 'present', 'present', 'late', 'absent'];
                $status = $statuses[array_rand($statuses)];
                AttendanceRecord::create([
                    'student_user_id' => $s->id,
                    'class_room_id' => $s->studentProfile->class_room_id,
                    'subject_id' => null,
                    'date' => $date, 'status' => $status,
                    'marked_by' => $teachers[0]->id,
                ]);
            }
        }

        // Grade components & grades for class1, math
        $math = $subjects->firstWhere('code', 'MATH');
        $componentsData = [
            ['name' => 'Quiz 1', 'type' => 'quiz', 'weight' => 10, 'max_score' => 20],
            ['name' => 'Quiz 2', 'type' => 'quiz', 'weight' => 10, 'max_score' => 20],
            ['name' => 'Midterm', 'type' => 'exam', 'weight' => 30, 'max_score' => 100],
            ['name' => 'Homework Avg', 'type' => 'homework', 'weight' => 20, 'max_score' => 100],
        ];
        foreach ([$class1, $class2, $class3] as $cls) {
            foreach ($componentsData as $cd) {
                $comp = GradeComponent::create(array_merge($cd, [
                    'class_room_id' => $cls->id, 'subject_id' => $math->id, 'semester_id' => $sem1->id,
                ]));
                foreach ($students->where('studentProfile.class_room_id', $cls->id) as $stud) {
                    Grade::create([
                        'student_user_id' => $stud->id, 'grade_component_id' => $comp->id,
                        'score' => round($cd['max_score'] * (0.5 + (mt_rand(0, 100) / 200)), 1),
                        'entered_by' => $teachers[0]->id,
                    ]);
                }
            }
        }

        // Assignments + submissions
        foreach ([$class1, $class2] as $cls) {
            $a = Assignment::create([
                'teacher_user_id' => $teachers[0]->id,
                'class_room_id' => $cls->id, 'subject_id' => $math->id,
                'title' => 'Algebra Practice Set 3',
                'instructions' => 'Solve problems 1-15 in chapter 4. Show your work.',
                'due_at' => now()->addDays(3), 'max_score' => 100,
            ]);
            foreach ($students->where('studentProfile.class_room_id', $cls->id)->take(2) as $stud) {
                Submission::create([
                    'assignment_id' => $a->id, 'student_user_id' => $stud->id,
                    'content_text' => 'See attached work.', 'submitted_at' => now()->subHours(2),
                    'status' => 'submitted',
                ]);
            }
        }

        // Conduct
        ConductLog::create([
            'student_user_id' => $students[0]->id, 'teacher_user_id' => $teachers[0]->id,
            'category' => 'positive', 'title' => 'Excellent participation',
            'note' => 'Helped classmates during group work today.',
        ]);
        ConductLog::create([
            'student_user_id' => $students[1]->id, 'teacher_user_id' => $teachers[1]->id,
            'category' => 'warning', 'title' => 'Late to class',
            'note' => 'Arrived 10 minutes late without explanation.',
        ]);

        // Fees & invoices
        $tuition = FeeStructure::create(['name' => 'Monthly Tuition', 'billing_cycle' => 'monthly', 'amount' => 800, 'is_active' => true]);
        $bus = FeeStructure::create(['name' => 'Bus Service', 'billing_cycle' => 'monthly', 'amount' => 150, 'is_active' => true]);
        FeeStructure::create(['name' => 'Activity Fee', 'billing_cycle' => 'semester', 'amount' => 200, 'is_active' => true]);

        foreach ($students as $i => $s) {
            Invoice::create([
                'student_user_id' => $s->id, 'fee_structure_id' => $tuition->id,
                'invoice_no' => 'INV-'.str_pad((string) (2026000 + $i), 8, '0', STR_PAD_LEFT),
                'description' => 'Tuition - April 2026',
                'amount' => 800, 'due_date' => now()->addDays(10),
                'status' => $i % 3 === 0 ? 'paid' : 'pending',
                'paid_amount' => $i % 3 === 0 ? 800 : 0,
            ]);
            if ($i % 2 === 0) {
                Invoice::create([
                    'student_user_id' => $s->id, 'fee_structure_id' => $bus->id,
                    'invoice_no' => 'INV-'.str_pad((string) (2026100 + $i), 8, '0', STR_PAD_LEFT),
                    'description' => 'Bus - April 2026',
                    'amount' => 150, 'due_date' => now()->addDays(10),
                ]);
            }
        }

        // Calendar events
        CalendarEvent::create(['title' => 'Eid Holiday', 'type' => 'holiday', 'start_date' => '2026-04-21', 'end_date' => '2026-04-23']);
        CalendarEvent::create(['title' => 'Midterm Exams Begin', 'type' => 'exam', 'start_date' => '2026-05-04']);
        CalendarEvent::create(['title' => 'Parent-Teacher Conference', 'type' => 'event', 'start_date' => '2026-05-15']);

        // Announcements
        Announcement::create([
            'sender_user_id' => $admin->id, 'audience' => 'all',
            'title' => 'Welcome back from spring break',
            'body' => 'We hope everyone had a restful break. Classes resume normal schedule starting Monday.',
        ]);
        Announcement::create([
            'sender_user_id' => $admin->id, 'audience' => 'parents',
            'title' => 'Fee reminder',
            'body' => 'April tuition invoices are now available. Please settle by the due date.',
        ]);
    }

    private function makeUser(string $name, string $email, string $role): User
    {
        return User::create([
            'name' => $name, 'email' => $email,
            'password' => Hash::make('password'),
            'role' => $role, 'is_active' => true,
            'phone' => '+971 50 000 0000',
        ]);
    }
}
