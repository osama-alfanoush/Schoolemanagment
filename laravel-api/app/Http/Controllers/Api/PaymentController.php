<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Invoice;
use App\Models\PaymentTransaction;
use App\Services\PaymentGatewayService;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    protected PaymentGatewayService $paymentService;

    public function __construct()
    {
        $this->paymentService = new PaymentGatewayService;
    }

    /**
     * Create a payment intent for an invoice
     */
    public function createPaymentIntent(Request $request)
    {
        $data = $request->validate([
            'invoice_id' => 'required|exists:invoices,id',
            'currency' => 'nullable|string|size:3',
        ]);

        $invoice = Invoice::with('student')->findOrFail($data['invoice_id']);

        // Authorization: parent of student or student themselves
        $user = $request->user();
        $canPay = $user->role === 'student' && $user->id === $invoice->student_user_id;
        if (! $canPay && $user->role === 'parent') {
            $canPay = $user->children()->where('users.id', $invoice->student_user_id)->exists();
        }
        if (! $canPay && ! in_array($user->role, ['admin', 'finance'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $result = $this->paymentService->createPaymentIntent($invoice, [
            'currency' => $data['currency'] ?? 'usd',
            'customer_email' => $invoice->student->email,
            'customer_name' => $invoice->student->name,
        ]);

        if (! $result['success']) {
            return response()->json(['message' => $result['error']], 400);
        }

        return response()->json([
            'client_secret' => $result['client_secret'],
            'payment_intent_id' => $result['payment_intent_id'],
            'amount' => $result['amount'],
        ]);
    }

    /**
     * Check the caller is allowed to act on the given payment intent:
     * admin/finance, the student who owns the invoice, or that student's parent.
     */
    private function authorizeIntentAccess(Request $request, string $paymentIntentId): bool
    {
        $user = $request->user();
        if (in_array($user->role, ['admin', 'finance'], true)) {
            return true;
        }

        $txn = PaymentTransaction::with('invoice:id,student_user_id')
            ->where('provider_transaction_id', $paymentIntentId)
            ->first();
        if (! $txn || ! $txn->invoice) {
            return false;
        }

        if ($user->role === 'student') {
            return $user->id === $txn->invoice->student_user_id;
        }
        if ($user->role === 'parent') {
            return $user->children()->where('users.id', $txn->invoice->student_user_id)->exists();
        }

        return false;
    }

    /**
     * Confirm payment after client-side completion
     */
    public function confirmPayment(Request $request)
    {
        $data = $request->validate([
            'payment_intent_id' => 'required|string',
        ]);

        if (! $this->authorizeIntentAccess($request, $data['payment_intent_id'])) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $result = $this->paymentService->confirmPayment($data['payment_intent_id']);

        if (! $result['success']) {
            return response()->json(['message' => $result['error']], 400);
        }

        return response()->json([
            'message' => 'Payment confirmed',
            'payment' => $result['payment'] ?? null,
            'already_recorded' => $result['already_recorded'] ?? false,
        ]);
    }

    /**
     * Get payment status
     */
    public function getStatus(Request $request, string $paymentIntentId)
    {
        if (! $this->authorizeIntentAccess($request, $paymentIntentId)) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $result = $this->paymentService->getPaymentStatus($paymentIntentId);

        if (! $result['success']) {
            return response()->json(['message' => $result['error']], 400);
        }

        return response()->json([
            'status' => $result['status'],
            'amount' => $result['amount'],
            'currency' => $result['currency'],
        ]);
    }

    /**
     * Get user's saved payment methods
     */
    public function getPaymentMethods(Request $request)
    {
        // This would require Stripe customer ID stored on user
        // For now, return empty or implement as needed
        return response()->json([
            'methods' => [],
            'message' => 'Payment methods feature coming soon',
        ]);
    }

    /**
     * Create setup intent for saving card
     */
    public function createSetupIntent(Request $request)
    {
        // Would require customer creation and association
        return response()->json([
            'message' => 'Setup intent feature coming soon',
        ], 501);
    }

    /**
     * Handle payment webhooks
     */
    public function handleWebhook(Request $request)
    {
        $payload = $request->getContent();
        $signature = $request->header('Stripe-Signature');

        if (empty($signature)) {
            return response()->json(['message' => 'Missing Stripe-Signature header'], 400);
        }

        $result = $this->paymentService->handleWebhook($payload, $signature);

        if (! $result['success']) {
            return response()->json(['message' => $result['error']], 400);
        }

        return response()->json(['received' => true]);
    }
}
