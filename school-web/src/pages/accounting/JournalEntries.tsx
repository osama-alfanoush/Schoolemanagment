import { useState, useMemo } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Accounting, JournalBatch, ChartOfAccount } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import BrandModal from "@/components/ui/BrandModal";
import { renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { EyeIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

export default function JournalEntries() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [showModal, setShowModal] = useState(false);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});
  const [form, setForm] = useState({
    entry_date: new Date().toISOString().slice(0, 10),
    description: "",
    reference_number: "",
    type: "general",
    lines: [{ account_id: "", description: "", debit: 0, credit: 0 }],
  });

  const { data, isLoading } = useQuery({
    queryKey: ["journal-entries", search, activeFilters, page],
    queryFn: () => Accounting.journalBatches({ search, ...activeFilters, page, per_page: 20 }),
  }) as any;

  const { data: accountsData } = useQuery({
    queryKey: ["chart-of-accounts-list"],
    queryFn: () => Accounting.chartOfAccounts({ per_page: 200 }),
  }) as any;

  const entries = toArray<JournalBatch>(data);
  const accounts = toArray<ChartOfAccount>(accountsData);
  const meta = paginationMeta(data);

  const createMutation = useMutation({
    mutationFn: (payload: any) => Accounting.createJournalBatch({ ...payload, source: payload.type }),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["journal-entries"] });
      toast({ title: t("accountingPages.draftCreated") });
      setShowModal(false);
      setForm({ entry_date: new Date().toISOString().slice(0, 10), description: "", reference_number: "", type: "general", lines: [{ account_id: "", description: "", debit: 0, credit: 0 }] });
    },
    onError: (e: any) => toast({ variant: "destructive", title: t("accountingPages.failed"), description: e?.message }),
  });

  const workflowMutation = useMutation({
    mutationFn: async ({ row, action }: { row: JournalBatch; action: "approve" | "post" | "reverse" }) => {
      if (action === "approve") return Accounting.approveJournalBatch(row.id);
      if (action === "post") return Accounting.postJournalBatch(row.id);
      const reason = window.prompt(t("accountingPages.reversalReason"))?.trim();
      if (!reason) throw new Error(t("accountingPages.reversalReasonRequired"));
      return Accounting.reverseJournalBatch(row.id, reason);
    },
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["journal-entries"] }); toast({ title: t("accountingPages.workflowUpdated") }); },
    onError: (e: any) => toast({ variant: "destructive", title: t("accountingPages.failed"), description: e?.message }),
  });

  const totalDebits = useMemo(() => form.lines.reduce((s, l) => s + Number(l.debit || 0), 0), [form.lines]);
  const totalCredits = useMemo(() => form.lines.reduce((s, l) => s + Number(l.credit || 0), 0), [form.lines]);
  const isBalanced = Math.abs(totalDebits - totalCredits) < 0.01;

  const addLine = () => setForm((f) => ({ ...f, lines: [...f.lines, { account_id: "", description: "", debit: 0, credit: 0 }] }));
  const updateLine = (idx: number, field: string, value: any) => {
    setForm((f) => { const lines = [...f.lines]; (lines as any)[idx][field] = value; return { ...f, lines }; });
  };
  const removeLine = (idx: number) => setForm((f) => ({ ...f, lines: f.lines.filter((_, i) => i !== idx) }));

  const modalFooter = (
    <div className="flex justify-end gap-2">
      <BrandButton variant="ghost" onClick={() => setShowModal(false)}>{t("accountingPages.cancel")}</BrandButton>
      <BrandButton variant="primary" disabled={!isBalanced || !form.description} onClick={() => createMutation.mutate(form)}>
        {createMutation.isPending ? "Posting..." : t("accountingPages.postEntry")}
      </BrandButton>
    </div>
  );

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("accountingPages.journalTitle")} subtitle={t("accountingPages.journalSubtitle")} actions={<BrandButton variant="primary" onClick={() => setShowModal(true)}>+ {t("accountingPages.newEntry")}</BrandButton>} />

      <DataTable
        title={t("accountingPages.allJournalEntries")}
        columns={[
          { key: "reference_no", label: t("accountingPages.reference"), render: (v) => <span className="font-mono text-xs text-muted-foreground">{v ?? "-"}</span> },
          { key: "entry_date", label: t("accountingPages.date"), render: (v) => renderDate(v), sortable: true },
          { key: "description", label: t("accountingPages.description"), render: (v) => <span className="text-sm text-foreground line-clamp-1">{v}</span> },
          { key: "lines", label: t("accountingPages.amount"), render: (_v, row) => renderCurrency((row.lines ?? []).filter((line: any) => line.type === "debit").reduce((sum: number, line: any) => sum + Number(line.amount), 0)), align: "right" as const },
          { key: "source", label: t("accountingPages.type"), render: (v) => (
            <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${v === "closing" ? "bg-purple-50 text-purple-700" : v === "adjustment" ? "bg-amber-50 text-amber-700" : "bg-blue-50 text-blue-700"}`}>{v ?? "general"}</span>
          )},
          { key: "status", label: t("common.status"), render: (v) => renderStatus(v ?? "draft") },
        ]}
        data={entries}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder={t("accountingPages.searchJournal")}
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "source", label: t("accountingPages.type"), options: [{ value: "general", label: t("accountingPages.general") }, { value: "adjustment", label: t("accountingPages.adjustment") }, { value: "closing", label: t("accountingPages.closingType") }] },
              { key: "status", label: t("common.status"), options: [{ value: "draft", label: t("status.draft") }, { value: "posted", label: t("accountingPages.posted") }, { value: "reversed", label: t("accountingPages.reversed") }] },
            ]}
          />
        }
        rowActions={[
          { label: t("accountingPages.view"), icon: <EyeIcon />, onClick: () => {} },
          { label: t("accountingPages.approve"), icon: <span>✓</span>, onClick: (row) => workflowMutation.mutate({ row, action: "approve" }), show: (row) => row.status === "draft" },
          { label: t("accountingPages.post"), icon: <span>↗</span>, onClick: (row) => workflowMutation.mutate({ row, action: "post" }), show: (row) => row.status === "approved" },
          { label: t("accountingPages.reverse"), icon: <span>↶</span>, onClick: (row) => workflowMutation.mutate({ row, action: "reverse" }), variant: "danger" as const, show: (row) => row.status === "posted" },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? entries.length, perPage: 20, onPageChange: setPage }}
        emptyMessage={t("accountingPages.noJournalEntries")}
      />

      <BrandModal isOpen={showModal} onClose={() => setShowModal(false)} title={t("accountingPages.newJournalEntry")} size="lg" footer={modalFooter}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label htmlFor="journal-entry-date" className="block text-xs font-medium text-muted-foreground mb-1">Date</label>
              <input id="journal-entry-date" type="date" value={form.entry_date} onChange={(e) => setForm({ ...form, entry_date: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
            </div>
            <div>
              <label htmlFor="journal-entry-reference" className="block text-xs font-medium text-muted-foreground mb-1">{t("accountingPages.reference")}</label>
              <input id="journal-entry-reference" type="text" value={form.reference_number} onChange={(e) => setForm({ ...form, reference_number: e.target.value })} placeholder="JE-2026-001" className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
            </div>
          </div>
          <div>
            <label htmlFor="journal-entry-description" className="block text-xs font-medium text-muted-foreground mb-1">{t("accountingPages.description")}</label>
            <textarea id="journal-entry-description" rows={2} value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
          </div>
          <div>
            <label htmlFor="journal-entry-type" className="block text-xs font-medium text-muted-foreground mb-1">Type</label>
            <select id="journal-entry-type" value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm">
              <option value="general">{t("accountingPages.general")}</option>
              <option value="adjustment">{t("accountingPages.adjustment")}</option>
              <option value="closing">{t("accountingPages.closingType")}</option>
            </select>
          </div>

          <div>
            <div className="flex items-center justify-between mb-2">
              <h4 className="text-sm font-semibold text-foreground">{t("accountingPages.journalLines")}</h4>
              <BrandButton variant="ghost" size="sm" onClick={addLine}>+ Add Line</BrandButton>
            </div>
            {form.lines.map((line, idx) => (
              <div key={idx} className="flex items-start gap-2 mb-2 p-2 rounded-lg bg-muted/30">
                <div className="flex-1">
                  <select value={line.account_id} onChange={(e) => updateLine(idx, "account_id", e.target.value)} className="w-full px-2 py-1.5 rounded border border-border text-xs">
                    <option value="">{t("accountingPages.selectAccount")}</option>
                    {accounts.map((acc: ChartOfAccount) => <option key={acc.id} value={acc.id}>{acc.account_code} - {acc.account_name}</option>)}
                  </select>
                </div>
                <div className="flex-1">
                  <input type="text" value={line.description} onChange={(e) => updateLine(idx, "description", e.target.value)} placeholder={t("accountingPages.lineDesc")} className="w-full px-2 py-1.5 rounded border border-border text-xs" />
                </div>
                <div className="w-20">
                  <input type="number" step="0.01" value={line.debit} onChange={(e) => updateLine(idx, "debit", e.target.value)} placeholder={t("accountingPages.debit")} className="w-full px-2 py-1.5 rounded border border-border text-xs" />
                </div>
                <div className="w-20">
                  <input type="number" step="0.01" value={line.credit} onChange={(e) => updateLine(idx, "credit", e.target.value)} placeholder={t("accountingPages.credit")} className="w-full px-2 py-1.5 rounded border border-border text-xs" />
                </div>
                <button onClick={() => removeLine(idx)} className="p-1.5 text-muted-foreground/70 hover:text-red-500 mt-1">x</button>
              </div>
            ))}
            <div className="flex items-center justify-between pt-2 border-t border-border/50">
              <div className="space-x-4 text-sm">
                <span>Total Debits: <strong>{renderCurrency(totalDebits)}</strong></span>
                <span>Total Credits: <strong>{renderCurrency(totalCredits)}</strong></span>
              </div>
              {isBalanced ? <span className="text-xs text-green-600 font-semibold">Done Balanced</span> : <span className="text-xs text-red-600 font-semibold">Warning Entry not balanced</span>}
            </div>
          </div>
        </div>
      </BrandModal>
    </div>
  );
}
