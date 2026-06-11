<?php

namespace Database\Factories;

use App\Models\GradeComponent;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Grade>
 */
class GradeFactory extends Factory
{
    public function definition(): array
    {
        $component = GradeComponent::factory()->create();
        return [
            'student_user_id' => User::factory()->student(),
            'grade_component_id' => $component->id,
            'score' => $this->faker->randomFloat(2, 0, $component->max_score),
            'entered_by' => User::factory()->teacher(),
        ];
    }
}