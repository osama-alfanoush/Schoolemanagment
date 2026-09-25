<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\HrPayrollSetting;
use App\Models\PayrollAccountSetting;
use App\Models\PayrollComponent;
use App\Models\SocialInsuranceScheme;
use App\Models\StaffPayrollComponent;
use App\Models\StaffProfile;
use App\Services\AuditLogger;
use App\Services\SchoolContext;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class PayrollSettingsController extends Controller
{
    public function __construct(private SchoolContext $schools) {}

    public function index(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json([
            'general' => HrPayrollSetting::where('school_id', $schoolId)->first(),
            'accounts' => PayrollAccountSetting::where('school_id', $schoolId)->first(),
            'components' => PayrollComponent::where('school_id', $schoolId)->orderBy('priority')->orderBy('code')->get(),
            'social_insurance_schemes' => SocialInsuranceScheme::where('school_id', $schoolId)->orderBy('scheme_code')->orderByDesc('effective_from')->get(),
        ]);
    }

    public function storeComponent(Request $request)
    {
        $data = $this->componentData($request);
        $schoolId = $this->schools->forUser($request->user());
        $component = DB::transaction(function () use ($data, $schoolId) {
            $previous = PayrollComponent::where('school_id', $schoolId)->where('code', $data['code'])->latest('effective_from')->lockForUpdate()->first();
            if ($previous && $previous->effective_from->gte($data['effective_from'])) {
                throw ValidationException::withMessages(['effective_from' => 'A new component version must start after the latest version.']);
            }
            if ($previous && (! $previous->effective_to || $previous->effective_to->gte($data['effective_from']))) {
                $previous->update(['effective_to' => Carbon::parse($data['effective_from'])->subDay()->toDateString()]);
            }

            return PayrollComponent::create(['scope_key' => 'school:'.$schoolId, 'school_id' => $schoolId, ...$data]);
        });
        AuditLogger::log($request, 'create_payroll_component', 'payroll_component', $component->id, ['new' => $component->toArray()]);

        return response()->json($component, 201);
    }

    public function updateComponent(Request $request, int $id)
    {
        $component = PayrollComponent::findOrFail($id);
        $this->schools->authorize($request->user(), (int) $component->school_id);
        abort_if($component->payrollRecordComponents()->exists(), 422, 'Create a new effective-dated version; this component is already used by payroll.');
        $old = $component->toArray();
        $component->update($this->componentData($request, $component->id));
        AuditLogger::log($request, 'update_payroll_component', 'payroll_component', $component->id, ['old' => $old, 'new' => $component->fresh()->toArray()]);

        return response()->json($component->fresh());
    }

    public function storeScheme(Request $request)
    {
        $data = $this->schemeData($request);
        $schoolId = $this->schools->forUser($request->user());
        $scheme = DB::transaction(function () use ($data, $schoolId) {
            $previous = SocialInsuranceScheme::where('school_id', $schoolId)->where('scheme_code', $data['scheme_code'])->latest('effective_from')->lockForUpdate()->first();
            if ($previous && $previous->effective_from->gte($data['effective_from'])) {
                throw ValidationException::withMessages(['effective_from' => 'A new insurance version must start after the latest version.']);
            }
            if ($previous && (! $previous->effective_to || $previous->effective_to->gte($data['effective_from']))) {
                $previous->update(['effective_to' => Carbon::parse($data['effective_from'])->subDay()->toDateString()]);
            }

            return SocialInsuranceScheme::create(['scope_key' => 'school:'.$schoolId, 'school_id' => $schoolId, ...$data]);
        });
        AuditLogger::log($request, 'create_social_insurance_scheme', 'social_insurance_scheme', $scheme->id, ['new' => $scheme->toArray()]);

        return response()->json($scheme, 201);
    }

    public function updateGeneral(Request $request)
    {
        $data = $request->validate([
            'contract_alert_days' => 'sometimes|array|min:1', 'contract_alert_days.*' => 'integer|min:1|max:365',
            'proration_policy' => 'sometimes|in:none,calendar_days', 'negative_net_policy' => 'sometimes|in:block,allow',
            'currency' => 'sometimes|string|size:3',
        ]);
        $schoolId = $this->schools->forUser($request->user());
        $settings = HrPayrollSetting::firstOrCreate(['school_id' => $schoolId], ['scope_key' => 'school:'.$schoolId]);
        $old = $settings->toArray();
        $settings->update($data);
        AuditLogger::log($request, 'update_hr_payroll_settings', 'hr_payroll_setting', $settings->id, ['old' => $old, 'new' => $settings->fresh()->toArray()]);

        return response()->json($settings->fresh());
    }

    public function updateAccounts(Request $request)
    {
        $fields = [
            'salary_expense', 'employer_insurance_expense', 'payroll_payable', 'social_insurance_payable',
            'deductions_payable', 'employee_advances_receivable', 'cash_bank',
        ];
        $rules = [];
        foreach ($fields as $field) {
            $rules[$field.'_code'] = 'required|string|max:50';
            $rules[$field.'_name'] = 'required|string|max:150';
        }
        $data = $request->validate($rules);
        $schoolId = $this->schools->forUser($request->user());
        $settings = PayrollAccountSetting::firstOrCreate(['school_id' => $schoolId], ['scope_key' => 'school:'.$schoolId, ...$data]);
        $old = $settings->toArray();
        $settings->update($data);
        AuditLogger::log($request, 'update_payroll_accounts', 'payroll_account_setting', $settings->id, ['old' => $old, 'new' => $settings->fresh()->toArray()]);

        return response()->json($settings->fresh());
    }

    public function assignComponent(Request $request, int $staffProfileId)
    {
        $profile = StaffProfile::findOrFail($staffProfileId);
        $this->schools->authorize($request->user(), (int) $profile->school_id);
        $data = $request->validate([
            'payroll_component_id' => 'required|exists:payroll_components,id', 'amount_override' => 'nullable|numeric|money|min:0',
            'rate_override' => 'nullable|numeric|min:0', 'effective_from' => 'required|date',
            'effective_to' => 'nullable|date|after_or_equal:effective_from', 'one_time_period' => 'nullable|date',
            'reason' => 'required|string|max:255',
        ]);
        abort_unless(PayrollComponent::where('school_id', $profile->school_id)->whereKey($data['payroll_component_id'])->exists(), 422, 'The payroll component belongs to another school.');
        $assignment = StaffPayrollComponent::create([
            ...$data, 'school_id' => $profile->school_id, 'staff_profile_id' => $profile->id, 'status' => 'approved',
            'approved_by' => $request->user()->id, 'approved_at' => now(),
        ]);
        AuditLogger::log($request, 'assign_staff_payroll_component', 'staff_payroll_component', $assignment->id, ['new' => $assignment->toArray()]);

        return response()->json($assignment->load('component'), 201);
    }

    private function componentData(Request $request, ?int $ignoreId = null): array
    {
        return $request->validate([
            'code' => 'required|string|max:50', 'name_ar' => 'required|string|max:150', 'name_en' => 'required|string|max:150',
            'category' => 'required|in:earning,deduction,employer_contribution',
            'calculation_type' => 'required|in:fixed,percentage', 'percentage_base' => 'nullable|in:base,gross,insurable,custom',
            'amount' => 'nullable|required_if:calculation_type,fixed|numeric|money|min:0',
            'rate' => 'nullable|required_if:calculation_type,percentage|numeric|min:0|max:100',
            'minimum_amount' => 'nullable|numeric|money|min:0', 'maximum_amount' => 'nullable|numeric|money|gte:minimum_amount',
            'rounding_mode' => 'required|in:nearest,nearest_unit,up,down', 'is_recurring' => 'required|boolean',
            'effective_from' => 'required|date', 'effective_to' => 'nullable|date|after_or_equal:effective_from',
            'is_social_insurance_base' => 'required|boolean', 'is_taxable' => 'required|boolean',
            'show_on_payslip' => 'required|boolean', 'debit_account_code' => 'nullable|string|max:50',
            'credit_account_code' => 'nullable|string|max:50', 'is_active' => 'required|boolean', 'priority' => 'required|integer|min:1|max:9999',
        ]);
    }

    private function schemeData(Request $request): array
    {
        return $request->validate([
            'scheme_code' => 'required|string|max:50', 'name_ar' => 'required|string|max:150', 'name_en' => 'required|string|max:150',
            'employee_rate' => 'required|numeric|min:0|max:100', 'employer_rate' => 'required|numeric|min:0|max:100',
            'calculation_base' => 'required|in:base,gross,insurable,custom', 'minimum_wage' => 'nullable|numeric|money|min:0',
            'maximum_wage' => 'nullable|numeric|money|gte:minimum_wage', 'included_component_codes' => 'nullable|array',
            'excluded_component_codes' => 'nullable|array', 'effective_from' => 'required|date',
            'effective_to' => 'nullable|date|after_or_equal:effective_from', 'employee_payable_account_code' => 'nullable|string|max:50',
            'employer_expense_account_code' => 'nullable|string|max:50', 'employer_payable_account_code' => 'nullable|string|max:50',
            'rounding_mode' => 'required|in:nearest,nearest_unit,up,down', 'is_active' => 'required|boolean',
        ]);
    }
}
