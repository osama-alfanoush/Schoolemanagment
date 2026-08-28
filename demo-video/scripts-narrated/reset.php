<?php
/**
 * Returns the demo database to the state each take starts from: no warehouse
 * stock, no advances, no payroll runs, and invoice 12 unpaid. Run with:
 *   php artisan tinker --execute="require 'PATH/reset.php';"
 */

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

// Payments recorded by earlier takes (the first four are seed data).
$paymentIds = DB::table('payments')->where('id', '>', 4)->pluck('id');
DB::table('payment_allocations')->whereIn('payment_id', $paymentIds)->delete();
DB::table('payment_reversals')->whereIn('payment_id', $paymentIds)->delete();
DB::table('installments')->whereIn('payment_id', $paymentIds)->update(['payment_id' => null]);
DB::table('payments')->whereIn('id', $paymentIds)->delete();
DB::table('invoices')->where('id', 12)->update(['paid_amount' => 0, 'status' => 'pending']);

// Warehouse: the take builds the whole cycle from an empty module.
DB::table('stock_movements')->delete();
DB::table('warehouse_items')->delete();
DB::table('warehouse_categories')->delete();

// HR advances raised on camera.
DB::table('employee_advance_installments')->delete();
DB::table('employee_advances')->delete();

// Payroll runs and their records.
$runIds = DB::table('payroll_runs')->pluck('id');
$recordIds = DB::table('payroll_records')->whereIn('payroll_run_id', $runIds)->pluck('id');
DB::table('payroll_record_components')->whereIn('payroll_record_id', $recordIds)->delete();
DB::table('payroll_records')->whereIn('id', $recordIds)->delete();
DB::table('payroll_runs')->whereIn('id', $runIds)->delete();

// Journals posted by those runs and by on-camera payments. Without this the
// entries list accumulates one identical-looking accrual per rehearsal, which
// reads as duplicated data on screen.
DB::table('journal_entries')
    ->whereIn('source', [
        'payroll', 'payroll_accrual', 'student_payment',
        'employee_advance', 'employee_advance_settlement',
    ])
    ->delete();

// Batches left behind once their lines are gone.
if (Schema::hasTable('journal_batches')) {
    DB::table('journal_batches')
        ->whereNotIn('id', DB::table('journal_entries')->whereNotNull('journal_batch_id')->distinct()->pluck('journal_batch_id'))
        ->delete();
}

echo 'reset ok: payments=' . DB::table('payments')->count()
    . ' runs=' . DB::table('payroll_runs')->count()
    . ' items=' . DB::table('warehouse_items')->count()
    . ' advances=' . DB::table('employee_advances')->count()
    . ' journals=' . DB::table('journal_entries')->count()
    . PHP_EOL;
