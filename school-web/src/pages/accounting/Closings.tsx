import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Accounting, FinancialClosing } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { renderDate, renderStatus } from "@/lib/tableHelpers";
import { toArray } from "@/lib/response";

export default function Closings() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({
    month: String(new Date().getMonth() + 1),
    year: String(new Date().getFullYear()),
    notes: "",
  });

  const { data, isLoading, error } = useQuery({
    queryKey: ["accounting-closings"],
    queryFn: () => Accounting.closings(),
  });

  const createClosing = useMutation({
    mutationFn: () => Accounting.createClosing({
      month: Number(form.month),
      year: Number(form.year),
      notes: form.notes || undefined,
    }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["accounting-closings"] });
      toast({ title: "Month closed" });
      setOpen(false);
      setForm({ month: String(new Date().getMonth() + 1), year: String(new Date().getFullYear()), notes: "" });
    },
    onError: (e: unknown) =>
      toast({ variant: "destructive", title: "Close failed", description: (e as Error)?.message }),
  });

  const closings = toArray<FinancialClosing>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="CL"
        title="Financial Closings"
        subtitle="Close accounting periods and review locked months"
        actions={<BrandButton variant="primary" onClick={() => setOpen(true)}>Close Month</BrandButton>}
      />

      <DataTable<FinancialClosing>
        title="Accounting Periods"
        columns={[
          {
            key: "period_name",
            label: "Period",
            sortable: true,
            render: (v, row) => v ?? row.name ?? `${row.month}/${row.year}`,
          },
          { key: "month", label: "Month", align: "center", sortable: true },
          { key: "year", label: "Year", align: "center", sortable: true },
          { key: "status", label: "Status", render: (v) => renderStatus(v ?? "closed") },
          { key: "closed_at", label: "Closed At", render: (v) => v ? renderDate(v) : "Open" },
          { key: "notes", label: "Notes", render: (v) => v || "No notes", hide: "md" },
        ]}
        data={closings}
        isLoading={isLoading}
        error={(error as Error)?.message}
        emptyMessage="No closed periods yet."
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Close Month</DialogTitle>
            <DialogDescription>Lock a financial period after reports are reviewed.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label>Month</Label>
                <Input
                  type="number"
                  min="1"
                  max="12"
                  value={form.month}
                  onChange={(e) => setForm({ ...form, month: e.target.value })}
                />
              </div>
              <div className="space-y-1.5">
                <Label>Year</Label>
                <Input
                  type="number"
                  value={form.year}
                  onChange={(e) => setForm({ ...form, year: e.target.value })}
                />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label>Notes</Label>
              <Input
                value={form.notes}
                onChange={(e) => setForm({ ...form, notes: e.target.value })}
                placeholder="Optional closing note"
              />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton
              variant="primary"
              onClick={() => createClosing.mutate()}
              disabled={createClosing.isPending || !form.month || !form.year}
            >
              {createClosing.isPending ? "Closing..." : "Close Period"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
