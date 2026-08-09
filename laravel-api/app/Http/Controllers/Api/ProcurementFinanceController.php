<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Supplier;
use App\Models\SupplierInvoice;
use App\Models\SupplierPayment;
use App\Services\AuditLogger;
use App\Services\LedgerService;
use App\Services\ProcurementService;
use App\Services\WarehouseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * Procurement Finance (accounts payable): supplier invoices and payments.
 * Guarded by the finance.procurement.* permission set.
 */
class ProcurementFinanceController extends Controller
{
    public function __construct(
        private ProcurementService $procurement,
        private WarehouseService $warehouse,
        private LedgerService $ledger,
    ) {}

    public function indexInvoices(Request $request)
    {
        $q = SupplierInvoice::query()->with('supplier:id,code,name');
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }
        if ($supplierId = $request->query('supplier_id')) {
            $q->where('supplier_id', $supplierId);
        }
        if ($request->boolean('overdue')) {
            $q->whereIn('status', ['pending', 'partial'])->where('due_date', '<', now()->toDateString());
        }

        return response()->json($q->latest('invoice_date')->paginate((int) $request->query('per_page', 20)));
    }

    public function storeInvoice(Request $request)
    {
        $data = $request->validate([
            'supplier_id' => 'required|exists:suppliers,id',
            'purchase_order_id' => 'nullable|exists:purchase_orders,id',
            'supplier_invoice_ref' => 'nullable|string|max:100',
            'invoice_date' => 'required|date',
            'due_date' => 'required|date|after_or_equal:invoice_date',
            'amount' => 'required|numeric|gt:0',
            'notes' => 'nullable|string',
        ]);

        $invoice = SupplierInvoice::create([
            ...$data,
            'invoice_no' => $this->warehouse->generateRef('SINV', SupplierInvoice::class),
            'created_by' => $request->user()->id,
        ]);

        AuditLogger::log($request, 'create_supplier_invoice', 'supplier_invoice', $invoice->id, [
            'invoice_no' => $invoice->invoice_no, 'amount' => (float) $invoice->amount,
        ]);

        return response()->json($invoice->load('supplier:id,code,name'), 201);
    }

    public function showInvoice(int $id)
    {
        return response()->json(
            SupplierInvoice::with([
                'supplier.account', 'purchaseOrder:id,po_no,status',
                'payments.recordedBy:id,name', 'createdBy:id,name',
            ])->findOrFail($id)
        );
    }

    public function updateInvoice(Request $request, int $id)
    {
        $invoice = SupplierInvoice::findOrFail($id);
        if ((float) $invoice->paid_amount > 0) {
            return response()->json(['message' => 'Invoices with recorded payments cannot be edited.'], 422);
        }

        $data = $request->validate([
            'supplier_invoice_ref' => 'nullable|string|max:100',
            'invoice_date' => 'sometimes|date',
            'due_date' => 'sometimes|date',
            'amount' => 'sometimes|numeric|gt:0',
            'notes' => 'nullable|string',
        ]);
        $invoice->update($data);
        AuditLogger::log($request, 'update_supplier_invoice', 'supplier_invoice', $invoice->id, $data);

        return response()->json($invoice->fresh());
    }

    public function cancelInvoice(Request $request, int $id)
    {
        $invoice = SupplierInvoice::findOrFail($id);
        if ((float) $invoice->paid_amount > 0) {
            return response()->json(['message' => 'Invoices with recorded payments cannot be cancelled.'], 422);
        }
        $invoice->update(['status' => 'cancelled']);
        AuditLogger::log($request, 'cancel_supplier_invoice', 'supplier_invoice', $invoice->id);

        return response()->json($invoice);
    }

    public function recordPayment(Request $request, int $id)
    {
        $data = $request->validate([
            'amount' => 'required|numeric|gt:0',
            'method' => 'required|in:cash,bank_transfer,cheque',
            'reference' => 'nullable|string|max:100',
            'paid_at' => 'nullable|date',
            'note' => 'nullable|string',
        ]);

        SupplierInvoice::findOrFail($id);

        $payment = DB::transaction(function () use ($data, $id, $request) {
            // Lock so concurrent payments cannot race the paid_amount total.
            $invoice = SupplierInvoice::with('supplier.account')->lockForUpdate()->findOrFail($id);
            if ($invoice->status === 'cancelled') {
                abort(422, 'Cannot pay a cancelled invoice.');
            }

            $amount = round((float) $data['amount'], 2);
            $newPaid = round((float) $invoice->paid_amount + $amount, 2);
            if ($newPaid > (float) $invoice->amount + 0.005) {
                $outstanding = round((float) $invoice->amount - (float) $invoice->paid_amount, 2);
                abort(422, "Payment exceeds the outstanding balance of {$outstanding}.");
            }

            $payment = SupplierPayment::create([
                'supplier_invoice_id' => $invoice->id,
                'amount' => $amount,
                'method' => $data['method'],
                'reference' => $data['reference'] ?? null,
                'recorded_by' => $request->user()->id,
                'approved_by' => $request->user()->id,
                'paid_at' => $data['paid_at'] ?? now(),
                'note' => $data['note'] ?? null,
            ]);

            $invoice->update([
                'paid_amount' => $newPaid,
                'status' => $newPaid >= (float) $invoice->amount ? 'paid' : 'partial',
            ]);

            // Supplier ledger: payment reduces what we owe.
            $this->procurement->postSupplierTransaction(
                $invoice->supplier->account,
                type: 'payment',
                amount: $amount,
                referenceNo: $invoice->invoice_no,
                description: "Payment for supplier invoice {$invoice->invoice_no}",
                actor: $request->user(),
                sourceType: SupplierPayment::class,
                sourceId: $payment->id,
            );

            // Double entry: settle the payable from cash.
            $this->ledger->postPair(
                description: "Supplier payment {$invoice->invoice_no} ({$invoice->supplier->name})",
                amount: $amount,
                debitAccount: 'accounts_payable',
                creditAccount: 'cash',
                source: 'supplier_payment',
                sourceId: $payment->id,
                createdBy: $request->user()->id,
            );

            return $payment;
        });

        AuditLogger::log($request, 'record_supplier_payment', 'supplier_invoice', $id, [
            'payment_id' => $payment->id, 'amount' => (float) $data['amount'],
        ]);

        return response()->json($payment->load('invoice'), 201);
    }

    /** AP aging buckets per supplier: current / 1-30 / 31-60 / 61-90 / 90+. */
    public function apAging()
    {
        $today = now()->startOfDay();
        $open = SupplierInvoice::with('supplier:id,code,name')
            ->whereIn('status', ['pending', 'partial', 'overdue'])
            ->get();

        $bySupplier = $open->groupBy('supplier_id')->map(function ($invoices) use ($today) {
            $buckets = ['current' => 0.0, 'days_30' => 0.0, 'days_60' => 0.0, 'days_90' => 0.0, 'days_90_plus' => 0.0];
            foreach ($invoices as $inv) {
                $outstanding = round((float) $inv->amount - (float) $inv->paid_amount, 2);
                $overdueDays = $inv->due_date->lt($today) ? $inv->due_date->diffInDays($today) : 0;
                $bucket = match (true) {
                    $overdueDays <= 0 => 'current',
                    $overdueDays <= 30 => 'days_30',
                    $overdueDays <= 60 => 'days_60',
                    $overdueDays <= 90 => 'days_90',
                    default => 'days_90_plus',
                };
                $buckets[$bucket] += $outstanding;
            }

            return [
                'supplier' => $invoices->first()->supplier,
                'buckets' => array_map(fn ($v) => round($v, 2), $buckets),
                'total_outstanding' => round(array_sum($buckets), 2),
            ];
        })->values();

        return response()->json([
            'data' => $bySupplier,
            'total_payable' => round($bySupplier->sum('total_outstanding'), 2),
        ]);
    }
}
