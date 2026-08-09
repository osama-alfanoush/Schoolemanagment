import { beforeEach, describe, expect, it } from "vitest";
import { http, HttpResponse } from "msw";
import { server } from "./msw-handlers";
import { authStore, PayrollRuns } from "@/lib/api";
import { HrAdvancesApi, HrEmployeesApi, HrWarningsApi, PayrollSettingsApi } from "@/lib/hrPayrollApi";

beforeEach(() => {
  localStorage.clear();
  authStore.setSession({ id: 5, name: "HR", email: "hr@test.com", role: "hr", is_active: true });
});

describe("HR and payroll workspace API", () => {
  it("loads actionable dashboard indicators", async () => {
    const dashboard = await HrEmployeesApi.dashboard();
    expect(dashboard.contracts_expiring_soon).toBe(1);
    expect(dashboard.uninsured_staff).toBe(1);
  });

  it("creates contract history instead of patching the profile", async () => {
    let endpoint = "";
    server.use(http.post("/api/hr/staff/7/contracts", ({ request }) => {
      endpoint = new URL(request.url).pathname;
      return HttpResponse.json({ id: 9, contract_no: "C-9", contract_type: "indefinite", start_date: "2026-09-01", end_date: null, base_salary: "1200.00", status: "active", is_current: true, days_remaining: null, duration_days: null, display_status: "indefinite", staff_profile_id: 3 }, { status: 201 });
    }));
    const contract = await HrEmployeesApi.createContract(7, { contract_no: "C-9", contract_type: "indefinite", start_date: "2026-09-01", base_salary: "1200.00" });
    expect(endpoint).toBe("/api/hr/staff/7/contracts");
    expect(contract.display_status).toBe("indefinite");
  });

  it("uses explicit warning and advance transitions", async () => {
    const calls: string[] = [];
    server.use(
      http.post("/api/hr/warnings/4/approve", () => { calls.push("warning-approved"); return HttpResponse.json({ id: 4, status: "issued" }); }),
      http.post("/api/hr/advances/8/disburse", async ({ request }) => { calls.push((await request.json() as { method: string }).method); return HttpResponse.json({ id: 8, status: "disbursed" }); }),
      http.post("/api/hr/advances/8/settle", () => { calls.push("settled"); return HttpResponse.json({ id: 8, status: "settled" }); }),
    );
    await HrWarningsApi.transition(4, "approve");
    await HrAdvancesApi.disburse(8, "bank_transfer");
    await HrAdvancesApi.settle(8, "cash");
    expect(calls).toEqual(["warning-approved", "bank_transfer", "settled"]);
  });

  it("submits social-insurance rates only from settings", async () => {
    let rates: unknown;
    server.use(http.post("/api/finance/payroll/settings/social-insurance", async ({ request }) => {
      rates = await request.json();
      return HttpResponse.json({ id: 1, ...(rates as object) }, { status: 201 });
    }));
    await PayrollSettingsApi.createScheme({ scheme_code: "SS", name_ar: "الضمان", name_en: "Social", employee_rate: "5", employer_rate: "10", calculation_base: "insurable", effective_from: "2026-01-01", rounding_mode: "nearest", is_active: true });
    expect(rates).toMatchObject({ employee_rate: "5", employer_rate: "10", effective_from: "2026-01-01" });
  });

  it("creates payroll runs without a client-controlled school id", async () => {
    let payload: Record<string, unknown> = {};
    server.use(http.post("/api/finance/payroll/runs", async ({ request }) => {
      payload = await request.json() as Record<string, unknown>;
      return HttpResponse.json({ id: 11, run_no: "RUN-S1-2026-08", year: 2026, month: 8, status: "draft" }, { status: 201 });
    }));

    await PayrollRuns.createRun({ year: 2026, month: 8 });
    expect(payload).toEqual({ year: 2026, month: 8 });
    expect(payload).not.toHaveProperty("school_id");
  });
});
