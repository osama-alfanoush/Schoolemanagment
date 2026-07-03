<?php

namespace Database\Seeders;

use App\Models\StaffProfile;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DemoRoleUsersSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            ['name' => 'Sara Admin', 'email' => 'admin@school.test', 'role' => 'admin', 'department' => 'Administration', 'position' => 'Administrator'],
            ['name' => 'Fadi Finance', 'email' => 'finance@school.test', 'role' => 'finance', 'department' => 'Finance', 'position' => 'Finance Officer'],
            ['name' => 'Hala HR', 'email' => 'hr@school.test', 'role' => 'hr', 'department' => 'Human Resources', 'position' => 'HR Officer'],
            ['name' => 'Amina Accountant', 'email' => 'accounting@school.test', 'role' => 'finance', 'department' => 'Accounting', 'position' => 'Accountant'],
            ['name' => 'Omar Warehouse', 'email' => 'warehouse@school.test', 'role' => 'warehouse', 'department' => 'Warehouse', 'position' => 'Warehouse Manager'],
        ];

        foreach ($users as $data) {
            $user = User::updateOrCreate(
                ['email' => $data['email']],
                [
                    'name' => $data['name'],
                    'password' => Hash::make('password'),
                    'role' => $data['role'],
                    'is_active' => true,
                    'phone' => '+971 50 000 0000',
                ],
            );

            StaffProfile::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'department' => $data['department'],
                    'position' => $data['position'],
                    'hire_date' => now()->subYears(2)->toDateString(),
                    'contract_type' => 'full-time',
                    'base_salary' => 4000,
                    'annual_leave_balance' => 20,
                    'sick_leave_balance' => 10,
                ],
            );
        }
    }
}
