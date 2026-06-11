<?php

namespace App\Services;

use App\Models\ChartOfAccount;
use App\Models\JournalEntry;
use App\Models\Payment;
use App\Models\PayrollRecord;
use Illuminate\Http\Request;

class FinancialReportService
{
    public function trialBalance(Request $request): array
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $rows = JournalEntry::whereYear('entry_date', $data['year'])
            ->whereMonth('entry_date', $data['month'])
            ->selectRaw('account_code, account_name,
                sum(amount) filter (where type = \'debit\') as total_debit,
                sum(amount) filter (where type = \'credit\') as total_credit')
            ->groupBy('account_code', 'account_name')
            ->get()
            ->map(fn($r) => [
                'account_code' => $r->account_code,
                'account_name' => $r->account_name,
                'total_debit' => (float) $r->total_debit,
                'total_credit' => (float) $r->total_credit,
                'balance' => (float) $r->total_debit - (float) $r->total_credit,
            ]);

        return ['data' => $rows];
    }

    public function trialBalancePdf(Request $request)
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $rows = JournalEntry::whereYear('entry_date', $data['year'])
            ->whereMonth('entry_date', $data['month'])
            ->selectRaw('account_code, account_name,
                sum(amount) filter (where type = \'debit\') as total_debit,
                sum(amount) filter (where type = \'credit\') as total_credit')
            ->groupBy('account_code', 'account_name')
            ->get();

        return \Barryvdh\DomPDF\Facade\Pdf::loadView('reports.trial-balance', [
            'rows' => $rows, 'month' => $data['month'], 'year' => $data['year'],
        ])->download("trial-balance-{$data['year']}-{$data['month']}.pdf");
    }

    public function incomeStatement(Request $request): array
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $totalIncome = (float) Payment::whereYear('paid_at', $data['year'])
            ->whereMonth('paid_at', $data['month'])->sum('amount');
        $totalPayroll = (float) PayrollRecord::where('year', $data['year'])
            ->where('month', $data['month'])->sum('net_pay');
        $totalExpenses = (float) JournalEntry::whereYear('entry_date', $data['year'])
            ->whereMonth('entry_date', $data['month'])
            ->where('type', 'debit')->where('source', 'expense')->sum('amount');
        $netIncome = $totalIncome - $totalPayroll - $totalExpenses;

        return [
            'data' => [
                'total_income' => $totalIncome,
                'total_payroll' => $totalPayroll,
                'total_expenses' => $totalExpenses,
                'net_income' => $netIncome,
            ],
        ];
    }

    public function incomeStatementPdf(Request $request)
    {
        $data = $request->validate([
            'month' => 'required|integer|between:1,12',
            'year' => 'required|integer',
        ]);

        $totalIncome = (float) Payment::whereYear('paid_at', $data['year'])
            ->whereMonth('paid_at', $data['month'])->sum('amount');
        $totalPayroll = (float) PayrollRecord::where('year', $data['year'])
            ->where('month', $data['month'])->sum('net_pay');
        $totalExpenses = (float) JournalEntry::whereYear('entry_date', $data['year'])
            ->whereMonth('entry_date', $data['month'])
            ->where('type', 'debit')->where('source', 'expense')->sum('amount');

        return \Barryvdh\DomPDF\Facade\Pdf::loadView('reports.income-statement', [
            'total_income' => $totalIncome,
            'total_payroll' => $totalPayroll,
            'total_expenses' => $totalExpenses,
            'net_income' => $totalIncome - $totalPayroll - $totalExpenses,
            'month' => $data['month'],
            'year' => $data['year'],
        ])->download("income-statement-{$data['year']}-{$data['month']}.pdf");
    }

    public function balanceSheet(Request $request): array
    {
        $data = $request->validate([
            'as_of_date' => 'required|date',
        ]);

        $accounts = ChartOfAccount::where('is_active', true)->get();
        $assets = []; $liabilities = []; $equity = [];
        $assetTotal = 0; $liabilityTotal = 0; $equityTotal = 0;

        foreach ($accounts as $account) {
            $debit = (float) JournalEntry::where('account_code', $account->account_code)
                ->where('entry_date', '<=', $data['as_of_date'])
                ->where('type', 'debit')->sum('amount');
            $credit = (float) JournalEntry::where('account_code', $account->account_code)
                ->where('entry_date', '<=', $data['as_of_date'])
                ->where('type', 'credit')->sum('amount');
            $balance = $debit - $credit;

            $entry = [
                'account_code' => $account->account_code,
                'account_name' => $account->account_name,
                'balance' => $balance,
            ];

            if ($account->account_type === 'asset') {
                $assets[] = $entry; $assetTotal += $balance;
            } elseif ($account->account_type === 'liability') {
                $liabilities[] = $entry; $liabilityTotal += $balance;
            } elseif ($account->account_type === 'equity') {
                $equity[] = $entry; $equityTotal += $balance;
            }
        }

        return [
            'data' => [
                'assets' => $assets, 'liabilities' => $liabilities, 'equity' => $equity,
                'asset_total' => $assetTotal, 'liability_total' => $liabilityTotal, 'equity_total' => $equityTotal,
            ],
        ];
    }
}