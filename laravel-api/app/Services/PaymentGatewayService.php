<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\Payment;
use App\Models\PaymentTransaction;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Stripe\Refund;
use Stripe\Stripe;
use Stripe\StripeClient;
use Stripe\Webhook;

class PaymentGatewayService
{
    protected string $provider;

    public function __construct(private CurrentSchool $currentSchool)
    {
        $this->provider = config('services.payment.provider', 'stripe');
    }

    /**
     * Initialize Stripe client.
     *
     * Every path to the provider goes through here, so this is where a disabled
     * or half-configured integration is stopped. Payments fail closed by
     * design: a payment path that silently no-ops can record money that was
     * never taken.
     */
    protected function getStripeClient(): StripeClient
    {
        app(IntegrationGate::class)->ensureAvailable(IntegrationGate::PAYMENTS);

        $client = ['api_key' => config('services.payment.stripe.secret_key')];

        // Points the SDK at a local stripe-mock during verification. Ignored
        // unless explicitly set, so production always reaches the real API.
        if (filled($base = config('services.payment.stripe.api_base'))) {
            $client['api_base'] = $base;
        }

        return new StripeClient($client);
    }

    /**
     * Create a payment intent for an invoice
     */
    public function createPaymentIntent(Invoice $invoice, array $options = []): array
    {
        try {
            $stripe = $this->getStripeClient();

            $amountDue = round((float) $invoice->amount - (float) $invoice->paid_amount - (float) ($invoice->credits ?? 0), 2);
            if ($amountDue <= 0) {
                return [
                    'success' => false,
                    'error' => 'Invoice has no outstanding balance.',
                ];
            }
            // Round BEFORE casting to int to avoid float truncation (e.g. 19.99 * 100 = 1998.999…)
            $amount = (int) round($amountDue * 100); // cents

            $paymentIntentData = [
                'amount' => $amount,
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

            if (! empty($options['customer_email'])) {
                // Create or retrieve customer — escape quotes/backslashes to keep the
                // Stripe search query well-formed regardless of stored email content.
                $escapedEmail = str_replace(['\\', "'"], ['\\\\', "\\'"], $options['customer_email']);
                $customers = $stripe->customers->search([
                    'query' => "email:'{$escapedEmail}'",
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

            $requestOptions = empty($options['idempotency_key']) ? [] : ['idempotency_key' => $options['idempotency_key']];
            $paymentIntent = $stripe->paymentIntents->create($paymentIntentData, $requestOptions);

            // Create transaction record
            PaymentTransaction::updateOrCreate([
                'provider' => $this->provider,
                'provider_transaction_id' => $paymentIntent->id,
            ], [
                'invoice_id' => $invoice->id,
                'amount' => $amountDue,
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
                'amount' => $amountDue,
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
        $transactionSchoolId = PaymentTransaction::withoutGlobalScope('school')
            ->where('provider', $this->provider)
            ->where('provider_transaction_id', $paymentIntentId)
            ->value('school_id');
        if (! $transactionSchoolId) {
            return ['success' => false, 'error' => 'Payment transaction not found'];
        }
        if (! $this->currentSchool->has()) {
            return $this->currentSchool->run(
                (int) $transactionSchoolId,
                fn (): array => $this->confirmPayment($paymentIntentId),
            );
        }
        if ($this->currentSchool->id() !== (int) $transactionSchoolId) {
            return ['success' => false, 'error' => 'Payment transaction belongs to another school'];
        }

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
            if (! $invoiceId) {
                return [
                    'success' => false,
                    'error' => 'Invoice not found in payment metadata',
                ];
            }

            $amount = round($paymentIntent->amount / 100, 2);
            $alreadyRecorded = false;

            // The Stripe webhook and the client-side /payments/confirm call can race.
            // Serialize them by locking the invoice row and performing the duplicate
            // check INSIDE the same transaction. The unique index on payments.reference
            // is the final safety net against double-recording.
            $payment = \DB::transaction(function () use ($invoiceId, $amount, $paymentIntent, &$alreadyRecorded) {
                $invoice = Invoice::lockForUpdate()->find($invoiceId);
                if (! $invoice) {
                    return null;
                }

                $existingPayment = Payment::where('reference', $paymentIntent->id)->first();
                if ($existingPayment) {
                    $alreadyRecorded = true;

                    return $existingPayment;
                }

                $payment = Payment::create([
                    'invoice_id' => $invoice->id,
                    'amount' => $amount,
                    'method' => 'online',
                    'reference' => $paymentIntent->id,
                    'recorded_by' => null, // System recorded
                    'paid_at' => now(),
                    'note' => 'Paid via Stripe',
                ]);
                DB::table('payment_allocations')->insertOrIgnore([
                    'school_id' => $invoice->school_id,
                    'payment_id' => $payment->id, 'invoice_id' => $invoice->id, 'amount' => $amount,
                    'created_at' => now(), 'updated_at' => now(),
                ]);

                $newPaid = round((float) $invoice->paid_amount + $amount, 2);
                $status = $newPaid >= (float) $invoice->amount ? 'paid' : 'partial';
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

                return $payment;
            });

            if (! $payment) {
                return [
                    'success' => false,
                    'error' => 'Invoice not found',
                ];
            }

            if ($alreadyRecorded) {
                return [
                    'success' => true,
                    'payment' => $payment,
                    'already_recorded' => true,
                ];
            }

            // Notifications fire AFTER commit so a notifier failure can never
            // roll back (or delay locks on) the financial records.
            try {
                $invoice = Invoice::with('student')->find($invoiceId);
                NotificationService::sendWithTemplate(
                    $invoice->student_user_id,
                    'payment_received',
                    [
                        'amount' => $amount,
                        'description' => $invoice->description,
                        'payment_id' => $payment->id,
                    ]
                );
                NotificationService::sendToParents(
                    $invoice->student_user_id,
                    'payment_received',
                    [
                        'student_name' => $invoice->student->name,
                        'amount' => $amount,
                        'description' => $invoice->description,
                    ]
                );
            } catch (\Throwable $e) {
                Log::warning('Payment recorded but notification failed', [
                    'payment_id' => $payment->id,
                    'error' => $e->getMessage(),
                ]);
            }

            return [
                'success' => true,
                'payment' => $payment,
            ];
        } catch (QueryException $e) {
            // Unique-constraint violation on payments.reference = concurrent insert
            // already recorded this payment. Treat as idempotent success.
            $existing = Payment::where('reference', $paymentIntentId)->first();
            if ($existing) {
                return ['success' => true, 'payment' => $existing, 'already_recorded' => true];
            }
            Log::error('Payment confirmation failed', [
                'payment_intent_id' => $paymentIntentId,
                'error' => $e->getMessage(),
            ]);

            return ['success' => false, 'error' => 'Database error while recording payment'];

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
        $event = null;
        try {
            $event = Webhook::constructEvent(
                $payload,
                $signature,
                config('services.payment.stripe.webhook_secret')
            );

            $payloadHash = hash('sha256', $payload);
            DB::table('payment_webhook_events')->insertOrIgnore([
                'provider' => $this->provider, 'event_id' => $event->id, 'payload_hash' => $payloadHash,
                'status' => 'pending', 'attempts' => 0, 'created_at' => now(), 'updated_at' => now(),
            ]);
            $claim = DB::transaction(function () use ($event, $payloadHash) {
                $row = DB::table('payment_webhook_events')->where('provider', $this->provider)
                    ->where('event_id', $event->id)->lockForUpdate()->first();
                if (! hash_equals($row->payload_hash, $payloadHash)) {
                    return 'mismatch';
                }
                if ($row->status === 'completed') {
                    return 'completed';
                }
                if ($row->status === 'processing') {
                    return 'processing';
                }
                DB::table('payment_webhook_events')->where('id', $row->id)->update([
                    'status' => 'processing', 'attempts' => $row->attempts + 1, 'updated_at' => now(),
                ]);

                return 'claimed';
            });
            if ($claim === 'mismatch') {
                return ['success' => false, 'error' => 'Webhook event payload does not match its original event ID.'];
            }
            if (in_array($claim, ['completed', 'processing'], true)) {
                return ['success' => true, 'already_processed' => true];
            }

            switch ($event->type) {
                case 'payment_intent.succeeded':
                    $paymentIntent = $event->data->object;
                    $result = $this->confirmPayment($paymentIntent->id);
                    break;

                case 'payment_intent.payment_failed':
                    $paymentIntent = $event->data->object;
                    PaymentTransaction::withoutGlobalScope('school')
                        ->where('provider', $this->provider)
                        ->where('provider_transaction_id', $paymentIntent->id)
                        ->update([
                            'status' => 'failed',
                            'error_message' => $paymentIntent->last_payment_error?->message ?? 'Payment failed',
                        ]);

                    $result = ['success' => true, 'event' => 'payment_failed'];
                    break;

                case 'charge.refunded':
                    $charge = $event->data->object;

                    $result = $this->handleRefund($charge, $event->id);
                    break;

                default:
                    $result = ['success' => true, 'event' => $event->type, 'handled' => false];
            }

            DB::table('payment_webhook_events')->where('provider', $this->provider)->where('event_id', $event->id)->update([
                'status' => $result['success'] ? 'completed' : 'failed',
                'processed_at' => $result['success'] ? now() : null,
                'last_error' => $result['success'] ? null : ($result['error'] ?? 'Unknown webhook processing failure'),
                'updated_at' => now(),
            ]);

            return $result;

        } catch (\Exception $e) {
            if ($event?->id) {
                DB::table('payment_webhook_events')->where('provider', $this->provider)->where('event_id', $event->id)->update([
                    'status' => 'failed', 'last_error' => Str::limit($e->getMessage(), 2000), 'updated_at' => now(),
                ]);
            }
            Log::error('Webhook processing failed', ['error' => $e->getMessage()]);

            return ['success' => false, 'error' => $e->getMessage()];
        }
    }

    /**
     * Handle refund
     */
    protected function handleRefund($charge, string $eventId): array
    {
        try {
            $refundedAmount = round($charge->amount_refunded / 100, 2);

            \DB::transaction(function () use ($charge, $refundedAmount, $eventId) {
                $transaction = PaymentTransaction::where('provider_transaction_id', $charge->payment_intent)->first();

                if ($transaction) {
                    $previousRefunded = (float) $transaction->refunded_amount;
                    $refundDelta = round(max(0, $refundedAmount - $previousRefunded), 2);
                    $transaction->update([
                        'status' => 'refunded',
                        'refunded_amount' => $refundedAmount,
                    ]);

                    // Reverse the payment in our system (lock invoice to avoid racing
                    // with a concurrent payment confirmation on the same invoice)
                    $payment = Payment::where('reference', $charge->payment_intent)->first();
                    if ($payment && $refundDelta > 0) {
                        DB::table('payment_reversals')->insertOrIgnore([
                            'school_id' => $transaction->school_id,
                            'payment_id' => $payment->id, 'amount' => $refundDelta,
                            'provider_reference' => $eventId, 'reason' => 'Stripe refund',
                            'reversed_at' => now(), 'created_at' => now(), 'updated_at' => now(),
                        ]);
                        $invoice = Invoice::lockForUpdate()->find($payment->invoice_id);
                        if ($invoice) {
                            $newPaid = round(max(0, (float) $invoice->paid_amount - $refundDelta), 2);
                            $invoice->update([
                                'paid_amount' => $newPaid,
                                'status' => $newPaid >= (float) $invoice->amount ? 'paid' : ($newPaid > 0 ? 'partial' : 'pending'),
                            ]);
                        }
                    }
                }
            });

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
