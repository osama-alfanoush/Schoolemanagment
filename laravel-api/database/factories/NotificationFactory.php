<?php

namespace Database\Factories;

use App\Models\Notification;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class NotificationFactory extends Factory
{
    protected $model = Notification::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'type' => $this->faker->randomElement(['assignment_created', 'grade_posted', 'announcement']),
            'category' => $this->faker->randomElement(['academic', 'administrative', 'financial']),
            'priority' => 'normal',
            'title' => $this->faker->sentence,
            'body' => $this->faker->paragraph,
            'data' => null,
            'read_at' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }

    public function highPriority(): self
    {
        return $this->state(fn (array $attributes) => [
            'priority' => 'high',
        ]);
    }

    public function read(): self
    {
        return $this->state(fn (array $attributes) => [
            'read_at' => now(),
        ]);
    }
}
