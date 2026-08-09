import type { PaginatedResponse } from "./api.types";

export type ContractDisplayStatus = "active" | "expiring_soon" | "expired" | "indefinite";
export interface EmployeeContract {
  id: number; staff_profile_id: number; contract_no: string; contract_type: "fixed_term" | "indefinite";
  start_date: string; end_date: string | null; probation_days?: number | null; probation_end?: string | null;
  base_salary: string; status: string; is_current: boolean; days_remaining: number | null;
  duration_days: number | null; display_status: ContractDisplayStatus;
  staff_profile?: { id: number; employee_no?: string; user?: { id: number; name: string; email?: string } };
}

export interface HrDashboardData {
  active_staff: number; terminated_staff: number; contracts_expiring_soon: number; expired_contracts: number;
  uninsured_staff: number; pending_advances: number; pending_warnings: number;
  current_payroll_run?: { id: number; run_no: string; status: string; total_net: string } | null;
  expiring_contracts: EmployeeContract[];
}

export interface PayrollComponentSetting {
  id: number; code: string; name_ar: string; name_en: string; category: "earning" | "deduction" | "employer_contribution";
  calculation_type: "fixed" | "percentage"; percentage_base?: string | null; amount?: string | null; rate?: string | null;
  minimum_amount?: string | null; maximum_amount?: string | null; rounding_mode: string; is_recurring: boolean;
  effective_from: string; effective_to?: string | null; is_social_insurance_base: boolean; is_taxable: boolean;
  show_on_payslip: boolean; is_active: boolean; priority: number;
}

export interface SocialInsuranceScheme {
  id: number; scheme_code: string; name_ar: string; name_en: string; employee_rate: string; employer_rate: string;
  calculation_base: string; minimum_wage?: string | null; maximum_wage?: string | null; effective_from: string;
  effective_to?: string | null; rounding_mode: string; is_active: boolean;
}

export interface PayrollSettingsData {
  general: { contract_alert_days: number[]; proration_policy: string; negative_net_policy: string; currency: string };
  accounts: Record<string, string | number | null>;
  components: PayrollComponentSetting[];
  social_insurance_schemes: SocialInsuranceScheme[];
}

export interface DisciplinaryWarning {
  id: number; warning_no: string; staff_profile_id: number; warning_type: string; offence: string;
  incident_description: string; incident_date: string; issued_date: string; level: string; status: string;
  employee_comments?: string | null; effect_expires_at?: string | null;
  staff_profile?: { user?: { id: number; name: string } }; issuer?: { id: number; name: string };
}

export interface AdvanceInstallment {
  id: number; installment_no: number; due_date: string; amount: string; collected_amount: string; status: string;
}

export interface EmployeeAdvance {
  id: number; advance_no: string; staff_profile_id: number; original_amount: string; remaining_balance: string;
  reason: string; requested_at: string; disbursed_at?: string | null; installment_count: number;
  installment_amount: string; first_deduction_month: string; status: string; journal_batch_id?: number | null;
  staff_profile?: { user?: { id: number; name: string } }; installments?: AdvanceInstallment[];
}

export type ContractPage = PaginatedResponse<EmployeeContract>;
export type WarningPage = PaginatedResponse<DisciplinaryWarning>;
export type AdvancePage = PaginatedResponse<EmployeeAdvance>;
