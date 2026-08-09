<?php

namespace App\Services;

use App\Models\Installment;

class InstallmentReminderService
{
    /**
     * Notify students/parents about installments due within 3 days or overdue.
     * Skips rows reminded in the last 2 days so daily runs don't spam.
     * Returns the number of reminders sent.
     */
    public function send(): int
    {
        $targets = Installment::with(['plan.student.parents'])
            ->whereIn('status', ['pending', 'partial', 'overdue'])
            ->where('due_date', '<=', now()->addDays(3)->toDateString())
            ->where(function ($q) {
                $q->whereNull('reminder_sent_at')->orWhere('reminder_sent_at', '<', now()->subDays(2));
            })
            ->get();

        $sent = 0;
        foreach ($targets as $inst) {
            $student = $inst->plan->student;
            $recipients = $student->parents->pluck('id')->push($student->id)->unique()->all();
            NotificationService::sendToMany($recipients, 'installment_due', [
                'sequence_no' => $inst->sequence_no,
                'plan_no' => $inst->plan->plan_no,
                'plan_id' => $inst->plan->id,
                'student_name' => $student->name,
                'amount' => number_format((float) $inst->amount - (float) $inst->paid_amount, 2),
                'due_date' => $inst->due_date->toDateString(),
            ]);
            $inst->update(['reminder_sent_at' => now()]);
            $sent++;
        }

        return $sent;
    }
}
