import { apiFetch } from "./api";
import type { PaginatedResponse } from "@/types/api.types";
import type {
  AdvancePage, DisciplinaryWarning, EmployeeAdvance, EmployeeContract, HrDashboardData,
  PayrollComponentSetting, PayrollSettingsData, SocialInsuranceScheme, WarningPage,
} from "@/types/hrPayroll.types";

type Query = Record<string, string | number | boolean | null | undefined>;

export const HrEmployeesApi = {
  dashboard: () => apiFetch<HrDashboardData>("/hr/dashboard"),
  contracts: (query?: Query) => apiFetch<PaginatedResponse<EmployeeContract>>("/hr/contracts", { query }),
  contractHistory: (userId: number) => apiFetch<{ employment: unknown; contracts: EmployeeContract[] }>(`/hr/staff/${userId}/contracts`),
  createContract: (userId: number, body: Partial<EmployeeContract> & { overlap_reason?: string }) =>
    apiFetch<EmployeeContract>(`/hr/staff/${userId}/contracts`, { method: "POST", body }),
  renewContract: (contractId: number, body: Partial<EmployeeContract>) =>
    apiFetch<EmployeeContract>(`/hr/contracts/${contractId}/renew`, { method: "POST", body }),
};

export const HrWarningsApi = {
  list: (query?: Query) => apiFetch<WarningPage>("/hr/warnings", { query }),
  create: (body: Partial<DisciplinaryWarning>) => apiFetch<DisciplinaryWarning>("/hr/warnings", { method: "POST", body }),
  transition: (id: number, action: "submit" | "approve" | "receive" | "object" | "cancel", body?: Record<string, unknown>) =>
    apiFetch<DisciplinaryWarning>(`/hr/warnings/${id}/${action}`, { method: "POST", body }),
};

export const HrAdvancesApi = {
  list: (query?: Query) => apiFetch<AdvancePage>("/hr/advances", { query }),
  show: (id: number) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}`),
  create: (body: Record<string, unknown>) => apiFetch<EmployeeAdvance>("/hr/advances", { method: "POST", body }),
  submit: (id: number) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/submit`, { method: "POST" }),
  approve: (id: number) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/approve`, { method: "POST" }),
  reject: (id: number, reason: string) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/reject`, { method: "POST", body: { reason } }),
  cancel: (id: number, reason: string) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/cancel`, { method: "POST", body: { reason } }),
  disburse: (id: number, method: string) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/disburse`, { method: "POST", body: { method } }),
  settle: (id: number, method: string) => apiFetch<EmployeeAdvance>(`/hr/advances/${id}/settle`, { method: "POST", body: { method } }),
  reschedule: (id: number, body: { installment_count: number; first_deduction_month: string; reason: string }) =>
    apiFetch<EmployeeAdvance>(`/hr/advances/${id}/reschedule`, { method: "POST", body }),
};

export const PayrollSettingsApi = {
  get: () => apiFetch<PayrollSettingsData>("/finance/payroll/settings"),
  createComponent: (body: Omit<PayrollComponentSetting, "id">) => apiFetch<PayrollComponentSetting>("/finance/payroll/settings/components", { method: "POST", body }),
  createScheme: (body: Omit<SocialInsuranceScheme, "id">) => apiFetch<SocialInsuranceScheme>("/finance/payroll/settings/social-insurance", { method: "POST", body }),
  updateGeneral: (body: Record<string, unknown>) => apiFetch("/finance/payroll/settings/general", { method: "PATCH", body }),
  updateAccounts: (body: Record<string, unknown>) => apiFetch("/finance/payroll/settings/accounts", { method: "PATCH", body }),
  assignComponent: (staffProfileId: number, body: Record<string, unknown>) => apiFetch(`/finance/payroll/staff/${staffProfileId}/components`, { method: "POST", body }),
};

export const HrPayrollReportsApi = {
  report: <T>(type: string, query?: Query) => apiFetch<PaginatedResponse<T>>(`/hr/payroll-reports/${type}`, { query }),
};
