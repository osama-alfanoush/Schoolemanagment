<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * Covers the student/parent "performance chart" endpoints, which are backed by
 * the shared, database-portable PerformanceChartService. Guards against
 * regressions of the bucketing math and the previous SQLite-only strftime()
 * implementation (which threw on PostgreSQL).
 */
class PerformanceChartTest extends TestCase
{
    use RefreshDatabase;

    /** @return array{0: User, 1: string} student + subject name, with two grades this month (81, 90 => 85.5%). */
    private function seedStudentWithGrades(): array
    {
        $classRoom = ClassRoom::factory()->create();
        $subject = Subject::factory()->create(['name' => 'Mathematics']);

        // A subject's monthly average spans its components; one grade per
        // (student, component) is enforced by a unique index.
        $components = GradeComponent::factory()->count(2)->create([
            'class_room_id' => $classRoom->id,
            'subject_id' => $subject->id,
            'max_score' => 100,
        ]);

        $student = User::factory()->student()->create();
        StudentProfile::factory()->create([
            'user_id' => $student->id,
            'class_room_id' => $classRoom->id,
        ]);

        foreach ([81, 90] as $i => $score) {
            Grade::factory()->create([
                'student_user_id' => $student->id,
                'grade_component_id' => $components[$i]->id,
                'score' => $score,
            ]);
        }

        return [$student, 'Mathematics'];
    }

    public function test_student_performance_chart_returns_monthly_averages(): void
    {
        [$student] = $this->seedStudentWithGrades();

        $response = $this->actingAs($student)->getJson('/api/student/performance-chart');

        $response->assertOk()
            ->assertJsonStructure(['labels', 'datasets' => [['subject', 'data']]]);

        $data = $response->json();
        $this->assertCount(6, $data['labels']);

        $dataset = collect($data['datasets'])->firstWhere('subject', 'Mathematics');
        $this->assertNotNull($dataset, 'Mathematics dataset should be present');
        $this->assertCount(6, $dataset['data']);
        // Current month (last bucket) = avg(81, 90) = 85.5
        $this->assertEquals(85.5, $dataset['data'][5]);
        // No grades five months ago
        $this->assertNull($dataset['data'][0]);
    }

    public function test_parent_performance_chart_matches_student(): void
    {
        [$child] = $this->seedStudentWithGrades();
        $parent = $this->loginAs('parentRole');
        $child->parents()->attach($parent);

        $response = $this->actingAs($parent)
            ->getJson("/api/parent/children/{$child->id}/performance-chart");

        $response->assertOk();
        $dataset = collect($response->json('datasets'))->firstWhere('subject', 'Mathematics');
        $this->assertNotNull($dataset);
        $this->assertEquals(85.5, $dataset['data'][5]);
    }

    public function test_student_without_class_returns_empty_datasets(): void
    {
        $student = User::factory()->student()->create();

        $response = $this->actingAs($student)->getJson('/api/student/performance-chart');

        $response->assertOk();
        $this->assertSame([], $response->json('datasets'));
        $this->assertCount(6, $response->json('labels'));
    }
}
