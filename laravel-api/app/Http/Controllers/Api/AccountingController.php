<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\AuditLog;
use App\Models\ChartOfAccount;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\BudgetService;
use App\Services\FinancialReportService;
use App\Services\JournalService;
use Illuminate\Http\Request;

class AccountingController extends Controller
{
    public function __construct(
        private JournalService $journal,
        private BudgetService $budget,
        private FinancialReportService $reports
    ) {}
    public function indexJournalEntries(Request $request)
    {
        $result = $this->journal->listEntries($request);
        return response()->json($result);
    }

    public function storeJournalEntry(Request $request)
    {
        try {
            $result = $this->journal->createEntry($request);
            return response()->json($result['data'], $result['status'] ?? 201);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    public function showJournalEntry($id)
    {
        $entry = $this->journal->getEntry((int) $id);
        if (!$entry) {
            return response()->json(['message' => 'Not found'], 404);
        }
        return response()->json(['data' => $entry]);
    }

    public function destroyJournalEntry(Request $request, $id)
    {
        try {
            $this->journal->deleteEntry($request, (int) $id);
            return ApiResponse::deleted();
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    public function indexAccounts(Request $request)
    {
        $q = ChartOfAccount::query();
        if ($type = $request->query('account_type')) $q->where('account_type', $type);
        if ($request->has('is_active')) $q->where('is_active', filter_var($request->query('is_active'), FILTER_VALIDATE_BOOLEAN));
        return response()->json(['data' => $q->orderBy('account_code')->get()]);
    }

    public function storeAccount(Request $request)
    {
        $data = $request->validate([
            'account_code' => 'required|unique:chart_of_accounts',
            'account_name' => 'required',
            'account_type' => 'required|in:asset,liability,equity,income,expense',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
        ]);
        $account = ChartOfAccount::create($data);
        AuditLogger::log($request, 'create_chart_of_account', 'chart_of_account', $account->id, $data);
        return response()->json(['data' => $account], 201);
    }

    public function updateAccount(Request $request, $id)
    {
        $account = ChartOfAccount::findOrFail($id);
        $data = $request->validate([
            'account_code' => "sometimes|unique:chart_of_accounts,account_code,{$id}",
            'account_name' => 'sometimes|string',
            'account_type' => 'sometimes|in:asset,liability,equity,income,expense',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
        ]);
        $account->update($data);
        AuditLogger::log($request, 'update_chart_of_account', 'chart_of_account', $account->id, $data);
        return response()->json(['data' => $account]);
    }

    public function indexBudget(Request $request)
    {
        $result = $this->budget->listBudget($request);
        return response()->json($result);
    }

    public function storeBudget(Request $request)
    {
        $result = $this->budget->createBudget($request);
        return response()->json($result['data'], $result['status'] ?? 201);
    }

    public function updateBudget(Request $request, $id)
    {
        $result = $this->budget->updateBudget($request, (int) $id);
        return response()->json($result['data']);
    }

    public function syncBudgetActuals(Request $request)
    {
        $result = $this->budget->syncActuals($request);
        return response()->json($result);
    }

    public function indexClosings()
    {
        $result = $this->journal->listClosings();
        return response()->json($result);
    }

    public function closeMonth(Request $request)
    {
        try {
            $result = $this->journal->closeMonth($request);
            return response()->json($result['data'], $result['status'] ?? 201);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    public function trialBalance(Request $request)
    {
        $result = $this->reports->trialBalance($request);
        return response()->json($result);
    }

    public function incomeStatement(Request $request)
    {
        $result = $this->reports->incomeStatement($request);
        return response()->json($result);
    }

    public function balanceSheet(Request $request)
    {
        $result = $this->reports->balanceSheet($request);
        return response()->json($result);
    }

    public function trialBalancePdf(Request $request)
    {
        return $this->reports->trialBalancePdf($request);
    }

    public function incomeStatementPdf(Request $request)
    {
        return $this->reports->incomeStatementPdf($request);
    }

    public function auditTrail(Request $request)
    {
        $q = AuditLog::with('user:id,name,role')
            ->where(function ($query) {
                $query->where('action', 'like', 'finance_%')
                    ->orWhere('action', 'like', 'accounting_%')
                    ->orWhere('action', 'like', 'payment_%');
            });

        if ($from = $request->query('date_from')) $q->where('created_at', '>=', $from);
        if ($to = $request->query('date_to')) $q->where('created_at', '<=', $to);

        return response()->json([
            'data' => $q->latest()->paginate((int) $request->query('per_page', 20)),
        ]);
    }
}
