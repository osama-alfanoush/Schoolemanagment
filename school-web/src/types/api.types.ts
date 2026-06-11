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
  total_revenue: number;
  total_invoices: number;
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
  count_type: string;
  count_date: string;
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
  | 'finance' | 'hr' | 'accounting' | 'warehouse';

export type AttendanceStatus = 'present' | 'absent' | 'late' | 'excused';
export type InvoiceStatus = 'pending' | 'partial' | 'paid' | 'overdue';
export type PaymentMethod = 'cash' | 'card' | 'bank_transfer' | 'online';
export type GradeComponentType = 'quiz' | 'homework' | 'exam' | 'project';
export type JournalEntryType = 'debit' | 'credit';
export type JournalSource = 'manual' | 'invoice' | 'payroll' | 'expense';
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
  phone?: string;
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
}

export interface FeeStructure {
  id: number;
  name: string;
  amount: number;
  academic_year: string;
  due_date: string;
  description?: string;
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

export interface WarehouseItem {
  id: number;
  name: string;
  sku?: string;
  category_id: number;
  unit: string;
  current_qty: number;
  min_stock_qty: number;
  location?: string;
  description?: string;
  is_active: boolean;
}

export interface StockMovement {
  id: number;
  item_id: number;
  movement_type: MovementType;
  quantity: number;
  reference_no?: string;
  supplier?: string;
  department?: string;
  recipient_name?: string;
  reason?: string;
  performed_by: number;
  movement_date: string;
}

export interface PurchaseRequest {
  id: number;
  request_no: string;
  item_id: number;
  quantity_requested: number;
  unit: string;
  estimated_cost?: number;
  justification?: string;
  status: PurchaseRequestStatus;
  requested_by: number;
  reviewed_by?: number;
  reviewed_at?: string;
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
  access_token: string;
  refresh_token: string;
  token_type: string;
  expires_in: number;
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
  password?: string;
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
  amount: number;
  academic_year: string;
  due_date: string;
  description?: string;
}

export interface UpdateFeeStructureRequest {
  name?: string;
  amount?: number;
  academic_year?: string;
  due_date?: string;
  description?: string;
}

// Generic query params
export type QueryParams = Record<string, string | number | boolean | undefined | null>;