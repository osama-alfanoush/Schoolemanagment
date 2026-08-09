<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Models\School;
use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;

class ProvisionAdmin extends Command
{
    protected $signature = 'school:provision-admin {email} {--name=School Administrator} {--school= : School ID}';

    protected $description = 'Create the first production administrator without demo credentials';

    public function handle(): int
    {
        $email = (string) $this->argument('email');
        $school = $this->resolveSchool();
        if (! $school) {
            return self::FAILURE;
        }

        $password = (string) $this->secret('Enter a unique administrator password');
        $confirmation = (string) $this->secret('Confirm the administrator password');

        $validator = Validator::make([
            'email' => $email,
            'password' => $password,
            'password_confirmation' => $confirmation,
        ], [
            'email' => ['required', 'email:rfc,strict', 'unique:users,email'],
            'password' => [
                'required',
                'confirmed',
                Password::min(12)->mixedCase()->numbers()->symbols(),
            ],
        ]);

        if ($validator->fails()) {
            foreach ($validator->errors()->all() as $error) {
                $this->error($error);
            }

            return self::FAILURE;
        }

        DB::transaction(function () use ($email, $password, $school): void {
            $user = User::create([
                'name' => (string) $this->option('name'),
                'email' => $email,
                'password' => Hash::make($password),
                'role' => 'admin',
                'is_active' => true,
                'must_change_password' => false,
            ]);
            $user->schoolRoles()->create([
                'school_id' => $school->id,
                'role' => 'admin',
                'starts_on' => now()->toDateString(),
            ]);
        });

        $this->info("Administrator {$email} created for school {$school->name} ({$school->id}).");

        return self::SUCCESS;
    }

    private function resolveSchool(): ?School
    {
        $schoolId = $this->option('school');
        if ($schoolId !== null) {
            $school = School::query()->whereKey($schoolId)->where('is_active', true)->first();
            if (! $school) {
                $this->error('The requested active school does not exist.');
            }

            return $school;
        }

        $schools = School::query()->where('is_active', true)->limit(2)->get();
        if ($schools->count() !== 1) {
            $this->error('Use --school=<id> when the database does not contain exactly one active school.');

            return null;
        }

        return $schools->first();
    }
}
