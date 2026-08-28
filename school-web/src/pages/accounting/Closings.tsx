import { useState } from "react";
import { useTranslation } from "react-i18next";
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
  const { t } = useTranslation();
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
      void qc.invalidateQueries({ queryKey: ["accounting-closings"] });
      toast({ title: t("accountingPages.monthClosed") });
      setOpen(false);
      setForm({ month: String(new Date().getMonth() + 1), year: String(new Date().getFullYear()), notes: "" });
    },
    onError: (e: unknown) =>
      toast({ variant: "destructive", title: t("accountingPages.closeFailed"), description: (e as Error)?.message }),
  });

  const closings = toArray<FinancialClosing>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="CL"
        title={t("accountingPages.closingsTitle")}
        subtitle={t("accountingPages.closingsSubtitle")}
        actions={<BrandButton variant="primary" onClick={() => setOpen(true)}>{t("accountingPages.closeMonth")}</BrandButton>}
      />

      <DataTable<FinancialClosing>
        title={t("accountingPages.periods")}
        columns={[
          {
            key: "period_name",
            label: t("accountingPages.period"),
            sortable: true,
            render: (v, row) => v ?? row.name ?? `${row.month}/${row.year}`,
          },
          { key: "month", label: t("accountingPages.month"), align: "center", sortable: true },
          { key: "year", label: t("accountingPages.year"), align: "center", sortable: true },
          { key: "status", label: t("common.status"), render: (v) => renderStatus(v ?? "closed") },
          { key: "closed_at", label: t("accountingPages.closedAt"), render: (v) => v ? renderDate(v) : t("accountingPages.open") },
          { key: "notes", label: t("accountingPages.notes"), render: (v) => v || t("accountingPages.noNotes"), hide: "md" },
        ]}
        data={closings}
        isLoading={isLoading}
        error={(error as Error)?.message}
        emptyMessage={t("accountingPages.noClosedPeriods")}
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("accountingPages.closeMonth")}</DialogTitle>
            <DialogDescription>{t("accountingPages.lockPeriodHint")}</DialogDescription>
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
                placeholder={t("accountingPages.optionalNote")}
              />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("accountingPages.cancel")}</BrandButton>
            <BrandButton
              variant="primary"
              onClick={() => createClosing.mutate()}
              disabled={createClosing.isPending || !form.month || !form.year}
            >
              {createClosing.isPending ? t("accountingPages.closing") : t("accountingPages.closePeriod")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
