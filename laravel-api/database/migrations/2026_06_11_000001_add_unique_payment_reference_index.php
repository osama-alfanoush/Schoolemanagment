<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/**
 * Gateway payments are deduplicated by the provider's payment-intent ID stored
 * in payments.reference. A unique index makes idempotency a database guarantee
 * rather than an application-level best effort (webhook + client confirm race).
 *
 * NULL references (manual/cash payments without a reference) are unaffected:
 * SQL unique indexes permit multiple NULLs.
 */
return new class extends Migration
{
    public function up(): void
    {
        // Guard against pre-existing duplicates before adding the constraint:
        // keep the earliest payment per reference, which mirrors the
        // application-level dedupe behaviour.
        $duplicates = DB::table('payments')
            ->select('reference', DB::raw('MIN(id) as keep_id'))
            ->whereNotNull('reference')
            ->groupBy('reference')
            ->havingRaw('COUNT(*) > 1')
            ->get();

        foreach ($duplicates as $dup) {
            DB::transaction(function () use ($dup) {
                $extras = DB::table('payments')
                    ->where('reference', $dup->reference)
                    ->where('id', '!=', $dup->keep_id)
                    ->get();

                foreach ($extras as $extra) {
                    // Reverse the double-counted amount on the invoice before deleting
                    $invoice = DB::table('invoices')->where('id', $extra->invoice_id)->lockForUpdate()->first();
                    if ($invoice) {
                        $newPaid = round(max(0, (float) $invoice->paid_amount - (float) $extra->amount), 2);
                        DB::table('invoices')->where('id', $invoice->id)->update([
                            'paid_amount' => $newPaid,
                            'status' => $newPaid >= (float) $invoice->amount ? 'paid' : ($newPaid > 0 ? 'partial' : 'pending'),
                        ]);
                    }
                    DB::table('payments')->where('id', $extra->id)->delete();
                }
            });
        }

        Schema::table('payments', function (Blueprint $t) {
            $t->unique('reference', 'payments_reference_unique');
        });
    }

    public function down(): void
    {
        Schema::table('payments', function (Blueprint $t) {
            $t->dropUnique('payments_reference_unique');
        });
    }
};
