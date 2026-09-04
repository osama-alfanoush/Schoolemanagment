<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Installment;
use App\Models\Invoice;
use App\Models\MobilePaymentIntent;
use App\Models\PaymentReceipt;
use App\Models\User;
use App\Services\AuditLogger;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

/**
 * The fees a guardian owes, and the intent to pay one of them.
 *
 * This is the screen the product is sold on, so two rules run through all of
 * it:
 *
 *  - **Every amount is integer minor units.** The relational columns are
 *    `decimal(12,2)` and the SQLite driver hands those back as floats, so the
 *    conversion happens once, at the boundary, through `MobileMoney`. Nothing
 *    downstream ever sees a float, and nothing is divided to format it.
 *  - **Nothing about clearance is invented.** The QR on a cleared invoice is
 *    the authority's, or there is no QR field at all.
 */
final class ParentFinanceService
{
    /** Statuses that still owe money. */
    private const UNPAID = ['pending', 'partial', 'overdue'];

    /**
     * Family-level totals plus a line per child.
     *
     * Batched across every child, so three siblings cost what one does.
     *
     * @param  list<int>  $childIds
     * @return array<string, mixed>
     */
    public function summary(array $childIds, int $schoolId): array
    {
        if ($childIds === []) {
            return [
                'children' => [],
                'total' => self::money(0),
                'total_outstanding' => self::money(0),
                'overdue_count' => 0,
            ];
        }

        $names = User::query()->whereIn('id', $childIds)->pluck('name', 'id');

        $invoiceRows = DB::table('invoices')
            ->whereIn('student_user_id', $childIds)
            ->where('school_id', $schoolId)
            ->whereNot('status', 'cancelled')
            ->get(['student_user_id', 'amount', 'paid_amount']);

        $installmentRows = DB::table('installments')
            ->join('payment_plans', 'payment_plans.id', '=', 'installments.payment_plan_id')
            ->where('payment_plans.school_id', $schoolId)
            ->whereNull('payment_plans.deleted_at')
            ->whereIn('payment_plans.student_user_id', $childIds)
            ->get([
                'payment_plans.student_user_id',
                'installments.due_date',
                'installments.amount',
                'installments.paid_amount',
                'installments.status',
            ]);

        $today = Carbon::today();
        $perChild = [];

        foreach ($childIds as $childId) {
            $perChild[$childId] = [
                'student_user_id' => $childId,
                'name' => $names[$childId] ?? null,
                'billed_minor' => 0,
                'paid_minor' => 0,
                'outstanding_minor' => 0,
                'overdue_count' => 0,
                'overdue_minor' => 0,
            ];
        }

        foreach ($invoiceRows as $row) {
            $childId = (int) $row->student_user_id;
            if (! isset($perChild[$childId])) {
                continue;
            }

            $perChild[$childId]['billed_minor'] += MobileMoney::minorOf($row->amount);
            $perChild[$childId]['paid_minor'] += MobileMoney::minorOf($row->paid_amount);
        }

        foreach ($installmentRows as $row) {
            $childId = (int) $row->student_user_id;
            if (! isset($perChild[$childId]) || ! in_array($row->status, self::UNPAID, true)) {
                continue;
            }

            $due = MobileMoney::minorOf($row->amount) - MobileMoney::minorOf($row->paid_amount);
            if ($due <= 0) {
                continue;
            }

            if (Carbon::parse($row->due_date)->startOfDay()->lt($today)) {
                $perChild[$childId]['overdue_count']++;
                $perChild[$childId]['overdue_minor'] += $due;
            }
        }

        $children = [];
        $totalBilled = 0;
        $totalOutstanding = 0;
        $overdueCount = 0;

        foreach ($perChild as $childId => $line) {
            $outstanding = max(0, $line['billed_minor'] - $line['paid_minor']);
            $totalBilled += $line['billed_minor'];
            $totalOutstanding += $outstanding;
            $overdueCount += $line['overdue_count'];

            $children[] = [
                'student_user_id' => $childId,
                'name' => $line['name'],
                // Per child, so a guardian with three siblings can see which
                // one the money is for. A single family total is the thing
                // that sends a parent to the office to ask.
                'billed' => self::money($line['billed_minor']),
                'paid' => self::money($line['paid_minor']),
                'outstanding' => self::money($outstanding),
                'overdue' => self::money($line['overdue_minor']),
                'overdue_count' => $line['overdue_count'],
            ];
        }

        return [
            'children' => $children,
            'total' => self::money($totalBilled),
            'total_outstanding' => self::money($totalOutstanding),
            'overdue_count' => $overdueCount,
        ];
    }

    /**
     * Every installment for one child, with the plan it belongs to.
     *
     * @return array<string, mixed>
     */
    public function installmentsFor(int $childId, int $schoolId): array
    {
        $rows = DB::table('installments')
            ->join('payment_plans', 'payment_plans.id', '=', 'installments.payment_plan_id')
            ->where('payment_plans.school_id', $schoolId)
            ->whereNull('payment_plans.deleted_at')
            ->where('payment_plans.student_user_id', $childId)
            ->orderBy('payment_plans.id')
            ->orderBy('installments.sequence_no')
            ->get([
                'installments.id',
                'installments.payment_plan_id',
                'installments.sequence_no',
                'installments.due_date',
                'installments.amount',
                'installments.paid_amount',
                'installments.status',
                'installments.paid_at',
                'payment_plans.plan_no',
                'payment_plans.total_amount',
                'payment_plans.invoice_id',
                'payment_plans.status as plan_status',
            ]);

        $today = Carbon::today();
        $plans = [];

        foreach ($rows as $row) {
            $planId = (int) $row->payment_plan_id;
            $plans[$planId] ??= [
                'id' => $planId,
                'plan_no' => $row->plan_no,
                'invoice_id' => $row->invoice_id === null ? null : (int) $row->invoice_id,
                'status' => $row->plan_status,
                'total' => self::money(MobileMoney::minorOf($row->total_amount)),
                'installments' => [],
                'installments_total_minor' => 0,
            ];

            $amountMinor = MobileMoney::minorOf($row->amount);
            $paidMinor = MobileMoney::minorOf($row->paid_amount);
            $due = Carbon::parse($row->due_date)->startOfDay();
            $unpaid = in_array($row->status, self::UNPAID, true);

            $plans[$planId]['installments_total_minor'] += $amountMinor;
            $plans[$planId]['installments'][] = [
                'id' => (int) $row->id,
                'sequence_no' => (int) $row->sequence_no,
                'due_date' => $due->toDateString(),
                'amount' => self::money($amountMinor),
                'paid' => self::money($paidMinor),
                'outstanding' => self::money(max(0, $amountMinor - $paidMinor)),
                'status' => $row->status,
                'days_remaining' => (int) $today->diffInDays($due, false),
                'overdue' => $unpaid && $due->lt($today),
                'payable' => $unpaid && $amountMinor > $paidMinor,
                'paid_at' => $row->paid_at === null
                    ? null
                    : Carbon::parse($row->paid_at)->toIso8601String(),
            ];
        }

        return [
            'student_user_id' => $childId,
            'plans' => array_map(
                static function (array $plan): array {
                    // Stated, not assumed. A schedule whose parts do not add up
                    // to the plan total is a schedule someone will be billed
                    // wrongly from, and the client can surface it rather than
                    // quietly showing numbers that disagree.
                    $plan['installments_total'] = self::money($plan['installments_total_minor']);
                    $plan['reconciles'] = $plan['installments_total_minor'] === $plan['total']['minor'];
                    unset($plan['installments_total_minor']);

                    return $plan;
                },
                array_values($plans),
            ),
        ];
    }

    /**
     * Invoices across a guardian's children.
     *
     * @param  list<int>  $childIds
     * @return list<array<string, mixed>>
     */
    public function invoices(array $childIds, int $schoolId, int $limit = 50): array
    {
        if ($childIds === []) {
            return [];
        }

        return Invoice::query()
            ->whereIn('student_user_id', $childIds)
            ->where('school_id', $schoolId)
            ->orderByDesc('due_date')
            ->orderByDesc('id')
            ->limit($limit)
            ->get()
            ->map(fn (Invoice $invoice): array => $this->invoicePayload($invoice))
            ->all();
    }

    /** @return array<string, mixed> */
    public function invoicePayload(Invoice $invoice): array
    {
        $amount = MobileMoney::minorOf($invoice->getRawOriginal('amount'));
        $paid = MobileMoney::minorOf($invoice->getRawOriginal('paid_amount'));

        return [
            'id' => $invoice->id,
            'student_user_id' => (int) $invoice->student_user_id,
            'invoice_no' => $invoice->invoice_no,
            'description' => $invoice->description,
            'amount' => self::money($amount),
            'paid' => self::money($paid),
            'outstanding' => self::money(max(0, $amount - $paid)),
            'due_date' => $invoice->due_date?->toDateString(),
            'status' => $invoice->status,
        ] + self::clearance();
    }

    /**
     * The e-invoicing clearance block.
     *
     * **There is no clearance integration in this system yet.** No JoFotara
     * client, no submission, no authority response — so nothing has been
     * cleared, the state is `pending`, and there is no `qr` key at all.
     *
     * A QR is a signed artefact the tax authority returns. Generating one here
     * from the invoice's own fields would produce a code that scans, looks
     * official, and verifies against nothing. The field is absent until there
     * is a real one to put in it.
     *
     * @return array<string, mixed>
     */
    private static function clearance(): array
    {
        return [
            'clearance' => [
                'state' => 'pending',
                'cleared_at' => null,
            ],
        ];
    }

    /**
     * Creates — or returns — the intent for this idempotency key.
     *
     * The unique index on the key is what makes this safe, not a check
     * followed by an insert: two requests can both pass a check, and only one
     * can win a unique index.
     *
     * @return array{intent: MobilePaymentIntent, created: bool}
     *
     * @throws IdempotencyConflict when the key was used with a different body.
     * @throws UnpayableInstallment
     */
    public function createIntent(
        Request $request,
        User $guardian,
        Installment $installment,
        string $idempotencyKey,
        int $schoolId,
    ): array {
        $amountMinor = MobileMoney::minorOf($installment->getRawOriginal('amount'))
            - MobileMoney::minorOf($installment->getRawOriginal('paid_amount'));

        if (! in_array($installment->status, self::UNPAID, true) || $amountMinor <= 0) {
            throw new UnpayableInstallment;
        }

        $studentId = (int) DB::table('payment_plans')
            ->where('id', $installment->payment_plan_id)
            ->value('student_user_id');

        $hash = hash('sha256', (string) json_encode([
            'installment_id' => $installment->id,
            'guardian_user_id' => $guardian->id,
            'amount_minor' => $amountMinor,
        ]));

        $existing = MobilePaymentIntent::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            return ['intent' => $this->assertSameRequest($existing, $hash), 'created' => false];
        }

        try {
            $intent = MobilePaymentIntent::query()->create([
                'school_id' => $schoolId,
                'idempotency_key' => $idempotencyKey,
                'request_hash' => $hash,
                'reference' => 'PAY-'.strtoupper(Str::random(12)),
                'guardian_user_id' => $guardian->id,
                'student_user_id' => $studentId,
                'installment_id' => $installment->id,
                'amount_minor' => $amountMinor,
                'currency' => strtoupper((string) config('mobile.currency', 'JOD')),
                'decimals' => (int) config('mobile.currency_decimals', 3),
            ]);
        } catch (QueryException $e) {
            // Lost the race for the unique index. The winner's row is the
            // answer — that is the whole point of the constraint.
            $winner = MobilePaymentIntent::query()
                ->where('idempotency_key', $idempotencyKey)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            return ['intent' => $this->assertSameRequest($winner, $hash), 'created' => false];
        }

        AuditLogger::log($request, 'mobile_payment_intent_created', 'mobile_payment_intent', $intent->id, [
            'installment_id' => $installment->id,
            'student_user_id' => $studentId,
        ], $guardian->id);

        return ['intent' => $intent, 'created' => true];
    }

    /** @throws IdempotencyConflict */
    private function assertSameRequest(MobilePaymentIntent $intent, string $hash): MobilePaymentIntent
    {
        // Same key, same body is the retry this exists to absorb. Same key,
        // different body is a bug or an attack, and paying a different amount
        // under a spent key is exactly what must not happen.
        if (! hash_equals($intent->request_hash, $hash)) {
            throw new IdempotencyConflict;
        }

        return $intent;
    }

    /** @return array<string, mixed> */
    public function intentPayload(MobilePaymentIntent $intent): array
    {
        return [
            'reference' => $intent->reference,
            'installment_id' => $intent->installment_id,
            'student_user_id' => $intent->student_user_id,
            'amount' => [
                'minor' => $intent->amount_minor,
                'currency' => $intent->currency,
                'decimals' => $intent->decimals,
            ],
            'status' => $intent->status,
            'created_at' => $intent->created_at?->toIso8601String(),
        ];
    }

    /**
     * A receipt a guardian is allowed to download.
     *
     * Only a posted receipt: a draft is a finance clerk's working document,
     * not proof of anything, and a parent who downloads one and files it has
     * been given something that may still be reversed.
     *
     * @param  list<int>  $childIds
     */
    public function receiptFor(int $receiptId, array $childIds): ?PaymentReceipt
    {
        if ($childIds === []) {
            return null;
        }

        return PaymentReceipt::query()
            ->whereKey($receiptId)
            ->whereIn('student_user_id', $childIds)
            ->where('status', 'posted')
            ->with(['student:id,name', 'allocations'])
            ->first();
    }

    /** @return array{minor: int, currency: string, decimals: int} */
    private static function money(int $minor): array
    {
        return [
            'minor' => $minor,
            'currency' => strtoupper((string) config('mobile.currency', 'JOD')),
            'decimals' => (int) config('mobile.currency_decimals', 3),
        ];
    }
}
