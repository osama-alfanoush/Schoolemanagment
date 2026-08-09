import BrandButton from "@/components/ui/BrandButton";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Admin, ApiError, mediaUrl, Role, type ClassRoom, type CreateUserRequest, type PermissionDef, type UpdateUserRequest, type User, type UserPermissionsResponse } from "@/lib/api";
import { toArray } from "@/lib/response";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Search, Plus, Pencil, ShieldCheck, UserX, UserCheck } from "lucide-react";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
const ROLE_OPTIONS: Role[] = ["student", "parent", "teacher", "admin", "finance", "hr", "warehouse", "procurement"];
// Employee roles get a staff profile (salary, department) — without it the
// user is invisible to payroll runs and HR salary flows.
const STAFF_ROLES: Role[] = ["teacher", "admin", "finance", "hr", "warehouse", "procurement"];
const EMPTY_STAFF = { department: "", position: "", hire_date: "", contract_type: "full-time", base_salary: "" };
const EMPTY_STUDENT = { admission_no: "", class_room_id: "", date_of_birth: "", gender: "" };
export default function AdminUsers() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [roleFilter, setRoleFilter] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [createErrors, setCreateErrors] = useState<Record<string, string>>({});
  const [deactivating, setDeactivating] = useState<User | null>(null);
  const [deactivationReason, setDeactivationReason] = useState("");
  const [editing, setEditing] = useState<any>(null);
  const [editForm, setEditForm] = useState({ name: "", email: "", phone: "", role: "" as Role | "", is_active: true, password: "" });
  const [permUser, setPermUser] = useState<any>(null);
  const [permData, setPermData] = useState<UserPermissionsResponse | null>(null);
  const [checkedKeys, setCheckedKeys] = useState<Set<string>>(new Set());
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: "",
    role: "student" as Role,
    phone: ""
  });
  const [staffForm, setStaffForm] = useState({ ...EMPTY_STAFF });
  const [studentForm, setStudentForm] = useState({ ...EMPTY_STUDENT });
  const isStaffRole = STAFF_ROLES.includes(form.role);
  const {
    data,
    isLoading,
    error
  } = useQuery({
    queryKey: ["admin", "users", search, roleFilter],
    queryFn: () => Admin.users({
      q: search,
      role: roleFilter || undefined
    })
  });
  const users = toArray<User>(data);
  const { data: permCatalog } = useQuery({
    queryKey: ["admin", "permissions"],
    queryFn: () => Admin.listPermissions(),
    enabled: !!permUser,
  });
  const { data: classData } = useQuery({
    queryKey: ["admin", "classes"],
    queryFn: () => Admin.classes(),
    enabled: createOpen && form.role === "student",
  });
  const classes = toArray<ClassRoom>(classData);

  const buildPayload = (): CreateUserRequest => {
    const payload: CreateUserRequest = { ...form, phone: form.phone || undefined };
    if (isStaffRole) {
      const staff: NonNullable<CreateUserRequest["staff"]> = {};
      if (staffForm.department) staff.department = staffForm.department;
      if (staffForm.position) staff.position = staffForm.position;
      if (staffForm.hire_date) staff.hire_date = staffForm.hire_date;
      if (staffForm.contract_type) staff.contract_type = staffForm.contract_type;
      if (staffForm.base_salary !== "") staff.base_salary = Number(staffForm.base_salary);
      if (Object.keys(staff).length) payload.staff = staff;
    }
    if (form.role === "student") {
      const student: NonNullable<CreateUserRequest["student"]> = {};
      if (studentForm.admission_no) student.admission_no = studentForm.admission_no;
      if (studentForm.class_room_id) student.class_room_id = Number(studentForm.class_room_id);
      if (studentForm.date_of_birth) student.date_of_birth = studentForm.date_of_birth;
      if (studentForm.gender) student.gender = studentForm.gender;
      if (Object.keys(student).length) payload.student = student;
    }
    return payload;
  };

  const createUser = useMutation({
    mutationFn: () => Admin.createUser(buildPayload()),
    onMutate: () => setCreateErrors({}),
    onSuccess: () => {
      void qc.invalidateQueries({
        queryKey: ["admin", "users"]
      });
      toast({
        title: "User created"
      });
      setCreateOpen(false);
      setForm({
        name: "",
        email: "",
        password: "",
        role: "student",
        phone: ""
      });
      setStaffForm({ ...EMPTY_STAFF });
      setStudentForm({ ...EMPTY_STUDENT });
      setCreateErrors({});
    },
    onError: (e: unknown) => {
      if (e instanceof ApiError && typeof e.data === "object" && e.data !== null && "errors" in e.data) {
        const errors = (e.data as { errors?: Record<string, string[]> }).errors ?? {};
        setCreateErrors(Object.fromEntries(
          Object.entries(errors).map(([field, messages]) => [field, messages[0] ?? "Invalid value"]),
        ));
      }
      toast({
        variant: "destructive",
        title: "Failed to create user",
        description: e instanceof Error ? e.message : "Please verify the profile details and try again."
      });
    }
  });

  const openEdit = (user: User) => {
    setEditing(user);
    setEditForm({
      name: user.name ?? "",
      email: user.email ?? "",
      phone: user.phone ?? "",
      role: user.role,
      is_active: !!user.is_active,
      password: "",
    });
  };

  const updateUser = useMutation({
    mutationFn: () => {
      const payload: UpdateUserRequest = {
        name: editForm.name,
        email: editForm.email,
        phone: editForm.phone || undefined,
        is_active: editForm.is_active,
      };
      // Role changes are staff-to-staff only; leave untouched otherwise.
      if (editForm.role && editForm.role !== editing.role && STAFF_ROLES.includes(editing.role)) {
        payload.role = editForm.role;
      }
      if (editForm.password) payload.password = editForm.password;
      return Admin.updateUser(editing.id, payload);
    },
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["admin", "users"] });
      toast({
        title: "User updated",
        description: editForm.password ? "The temporary password must be changed at next login." : undefined,
      });
      setEditing(null);
    },
    onError: (e: unknown) => toast({
      variant: "destructive",
      title: "Failed to update user",
      description: e instanceof Error ? e.message : undefined
    })
  });

  const toggleActive = useMutation({
    mutationFn: ({ user, reason }: { user: User; reason?: string }) => user.is_active
      ? Admin.deactivateUser(user.id, reason ?? "")
      : Admin.updateUser(user.id, { is_active: true }),
    onSuccess: (_res, { user }) => {
      void qc.invalidateQueries({ queryKey: ["admin", "users"] });
      toast({ title: user.is_active ? "User deactivated" : "User reactivated" });
      setDeactivating(null);
      setDeactivationReason("");
    },
    onError: (e: unknown) => toast({
      variant: "destructive",
      title: "Failed to change status",
      description: e instanceof Error ? e.message : undefined
    })
  });

  const openPermissions = async (user: User) => {
    try {
      const detail = await Admin.userPermissions(user.id);
      setPermUser(user);
      setPermData(detail);
      setCheckedKeys(new Set(detail.effective));
    } catch (e) {
      toast({ variant: "destructive", title: "Could not load permissions", description: e instanceof Error ? e.message : undefined });
    }
  };

  const savePermissions = useMutation({
    mutationFn: () => {
      const roleKeys = new Set(permData?.role_keys ?? []);
      // Overrides are only the differences from the role baseline:
      // checked but not in the role → grant; in the role but unchecked → deny.
      const grants = [...checkedKeys].filter(key => !roleKeys.has(key));
      const denies = [...roleKeys].filter(key => !checkedKeys.has(key));
      return Admin.updateUserPermissions(permUser.id, { grants, denies });
    },
    onSuccess: () => {
      toast({ title: "Permissions updated", description: `${permUser.name} now has the selected access.` });
      setPermUser(null);
      setPermData(null);
    },
    onError: (e: unknown) => toast({
      variant: "destructive",
      title: "Failed to update permissions",
      description: e instanceof Error ? e.message : undefined
    })
  });

  const toggleKey = (key: string) => {
    setCheckedKeys(prev => {
      const next = new Set(prev);
      if (next.has(key)) next.delete(key); else next.add(key);
      return next;
    });
  };

  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
          {t("nav.staff")} / Users
        </h1>
        <BrandButton onClick={() => { setCreateErrors({}); setCreateOpen(true); }}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} User
        </BrandButton>
      </div>

      <div className="flex flex-wrap items-center gap-2">
        <div className="relative w-full max-w-sm">
          <Search className="absolute start-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input placeholder={t("common.search") + "..."} className="ps-9" value={search} onChange={e => setSearch(e.target.value)} />
        </div>
        <div>
          <Label htmlFor="user-role-filter" className="sr-only">{t("common.role")}</Label>
          <select id="user-role-filter" className="flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm" value={roleFilter} onChange={e => setRoleFilter(e.target.value)}>
            <option value="">{t("common.allRoles", "All roles")}</option>
            {ROLE_OPTIONS.map(r => <option key={r} value={r}>{t(`roles.${r}`)}</option>)}
          </select>
        </div>
      </div>

      <div>
        <DataTable<User>
          columns={[
            {
              key: "name",
              label: t("common.name"),
              sortable: true,
              render: (_, user) => (
                <div className="flex items-center space-x-3 rtl:space-x-reverse">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={mediaUrl(user.photo_path)} />
                    <AvatarFallback>
                      {user.name.substring(0, 2).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>
                  <div className="font-medium">{user.name}</div>
                </div>
              ),
            },
            {
              key: "role",
              label: t("common.role"),
              sortable: true,
              render: (val) => (
                <Badge variant="outline" className="capitalize">
                  {t(`roles.${val}`)}
                </Badge>
              ),
            },
            { key: "email", label: t("common.email"), sortable: true },
            {
              key: "is_active",
              label: t("common.status"),
              sortable: true,
              render: (val) => (
                <Badge variant={val ? "default" : "secondary"}>
                  {val ? t("common.active", "Active") : t("common.inactive", "Inactive")}
                </Badge>
              ),
            },
          ]}
          data={users}
          isLoading={isLoading}
          error={(error as Error)?.message}
          emptyMessage={t("common.empty")}
          rowActions={[
            {
              label: t("common.edit"),
              icon: <Pencil className="h-4 w-4" />,
              onClick: openEdit,
            },
            {
              label: t("common.permissions", "Permissions"),
              icon: <ShieldCheck className="h-4 w-4" />,
              // Granular permissions apply to operational staff; admins bypass
              // them and students/parents have none.
              show: (user: User) => STAFF_ROLES.includes(user.role) && user.role !== "admin",
              onClick: (user: User) => void openPermissions(user),
            },
            {
              label: t("common.deactivate", "Deactivate"),
              icon: <UserX className="h-4 w-4" />,
              variant: "danger",
              show: (user: User) => !!user.is_active,
              onClick: (user: User) => { setDeactivationReason(""); setDeactivating(user); },
            },
            {
              label: t("common.reactivate", "Reactivate"),
              icon: <UserCheck className="h-4 w-4" />,
              show: (user: User) => !user.is_active,
              onClick: (user: User) => toggleActive.mutate({ user }),
            },
          ]}
        />
      </div>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>{t("common.create")} User</DialogTitle>
            <DialogDescription>
              {t("common.createUserDesc", "Create a new user account with a chosen role.")}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="name">{t("common.name")}</Label>
              <Input id="name" value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="email">{t("common.email")}</Label>
              <Input id="email" type="email" value={form.email} onChange={e => setForm({
              ...form,
              email: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="password">{t("login.password")}</Label>
              <Input
                id="password"
                type="password"
                minLength={8}
                aria-invalid={!!createErrors.password || (form.password.length > 0 && form.password.length < 8)}
                aria-describedby="create-password-error"
                value={form.password}
                onChange={e => {
                  setForm({ ...form, password: e.target.value });
                  setCreateErrors(prev => {
                    const { password: _password, ...rest } = prev;
                    return rest;
                  });
                }}
              />
              {(createErrors.password || (form.password.length > 0 && form.password.length < 8)) && (
                <p id="create-password-error" role="alert" className="text-sm text-destructive">
                  {createErrors.password ?? "Password must be at least 8 characters."}
                </p>
              )}
            </div>
            <div className="space-y-1.5">
              <Label>{t("common.role")}</Label>
              <div className="flex flex-wrap gap-2">
                {ROLE_OPTIONS.map(r => <Badge key={r} variant={form.role === r ? "default" : "outline"} className="cursor-pointer capitalize px-3 py-1" onClick={() => setForm({
                ...form,
                role: r
              })}>
                    {t(`roles.${r}`)}
                  </Badge>)}
              </div>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="phone">{t("profileSettings.phone")}</Label>
              <Input id="phone" value={form.phone} onChange={e => setForm({
              ...form,
              phone: e.target.value
            })} />
            </div>

            {isStaffRole && <div className="space-y-3 rounded-xl border border-border p-3">
              <p className="text-sm font-semibold">{t("common.staffProfile", "Staff profile")}</p>
              <p className="text-xs text-muted-foreground">{t("common.staffProfileDesc", "Salary and hire details — required for this user to appear in payroll runs.")}</p>
              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label htmlFor="staff-department">{t("common.department", "Department")}</Label>
                  <Input id="staff-department" value={staffForm.department} onChange={e => setStaffForm({ ...staffForm, department: e.target.value })} />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="staff-position">{t("common.position", "Position")}</Label>
                  <Input id="staff-position" value={staffForm.position} onChange={e => setStaffForm({ ...staffForm, position: e.target.value })} />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="staff-hire-date">{t("common.hireDate", "Hire date")}</Label>
                  <Input id="staff-hire-date" type="date" value={staffForm.hire_date} onChange={e => setStaffForm({ ...staffForm, hire_date: e.target.value })} />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="staff-contract">{t("common.contractType", "Contract type")}</Label>
                  <select id="staff-contract" className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm" value={staffForm.contract_type} onChange={e => setStaffForm({ ...staffForm, contract_type: e.target.value })}>
                    <option value="full-time">Full-time</option>
                    <option value="part-time">Part-time</option>
                    <option value="contract">Contract</option>
                  </select>
                </div>
                <div className="space-y-1.5 sm:col-span-2">
                  <Label htmlFor="staff-salary">{t("common.baseSalary", "Base salary")}</Label>
                  <Input id="staff-salary" type="number" min="0" step="0.01" value={staffForm.base_salary} onChange={e => setStaffForm({ ...staffForm, base_salary: e.target.value })} />
                </div>
              </div>
            </div>}

            {form.role === "student" && <div className="space-y-3 rounded-xl border border-border p-3">
              <p className="text-sm font-semibold">{t("common.studentProfile", "Student profile")}</p>
              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label htmlFor="student-admission">{t("common.admissionNo", "Admission no. (auto if empty)")}</Label>
                  <Input id="student-admission" value={studentForm.admission_no} onChange={e => setStudentForm({ ...studentForm, admission_no: e.target.value })} />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="student-class">{t("nav.classes")}</Label>
                  <select id="student-class" className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm" value={studentForm.class_room_id} onChange={e => setStudentForm({ ...studentForm, class_room_id: e.target.value })}>
                    <option value="">—</option>
                    {classes.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
                  </select>
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="student-dob">{t("common.dateOfBirth", "Date of birth")}</Label>
                  <Input id="student-dob" type="date" value={studentForm.date_of_birth} onChange={e => setStudentForm({ ...studentForm, date_of_birth: e.target.value })} />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="student-gender">{t("common.gender", "Gender")}</Label>
                  <select id="student-gender" className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm" value={studentForm.gender} onChange={e => setStudentForm({ ...studentForm, gender: e.target.value })}>
                    <option value="">—</option>
                    <option value="M">M</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div>
            </div>}
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setCreateOpen(false)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={() => createUser.mutate()} disabled={!form.name || !form.email || form.password.length < 8 || (isStaffRole && staffForm.base_salary === "") || createUser.isPending}>
              {createUser.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!deactivating} onOpenChange={open => { if (!open) { setDeactivating(null); setDeactivationReason(""); } }}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{t("common.deactivate", "Deactivate")} — {deactivating?.name}</DialogTitle>
            <DialogDescription>
              {t("common.deactivateReasonDesc", "Provide a reason for deactivating this user. Their active sessions will be revoked.")}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-1.5">
            <Label htmlFor="deactivation-reason">{t("common.reason", "Reason")}</Label>
            <Input
              id="deactivation-reason"
              maxLength={500}
              value={deactivationReason}
              onChange={event => setDeactivationReason(event.target.value)}
            />
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setDeactivating(null); setDeactivationReason(""); }}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton
              variant="destructive"
              disabled={!deactivationReason.trim() || toggleActive.isPending || !deactivating}
              onClick={() => deactivating && toggleActive.mutate({ user: deactivating, reason: deactivationReason.trim() })}
            >
              {toggleActive.isPending ? t("common.loading") : t("common.deactivate", "Deactivate")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!editing} onOpenChange={open => !open && setEditing(null)}>
        <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>{t("common.edit")} — {editing?.name}</DialogTitle>
            <DialogDescription>
              {t("common.editUserDesc", "Update account details, status, or issue a temporary password.")}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="edit-name">{t("common.name")}</Label>
              <Input id="edit-name" value={editForm.name} onChange={e => setEditForm({ ...editForm, name: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="edit-email">{t("common.email")}</Label>
              <Input id="edit-email" type="email" value={editForm.email} onChange={e => setEditForm({ ...editForm, email: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="edit-phone">{t("profileSettings.phone")}</Label>
              <Input id="edit-phone" value={editForm.phone} onChange={e => setEditForm({ ...editForm, phone: e.target.value })} />
            </div>
            {editing && STAFF_ROLES.includes(editing.role) && <div className="space-y-1.5">
              <Label>{t("common.role")}</Label>
              <div className="flex flex-wrap gap-2">
                {STAFF_ROLES.map(r => <Badge key={r} variant={editForm.role === r ? "default" : "outline"} className="cursor-pointer capitalize px-3 py-1" onClick={() => setEditForm({ ...editForm, role: r })}>
                    {t(`roles.${r}`)}
                  </Badge>)}
              </div>
            </div>}
            <div className="flex items-center gap-2">
              <input id="edit-active" type="checkbox" className="h-4 w-4" checked={editForm.is_active} onChange={e => setEditForm({ ...editForm, is_active: e.target.checked })} />
              <Label htmlFor="edit-active">{t("common.active", "Active")}</Label>
            </div>
            <div className="space-y-1.5 rounded-xl border border-border p-3">
              <Label htmlFor="edit-password">{t("common.tempPassword", "Temporary password (optional)")}</Label>
              <Input id="edit-password" type="password" value={editForm.password} onChange={e => setEditForm({ ...editForm, password: e.target.value })} />
              <p className="text-xs text-muted-foreground">
                {t("common.tempPasswordDesc", "Setting a password here forces the user to choose their own at next login.")}
              </p>
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setEditing(null)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => updateUser.mutate()} disabled={!editForm.name || !editForm.email || updateUser.isPending}>
              {updateUser.isPending ? t("common.loading") : t("common.save")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!permUser} onOpenChange={open => { if (!open) { setPermUser(null); setPermData(null); } }}>
        <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>{t("common.permissions", "Permissions")} — {permUser?.name}</DialogTitle>
            <DialogDescription>
              {t("common.permissionsDesc", "The role provides the baseline; changes here become per-user grants or denies. Use denies to separate duties, e.g. an accountant who records invoices but may not approve payments.")}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4">
            {Object.entries(permCatalog?.data ?? {}).map(([module, perms]) => {
              const roleKeys = new Set(permData?.role_keys ?? []);
              return <div key={module} className="space-y-2 rounded-xl border border-border p-3">
                <p className="text-sm font-semibold capitalize">{module.replaceAll(".", " · ").replaceAll("_", " ")}</p>
                <div className="grid gap-1.5 sm:grid-cols-2">
                  {perms.map((perm: PermissionDef) => <label key={perm.key} className="flex items-center gap-2 text-sm">
                      <input type="checkbox" className="h-4 w-4" checked={checkedKeys.has(perm.key)} onChange={() => toggleKey(perm.key)} />
                      <span className="capitalize">{perm.action}</span>
                      {roleKeys.has(perm.key)
                        ? checkedKeys.has(perm.key) || <Badge variant="secondary" className="text-[10px]">deny override</Badge>
                        : checkedKeys.has(perm.key) && <Badge variant="secondary" className="text-[10px]">extra grant</Badge>}
                    </label>)}
                </div>
              </div>;
            })}
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setPermUser(null); setPermData(null); }}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => savePermissions.mutate()} disabled={savePermissions.isPending || !permData}>
              {savePermissions.isPending ? t("common.loading") : t("common.save")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}
