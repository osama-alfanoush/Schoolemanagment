<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Http\Responses\Mobile\CachedPayload;
use App\Models\Installment;
use App\Models\Invoice;
use App\Services\AuditLogger;
use App\Services\Mobile\IdempotencyConflict;
use App\Services\Mobile\ParentFinanceService;
use App\Services\Mobile\UnpayableInstallment;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

/**
 * Fees, invoices and payment intents for a guardian.
 *
 * Every route resolves the guardian's children server-side from the
 * school-scoped `parent_student` pivot. No id in a path or a body widens that
 * set — the id is only ever checked *against* it.
 */
class ParentFinanceController extends Controller
{
    public function __construct(private readonly ParentFinanceService $finance) {}

    public function summary(Request $request): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        return CachedPayload::respond(
            $request,
            $this->finance->summary($this->childIds($request, $schoolId), $schoolId),
        );
    }

    public function installments(Request $request, int $studentId): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        if (! $this->owns($request, $studentId, $schoolId)) {
            return $this->deny($request, $studentId);
        }

        return CachedPayload::respond(
            $request,
            $this->finance->installmentsFor($studentId, $schoolId),
        );
    }

    public function invoices(Request $request): JsonResponse
    {
        $schoolId = $this->schoolId($request);

        return CachedPayload::respond($request, [
            'invoices' => $this->finance->invoices(
                $this->childIds($request, $schoolId),
                $schoolId,
            ),
        ]);
    }

    public function invoice(Request $request, int $invoiceId): JsonResponse
    {
        $schoolId = $this->schoolId($request);
        $childIds = $this->childIds($request, $schoolId);

        $invoice = Invoice::query()
            ->whereKey($invoiceId)
            ->where('school_id', $schoolId)
            ->first();

        // Refused the same way whether the invoice belongs to another family or
        // does not exist, so the endpoint cannot be used to discover invoice
        // ids by watching which ones answer differently.
        if ($invoice === null || ! in_array((int) $invoice->student_user_id, $childIds, true)) {
            return $this->deny($request, $invoiceId, 'invoice');
        }

        return CachedPayload::respond($request, $this->finance->invoicePayload($invoice));
    }

    /**
     * Creates the intent to pay one installment.
     *
     * `Idempotency-Key` is required. A parent on a bad connection taps pay,
     * sees nothing, and taps again; the phone may retry on its own too. Without
     * the key those are separate payments.
     */
    public function payIntent(Request $request, int $installmentId): JsonResponse
    {
        $request->merge(['idempotency_key' => $request->header('Idempotency-Key')]);
        $data = $request->validate(['idempotency_key' => ['required', 'uuid']]);

        $schoolId = $this->schoolId($request);
        $childIds = $this->childIds($request, $schoolId);

        $installment = Installment::query()
            ->whereKey($installmentId)
            ->where('school_id', $schoolId)
            ->first();

        $ownerId = $installment === null ? null : (int) DB::table('payment_plans')
            ->where('id', $installment->payment_plan_id)
            ->whereNull('deleted_at')
            ->value('student_user_id');

        if ($installment === null || $ownerId === null || ! in_array($ownerId, $childIds, true)) {
            return $this->deny($request, $installmentId, 'installment');
        }

        try {
            $result = $this->finance->createIntent(
                $request,
                $request->user(),
                $installment,
                $data['idempotency_key'],
                $schoolId,
            );
        } catch (IdempotencyConflict $e) {
            return ApiResponse::error($e->getMessage(), Response::HTTP_CONFLICT);
        } catch (UnpayableInstallment $e) {
            return ApiResponse::error($e->getMessage(), Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        // 201 the first time, 200 for every replay of the same key. Both carry
        // the same body, so a client that missed the first answer is not told
        // anything different by the retry that reached it.
        return ApiResponse::success(
            $this->finance->intentPayload($result['intent']),
            $result['created'] ? Response::HTTP_CREATED : Response::HTTP_OK,
        );
    }

    /**
     * Streams a posted receipt as a PDF.
     */
    public function receiptPdf(Request $request, int $receiptId): Response
    {
        $schoolId = $this->schoolId($request);
        $receipt = $this->finance->receiptFor($receiptId, $this->childIds($request, $schoolId));

        if ($receipt === null) {
            AuditLogger::log($request, 'authorization_denied', 'payment_receipt', $receiptId, [
                'guard' => 'ParentFinanceController',
            ]);

            return response('', Response::HTTP_FORBIDDEN);
        }

        return Pdf::loadView('pdf.payment-receipt', ['receipt' => $receipt])
            ->download("receipt-{$receipt->receipt_no}.pdf");
    }

    /* ---------- scope ---------- */

    private function schoolId(Request $request): int
    {
        // Server-side, from the resolved tenant context. Never from the client.
        return (int) $request->attributes->get('school_id');
    }

    /** @return list<int> */
    private function childIds(Request $request, int $schoolId): array
    {
        return DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->where('parent_user_id', $request->user()->id)
            ->pluck('student_user_id')
            ->map(static fn ($id): int => (int) $id)
            ->all();
    }

    private function owns(Request $request, int $childId, int $schoolId): bool
    {
        return in_array($childId, $this->childIds($request, $schoolId), true);
    }

    private function deny(Request $request, int $id, string $entity = 'student'): JsonResponse
    {
        // Recorded, not just refused. A guardian reaching for another family's
        // money is the highest-signal event on this surface.
        AuditLogger::log($request, 'authorization_denied', $entity, $id, [
            'guard' => 'ParentFinanceController',
        ]);

        return ApiResponse::error('You do not have access to this record.', Response::HTTP_FORBIDDEN);
    }
}
