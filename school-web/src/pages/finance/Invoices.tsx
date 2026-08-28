import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Download, CreditCard, Send } from "lucide-react";
import { format } from "date-fns";
import { useToast } from "@/hooks/use-toast";

export default function FinanceInvoices() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [genOpen, setGenOpen] = useState(false);
  const [payOpen, setPayOpen] = useState<any>(null);
  const [genForm, setGenForm] = useState({ fee_structure_id: "", due_date: "", class_room_id: "", student_user_ids: "" });
  const [payForm, setPayForm] = useState({ amount: "", method: "cash", reference: "" });

  const { data, isLoading } = useQuery({
    queryKey: ["finance", "invoices"],
    queryFn: () => Finance.invoices()
  }) as any;
  const { data: fsData } = useQuery({
    queryKey: ["finance", "fee-structures"],
    queryFn: Finance.feeStructures,
  }) as any;

  const invoices = Array.isArray(data) ? data : data?.data ?? [];
  const feeStructures = Array.isArray(fsData) ? fsData : fsData?.data ?? [];
  const outstandingOf = (inv: any) => Math.max(0, Number(inv.amount ?? 0) - Number(inv.paid_amount ?? 0));

  const generate = useMutation({
    mutationFn: (body: any) => Finance.generateInvoices(body),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["finance", "invoices"] });
      toast({ title: t("financePages.invoicesGenerated") });
      setGenOpen(false);
      setGenForm({ fee_structure_id: "", due_date: "", class_room_id: "", student_user_ids: "" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: t("financePages.generationFailed"), description: e?.data?.message ?? e?.message })
  });

  const pay = useMutation({
    mutationFn: ({ id, body }: { id: number; body: any }) => Finance.recordPayment(id, body),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["finance", "invoices"] });
      toast({ title: t("financePages.paymentRecordedOk") });
      setPayOpen(null);
      setPayForm({ amount: "", method: "cash", reference: "" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: t("financePages.paymentFailed"), description: e?.data?.message ?? e?.message })
  });

  const reminders = useMutation({
    mutationFn: () => Finance.sendReminders(),
    onSuccess: () => toast({ title: t("financePages.remindersSent") }),
    onError: (e: any) => toast({ variant: "destructive", title: t("financePages.failed"), description: e?.message })
  });

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
          {t("nav.invoices")}
        </h1>
        <div className="flex gap-2">
          <BrandButton variant="outline" onClick={() => reminders.mutate()} disabled={reminders.isPending}>
            <Send className="h-4 w-4 me-2" />
            {t("financePages.sendReminders")}
          </BrandButton>
          <BrandButton onClick={() => setGenOpen(true)}>{t("financePages.generateBatch")}</BrandButton>
        </div>
      </div>

      <div>
        <DataTable
          columns={[
            {
              key: "invoice_no",
              label: t("financePages.invoiceNo"),
              sortable: true,
              render: (val) => <span className="font-medium font-mono text-sm">{val}</span>,
            },
            {
              key: "student",
              label: t("financePages.student"),
              sortable: true,
              render: (_, inv) => inv.student?.name || t("financePages.unknown"),
            },
            {
              key: "amount",
              label: t("common.amount"),
              sortable: true,
              align: "right",
              render: (val) => <span className="font-mono">{Number(val ?? 0).toFixed(2)}</span>,
            },
            {
              key: "balance",
              label: t("financePages.balance"),
              sortable: true,
              align: "right",
              render: (_, inv) => <span className="font-mono">{outstandingOf(inv).toFixed(2)}</span>,
            },
            {
              key: "status",
              label: t("common.status"),
              sortable: true,
              render: (val) => (
                <Badge
                  variant={
                    val === "paid"
                      ? "default"
                      : val === "overdue"
                      ? "destructive"
                      : val === "partial"
                      ? "secondary"
                      : "outline"
                  }
                  className="capitalize"
                >
                  {val}
                </Badge>
              ),
            },
            {
              key: "due_date",
              label: t("financePages.dueDate"),
              sortable: true,
              render: (val) => (val ? format(new Date(val), "MMM d, yyyy") : "-"),
            },
          ]}
          data={invoices}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
          rowActions={[
            {
              label: t("financePages.recordPayment"),
              icon: <CreditCard className="h-4 w-4" />,
              show: (inv) => inv.status !== "paid",
              onClick: (inv) => {
                setPayOpen(inv);
                setPayForm({
                  amount: String(outstandingOf(inv) || inv.amount || ""),
                  method: "cash",
                  reference: "",
                });
              },
            },
            {
              label: t("financePages.downloadReceipt"),
              icon: <Download className="h-4 w-4" />,
              onClick: (inv) => {
                void Finance.receiptPdf(inv.id, inv.invoice_no);
              },
            },
          ]}
        />
      </div>

      <Dialog open={genOpen} onOpenChange={setGenOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("financePages.generateInvoiceBatch")}</DialogTitle>
            <DialogDescription>
              Issue invoices for all students under a fee structure.
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="fs">{t("financePages.feeStructure")}</Label>
              <select
                id="fs"
                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                value={genForm.fee_structure_id}
                onChange={e => setGenForm({ ...genForm, fee_structure_id: e.target.value })}
              >
                <option value="">Select…</option>
                {feeStructures.map((fs: any) => (
                  <option key={fs.id} value={fs.id}>
                    {fs.name}{fs.grade != null && fs.grade !== "" ? ` — Grade ${fs.grade}` : ""} (${Number(fs.amount ?? 0).toFixed(2)})
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="due">{t("financePages.dueDate")}</Label>
              <Input id="due" type="date" value={genForm.due_date} onChange={e => setGenForm({ ...genForm, due_date: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cls">{t("financePages.classRoomId")}</Label>
              <Input id="cls" type="number" value={genForm.class_room_id} placeholder={t("financePages.invoiceWholeClass")} onChange={e => setGenForm({ ...genForm, class_room_id: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="sids">{t("financePages.studentIdsOptional")}</Label>
              <Input id="sids" value={genForm.student_user_ids} placeholder="e.g. 12, 15, 20" onChange={e => setGenForm({ ...genForm, student_user_ids: e.target.value })} />
              <p className="text-xs text-muted-foreground">Provide a class room ID and/or a comma-separated list of student IDs.</p>
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setGenOpen(false)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={() => {
              const ids = genForm.student_user_ids
                .split(",")
                .map(s => Number(s.trim()))
                .filter(n => Number.isFinite(n) && n > 0);
              const body: any = { fee_structure_id: Number(genForm.fee_structure_id), due_date: genForm.due_date };
              if (genForm.class_room_id) body.class_room_id = Number(genForm.class_room_id);
              if (ids.length) body.student_user_ids = ids;
              generate.mutate(body);
            }} disabled={!genForm.fee_structure_id || !genForm.due_date || (!genForm.class_room_id && !genForm.student_user_ids.trim()) || generate.isPending}>
              {generate.isPending ? t("common.loading") : t("financePages.generate")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!payOpen} onOpenChange={o => !o && setPayOpen(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("financePages.recordPayment")}</DialogTitle>
            <DialogDescription>
              {payOpen ? `${t("financePages.invoiceNo")} ${payOpen.invoice_no}` : ""}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="amt">{t("common.amount")}</Label>
              <Input id="amt" type="number" step="0.01" value={payForm.amount} onChange={e => setPayForm({
              ...payForm,
              amount: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="method">{t("financePages.method")}</Label>
              <select id="method" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={payForm.method} onChange={e => setPayForm({
              ...payForm,
              method: e.target.value
            })}>
                <option value="cash">{t("financePages.cash")}</option>
                <option value="bank_transfer">{t("financePages.bankTransfer")}</option>
                <option value="card">{t("financePages.card")}</option>
                <option value="online">{t("financePages.online")}</option>
              </select>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="ref">{t("financePages.reference")}</Label>
              <Input id="ref" value={payForm.reference} onChange={e => setPayForm({
              ...payForm,
              reference: e.target.value
            })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setPayOpen(null)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={() => payOpen && pay.mutate({
            id: payOpen.id,
            body: {
              amount: Number(payForm.amount),
              method: payForm.method,
              reference: payForm.reference
            }
          })} disabled={!payForm.amount || pay.isPending}>
              {pay.isPending ? t("common.loading") : t("financePages.record")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
