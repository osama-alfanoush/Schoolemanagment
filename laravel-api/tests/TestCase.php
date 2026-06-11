<?php

namespace Tests;

use App\Models\User;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Laravel\Sanctum\Sanctum;

abstract class TestCase extends BaseTestCase
{
    protected function loginAs(string $role): User
    {
        $user = User::factory()->{$role}()->create();
        Sanctum::actingAs($user, ['*']);
        return $user;
    }

    protected function assertApiSuccess($response, int $status = 200): void
    {
        $response->assertStatus($status)->assertJsonStructure(['data']);
    }

    protected function assertPaginated($response): void
    {
        $response->assertOk()->assertJsonStructure([
            'data',
            'meta' => ['current_page', 'last_page', 'per_page', 'total'],
        ]);
    }
}