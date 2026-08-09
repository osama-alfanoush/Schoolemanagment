// ─── Dashboard Data Shapes ────────────────────────────────────────
export interface StudentDashboardData {
  pending_assignments: number;
  recent_grades: unknown[];
  today_attendance: { status: string };
  upcoming_events: unknown[];
  upcoming_assignments: unknown[];
  attendance_rate: number;
  average_grade: number;
  unread_messages: number;
  grade?: number;
  class_name?: string;
  today_schedule: TimetableSlot[];
  announcements: unknown[];
}

export interface TimetableSlot {
  id?: number;
  start_time: string;
  end_time: string;
  subject?: { name: string };
  teacher_name?: string;
  room?: string;
  is_current?: boolean;
}

export interface ParentChild {
  id: number;
  name: string;
  class_room?: ClassRoom;
  user?: User;
}

export interface ChildOverview {
  student: User & { student_profile?: StudentProfile };
  attendance?: { present: number; absent: number; late: number };
  grades?: unknown[];
}

export interface AdminKpis {
  students: number;
  teachers: number;
  staff: number;
  classes: number;
  today_attendance_rate: number;
  pending_hr_requests: number;
  outstanding_fees: number;
  present_count?: number;
  absent_count?: number;
  late_count?: number;
  academic_year?: string;
}

export interface AttendanceDashboard {
  today: { present?: number; absent?: number; late?: number };
  by_class: unknown[];
}

export interface FinanceReports {
  total_collected: number;
  total_outstanding?: number;
  invoices_issued: number;
  payroll_count: number;
}

export interface OutstandingAccount {
  student?: User;
  name?: string;
  amount_due?: number;
  balance?: number;
}

export interface PayrollRecord {
  id: number;
  month: number;
  year: number;
  total_amount: number;
}

export interface StaffAttendanceData {
  data: unknown[];
}

export interface MessageThread {
  id: number;
  other_user?: { id: number; name: string; photo_path?: string };
  last_message?: { body: string; created_at: string };
}

export interface Message {
  id: number;
  body: string;
  created_at: string;
  is_mine?: boolean;
}

export interface AuditLog {
  id: number;
  created_at: string;
  user_name: string;
  user_role?: string;
  action: string;
  entity_type: string;
  description: string;
  ip_address?: string;
}

export interface AuditTrailEntry {
  id: number;
  created_at: string;
  user_name: string;
  user_role?: string;
  action: string;
  entity_type: string;
  description: string;
  ip_address?: string;
}

export interface TrialBalanceData {
  data?: { code: string; name: string; type: string; debit: number; credit: number }[];
  total_revenue?: number;
  total_expenses?: number;
  net_income?: number;
  cash_balance?: number;
}

export interface WarehouseStats {
  total_items: number;
  low_stock_count: number;
  out_of_stock: number;
  pending_requests: number;
}

export interface InventoryCount {
  id: number;
  count_ref?: string;
  count_type: string;
  count_date: string;
  item_id?: number;
  item?: { id: number; name: string; sku?: string } | null;
  system_qty?: number;
  physical_qty?: number;
  notes?: string;
}

export interface ConsumptionRow {
  id: number;
  item_name: string;
  total_consumed: number;
}

export interface CalendarEvent {
  id: number;
  title: string;
  start_date: string;
  end_date?: string;
  type: string;
}

export interface AcademicYear {
  id: number;
  name: string;
  start_date: string;
  end_date: string;
  is_current?: boolean;
}

export interface TimetableEntry {
  id: number;
  subject_id: number;
  subject?: Subject;
  day_of_week: number;
  start_time: string;
  end_time: string;
  room?: string;
  teacher_name?: string;
}

export interface Announcement {
  id: number;
  title: string;
  body: string;
  created_at: string;
  priority?: string;
}

export interface PaginatedChartData {
  data: unknown[];
}

// ─── Enums / Unions ───────────────────────────────────────────────
export type UserRole =
  | 'admin' | 'teacher' | 'student' | 'parent'
  | 'finance' | 'hr' | 'warehouse' | 'procurement';

export type AttendanceStatus = 'present' | 'absent' | 'late' | 'excused';
export type InvoiceStatus = 'pending' | 'partial' | 'paid' | 'overdue' | 'cancelled';
export type PaymentMethod = 'cash' | 'card' | 'bank_transfer' | 'online';
export type GradeComponentType = 'quiz' | 'homework' | 'exam' | 'project';
export type JournalEntryType = 'debit' | 'credit';
export type JournalSource =
  | 'manual' | 'invoice' | 'payroll' | 'expense'
  | 'purchase' | 'supplier_payment' | 'installment';
export type PurchaseRequestStatus = 'pending' | 'approved' | 'rejected' | 'purchased';
export type MovementType = 'in' | 'out' | 'adjustment' | 'return';

// ─── API Wrappers ─────────────────────────────────────────────────
export interface ApiResponse<T = unknown> {
  data?: T;
  message?: string;
  errors?: Record<string, string[]>;
}

export interface PaginatedMeta {
  current_page: number;
  last_page: number;
  per_page: number;
  total: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  meta: PaginatedMeta;
}

// ─── User & Profiles ──────────────────────────────────────────────
export interface ClassRoom {
  id: number;
  name: string;
  grade: string;
  section?: string;
  capacity?: number;
  homeroom_teacher_id?: number;
  homeroom_teacher?: User;
  academic_year?: AcademicYear;
}

export interface StudentProfile {
  id: number;
  user_id: number;
  admission_no?: string;
  class_room_id?: number;
  class_room?: ClassRoom;
  date_of_birth?: string;
  gender?: string;
  address?: string;
  medical_notes?: string;
  emergency_contact_name?: string;
  emergency_contact_phone?: string;
}

export interface StaffProfile {
  id: number;
  user_id: number;
  department?: string;
  position?: string;
  hire_date?: string;
  contract_type?: string;
  base_salary?: number;
  qualifications?: string;
  annual_leave_balance?: number;
  sick_leave_balance?: number;
}

export interface User {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  permissions?: string[];
  must_change_password?: boolean;
  phone?: string;
  photo_path?: string | null;
  is_active: boolean;
  student_profile?: StudentProfile;
  staff_profile?: StaffProfile;
  created_at?: string;
  updated_at?: string;
}

// ─── Academic ────────────────────────────────────────────────────
export interface Subject {
  id: number;
  name: string;
  code: string;
}

export interface GradeComponent {
  id: number;
  class_room_id: number;
  subject_id: number;
  subject?: Subject;
  name: string;
  type: GradeComponentType;
  weight: number;
  max_score: number;
}

export interface Grade {
  id: number;
  student_user_id: number;
  grade_component_id: number;
  component?: GradeComponent;
  score: number;
  entered_by: number;
  created_at?: string;
}

export interface AttendanceRecord {
  id: number;
  student_user_id: number;
  class_room_id: number;
  subject_id?: number;
  date: string;
  status: AttendanceStatus;
  marked_by: number;
  note?: string;
}

export interface Assignment {
  id: number;
  title: string;
  class_room_id: number;
  subject_id: number;
  subject?: Subject;
  due_at: string;
  instructions?: string;
  max_score?: number;
  attachment_path?: string;
  created_by: number;
  created_at?: string;
}

export interface Submission {
  id: number;
  assignment_id: number;
  student_user_id: number;
  content_text?: string;
  file_path?: string;
  status: 'pending' | 'submitted' | 'graded';
  score?: number;
  feedback?: string;
  submitted_at?: string;
  graded_by?: number;
}

// ─── Finance ─────────────────────────────────────────────────────
export interface Payment {
  id: number;
  invoice_id: number;
  invoice?: Invoice;
  amount: number;
  method: PaymentMethod;
  paid_at: string;
  recorded_by: number;
  status?: 'posted' | 'reversed';
  receipt?: { id: number; receipt_no: string; status: string } | null;
}

export type BillingCycle = "monthly" | "semester" | "yearly" | "one-time";

export interface FeeStructure {
  id: number;
  name: string;
  grade?: string | number | null;
  billing_cycle: BillingCycle;
  amount: number;
  is_active: boolean;
}

export interface Invoice {
  id: number;
  student_user_id: number;
  student?: User;
  invoice_no: string;
  description: string;
  amount: number;
  paid_amount: number;
  due_date: string;
  status: InvoiceStatus;
  payments?: Payment[];
  fee_structure?: FeeStructure;
  created_at?: string;
}

export type FinanceWorkflowStatus = 'draft' | 'approved' | 'posted' | 'reversed';

export interface ReceiptAllocation {
  id: number;
  invoice_id: number;
  installment_id?: number | null;
  amount: number;
  invoice?: Invoice;
}

export interface PaymentReceipt {
  id: number;
  receipt_no: string;
  student_user_id: number;
  student?: User;
  amount: number;
  method: PaymentMethod;
  receipt_date: string;
  reference?: string | null;
  cash_account?: string | null;
  note?: string | null;
  status: FinanceWorkflowStatus;
  allocations?: ReceiptAllocation[];
  created_at?: string;
}

export interface StudentFinancialAdjustment {
  id: number;
  adjustment_no: string;
  student_user_id: number;
  student?: User;
  invoice_id?: number | null;
  invoice?: Invoice;
  type: 'discount' | 'adjustment' | 'refund';
  direction: 'debit' | 'credit';
  calculation_type: 'amount' | 'percentage';
  value: number;
  amount: number;
  reason: string;
  status: FinanceWorkflowStatus;
  created_at?: string;
}

export interface StudentFinanceSummary {
  gross_fees: number;
  discounts: number;
  adjustments: number;
  amount_due: number;
  paid: number;
  remaining: number;
  overdue: number;
}

export interface FinancialTimelineRow {
  date: string;
  type: 'invoice' | 'payment' | 'discount' | 'adjustment' | 'refund';
  status: string;
  description: string;
  reference?: string | null;
  debit: number;
  credit: number;
  balance?: number;
  source_type: string;
  source_id: number;
}

export interface StudentFinanceProfile {
  student: User & { student_profile?: StudentProfile; parents?: User[] };
  summary: StudentFinanceSummary;
  invoices: Invoice[];
  payment_plans: PaymentPlan[];
  payments: Payment[];
  adjustments: StudentFinancialAdjustment[];
  timeline: FinancialTimelineRow[];
}

export interface StudentStatement {
  data: FinancialTimelineRow[];
  current_page: number;
  per_page: number;
  last_page: number;
  total: number;
  opening_balance: number;
  period_debit: number;
  period_credit: number;
  closing_balance: number;
}

// ─── Accounting ───────────────────────────────────────────────────
export interface JournalEntry {
  id: number;
  entry_date: string;
  reference_no: string;
  description: string;
  type: JournalEntryType;
  account_code: string;
  account_name: string;
  amount: number;
  source?: JournalSource;
  created_by: number;
  created_at?: string;
  status?: string;
  total_debit?: number;
  total_credit?: number;
}

export interface JournalBatch {
  id: number;
  reference_no: string;
  entry_date: string;
  description: string;
  source: string;
  status: FinanceWorkflowStatus;
  lines: JournalEntry[];
  total_debit?: number;
  total_credit?: number;
}

export interface ChartOfAccount {
  id: number;
  account_code: string;
  account_name: string;
  account_type: 'asset' | 'liability' | 'equity' | 'income' | 'expense';
  is_active: boolean;
  description?: string;
  normal_balance?: string;
  balance?: number;
  level?: number;
}

export interface BudgetPlan {
  id: number;
  fiscal_year: number;
  category: string;
  sub_category?: string;
  planned_amount: number;
  actual_amount: number;
  usage_percent?: number;
  account_code?: string;
  budgeted_amount?: number;
}

export interface FinancialClosing {
  id: number;
  month: number;
  year: number;
  status: 'open' | 'closed';
  notes?: string;
  closed_by?: number;
  closed_at?: string;
  name?: string;
  period_name?: string;
  is_current?: boolean;
}

// ─── Warehouse ───────────────────────────────────────────────────
export interface WarehouseCategory {
  id: number;
  name: string;
  description?: string;
  items_count?: number;
}

export interface UserRef {
  id: number;
  name: string;
  role?: string;
}

export interface WarehouseItem {
  id: number;
  name: string;
  sku?: string;
  category_id: number;
  category?: { id: number; name: string } | null;
  unit: string;
  current_qty: number;
  min_stock_qty: number;
  location?: string;
  description?: string;
  is_active: boolean;
  unit_cost?: number | null;
  last_unit_cost?: number | null;
}

// Procurement
export type PurchaseOrderStatus =
  | 'draft' | 'pending_approval' | 'approved' | 'partially_received'
  | 'received' | 'closed' | 'cancelled';

export interface SupplierAccount {
  id: number;
  balance: number;
  credit_limit?: number | null;
  payment_terms: string;
}

export interface Supplier {
  id: number;
  code: string;
  name: string;
  contact_person?: string | null;
  phone: string;
  secondary_phone?: string | null;
  email?: string | null;
  address?: string | null;
  tax_number?: string | null;
  is_active: boolean;
  account?: SupplierAccount | null;
}

export interface PurchaseOrderItem {
  id: number;
  warehouse_item_id: number;
  warehouse_item?: WarehouseItem | null;
  warehouseItem?: WarehouseItem | null;
  description?: string | null;
  quantity_ordered: number;
  quantity_received: number;
  unit: string;
  unit_cost: number;
  line_total: number;
  warehouse_location?: string | null;
}

export interface PurchaseOrder {
  id: number;
  po_no: string;
  supplier_id: number;
  supplier?: Supplier | null;
  status: PurchaseOrderStatus;
  order_date: string;
  expected_date?: string | null;
  subtotal: number;
  tax: number;
  total: number;
  notes?: string | null;
  items?: PurchaseOrderItem[];
  requestedBy?: UserRef | null;
}

export interface GoodsReceipt {
  id: number;
  grn_no: string;
  purchase_order_id: number;
  purchase_order?: PurchaseOrder | null;
  purchaseOrder?: PurchaseOrder | null;
  status: string;
  notes?: string | null;
  received_at: string;
  received_by?: UserRef | null;
  items?: Array<{
    id: number;
    quantity_received: number;
    unit_cost: number;
    purchase_order_item?: PurchaseOrderItem | null;
  }>;
}

export interface SupplierInvoice {
  id: number;
  invoice_no: string;
  supplier_invoice_ref?: string | null;
  supplier_id: number;
  supplier?: Supplier | null;
  purchase_order_id?: number | null;
  invoice_date: string;
  due_date: string;
  amount: number;
  paid_amount: number;
  status: 'pending' | 'partial' | 'paid' | 'overdue' | 'cancelled';
  notes?: string | null;
}

export interface ProcurementDashboardData {
  suppliers_active: number;
  orders_by_status: Record<string, number>;
  pending_approval: number;
  awaiting_delivery: number;
  month_received_total: number;
  total_payable: number;
}

// ─── Finance sub-modules (installments + payroll runs) ───────────
export interface InstallmentRow {
  id: number;
  payment_plan_id: number;
  sequence_no: number;
  due_date: string;
  amount: number;
  paid_amount: number;
  status: 'pending' | 'partial' | 'paid' | 'overdue' | 'waived';
  paid_at?: string | null;
  plan?: PaymentPlan | null;
}

export interface PaymentPlan {
  id: number;
  plan_no: string;
  student_user_id: number;
  invoice_id?: number | null;
  total_amount: number;
  down_payment: number;
  num_installments: number;
  frequency: 'monthly' | 'quarterly';
  start_date: string;
  status: 'active' | 'completed' | 'defaulted' | 'cancelled';
  student?: UserRef | null;
  invoice?: { id: number; invoice_no: string; amount: number; paid_amount?: number; status?: string } | null;
  installments?: InstallmentRow[];
}

export interface CreatePaymentPlanRequest {
  student_user_id: number;
  invoice_id?: number;
  total_amount: number;
  down_payment?: number;
  num_installments: number;
  frequency?: 'monthly' | 'quarterly';
  start_date: string;
}

export interface PayInstallmentRequest {
  amount: number;
  method: 'cash' | 'bank_transfer' | 'card' | 'online';
  reference?: string;
  note?: string;
}

export interface PayrollRunRecord {
  id: number;
  staff_user_id: number;
  year: number;
  month: number;
  base_salary: number;
  allowances: number;
  deductions: number;
  advance_deduction: number;
  net_pay: number;
  total_earnings: number;
  gross_salary: number;
  insurable_wage: number;
  employee_social_insurance: number;
  employer_social_insurance: number;
  employer_contributions: number;
  other_deductions: number;
  employer_cost: number;
  contract_snapshot?: Record<string, unknown> | null;
  social_insurance_snapshot?: Record<string, unknown> | null;
  calculation_snapshot?: { formula?: string; amounts_cents?: Record<string, number>; [key: string]: unknown } | null;
  components?: Array<{ id: number; component_code: string; name_ar: string; name_en: string; category: string; calculation_type: string; rate?: number | null; amount: number }>;
  status: string;
  paid_at?: string | null;
  staff?: { id: number; name: string; role?: string };
}

export interface PayrollRunRow {
  id: number;
  run_no: string;
  year: number;
  month: number;
  status: 'draft' | 'processed' | 'approved' | 'paid' | 'reversed';
  total_gross: number;
  total_deductions: number;
  total_net: number;
  processed_by?: { id: number; name: string } | null;
  approved_by?: { id: number; name: string } | null;
  accrual_journal?: { id: number; reference_no: string; status: string; lines?: JournalEntry[] } | null;
  payment_journal?: { id: number; reference_no: string; status: string; lines?: JournalEntry[] } | null;
  records?: PayrollRunRecord[];
}

export interface StockMovement {
  id: number;
  item_id: number;
  item?: WarehouseItem | null;
  movement_type: MovementType;
  quantity: number;
  reference_no?: string;
  supplier?: string;
  department?: string;
  recipient_name?: string;
  reason?: string;
  notes?: string;
  category_name?: string;
  performed_by: number;
  performedBy?: UserRef | null;
  movement_date: string;
}

export interface PurchaseRequest {
  id: number;
  request_no: string;
  item_id: number;
  item?: WarehouseItem | null;
  quantity_requested: number;
  unit: string;
  estimated_cost?: number;
  justification?: string;
  department?: string;
  status: PurchaseRequestStatus;
  requested_by: number;
  requestedBy?: UserRef | null;
  reviewed_by?: number;
  reviewedBy?: UserRef | null;
  reviewed_at?: string;
  created_at?: string;
  admin_notes?: string;
}

// ─── HR ───────────────────────────────────────────────────────────
export interface Staff {
  id: number;
  user_id: number;
  user?: User;
  department?: string;
  position?: string;
  hire_date?: string;
  contract_type?: string;
  base_salary?: number;
  qualifications?: string;
  annual_leave_balance?: number;
  sick_leave_balance?: number;
}

export interface LeaveRequest {
  id: number;
  staff_user_id: number;
  leave_type: string;
  start_date: string;
  end_date: string;
  reason?: string;
  status: 'pending' | 'approved' | 'rejected';
  admin_response?: string;
  reviewed_by?: number;
  reviewed_at?: string;
}

// ─── Library ─────────────────────────────────────────────────────
export interface LibraryBook {
  id: number;
  isbn?: string;
  title: string;
  author: string;
  category?: string;
  publisher?: string;
  year_published?: number;
  copies_total: number;
  copies_available: number;
  shelf_location?: string;
  is_active: boolean;
}

export interface BorrowRecord {
  id: number;
  book_id: number;
  user_id: number;
  borrowed_at: string;
  due_date: string;
  returned_at?: string;
  status: 'borrowed' | 'returned' | 'overdue';
}

// ─── Transport ────────────────────────────────────────────────────
export interface TransportRoute {
  id: number;
  name: string;
  pickup_points: string;
  drop_points: string;
  is_active: boolean;
  bus_number?: string;
  route_name?: string;
  vehicle_plate?: string;
  capacity?: number;
  driver_name?: string;
  driver_phone?: string;
  pickup_time?: string;
  dropoff_time?: string;
  pickup_stop?: string;
  distance?: number;
  stops?: { name: string; time?: string }[];
}

export interface TransportVehicle {
  id: number;
  plate_number: string;
  model: string;
  capacity: number;
  driver_name?: string;
  driver_phone?: string;
  is_active: boolean;
}

// ─── Medical ──────────────────────────────────────────────────────
export interface MedicalRecord {
  id: number;
  student_user_id: number;
  record_type: string;
  description: string;
  record_date: string;
  recorded_by: number;
}

export interface MedicalVisit {
  id: number;
  student_user_id: number;
  visit_date: string;
  reason: string;
  diagnosis?: string;
  treatment?: string;
  doctor_name?: string;
  hospital_name?: string;
  follow_up_date?: string;
  recorded_by: number;
}

// ─── Request Types ────────────────────────────────────────────────

// Auth
export interface UpdateProfileRequest {
  name?: string;
  phone?: string;
  locale?: string;
}

export interface ChangePasswordRequest {
  current_password: string;
  new_password: string;
  new_password_confirmation: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  token_type: string;
  expires_in: number;
  must_change_password?: boolean;
  user: User;
}

export interface ResetPasswordRequest {
  token: string;
  email: string;
  password: string;
  password_confirmation: string;
}

// Attendance
export interface MarkAttendanceRequest {
  class_room_id: number;
  subject_id?: number;
  date: string;
  records: Array<{
    student_user_id: number;
    status: AttendanceStatus;
    note?: string;
  }>;
}

export interface EnterGradeRequest {
  student_user_id: number;
  grade_component_id: number;
  score: number;
}

// Finance
export interface GenerateInvoicesRequest {
  student_ids: number[];
  fee_structure_id: number;
  due_date?: string;
}

export interface RecordPaymentRequest {
  amount: number;
  method: PaymentMethod;
  paid_at?: string;
}

// Accounting
export interface CreateJournalEntryRequest {
  entry_date: string;
  description: string;
  type: JournalEntryType;
  account_code: string;
  account_name: string;
  amount: number;
  source?: JournalSource;
}

export interface CreateAccountRequest {
  account_code: string;
  account_name: string;
  account_type: 'asset' | 'liability' | 'equity' | 'income' | 'expense';
  description?: string;
  is_active?: boolean;
}

export interface UpdateAccountRequest {
  account_code?: string;
  account_name?: string;
  account_type?: 'asset' | 'liability' | 'equity' | 'income' | 'expense';
  description?: string;
  is_active?: boolean;
}

export interface CreateBudgetRequest {
  fiscal_year: number;
  category: string;
  sub_category?: string;
  planned_amount: number;
  actual_amount?: number;
  created_by?: number;
}

export interface UpdateBudgetRequest {
  fiscal_year?: number;
  category?: string;
  sub_category?: string;
  planned_amount?: number;
  actual_amount?: number;
}

export interface CloseMonthRequest {
  month: number;
  year: number;
  notes?: string;
}

// Admin
export interface CreateUserRequest {
  name: string;
  email: string;
  password: string;
  role: UserRole;
  phone?: string;
  student?: {
    admission_no?: string;
    class_room_id?: number;
    date_of_birth?: string;
    gender?: string;
    address?: string;
    medical_notes?: string;
    emergency_contact_name?: string;
    emergency_contact_phone?: string;
  };
  staff?: {
    department?: string;
    position?: string;
    hire_date?: string;
    contract_type?: string;
    base_salary?: number;
    qualifications?: string;
  };
}

export interface UpdateUserRequest {
  name?: string;
  email?: string;
  phone?: string;
  is_active?: boolean;
  /** Admin reset: the backend flags it temporary (must_change_password). */
  password?: string;
  /** Staff-to-staff role changes only; students/parents are rejected. */
  role?: UserRole;
}

export interface CreateClassRoomRequest {
  name: string;
  grade: string;
  section?: string;
  capacity?: number;
  academic_year_id?: number;
  homeroom_teacher_id?: number;
}

export interface UpdateClassRoomRequest {
  name?: string;
  grade?: string;
  section?: string;
  capacity?: number;
  academic_year_id?: number;
  homeroom_teacher_id?: number;
}

export interface AssignSubjectTeacherRequest {
  subject_id: number;
  teacher_user_id: number;
}

export interface CreateTimetableEntryRequest {
  subject_id: number;
  teacher_user_id: number;
  day_of_week: number;
  start_time: string;
  end_time: string;
  room?: string;
}

export interface CreateSubjectRequest {
  name: string;
  code: string;
}

export interface UpdateSubjectRequest {
  name?: string;
  code?: string;
}

export interface CreateExamRequest {
  class_room_id: number;
  subject_id: number;
  semester_id?: number;
  title: string;
  exam_date: string;
  start_time: string;
  end_time: string;
  room?: string;
}

export interface CreateAcademicYearRequest {
  name: string;
  start_date: string;
  end_date: string;
  is_current?: boolean;
}

export interface CreateCalendarEventRequest {
  title: string;
  description?: string;
  type: 'holiday' | 'exam' | 'event' | 'semester_start' | 'semester_end';
  start_date: string;
  end_date?: string;
}

export interface CreateAnnouncementRequest {
  audience: string;
  title: string;
  body: string;
}

export interface CreateLibraryBookRequest {
  isbn?: string;
  title: string;
  author: string;
  category?: string;
  publisher?: string;
  year_published?: number;
  copies_total?: number;
  shelf_location?: string;
}

export interface UpdateLibraryBookRequest {
  isbn?: string;
  title?: string;
  author?: string;
  category?: string;
  publisher?: string;
  copies_total?: number;
  shelf_location?: string;
  is_active?: boolean;
}

export interface CreateTransportRouteRequest {
  name: string;
  pickup_points?: string;
  drop_points?: string;
}

export interface CreateTransportVehicleRequest {
  plate_number: string;
  model: string;
  capacity: number;
  driver_name?: string;
  driver_phone?: string;
}

// HR
export interface UpdateStaffRequest {
  department?: string;
  position?: string;
  hire_date?: string;
  contract_type?: string;
  base_salary?: number;
  qualifications?: string;
  annual_leave_balance?: number;
  sick_leave_balance?: number;
}

export interface CreateLeaveRequest {
  type: string;
  subject: string;
  reason?: string;
  start_date?: string;
  end_date?: string;
  amount?: number;
}

export interface MarkStaffAttendanceRequest {
  date: string;
  records: Array<{
    staff_user_id: number;
    status: AttendanceStatus;
    note?: string;
  }>;
}

// Teacher
export interface CreateAssignmentRequest {
  title: string;
  instructions: string;
  class_room_ids: number[];
  subject_id: number;
  due_at: string;
  max_score?: number;
}

export interface GradeSubmissionRequest {
  score: number;
  feedback?: string;
}

export interface CreateGradeComponentRequest {
  name: string;
  type: GradeComponentType;
  weight: number;
  max_score: number;
  semester_id?: number;
}

export interface LogConductRequest {
  student_user_id: number;
  category: 'positive' | 'warning' | 'incident';
  title: string;
  note: string;
}

// Warehouse
export interface CreateCategoryRequest {
  name: string;
  description?: string;
}

export interface CreateWarehouseItemRequest {
  name: string;
  sku?: string;
  category_id: number;
  unit: string;
  min_stock_qty: number;
  location?: string;
  description?: string;
}

export interface UpdateWarehouseItemRequest {
  name?: string;
  sku?: string;
  category_id?: number;
  unit?: string;
  min_stock_qty?: number;
  location?: string;
  description?: string;
  is_active?: boolean;
}

export interface StockMovementRequest {
  item_id: number;
  movement_type: MovementType;
  quantity: number;
  supplier?: string;
  department?: string;
  recipient_name?: string;
  reason?: string;
  reference_no?: string;
}

export interface CreatePurchaseRequestData {
  item_id: number;
  quantity_requested: number;
  unit: string;
  justification?: string;
  estimated_cost?: number;
}

export interface ReviewPurchaseRequestData {
  status: 'approved' | 'rejected' | 'purchased';
  admin_notes?: string;
}

export interface CreateInventoryCountRequest {
  count_type: 'monthly' | 'annual' | 'spot';
  count_date: string;
  items: Array<{
    item_id: number;
    physical_qty: number;
    notes?: string;
  }>;
}

export interface CreateSupplierRequest {
  name: string;
  contact_person?: string;
  phone: string;
  secondary_phone?: string;
  email?: string;
  address?: string;
  tax_number?: string;
  payment_terms?: 'cash' | 'net_15' | 'net_30' | 'net_60';
  credit_limit?: number;
  notes?: string;
}

export interface CreatePurchaseOrderRequest {
  supplier_id: number;
  order_date: string;
  expected_date?: string;
  tax?: number;
  notes?: string;
  items: Array<{
    warehouse_item_id: number;
    description?: string;
    quantity_ordered: number;
    unit: string;
    unit_cost: number;
    warehouse_location?: string;
  }>;
}

export interface ReceivePurchaseOrderRequest {
  notes?: string;
  lines: Array<{
    purchase_order_item_id: number;
    quantity_received: number;
    unit_cost?: number;
    warehouse_location?: string;
  }>;
}

export interface CreateSupplierInvoiceRequest {
  supplier_id: number;
  purchase_order_id?: number;
  supplier_invoice_ref?: string;
  invoice_date: string;
  due_date: string;
  amount: number;
  notes?: string;
}

export interface RecordSupplierPaymentRequest {
  amount: number;
  method: 'cash' | 'bank_transfer' | 'cheque';
  reference?: string;
  paid_at?: string;
  note?: string;
}

// Payments
export interface PaymentIntentRequest {
  invoice_id: number;
  amount: number;
  currency?: string;
}

export interface ConfirmPaymentRequest {
  payment_intent_id: string;
}

// Notifications
export interface NotificationPreferencesRequest {
  push_enabled?: boolean;
  email_enabled?: boolean;
  quiet_hours?: { start: string; end: string };
}

export interface RegisterDeviceRequest {
  token: string;
  platform: string;
  device_name?: string;
  app_version?: string;
}

// Messaging
export interface SendMessageRequest {
  recipient_user_id: number;
  body: string;
  about_student_user_id?: number;
}

// Finance fee structure
export interface CreateFeeStructureRequest {
  name: string;
  grade?: string | number | null;
  billing_cycle: BillingCycle;
  amount: number;
  is_active?: boolean;
}

export interface UpdateFeeStructureRequest {
  name?: string;
  grade?: string | number | null;
  billing_cycle?: BillingCycle;
  amount?: number;
  is_active?: boolean;
}

// Generic query params
export type QueryParams = Record<string, string | number | boolean | undefined | null>;
