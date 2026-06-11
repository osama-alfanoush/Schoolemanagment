<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentTransaction;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Stripe\Stripe;
use Stripe\PaymentIntent;
use Stripe\Refund;

class PaymentGatewayService
{
    protected string $provider;

    public function __construct()
    {
        $this->provider = config('services.payment.provider', 'stripe');
    }

    /**
     * Initialize Stripe client
     */
    protected function getStripeClient(): \Stripe\StripeClient
    {
        return new \Stripe\StripeClient(config('services.payment.stripe.secret_key'));
    }

    /**
     * Create a payment intent for an invoice
     */
    public function createPaymentIntent(Invoice $invoice, array $options = []): array
    {
        try {
            $stripe = $this->getStripeClient();

            $amount = ($invoice->amount - $invoice->paid_amount) * 100; // Convert to cents

            $paymentIntentData = [
                'amount' => (int) $amount,
                'currency' => $options['currency'] ?? config('services.payment.currency', 'usd'),
                'automatic_payment_methods' => ['enabled' => true],
                'metadata' => [
                    'invoice_id' => $invoice->id,
                    'invoice_no' => $invoice->invoice_no,
                    'student_id' => $invoice->student_user_id,
                    'school_name' => config('app.name'),
                ],
                'description' => "Payment for invoice {$invoice->invoice_no}",
            ];

            if (!empty($options['customer_email'])) {
                // Create or retrieve customer
                $customers = $stripe->customers->search([
                    'query' => "email:'{$options['customer_email']}'",
                ]);

                if ($customers->data) {
                    $customer = $customers->data[0];
                } else {
                    $customer = $stripe->customers->create([
                        'email' => $options['customer_email'],
                        'name' => $options['customer_name'] ?? null,
                    ]);
                }

                $paymentIntentData['customer'] = $customer->id;
            }

            $paymentIntent = $stripe->paymentIntents->create($paymentIntentData);

            // Create transaction record
            PaymentTransaction::create([
                'invoice_id' => $invoice->id,
                'provider' => $this->provider,
                'provider_transaction_id' => $paymentIntent->id,
                'amount' => $amount / 100,
                'currency' => $paymentIntentData['currency'],
                'status' => 'pending',
                'metadata' => [
                    'client_secret' => $paymentIntent->client_secret,
                ],
            ]);

            return [
                'success' => true,
                'client_secret' => $paymentIntent->client_secret,
                'payment_intent_id' => $paymentIntent->id,
                'amount' => $amount / 100,
            ];

        } catch (\Exception $e) {
            Log::error('Payment intent creation failed', [
                'invoice_id' => $invoice->id,
                'error' => $e->getMessage(),
            ]);

            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Confirm payment and record it
     */
    public function confirmPayment(string $paymentIntentId): array
    {
        try {
            $stripe = $this->getStripeClient();
            $paymentIntent = $stripe->paymentIntents->retrieve($paymentIntentId);

            if ($paymentIntent->status !== 'succeeded') {
                return [
                    'success' => false,
                    'status' => $paymentIntent->status,
                    'error' => 'Payment not completed',
                ];
            }

            $invoiceId = $paymentIntent->metadata['invoice_id'] ?? null;
            if (!$invoiceId) {
                return [
                    'success' => false,
                    'error' => 'Invoice not found in payment metadata',
                ];
            }

            $invoice = Invoice::find($invoiceId);
            if (!$invoice) {
                return [
                    'success' => false,
                    'error' => 'Invoice not found',
                ];
            }

            // Check if already recorded
            $existingPayment = Payment::where('reference', $paymentIntentId)->first();
            if ($existingPayment) {
                return [
                    'success' => true,
                    'payment' => $existingPayment,
                    'already_recorded' => true,
                ];
            }

            // Record the payment
            $amount = $paymentIntent->amount / 100;
            $payment = \DB::transaction(function () use ($invoice, $amount, $paymentIntent) {
                $payment = Payment::create([
                    'invoice_id' => $invoice->id,
                    'amount' => $amount,
                    'method' => 'online',
                    'reference' => $paymentIntent->id,
                    'recorded_by' => null, // System recorded
                    'paid_at' => now(),
                    'note' => 'Paid via Stripe',
                ]);

                $newPaid = $invoice->paid_amount + $amount;
                $status = $newPaid >= $invoice->amount ? 'paid' : 'partial';
                $invoice->update([
                    'paid_amount' => $newPaid,
                    'status' => $status,
                ]);

                // Update transaction record
                PaymentTransaction::where('provider_transaction_id', $paymentIntent->id)
                    ->update([
                        'status' => 'completed',
                        'completed_at' => now(),
                    ]);

                // Send notification
                NotificationService::sendWithTemplate(
                    $invoice->student_user_id,
                    'payment_received',
                    [
                        'amount' => $amount,
                        'description' => $invoice->description,
                        'payment_id' => $payment->id,
                    ]
                );

                // Notify parents
                NotificationService::sendToParents(
                    $invoice->student_user_id,
                    'payment_received',
                    [
                        'student_name' => $invoice->student->name,
                        'amount' => $amount,
                        'description' => $invoice->description,
                    ]
                );

                return $payment;
            });

            return [
                'success' => true,
                'payment' => $payment,
            ];

        } catch (\Exception $e) {
            Log::error('Payment confirmation failed', [
                'payment_intent_id' => $paymentIntentId,
                'error' => $e->getMessage(),
            ]);

            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Process webhook from Stripe
     */
    public function handleWebhook(string $payload, string $signature): array
    {
        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload,
                $signature,
                config('services.payment.stripe.webhook_secret')
            );

            switch ($event->type) {
                case 'payment_intent.succeeded':
                    $paymentIntent = $event->data->object;
                    return $this->confirmPayment($paymentIntent->id);

                case 'payment_intent.payment_failed':
                    $paymentIntent = $event->data->object;
                    PaymentTransaction::where('provider_transaction_id', $paymentIntent->id)
                        ->update([
                            'status' => 'failed',
                            'error_message' => $paymentIntent->last_payment_error?->message ?? 'Payment failed',
                        ]);
                    return ['success' => true, 'event' => 'payment_failed'];

                case 'charge.refunded':
                    $charge = $event->data->object;
                    return $this->handleRefund($charge);

                default:
                    return ['success' => true, 'event' => $event->type, 'handled' => false];
            }

        } catch (\Exception $e) {
            Log::error('Webhook processing failed', ['error' => $e->getMessage()]);
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    /**
     * Handle refund
     */
    protected function handleRefund($charge): array
    {
        try {
            $transaction = PaymentTransaction::where('provider_transaction_id', $charge->payment_intent)->first();

            if ($transaction) {
                $transaction->update([
                    'status' => 'refunded',
                    'refunded_amount' => $charge->amount_refunded / 100,
                ]);

                // Reverse the payment in our system
                $payment = Payment::where('reference', $charge->payment_intent)->first();
                if ($payment) {
                    $invoice = $payment->invoice;
                    $newPaid = max(0, $invoice->paid_amount - ($charge->amount_refunded / 100));
                    $invoice->update([
                        'paid_amount' => $newPaid,
                        'status' => $newPaid >= $invoice->amount ? 'paid' : ($newPaid > 0 ? 'partial' : 'pending'),
                    ]);
                }
            }

            return ['success' => true, 'event' => 'refund_processed'];

        } catch (\Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    /**
     * Get payment methods for a customer
     */
    public function getPaymentMethods(string $customerId): array
    {
        try {
            $stripe = $this->getStripeClient();
            $methods = $stripe->paymentMethods->all([
                'customer' => $customerId,
                'type' => 'card',
            ]);

            return [
                'success' => true,
                'methods' => $methods->data,
            ];

        } catch (\Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    /**
     * Create a setup intent for saving card
     */
    public function createSetupIntent(string $customerId): array
    {
        try {
            $stripe = $this->getStripeClient();
            $setupIntent = $stripe->setupIntents->create([
                'customer' => $customerId,
            ]);

            return [
                'success' => true,
                'client_secret' => $setupIntent->client_secret,
            ];

        } catch (\Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    /**
     * Get payment status
     */
    public function getPaymentStatus(string $paymentIntentId): array
    {
        try {
            $stripe = $this->getStripeClient();
            $paymentIntent = $stripe->paymentIntents->retrieve($paymentIntentId);

            return [
                'success' => true,
                'status' => $paymentIntent->status,
                'amount' => $paymentIntent->amount / 100,
                'currency' => $paymentIntent->currency,
            ];

        } catch (\Exception $e) {
            return ['success' => false, 'error' => $e->getMessage()];
        }
    }
}
