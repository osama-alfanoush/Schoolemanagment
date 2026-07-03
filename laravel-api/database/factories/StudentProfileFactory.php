<?php

namespace Database\Factories;

use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<StudentProfile>
 */
class StudentProfileFactory extends Factory
{
    public function definition(): array
    {
        return [
            'user_id' => User::factory()->student(),
            'class_room_id' => ClassRoom::factory(),
            'admission_no' => 'STU-'.$this->faker->unique()->numerify('#####'),
            'date_of_birth' => $this->faker->dateTimeBetween('-20 years', '-5 years'),
            'gender' => $this->faker->randomElement(['male', 'female']),
            'address' => $this->faker->address(),
            'medical_notes' => null,
            'emergency_contact_name' => $this->faker->name(),
            'emergency_contact_phone' => $this->faker->phoneNumber(),
        ];
    }
}
