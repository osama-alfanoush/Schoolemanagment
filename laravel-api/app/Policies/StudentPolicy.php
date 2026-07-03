<?php

declare(strict_types=1);

namespace App\Policies;

use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class StudentPolicy
{
    use HandlesAuthorization;

    /**
     * Determine if the parent can view the student.
     */
    public function view(User $user, User $student): bool
    {
        return $user->children()->where('users.id', $student->id)->exists();
    }

    /**
     * Determine if the parent can view the student's grades.
     */
    public function viewGrades(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's assignments.
     */
    public function viewAssignments(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's attendance.
     */
    public function viewAttendance(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's invoices.
     */
    public function viewInvoices(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's payments.
     */
    public function viewPayments(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's conduct.
     */
    public function viewConduct(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's report card.
     */
    public function viewReportCard(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's performance chart.
     */
    public function viewPerformanceChart(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's medical records.
     */
    public function viewMedical(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's transport info.
     */
    public function viewTransport(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }

    /**
     * Determine if the parent can view the student's invoice receipt.
     */
    public function viewReceipt(User $user, User $student): bool
    {
        return $this->view($user, $student);
    }
}
