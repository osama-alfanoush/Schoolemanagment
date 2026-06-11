import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Badge } from "@/components/ui/badge";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Teacher, type CreateLeaveRequest } from "@/lib/api";
import { toArray } from "./response";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";

const requestTypes = [
  { value: "leave_annual", label: "Annual leave" },
  { value: "leave_sick", label: "Sick leave" },
  { value: "leave_emergency", label: "Emergency leave" },
  { value: "salary_advance", label: "Salary advance" },
  { value: "general", label: "General request" },
];

const emptyForm: CreateLeaveRequest = {
  type: "leave_annual",
  subject: "",
  reason: "",
  start_date: "",
  end_date: "",
  amount: undefined,
};

export default function TeacherHr() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState<CreateLeaveRequest>(emptyForm);

  const { data, isLoading } = useQuery({
    queryKey: ["teacher", "hr"],
    queryFn: Teacher.myHrRequests,
  }) as any;

  const submit = useMutation({
    mutationFn: () => Teacher.submitHrRequest({
      ...form,
      subject: form.subject.trim(),
      reason: form.reason?.trim(),
      start_date: form.start_date || undefined,
      end_date: form.end_date || undefined,
      amount: form.amount || undefined,
    }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["teacher", "hr"] });
      toast({ title: "Request sent to HR" });
      setOpen(false);
      setForm(emptyForm);
    },
    onError: (error: any) => {
      toast({
        title: "Could not submit request",
        description: error?.message || "Please check the form and try again.",
        variant: "destructive",
      });
    },
  });

  const requests = toArray(data);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.hrRequests")}</h1>
        <BrandButton onClick={() => setOpen(true)}>Submit Request</BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Type</TableHead>
              <TableHead>Subject</TableHead>
              <TableHead>Status</TableHead>
              <TableHead>Reason</TableHead>
              <TableHead>HR response</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              <TableRow>
                <TableCell colSpan={5} className="p-8 text-center">{t("common.loading")}</TableCell>
              </TableRow>
            ) : requests.length === 0 ? (
              <TableRow>
                <TableCell colSpan={5} className="p-8 text-center text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow>
            ) : (
              requests.map((req: any) => (
                <TableRow key={req.id}>
                  <TableCell className="font-medium capitalize">{String(req.type || "").replaceAll("_", " ")}</TableCell>
                  <TableCell>{req.subject}</TableCell>
                  <TableCell>
                    <Badge variant={req.status === "approved" ? "default" : req.status === "rejected" ? "destructive" : "secondary"} className="capitalize">
                      {req.status}
                    </Badge>
                  </TableCell>
                  <TableCell className="max-w-[260px] truncate text-muted-foreground" title={req.reason}>{req.reason}</TableCell>
                  <TableCell className="max-w-[240px] truncate text-muted-foreground" title={req.admin_response}>{req.admin_response || "-"}</TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Submit HR request</DialogTitle>
            <DialogDescription>Your request will be sent to HR for approval or rejection.</DialogDescription>
          </DialogHeader>

          <form
            className="space-y-4"
            onSubmit={(event) => {
              event.preventDefault();
              submit.mutate();
            }}
          >
            <div className="space-y-1.5">
              <Label htmlFor="request-type">Type</Label>
              <select
                id="request-type"
                value={form.type}
                onChange={(event) => setForm((prev) => ({ ...prev, type: event.target.value }))}
                className="flex h-9 w-full rounded-md border border-input bg-card px-3 py-2 text-sm shadow-sm focus:outline-none focus:ring-2 focus:ring-primary/40"
              >
                {requestTypes.map((type) => (
                  <option key={type.value} value={type.value}>{type.label}</option>
                ))}
              </select>
            </div>

            <div className="space-y-1.5">
              <Label htmlFor="subject">Subject</Label>
              <Input
                id="subject"
                value={form.subject}
                onChange={(event) => setForm((prev) => ({ ...prev, subject: event.target.value }))}
                required
              />
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-1.5">
                <Label htmlFor="start-date">Start date</Label>
                <Input
                  id="start-date"
                  type="date"
                  value={form.start_date || ""}
                  onChange={(event) => setForm((prev) => ({ ...prev, start_date: event.target.value }))}
                />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="end-date">End date</Label>
                <Input
                  id="end-date"
                  type="date"
                  value={form.end_date || ""}
                  onChange={(event) => setForm((prev) => ({ ...prev, end_date: event.target.value }))}
                />
              </div>
            </div>

            {form.type === "salary_advance" && (
              <div className="space-y-1.5">
                <Label htmlFor="amount">Amount</Label>
                <Input
                  id="amount"
                  type="number"
                  min="0"
                  step="0.01"
                  value={form.amount ?? ""}
                  onChange={(event) => setForm((prev) => ({ ...prev, amount: event.target.value ? Number(event.target.value) : undefined }))}
                />
              </div>
            )}

            <div className="space-y-1.5">
              <Label htmlFor="reason">Reason</Label>
              <Textarea
                id="reason"
                value={form.reason || ""}
                onChange={(event) => setForm((prev) => ({ ...prev, reason: event.target.value }))}
                rows={4}
                required
              />
            </div>

            <DialogFooter>
              <BrandButton type="button" variant="ghost" onClick={() => setOpen(false)} disabled={submit.isPending}>
                Cancel
              </BrandButton>
              <BrandButton type="submit" isLoading={submit.isPending} disabled={!form.subject.trim() || !form.reason?.trim()}>
                Send to HR
              </BrandButton>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
