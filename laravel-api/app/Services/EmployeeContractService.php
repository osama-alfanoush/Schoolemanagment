<?php

namespace App\Services;

use App\Models\EmployeeContract;
use App\Models\StaffProfile;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class EmployeeContractService
{
    public function createOrRenew(StaffProfile $profile, array $data, int $actorId, ?EmployeeContract $renewedFrom = null, bool $allowOverlap = false): EmployeeContract
    {
        return DB::transaction(function () use ($profile, $data, $actorId, $renewedFrom, $allowOverlap) {
            $profile = StaffProfile::lockForUpdate()->findOrFail($profile->id);
            $this->assertNoOverlap($profile->id, $data['start_date'], $data['end_date'] ?? null, $renewedFrom?->id, $allowOverlap);

            if ($renewedFrom) {
                $renewedFrom = EmployeeContract::lockForUpdate()->findOrFail($renewedFrom->id);
                $renewedFrom->update(['is_current' => false, 'status' => 'superseded']);
            }
            if (($data['is_current'] ?? true) === true) {
                EmployeeContract::where('staff_profile_id', $profile->id)->where('is_current', true)
                    ->update(['is_current' => false]);
            }

            $contract = EmployeeContract::create([
                ...$data, 'staff_profile_id' => $profile->id, 'school_id' => $profile->school_id,
                'renewed_from_id' => $renewedFrom?->id, 'created_by' => $actorId,
                'is_current' => $data['is_current'] ?? true, 'status' => $data['status'] ?? 'active',
            ]);
            if ($contract->is_current) {
                $profile->update([
                    'contract_type' => $contract->contract_type,
                    'contract_start' => $contract->start_date,
                    'contract_end' => $contract->end_date,
                    'probation_days' => $contract->probation_days,
                    'probation_end' => $contract->probation_end,
                    'base_salary' => $contract->base_salary,
                    'payment_method' => $contract->payment_method,
                    'bank_name' => $contract->bank_name,
                    'bank_account' => $contract->bank_account,
                ]);
            }

            return $contract->fresh(['staffProfile.user:id,name']);
        });
    }

    public function assertNoOverlap(int $profileId, string $start, ?string $end, ?int $ignoreId = null, bool $allow = false): void
    {
        if ($allow) {
            return;
        }
        $query = EmployeeContract::where('staff_profile_id', $profileId)
            ->whereNotIn('status', ['terminated', 'cancelled'])
            ->where('start_date', '<=', $end ?? '9999-12-31')
            ->where(fn ($q) => $q->whereNull('end_date')->orWhere('end_date', '>=', $start));
        if ($ignoreId) {
            $query->whereKeyNot($ignoreId);
        }
        if ($query->exists()) {
            throw ValidationException::withMessages(['start_date' => 'يوجد عقد فعّال متداخل مع هذه الفترة.']);
        }
    }
}
