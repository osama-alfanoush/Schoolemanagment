import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Hr, mediaUrl } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

const CONTRACT_TYPES = ["full-time", "part-time", "contract"];

export default function HrStaff() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [editing, setEditing] = useState<any>(null);
  const [form, setForm] = useState<any>({});

  const { data, isLoading } = useQuery({
    queryKey: ["hr", "staff"],
    queryFn: () => Hr.staff()
  }) as any;
  const staff = toArray(data);

  const openEdit = (employee: any) => {
    const sp = employee.staffProfile ?? employee.staff_profile ?? {};
    setEditing(employee);
    setForm({
      department: sp.department ?? "",
      position: sp.position ?? "",
      contract_type: sp.contract_type ?? "full-time",
      base_salary: sp.base_salary != null ? String(sp.base_salary) : "",
      annual_leave_balance: sp.annual_leave_balance != null ? String(sp.annual_leave_balance) : "",
      sick_leave_balance: sp.sick_leave_balance != null ? String(sp.sick_leave_balance) : "",
    });
  };

  const save = useMutation({
    mutationFn: () => {
      const payload: any = {};
      if (form.department !== "") payload.department = form.department;
      if (form.position !== "") payload.position = form.position;
      if (form.contract_type !== "") payload.contract_type = form.contract_type;
      if (form.base_salary !== "") payload.base_salary = Number(form.base_salary);
      if (form.annual_leave_balance !== "") payload.annual_leave_balance = Number(form.annual_leave_balance);
      if (form.sick_leave_balance !== "") payload.sick_leave_balance = Number(form.sick_leave_balance);
      return Hr.updateStaff(editing.id, payload);
    },
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["hr", "staff"] });
      toast({ title: "Staff updated" });
      setEditing(null);
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.staff")}</h1>
      </div>

      <div>
        <DataTable
          columns={[
            {
              key: "name",
              label: "Employee",
              sortable: true,
              render: (_, employee) => (
                <div className="flex items-center space-x-3 rtl:space-x-reverse">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={mediaUrl(employee.photo_path)} />
                    <AvatarFallback>{employee.name.substring(0, 2).toUpperCase()}</AvatarFallback>
                  </Avatar>
                  <div className="font-medium">{employee.name}</div>
                </div>
              ),
            },
            {
              key: "role",
              label: "Role",
              sortable: true,
              render: (val) => (
                <Badge variant="outline" className="capitalize">
                  {t(`roles.${val}`)}
                </Badge>
              ),
            },
            { key: "email", label: "Email", sortable: true },
            {
              key: "department",
              label: "Department",
              sortable: true,
              render: (_, employee) => employee.staffProfile?.department || "-",
            },
            {
              key: "base_salary",
              label: "Base Salary",
              align: "right" as const,
              render: (_, employee) => employee.staffProfile?.base_salary != null ? `$${Number(employee.staffProfile.base_salary).toFixed(2)}` : "-",
            },
          ]}
          data={staff}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
          rowActions={[
            { label: t("common.edit"), onClick: (employee: any) => openEdit(employee), variant: "default" }
          ]}
        />
      </div>

      <Dialog open={!!editing} onOpenChange={(v) => !v && setEditing(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Edit Staff{editing ? ` — ${editing.name}` : ""}</DialogTitle>
            <DialogDescription>Update employment details and leave balances.</DialogDescription>
          </DialogHeader>
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-1.5">
              <Label>Department</Label>
              <Input value={form.department ?? ""} onChange={e => setForm({ ...form, department: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Position</Label>
              <Input value={form.position ?? ""} onChange={e => setForm({ ...form, position: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Contract Type</Label>
              <select className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.contract_type ?? "full-time"} onChange={e => setForm({ ...form, contract_type: e.target.value })}>
                {CONTRACT_TYPES.map(c => <option key={c} value={c} className="capitalize">{c}</option>)}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Base Salary</Label>
              <Input type="number" step="0.01" value={form.base_salary ?? ""} onChange={e => setForm({ ...form, base_salary: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Annual Leave (days)</Label>
              <Input type="number" value={form.annual_leave_balance ?? ""} onChange={e => setForm({ ...form, annual_leave_balance: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Sick Leave (days)</Label>
              <Input type="number" value={form.sick_leave_balance ?? ""} onChange={e => setForm({ ...form, sick_leave_balance: e.target.value })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setEditing(null)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => save.mutate()} disabled={save.isPending}>
              {save.isPending ? t("common.loading") : t("common.save")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
