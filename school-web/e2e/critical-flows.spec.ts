import { expect, test, type Page, type Route } from "@playwright/test";

type Json = Record<string, unknown> | unknown[];

const admin = {
  id: 1,
  name: "E2E Admin",
  email: "admin@e2e.test",
  role: "admin",
  is_active: true,
  permissions: ["*"],
  must_change_password: false,
};

async function json(route: Route, body: Json, status = 200) {
  await route.fulfill({ status, contentType: "application/json", body: JSON.stringify(body) });
}

async function mockAuthenticatedApi(
  page: Page,
  handler?: (route: Route, path: string, method: string) => Promise<boolean>,
) {
  await page.addInitScript(() => {
    localStorage.setItem("sm_cookie_session", "1");
    localStorage.setItem("sm_user", JSON.stringify({
      id: 1,
      name: "E2E Admin",
      email: "admin@e2e.test",
      role: "admin",
    }));
  });
  await page.route("**/api/**", async route => {
    const request = route.request();
    const path = new URL(request.url()).pathname;
    const method = request.method();
    if (handler && await handler(route, path, method)) return;
    if (path.endsWith("/auth/csrf-cookie")) return json(route, { csrf_token: "e2e-csrf" });
    if (path.endsWith("/auth/me")) return json(route, { user: admin, permissions: ["*"] });
    if (path.endsWith("/school-settings")) return json(route, { data: {} });
    if (path.endsWith("/notifications/unread-count")) {
      return json(route, { total_unread: 0, notifications: 0, messages: 0 });
    }
    return json(route, method === "GET" ? [] : {});
  });
}

test("login exposes every role at mobile width", async ({ page }) => {
  await page.setViewportSize({ width: 375, height: 900 });
  await page.route("**/api/auth/csrf-cookie", route => json(route, { csrf_token: "e2e-csrf" }));
  await page.goto("/login");

  for (const name of ["Student", "Parent", "Teacher", "Administrator", "Finance & Accounting", "HR", "Warehouse", "Procurement"]) {
    await expect(page.getByRole("button", { name: new RegExp(name, "i") })).toBeInViewport();
  }
});

test("logout posts to the API, clears the marker, and redirects", async ({ page }) => {
  let logoutRequests = 0;
  await mockAuthenticatedApi(page, async (route, path, method) => {
    if (path.endsWith("/auth/logout") && method === "POST") {
      logoutRequests += 1;
      await json(route, { message: "Logged out" });
      return true;
    }
    return false;
  });

  await page.goto("/admin");
  await page.getByRole("button", { name: "Logout" }).click();

  await expect(page).toHaveURL(/\/login$/);
  await expect.poll(() => logoutRequests).toBe(1);
  expect(await page.evaluate(() => localStorage.getItem("sm_cookie_session"))).toBeNull();
});

test("forced password change blocks the portal until completion", async ({ page }) => {
  let loggedIn = false;
  let mustChange = true;
  await page.route("**/api/**", async route => {
    const request = route.request();
    const path = new URL(request.url()).pathname;
    if (path.endsWith("/auth/csrf-cookie")) return json(route, { csrf_token: "e2e-csrf" });
    if (path.endsWith("/auth/login")) {
      loggedIn = true;
      return json(route, { token_type: "Bearer", expires_in: 7200, must_change_password: true, user: { ...admin, must_change_password: true } });
    }
    if (path.endsWith("/auth/me")) {
      return loggedIn
        ? json(route, { user: { ...admin, must_change_password: mustChange }, permissions: ["*"] })
        : json(route, { message: "Unauthenticated" }, 401);
    }
    if (path.endsWith("/auth/change-password")) {
      mustChange = false;
      return json(route, { message: "Password updated" });
    }
    if (path.endsWith("/school-settings")) return json(route, { data: {} });
    return json(route, []);
  });

  await page.goto("/login");
  await page.getByLabel(/email/i).fill("admin@e2e.test");
  await page.getByLabel(/^password$/i).fill("OldPassword123");
  await page.getByRole("button", { name: /sign in/i }).click();
  await expect(page).toHaveURL(/\/change-password$/);

  await page.locator("#current-password").fill("OldPassword123");
  await page.locator("#new-password").fill("NewPassword123");
  await page.locator("#confirm-password").fill("NewPassword123");
  await page.getByRole("button", { name: /update password/i }).click();
  await expect(page).toHaveURL(/\/admin$/);
});

test("payroll run completes draft to paid lifecycle", async ({ page }) => {
  let status = "draft";
  const run = () => ({
    id: 10, run_no: "PAY-2026-07", year: 2026, month: 7, status,
    total_gross: 1000, total_deductions: 100, total_net: 900,
    records: [{ id: 101, staff_user_id: 7, base_salary: 1000, allowances: 0, deductions: 100, advance_deduction: 0, net_pay: 900, staff: { name: "Teacher One" } }],
  });
  await mockAuthenticatedApi(page, async (route, path, method) => {
    if (path.endsWith("/finance/payroll/runs") && method === "GET") {
      await json(route, { data: [run()], current_page: 1, last_page: 1, total: 1 }); return true;
    }
    if (path.endsWith("/finance/payroll/runs/10") && method === "GET") {
      await json(route, run()); return true;
    }
    for (const next of ["process", "approve", "pay"] as const) {
      if (path.endsWith(`/finance/payroll/runs/10/${next}`)) {
        status = next === "process" ? "processed" : next === "approve" ? "approved" : "paid";
        await json(route, run()); return true;
      }
    }
    return false;
  });

  await page.goto("/finance/payroll-runs");
  await page.getByRole("button", { name: "فتح" }).click();
  await page.getByRole("button", { name: "معالجة" }).last().click();
  await expect(page.getByRole("button", { name: "اعتماد" }).last()).toBeVisible();
  await page.getByRole("button", { name: "اعتماد" }).last().click();
  await expect(page.getByRole("button", { name: "دفع" }).last()).toBeVisible();
  await page.getByRole("button", { name: "دفع" }).last().click();
  await expect(page.getByText(/paid/i).first()).toBeVisible();
});

test("HR employee to advance to insured payroll accounting journey", async ({ page }) => {
  let runStatus = "draft";
  const profile = {
    id: 3, employee_no: "EMP-7", department: "Academic", position: "Teacher", employment_status: "active",
    base_salary: "2000.00", social_insurance_registered: true, social_insurance_number: "SS-7", social_insurance_scheme_code: "SS",
    current_contract: { id: 4, contract_no: "C-7", contract_type: "fixed_term", start_date: "2026-01-01", end_date: "2026-12-31", days_remaining: 151, duration_days: 365, display_status: "active" },
    contracts: [], advances: [], warnings: [], payroll_components: [],
  };
  const employee = { id: 7, name: "Teacher One", email: "teacher@e2e.test", role: "teacher", staff_profile: profile, effective_social_insurance: { employee_rate: "5", employer_rate: "10", estimated_insurable_wage: "2000", estimated_employee_amount: 100, estimated_employer_amount: 200 } };
  const payroll = () => ({
    id: 10, run_no: "RUN-GLOBAL-2026-08", year: 2026, month: 8, status: runStatus,
    total_gross: 2000, total_deductions: 433.33, total_net: 1566.67,
    records: [{ id: 101, staff_user_id: 7, year: 2026, month: 8, base_salary: 2000, allowances: 0, deductions: 0, total_earnings: 0, gross_salary: 2000, insurable_wage: 2000, employee_social_insurance: 100, employer_social_insurance: 200, other_deductions: 0, advance_deduction: 333.33, employer_cost: 2200, net_pay: 1566.67, status: runStatus, staff: { id: 7, name: "Teacher One" }, components: [{ id: 1, component_code: "SOCIAL_EMPLOYEE", name_ar: "الضمان الاجتماعي", name_en: "Social", category: "deduction", calculation_type: "percentage", amount: 100 }, { id: 2, component_code: "ADVANCE-1-1", name_ar: "قسط سلفة", name_en: "Advance", category: "deduction", calculation_type: "fixed", amount: 333.33 }] }],
    accrual_journal: runStatus === "approved" || runStatus === "paid" ? { id: 2, reference_no: "JB-ACCRUAL", status: "posted" } : null,
    payment_journal: runStatus === "paid" ? { id: 3, reference_no: "JB-PAY", status: "posted" } : null,
  });
  await mockAuthenticatedApi(page, async (route, path, method) => {
    if (path.endsWith("/hr/staff") && method === "GET") { await json(route, { data: [employee], current_page: 1, last_page: 1, total: 1 }); return true; }
    if (path.endsWith("/hr/staff/7") && method === "GET") { await json(route, employee); return true; }
    if (path.endsWith("/hr/advances") && method === "GET") { await json(route, { data: [], current_page: 1, last_page: 1, total: 0 }); return true; }
    if (path.endsWith("/hr/advances") && method === "POST") { await json(route, { id: 8, advance_no: "ADV-8", status: "draft" }, 201); return true; }
    if (path.endsWith("/finance/payroll/runs") && method === "GET") { await json(route, { data: [payroll()], current_page: 1, last_page: 1, total: 1 }); return true; }
    if (path.endsWith("/finance/payroll/runs/10") && method === "GET") { await json(route, payroll()); return true; }
    for (const next of ["process", "approve", "pay"] as const) if (path.endsWith(`/finance/payroll/runs/10/${next}`)) { runStatus = next === "process" ? "processed" : next === "approve" ? "approved" : "paid"; await json(route, payroll()); return true; }
    return false;
  });

  await page.goto("/hr/staff");
  await page.getByRole("button", { name: "عرض الملف" }).click();
  await page.getByRole("button", { name: "الوظيفة والعقد" }).click();
  await expect(page.getByText("C-7")).toBeVisible();
  await page.getByRole("button", { name: "الضمان الاجتماعي" }).click();
  await expect(page.getByText("5%")).toBeVisible();
  await page.getByRole("button", { name: "إغلاق" }).click();

  await page.goto("/hr/advances");
  await page.getByRole("button", { name: "طلب سلفة" }).click();
  const dialog = page.getByRole("dialog");
  await dialog.locator("select").selectOption("3");
  await dialog.locator('input[type="number"]').nth(0).fill("1000");
  await dialog.locator('input[type="number"]').nth(1).fill("3");
  await dialog.locator("textarea").fill("Emergency");
  await dialog.getByRole("button", { name: "حفظ المسودة" }).click();

  await page.goto("/finance/payroll-runs");
  await page.getByRole("button", { name: "فتح" }).click();
  const payrollDialog = page.getByRole("dialog");
  await payrollDialog.getByRole("button", { name: "معالجة" }).click();
  await payrollDialog.getByRole("button", { name: "اعتماد" }).click();
  await payrollDialog.getByRole("button", { name: "دفع" }).click();
  await payrollDialog.getByRole("button", { name: "التفاصيل" }).click();
  await expect(page.getByText(/قسط السلفة/).first()).toBeVisible();
  await expect(payrollDialog.getByText(/JB-ACCRUAL/)).toBeVisible();
});

test("installment plan is created from an open invoice", async ({ page }) => {
  let submitted: Record<string, unknown> | null = null;
  await mockAuthenticatedApi(page, async (route, path, method) => {
    if (path.endsWith("/finance/installments/plans") && method === "GET") {
      await json(route, { data: [], current_page: 1, last_page: 1, total: 0 }); return true;
    }
    if (path.endsWith("/finance/invoices") && method === "GET") {
      await json(route, { data: [{ id: 9, invoice_no: "INV-9", student_user_id: 22, amount: 600, paid_amount: 100, student: { name: "Student One" } }] }); return true;
    }
    if (path.endsWith("/finance/installments/plans") && method === "POST") {
      submitted = requestJson(route);
      await json(route, { id: 4, plan_no: "PLAN-4", status: "active" }, 201); return true;
    }
    return false;
  });

  await page.goto("/finance/installments");
  await page.getByRole("button", { name: "New plan" }).click();
  await page.locator("#plan-invoice").selectOption("9");
  await page.getByRole("button", { name: "Create plan" }).click();
  await expect.poll(() => submitted).not.toBeNull();
  expect(submitted).toMatchObject({ invoice_id: 9, student_user_id: 22, total_amount: 500, num_installments: 3 });
});

test("admin user creation submits a payroll-ready staff profile", async ({ page }) => {
  let submitted: Record<string, unknown> | null = null;
  await mockAuthenticatedApi(page, async (route, path, method) => {
    if (path.endsWith("/admin/users") && method === "GET") {
      await json(route, { data: [], current_page: 1, last_page: 1, total: 0 }); return true;
    }
    if (path.endsWith("/admin/users") && method === "POST") {
      submitted = requestJson(route);
      await json(route, { user: { id: 33 } }, 201); return true;
    }
    if (path.endsWith("/admin/classes")) { await json(route, []); return true; }
    return false;
  });

  await page.goto("/admin/users");
  await page.getByRole("button", { name: /create user/i }).first().click();
  await page.locator("#name").fill("Payroll Employee");
  await page.locator("#email").fill("employee@e2e.test");
  await page.locator("#password").fill("StrongPassword123");
  await page.getByRole("dialog").locator("div.cursor-pointer").filter({ hasText: /^HR$/ }).click();
  await page.locator("#staff-department").fill("Human Resources");
  await page.locator("#staff-position").fill("Officer");
  await page.locator("#staff-salary").fill("2500");
  await page.getByRole("button", { name: /^create$/i }).click();
  await expect.poll(() => submitted).not.toBeNull();
  expect(submitted).toMatchObject({ role: "hr", staff: { department: "Human Resources", position: "Officer", base_salary: 2500 } });
});

function requestJson(route: Route): Record<string, unknown> {
  return route.request().postDataJSON() as Record<string, unknown>;
}
