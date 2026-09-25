<?php

namespace Tests;

use App\Models\User;
use Illuminate\Foundation\Testing\TestCase as BaseTestCase;

abstract class TestCase extends BaseTestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        config(['mfa.enabled' => false]);
    }

    protected function loginAs(string $role): User
    {
        return User::factory()->{$role}()->create();
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
