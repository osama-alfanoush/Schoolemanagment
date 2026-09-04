<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\Invoice;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Tests\TestCase;

class ParentFinanceTest extends TestCase
{
    use RefreshDatabase;

    private const SUMMARY = '/api/mobile/v1/parent/finance/summary';

    private const INVOICES = '/api/mobile/v1/parent/invoices';

    /* ---------- fixtures ---------- */

    /** @return array{parent: User, child: User} */
    private function family(string $name = 'ليان'): array
    {
        $parent = User::factory()->parentRole()->create();
        $child = User::factory()->student()->create(['name' => $name]);
        $child->parents()->attach($parent);
        StudentProfile::factory()->create(['user_id' => $child->id]);

        return ['parent' => $parent, 'child' => $child];
    }

    private function addChild(User $parent, string $name): User
    {
        $child = User::factory()->student()->create(['name' => $name]);
        $child->parents()->attach($parent);
        StudentProfile::factory()->create(['user_id' => $child->id]);

        return $child;
    }

    private function schoolId(): int
    {
        return (int) DB::table('schools')->value('id');
    }

    /**
     * A plan for [$child] whose installments are [$amounts], one per month.
     *
     * @param  list<string>  $amounts
     * @return list<int> the installment ids, in order
     */
    private function planFor(User $child, array $amounts, string $firstDue = '+10 days'): array
    {
        $total = 0;
        foreach ($amounts as $amount) {
            $total += (int) round((float) $amount * 100);
        }

        $planId = DB::table('payment_plans')->insertGetId([
            'school_id' => $this->schoolId(),
            'plan_no' => 'PLAN-'.$child->id.'-'.Str::random(6),
            'student_user_id' => $child->id,
            'total_amount' => number_format($total / 100, 2, '.', ''),
            'num_installments' => count($amounts),
            'start_date' => now()->modify($firstDue)->toDateString(),
            'status' => 'active',
            'created_by' => $child->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $ids = [];
        foreach ($amounts as $index => $amount) {
            $ids[] = DB::table('installments')->insertGetId([
                'school_id' => $this->schoolId(),
                'payment_plan_id' => $planId,
                'sequence_no' => $index + 1,
                'due_date' => now()->modify($firstDue)->addMonths($index)->toDateString(),
                'amount' => $amount,
                'paid_amount' => '0.00',
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        return $ids;
    }

    private function key(): string
    {
        return (string) Str::uuid();
    }

    /* ---------- family summary ---------- */

    public function test_three_siblings_are_allocated_separately_not_lumped_together(): void
    {
        // One guardian, three children. A single family total is what sends a
        // parent to the office to ask which child the money is for.
        ['parent' => $parent, 'child' => $first] = $this->family('ليان');
        $second = $this->addChild($parent, 'يوسف');
        $third = $this->addChild($parent, 'رهف');

        Invoice::factory()->create(['student_user_id' => $first->id, 'amount' => 100.00, 'paid_amount' => 0]);
        Invoice::factory()->create(['student_user_id' => $second->id, 'amount' => 250.00, 'paid_amount' => 50.00]);
        Invoice::factory()->create(['student_user_id' => $third->id, 'amount' => 75.25, 'paid_amount' => 75.25]);

        $data = $this->actingAs($parent)->getJson(self::SUMMARY)->assertOk()->json('data');

        $byChild = collect($data['children'])->keyBy('student_user_id');

        $this->assertSame(100000, $byChild[$first->id]['billed']['minor']);
        $this->assertSame(100000, $byChild[$first->id]['outstanding']['minor']);
        $this->assertSame(250000, $byChild[$second->id]['billed']['minor']);
        $this->assertSame(200000, $byChild[$second->id]['outstanding']['minor']);
        $this->assertSame(0, $byChild[$third->id]['outstanding']['minor']);

        // And the family total is the sum of the three, to the fil.
        $this->assertSame(425250, $data['total']['minor']);
        $this->assertSame(300000, $data['total_outstanding']['minor']);
    }

    public function test_every_amount_is_integer_minor_units_and_never_a_float(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        Invoice::factory()->create(['student_user_id' => $child->id, 'amount' => 12.55, 'paid_amount' => 0]);
        $this->planFor($child, ['12.55']);

        foreach ([self::SUMMARY, self::INVOICES] as $endpoint) {
            $body = $this->actingAs($parent)->getJson($endpoint)->assertOk()->json();

            // Walk the whole payload: any float anywhere on this path is a fil
            // waiting to go missing.
            $this->assertNoFloats($body, $endpoint);
        }

        $summary = $this->actingAs($parent)->getJson(self::SUMMARY)->assertOk();
        // 12.55 JOD is 12 550 fils, not 1 255.
        $summary->assertJsonPath('data.children.0.billed.minor', 12550);
        $summary->assertJsonPath('data.children.0.billed.decimals', 3);
        $summary->assertJsonPath('data.children.0.billed.currency', 'JOD');
    }

    private function assertNoFloats(mixed $node, string $where, string $path = ''): void
    {
        if (is_float($node)) {
            $this->fail("Float found at {$where}{$path}.");
        }
        if (! is_array($node)) {
            return;
        }
        foreach ($node as $key => $value) {
            $this->assertNoFloats($value, $where, $path.'.'.$key);
        }
    }

    public function test_a_guardian_with_no_children_gets_zeroes_not_an_error(): void
    {
        $parent = User::factory()->parentRole()->create();

        $this->actingAs($parent)
            ->getJson(self::SUMMARY)
            ->assertOk()
            ->assertJsonPath('data.children', [])
            ->assertJsonPath('data.total_outstanding.minor', 0);
    }

    /* ---------- installments ---------- */

    public function test_installments_sum_exactly_to_the_plan_total_in_fils(): void
    {
        // 100.00 split three ways is where a schedule stops adding up.
        ['parent' => $parent, 'child' => $child] = $this->family();
        $this->planFor($child, ['33.34', '33.33', '33.33']);

        $plan = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/installments")
            ->assertOk()
            ->json('data.plans.0');

        $sum = array_sum(array_column(array_column($plan['installments'], 'amount'), 'minor'));

        $this->assertSame($plan['total']['minor'], $sum);
        $this->assertSame(100000, $sum);
        $this->assertTrue($plan['reconciles']);
    }

    public function test_a_schedule_that_does_not_add_up_says_so_rather_than_hiding_it(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        $this->planFor($child, ['33.34', '33.33', '33.33']);
        // A plan total that disagrees with its parts. Someone will be billed
        // wrongly from this, and the client should be able to surface it.
        DB::table('payment_plans')->update(['total_amount' => '120.00']);

        $plan = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/installments")
            ->assertOk()
            ->json('data.plans.0');

        $this->assertFalse($plan['reconciles']);
    }

    public function test_a_guardian_cannot_read_another_familys_schedule(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirs] = $this->family('سلمى');
        $this->planFor($theirs, ['50.00']);

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/children/{$theirs->id}/installments")
            ->assertStatus(403);

        $this->assertDatabaseHas('audit_logs', ['action' => 'authorization_denied']);
    }

    /* ---------- invoices ---------- */

    public function test_an_uncleared_invoice_never_carries_a_qr(): void
    {
        // There is no e-invoicing integration in this system. A QR is a signed
        // artefact the tax authority returns; generating one here would produce
        // a code that scans, looks official, and verifies against nothing.
        ['parent' => $parent, 'child' => $child] = $this->family();
        $invoice = Invoice::factory()->create(['student_user_id' => $child->id]);

        $body = $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/invoices/{$invoice->id}")
            ->assertOk()
            ->json('data');

        $this->assertSame('pending', $body['clearance']['state']);
        $this->assertArrayNotHasKey('qr', $body['clearance']);
        $this->assertArrayNotHasKey('qr', $body);
        $this->assertStringNotContainsString('qr', strtolower((string) json_encode($body)));
    }

    public function test_another_parents_invoice_is_refused(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');
        $theirs = Invoice::factory()->create(['student_user_id' => $theirChild->id]);

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/invoices/{$theirs->id}")
            ->assertStatus(403);
    }

    public function test_a_missing_invoice_is_refused_the_same_way_as_anothers(): void
    {
        // Answering 404 for one and 403 for the other would let a guardian map
        // which invoice ids exist.
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');
        $theirs = Invoice::factory()->create(['student_user_id' => $theirChild->id]);

        $forbidden = $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/invoices/{$theirs->id}");
        $missing = $this->actingAs($mine)
            ->getJson('/api/mobile/v1/parent/invoices/999999');

        $this->assertSame($forbidden->status(), $missing->status());
        $this->assertSame($forbidden->json('message'), $missing->json('message'));
    }

    public function test_the_invoice_list_holds_only_this_guardians_children(): void
    {
        ['parent' => $mine, 'child' => $myChild] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');
        $mineInvoice = Invoice::factory()->create(['student_user_id' => $myChild->id]);
        $theirsInvoice = Invoice::factory()->create(['student_user_id' => $theirChild->id]);

        $ids = array_column(
            $this->actingAs($mine)->getJson(self::INVOICES)->assertOk()->json('data.invoices'),
            'id',
        );

        $this->assertSame([$mineInvoice->id], $ids);
        $this->assertNotContains($theirsInvoice->id, $ids);
    }

    /* ---------- payment intent ---------- */

    private function intentUrl(int $installmentId): string
    {
        return "/api/mobile/v1/parent/pay/{$installmentId}/intent";
    }

    public function test_five_identical_intents_with_one_key_produce_exactly_one(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);
        $key = $this->key();

        $responses = [];
        for ($i = 0; $i < 5; $i++) {
            $responses[] = $this->actingAs($parent)
                ->withHeader('Idempotency-Key', $key)
                ->postJson($this->intentUrl($installmentId));
        }

        // Exactly one row, whatever the client did.
        $this->assertSame(1, DB::table('mobile_payment_intents')->count());

        // The first answer is 201 and every replay is 200, but all five carry
        // the same body — a client that missed the first is not told anything
        // different by the retry that reached it.
        $this->assertSame(201, $responses[0]->status());
        $reference = $responses[0]->json('data.reference');
        foreach (array_slice($responses, 1) as $replay) {
            $this->assertSame(200, $replay->status());
            $this->assertSame($reference, $replay->json('data.reference'));
        }
    }

    public function test_the_database_refuses_a_duplicate_key_not_just_the_application(): void
    {
        // A check-then-insert can be passed by two requests at once; a unique
        // index can be won by only one. This asserts the constraint is real.
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);
        $key = $this->key();

        $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson($this->intentUrl($installmentId))
            ->assertStatus(201);

        $row = (array) DB::table('mobile_payment_intents')->first();
        unset($row['id']);
        $row['reference'] = 'PAY-DIFFERENT';

        $this->expectException(\Illuminate\Database\QueryException::class);
        DB::table('mobile_payment_intents')->insert($row);
    }

    public function test_two_different_keys_are_two_intents(): void
    {
        // The key is what collapses retries. Two genuine attempts must not be
        // collapsed just because they are for the same installment.
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);

        foreach ([$this->key(), $this->key()] as $key) {
            $this->actingAs($parent)
                ->withHeader('Idempotency-Key', $key)
                ->postJson($this->intentUrl($installmentId))
                ->assertStatus(201);
        }

        $this->assertSame(2, DB::table('mobile_payment_intents')->count());
    }

    public function test_a_key_replayed_against_a_different_installment_is_refused(): void
    {
        // Paying a different amount under a spent key is the exact failure
        // idempotency exists to prevent.
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$first, $second] = $this->planFor($child, ['150.00', '75.00']);
        $key = $this->key();

        $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson($this->intentUrl($first))
            ->assertStatus(201);

        $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson($this->intentUrl($second))
            ->assertStatus(409);

        $this->assertSame(1, DB::table('mobile_payment_intents')->count());
    }

    public function test_an_intent_without_an_idempotency_key_is_refused(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);

        $this->actingAs($parent)
            ->postJson($this->intentUrl($installmentId))
            ->assertStatus(422);

        $this->assertSame(0, DB::table('mobile_payment_intents')->count());
    }

    public function test_the_intent_amount_is_what_is_still_outstanding(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);
        DB::table('installments')->where('id', $installmentId)
            ->update(['paid_amount' => '25.50', 'status' => 'partial']);

        $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $this->key())
            ->postJson($this->intentUrl($installmentId))
            ->assertStatus(201)
            // 150.00 - 25.50 = 124.50 JOD = 124 500 fils.
            ->assertJsonPath('data.amount.minor', 124500)
            ->assertJsonPath('data.amount.decimals', 3);
    }

    public function test_a_settled_installment_cannot_be_paid_again(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);
        DB::table('installments')->where('id', $installmentId)
            ->update(['paid_amount' => '150.00', 'status' => 'paid']);

        $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $this->key())
            ->postJson($this->intentUrl($installmentId))
            ->assertStatus(422);

        $this->assertSame(0, DB::table('mobile_payment_intents')->count());
    }

    public function test_a_guardian_cannot_pay_another_familys_installment(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');
        [$theirInstallment] = $this->planFor($theirChild, ['150.00']);

        $this->actingAs($mine)
            ->withHeader('Idempotency-Key', $this->key())
            ->postJson($this->intentUrl($theirInstallment))
            ->assertStatus(403);

        $this->assertSame(0, DB::table('mobile_payment_intents')->count());
        $this->assertDatabaseHas('audit_logs', ['action' => 'authorization_denied']);
    }

    public function test_the_idempotency_key_never_travels_back_out(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        [$installmentId] = $this->planFor($child, ['150.00']);
        $key = $this->key();

        $body = (string) $this->actingAs($parent)
            ->withHeader('Idempotency-Key', $key)
            ->postJson($this->intentUrl($installmentId))
            ->assertStatus(201)
            ->getContent();

        $this->assertStringNotContainsString($key, $body);
        $this->assertStringNotContainsString('request_hash', $body);
    }

    /* ---------- receipts ---------- */

    private function receiptFor(User $child, string $status = 'posted'): int
    {
        return DB::table('payment_receipts')->insertGetId([
            'school_id' => $this->schoolId(),
            'receipt_no' => 'RCT-'.Str::random(8),
            'student_user_id' => $child->id,
            'amount' => '150.00',
            'method' => 'cash',
            'receipt_date' => now()->toDateString(),
            'status' => $status,
            'idempotency_key' => (string) Str::uuid(),
            'idempotency_payload_hash' => str_repeat('a', 64),
            'created_by' => $child->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    public function test_a_guardian_downloads_a_posted_receipt_for_their_own_child(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        $receiptId = $this->receiptFor($child);

        $response = $this->actingAs($parent)
            ->get("/api/mobile/v1/parent/receipts/{$receiptId}/pdf");

        $response->assertOk();
        $this->assertStringContainsString('application/pdf', (string) $response->headers->get('Content-Type'));
    }

    public function test_a_draft_receipt_is_not_downloadable(): void
    {
        // A draft is a finance clerk's working document, not proof of anything.
        // A parent who files one has been given something still reversible.
        ['parent' => $parent, 'child' => $child] = $this->family();
        $receiptId = $this->receiptFor($child, 'draft');

        $this->actingAs($parent)
            ->get("/api/mobile/v1/parent/receipts/{$receiptId}/pdf")
            ->assertStatus(403);
    }

    public function test_another_familys_receipt_is_refused(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');
        $receiptId = $this->receiptFor($theirChild);

        $this->actingAs($mine)
            ->get("/api/mobile/v1/parent/receipts/{$receiptId}/pdf")
            ->assertStatus(403);
    }

    /* ---------- roles ---------- */

    public function test_a_teacher_cannot_reach_the_finance_surface(): void
    {
        $teacher = User::factory()->teacher()->create();

        foreach ([self::SUMMARY, self::INVOICES] as $endpoint) {
            $this->actingAs($teacher)->getJson($endpoint)->assertStatus(403);
        }
    }
}
