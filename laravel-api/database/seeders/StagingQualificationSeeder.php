<?php

namespace Database\Seeders;

use App\Models\Organization;
use App\Models\School;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Services\CurrentSchool;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use RuntimeException;

class StagingQualificationSeeder extends Seeder
{
    public function run(): void
    {
        if (! app()->environment('staging')) {
            throw new RuntimeException('Staging qualification data may only be created in APP_ENV=staging.');
        }

        $password = (string) env('STAGING_QUALIFICATION_PASSWORD');
        if (strlen($password) < 16) {
            throw new RuntimeException('STAGING_QUALIFICATION_PASSWORD must contain at least 16 characters.');
        }

        $organization = Organization::query()->firstOrFail();
        $schoolA = School::query()->orderBy('id')->firstOrFail();
        $schoolB = School::query()->firstOrCreate(
            ['code' => 'STAGING-B'],
            [
                'organization_id' => $organization->id,
                'name' => 'Staging Qualification School B',
                'timezone' => 'Asia/Damascus',
                'is_active' => true,
            ],
        );

        $this->call(PermissionSeeder::class);

        foreach (User::ROLES as $role) {
            $user = User::query()->updateOrCreate(
                ['email' => "{$role}.school-b@staging.school.test"],
                [
                    'name' => "Staging {$role} School B",
                    'password' => Hash::make($password),
                    'role' => $role,
                    'is_active' => true,
                    'must_change_password' => false,
                ],
            );

            $user->schoolRoles()->updateOrCreate(
                ['school_id' => $schoolB->id],
                ['role' => $role],
            );
        }

        $context = app(CurrentSchool::class);
        $context->run($schoolA->id, fn () => WarehouseCategory::query()->firstOrCreate(['name' => 'Qualification School A']));
        $context->run($schoolB->id, fn () => WarehouseCategory::query()->firstOrCreate(['name' => 'Qualification School B']));
    }
}
