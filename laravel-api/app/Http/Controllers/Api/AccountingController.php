<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\AuditLog;
use App\Models\ChartOfAccount;
use App\Models\JournalBatch;
use App\Services\AuditLogger;
use App\Services\BudgetService;
use App\Services\FinancialReportService;
use App\Services\JournalBatchService;
use App\Services\JournalService;
use App\Services\SchoolContext;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class AccountingController extends Controller
{
    public function __construct(
        private JournalService $journal,
        private JournalBatchService $journalBatches,
        private BudgetService $budget,
        private FinancialReportService $reports,
        private SchoolContext $schools,
    ) {}

    public function indexJournalEntries(Request $request)
    {
        $result = $this->journal->listEntries($request);

        return response()->json($result);
    }

    public function storeJournalEntry(Request $request)
    {
        if ($request->has('lines')) {
            return response()->json($this->journalBatches->create($request), 201);
        }

        try {
            $result = $this->journal->createEntry($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    public function indexJournalBatches(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $query = JournalBatch::query()->where(fn ($q) => $q->where('school_id', $schoolId)
            ->orWhere(fn ($legacy) => $legacy->whereNull('school_id')->whereNotIn('source', ['payroll', 'payroll_accrual', 'payroll_reversal', 'employee_advance', 'employee_advance_settlement'])))
            ->with(['lines', 'creator:id,name']);
        foreach (['status', 'source', 'academic_year_id'] as $filter) {
            if ($request->filled($filter)) {
                $query->where($filter, $request->query($filter));
            }
        }
        if ($request->filled('date_from')) {
            $query->whereDate('entry_date', '>=', $request->query('date_from'));
        }
        if ($request->filled('date_to')) {
            $query->whereDate('entry_date', '<=', $request->query('date_to'));
        }
        if ($request->filled('search')) {
            $search = $request->query('search');
            $query->where(fn ($q) => $q->where('reference_no', 'like', "%{$search}%")
                ->orWhere('description', 'like', "%{$search}%"));
        }

        return response()->json($query->latest('entry_date')->latest('id')
            ->paginate($this->perPage($request, 20)));
    }

    public function showJournalBatch(Request $request, int $id)
    {
        $batch = JournalBatch::with(['lines', 'creator:id,name'])->findOrFail($id);
        if ($batch->school_id !== null) {
            $this->schools->authorize($request->user(), (int) $batch->school_id);
        }

        return response()->json($batch);
    }

    public function approveJournalBatch(Request $request, int $id)
    {
        $this->authorizeBatch($request, $id);

        return response()->json($this->journalBatches->approve($request, $id));
    }

    public function postJournalBatch(Request $request, int $id)
    {
        $this->authorizeBatch($request, $id);

        return response()->json($this->journalBatches->post($request, $id));
    }

    public function reverseJournalBatch(Request $request, int $id)
    {
        $this->authorizeBatch($request, $id);

        return response()->json($this->journalBatches->reverse($request, $id), 201);
    }

    private function authorizeBatch(Request $request, int $id): void
    {
        $schoolId = JournalBatch::whereKey($id)->value('school_id');
        if ($schoolId !== null) {
            $this->schools->authorize($request->user(), (int) $schoolId);
        }
    }

    public function showJournalEntry($id)
    {
        $entry = $this->journal->getEntry((int) $id);
        if (! $entry) {
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
        if ($type = $request->query('account_type')) {
            $q->where('account_type', $type);
        }
        if ($request->has('is_active')) {
            $q->where('is_active', filter_var($request->query('is_active'), FILTER_VALIDATE_BOOLEAN));
        }

        return response()->json(['data' => $q->orderBy('account_code')->get()]);
    }

    public function storeAccount(Request $request)
    {
        $data = $request->validate([
            'account_code' => ['required', Rule::unique('chart_of_accounts')->where('school_id', $request->attributes->get('school_id'))],
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
            'account_code' => ['sometimes', Rule::unique('chart_of_accounts')->where('school_id', $request->attributes->get('school_id'))->ignore($account->id)],
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

    public function indexClosings(Request $request)
    {
        $result = $this->journal->listClosings($request);

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

        if ($from = $request->query('date_from')) {
            $q->where('created_at', '>=', $from);
        }
        if ($to = $request->query('date_to')) {
            $q->where('created_at', '<=', $to);
        }

        return response()->json([
            // Capped: an uncapped client-supplied page size lets one request
            // materialise the whole table.
            'data' => $q->latest()->paginate($this->perPage($request, 20)),
        ]);
    }
}
