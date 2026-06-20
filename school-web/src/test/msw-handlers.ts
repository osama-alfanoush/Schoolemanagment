import { http, HttpResponse } from 'msw';
import { setupServer } from 'msw/node';

const BASE = '/api';

const authHandlers = [
  http.post(`${BASE}/auth/login`, () =>
    HttpResponse.json({
      access_token: 'fake-token-123',
      refresh_token: 'fake-refresh-456',
      token_type: 'Bearer',
      expires_in: 3600,
      user: {
        id: 1,
        name: 'Test User',
        email: 'test@school.com',
        role: 'admin',
        is_active: true,
        locale: null,
        photo_path: null,
      },
    })
  ),
  http.get(`${BASE}/auth/me`, () =>
    HttpResponse.json({
      user: {
        id: 1,
        name: 'Test User',
        email: 'test@school.com',
        role: 'admin',
        is_active: true,
        locale: null,
        photo_path: null,
      },
    })
  ),
  http.post(`${BASE}/auth/logout`, () => new HttpResponse(null, { status: 204 })),
  http.post(`${BASE}/auth/refresh`, () =>
    HttpResponse.json({
      access_token: 'fake-refreshed-token',
      refresh_token: 'fake-refresh-456',
    })
  ),
  // ThemeProvider polls this when a token is present; return an empty theme.
  http.get(`${BASE}/school-settings`, () => HttpResponse.json({ data: {} })),
];

const studentHandlers = [
  http.get(`${BASE}/student/dashboard`, () =>
    HttpResponse.json({ pending_assignments: 3, upcoming_events: 0 })
  ),
  http.get(`${BASE}/student/grades`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/attendance`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/assignments`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/timetable`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/report-card`, () => HttpResponse.json({})),
  http.get(`${BASE}/student/announcements`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/calendar`, () => HttpResponse.json([])),
  http.get(`${BASE}/student/performance-chart`, () => HttpResponse.json({ data: [] })),
  http.get(`${BASE}/student/library/books`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/student/transport/my-route`, () => HttpResponse.json({})),
  http.get(`${BASE}/student/medical/my-records`, () => HttpResponse.json({})),
  http.get(`${BASE}/student/library/my-borrowings`, () => HttpResponse.json({})),
];

const teacherHandlers = [
  http.get(`${BASE}/teacher/classes`, () => HttpResponse.json([])),
  http.get(`${BASE}/teacher/timetable`, () => HttpResponse.json([])),
  http.post(`${BASE}/teacher/grades`, () =>
    HttpResponse.json({ data: { id: 1, score: 85 } }, { status: 200 })
  ),
  http.post(`${BASE}/teacher/attendance`, () =>
    HttpResponse.json({ data: {} }, { status: 201 })
  ),
  http.post(`${BASE}/teacher/assignments`, () =>
    HttpResponse.json({ data: {} }, { status: 201 })
  ),
  http.post(`${BASE}/teacher/announcements`, () =>
    HttpResponse.json({ data: {} }, { status: 201 })
  ),
  http.post(`${BASE}/teacher/conduct`, () =>
    HttpResponse.json({ data: {} }, { status: 201 })
  ),
  http.post(`${BASE}/teacher/hr-requests`, () =>
    HttpResponse.json({ data: {} }, { status: 201 })
  ),
  http.get(`${BASE}/teacher/hr-requests`, () => HttpResponse.json([])),
  http.get(`${BASE}/teacher/announcements`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/teacher/grades/export`, () => HttpResponse.json({})),
  http.get(`${BASE}/teacher/assignments/1/submissions`, () => HttpResponse.json([])),
  http.patch(`${BASE}/teacher/submissions/1/grade`, () => HttpResponse.json({ data: {} })),
  http.post(`${BASE}/teacher/grade-components/1/1`, () => HttpResponse.json({})),
];

const adminHandlers = [
  http.get(`${BASE}/admin/users`, () =>
    HttpResponse.json({
      data: [],
      meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 },
    })
  ),
  http.get(`${BASE}/admin/dashboard/kpis`, () =>
    HttpResponse.json({
      students: 120,
      teachers: 15,
      staff: 8,
      classes: 10,
    })
  ),
  http.get(`${BASE}/admin/classes`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/subjects`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/exams`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/academic-years`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/calendar`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/audit-logs`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/hr-requests`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/attendance/dashboard`, () => HttpResponse.json({})),
  http.get(`${BASE}/admin/announcements`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/admin/library/books`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/admin/transport/routes`, () => HttpResponse.json([])),
  http.get(`${BASE}/admin/medical/records`, () => HttpResponse.json({})),
  http.get(`${BASE}/admin/medical/visits`, () => HttpResponse.json({})),
];

const parentHandlers = [
  http.get(`${BASE}/parent/children`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/announcements`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/overview`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/grades`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/children/1/assignments`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/children/1/attendance`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/children/1/invoices`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/children/1/payments`, () => HttpResponse.json([])),
  http.get(`${BASE}/parent/children/1/conduct`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/report-card`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/performance-chart`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/medical`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/medical-visits`, () => HttpResponse.json({})),
  http.get(`${BASE}/parent/children/1/transport`, () => HttpResponse.json({})),
];

const financeHandlers = [
  http.get(`${BASE}/finance/fee-structures`, () => HttpResponse.json([])),
  http.get(`${BASE}/finance/invoices`, () =>
    HttpResponse.json({
      data: [],
      meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 },
    })
  ),
  http.get(`${BASE}/finance/outstanding`, () => HttpResponse.json([])),
  http.get(`${BASE}/finance/payroll`, () => HttpResponse.json([])),
  http.get(`${BASE}/finance/reports`, () => HttpResponse.json({})),
];

const hrHandlers = [
  http.get(`${BASE}/hr/staff`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/hr/staff/1`, () => HttpResponse.json({ id: 1, name: 'Staff Member' })),
  http.get(`${BASE}/hr/leave-requests`, () => HttpResponse.json([])),
  http.get(`${BASE}/hr/leave-balances`, () => HttpResponse.json({})),
  http.get(`${BASE}/hr/staff-attendance`, () => HttpResponse.json({})),
  http.get(`${BASE}/hr/staff-attendance/report`, () => HttpResponse.json({})),
];

const notificationHandlers = [
  http.get(`${BASE}/notifications`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/notifications/unread-count`, () =>
    HttpResponse.json({ notifications: 0, messages: 0 })
  ),
  http.get(`${BASE}/notifications/preferences`, () => HttpResponse.json({})),
  http.get(`${BASE}/messages/threads`, () => HttpResponse.json([])),
  http.get(`${BASE}/messages/conversation/1`, () => HttpResponse.json([])),
];

const accountingHandlers = [
  http.get(`${BASE}/accounting/journal-entries`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/accounting/journal-entries/1`, () => HttpResponse.json({})),
  http.get(`${BASE}/accounting/chart-of-accounts`, () => HttpResponse.json([])),
  http.get(`${BASE}/accounting/budget`, () => HttpResponse.json([])),
  http.get(`${BASE}/accounting/closings`, () => HttpResponse.json([])),
  http.get(`${BASE}/accounting/reports/trial-balance`, () => HttpResponse.json({})),
  http.get(`${BASE}/accounting/reports/income-statement`, () => HttpResponse.json({})),
  http.get(`${BASE}/accounting/reports/balance-sheet`, () => HttpResponse.json({})),
  http.get(`${BASE}/accounting/audit-trail`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
];

const warehouseHandlers = [
  http.get(`${BASE}/warehouse/categories`, () => HttpResponse.json([])),
  http.get(`${BASE}/warehouse/items`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/warehouse/items/1`, () => HttpResponse.json({})),
  http.get(`${BASE}/warehouse/movements`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/warehouse/purchase-requests`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/warehouse/inventory-counts`, () => HttpResponse.json([])),
  http.get(`${BASE}/warehouse/dashboard`, () => HttpResponse.json({})),
  http.get(`${BASE}/warehouse/reports/consumption`, () =>
    HttpResponse.json({ data: [], meta: { current_page: 1, last_page: 1, per_page: 15, total: 0 } })
  ),
  http.get(`${BASE}/warehouse/reports/inventory`, () => HttpResponse.json({})),
];

const paymentHandlers = [
  http.post(`${BASE}/payments/create-intent`, () => HttpResponse.json({})),
  http.post(`${BASE}/payments/confirm`, () => HttpResponse.json({})),
  http.get(`${BASE}/payments/status/test-id`, () => HttpResponse.json({})),
  http.get(`${BASE}/payments/methods`, () => HttpResponse.json([])),
  http.post(`${BASE}/payments/setup-intent`, () => HttpResponse.json({})),
];

export const handlers = [
  ...authHandlers,
  ...studentHandlers,
  ...teacherHandlers,
  ...adminHandlers,
  ...parentHandlers,
  ...financeHandlers,
  ...hrHandlers,
  ...notificationHandlers,
  ...accountingHandlers,
  ...warehouseHandlers,
  ...paymentHandlers,
];

export const server = setupServer(...handlers);