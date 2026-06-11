import { useState, useMemo } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Accounting, JournalEntry, ChartOfAccount, PaginatedResponse } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import BrandModal from "@/components/ui/BrandModal";
import { renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { EyeIcon, TrashIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

export default function JournalEntries() {
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
    queryFn: () => Accounting.journalEntries({ search, ...activeFilters, page, per_page: 20 }),
  }) as any;

  const { data: accountsData } = useQuery({
    queryKey: ["chart-of-accounts-list"],
    queryFn: () => Accounting.chartOfAccounts({ per_page: 200 }),
  }) as any;

  const entries = toArray<JournalEntry>(data);
  const accounts = toArray<ChartOfAccount>(accountsData);
  const meta = paginationMeta(data);

  const createMutation = useMutation({
    mutationFn: (payload: any) => Accounting.createJournalEntry(payload),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["journal-entries"] });
      toast({ title: "Journal entry posted" });
      setShowModal(false);
      setForm({ entry_date: new Date().toISOString().slice(0, 10), description: "", reference_number: "", type: "general", lines: [{ account_id: "", description: "", debit: 0, credit: 0 }] });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
  });

  const deleteMutation = useMutation({
    mutationFn: (id: number) => Accounting.deleteJournalEntry(id),
    onSuccess: () => { qc.invalidateQueries({ queryKey: ["journal-entries"] }); toast({ title: "Entry deleted" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
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
      <BrandButton variant="ghost" onClick={() => setShowModal(false)}>Cancel</BrandButton>
      <BrandButton variant="primary" disabled={!isBalanced || !form.description} onClick={() => createMutation.mutate(form)}>
        {createMutation.isPending ? "Posting..." : "Post Entry"}
      </BrandButton>
    </div>
  );

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Journal Entries" subtitle="Double-entry bookkeeping records" actions={<BrandButton variant="primary" onClick={() => setShowModal(true)}>+ New Entry</BrandButton>} />

      <DataTable
        title="All Journal Entries"
        columns={[
          { key: "reference_no", label: "Reference", render: (v) => <span className="font-mono text-xs text-muted-foreground">{v ?? "-"}</span> },
          { key: "entry_date", label: "Date", render: (v) => renderDate(v), sortable: true },
          { key: "description", label: "Description", render: (v) => <span className="text-sm text-foreground line-clamp-1">{v}</span> },
          { key: "amount", label: "Amount", render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          { key: "type", label: "Type", render: (v) => (
            <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${v === "closing" ? "bg-purple-50 text-purple-700" : v === "adjustment" ? "bg-amber-50 text-amber-700" : "bg-blue-50 text-blue-700"}`}>{v ?? "general"}</span>
          )},
          { key: "status", label: "Status", render: (v) => renderStatus(v ?? "draft") },
        ]}
        data={entries}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search journal entries..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "type", label: "Type", options: [{ value: "general", label: "General" }, { value: "adjustment", label: "Adjustment" }, { value: "closing", label: "Closing" }] },
              { key: "status", label: "Status", options: [{ value: "draft", label: "Draft" }, { value: "posted", label: "Posted" }, { value: "reversed", label: "Reversed" }] },
            ]}
          />
        }
        rowActions={[
          { label: "View", icon: <EyeIcon />, onClick: (row) => {} },
          { label: "Delete", icon: <TrashIcon />, onClick: (row) => deleteMutation.mutate(row.id), variant: "danger" as const, show: (row) => row.status === "draft" },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? entries.length, perPage: 20, onPageChange: setPage }}
        emptyMessage="No journal entries found."
      />

      <BrandModal isOpen={showModal} onClose={() => setShowModal(false)} title="New Journal Entry" size="lg" footer={modalFooter}>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-muted-foreground mb-1">Date</label>
              <input type="date" value={form.entry_date} onChange={(e) => setForm({ ...form, entry_date: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
            </div>
            <div>
              <label className="block text-xs font-medium text-muted-foreground mb-1">Reference</label>
              <input type="text" value={form.reference_number} onChange={(e) => setForm({ ...form, reference_number: e.target.value })} placeholder="JE-2026-001" className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
            </div>
          </div>
          <div>
            <label className="block text-xs font-medium text-muted-foreground mb-1">Description</label>
            <textarea rows={2} value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm" />
          </div>
          <div>
            <label className="block text-xs font-medium text-muted-foreground mb-1">Type</label>
            <select value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} className="w-full px-3 py-2 rounded-lg border border-border text-sm">
              <option value="general">General</option>
              <option value="adjustment">Adjustment</option>
              <option value="closing">Closing</option>
            </select>
          </div>

          <div>
            <div className="flex items-center justify-between mb-2">
              <h4 className="text-sm font-semibold text-foreground">Journal Lines</h4>
              <BrandButton variant="ghost" size="sm" onClick={addLine}>+ Add Line</BrandButton>
            </div>
            {form.lines.map((line, idx) => (
              <div key={idx} className="flex items-start gap-2 mb-2 p-2 rounded-lg bg-muted/30">
                <div className="flex-1">
                  <select value={line.account_id} onChange={(e) => updateLine(idx, "account_id", e.target.value)} className="w-full px-2 py-1.5 rounded border border-border text-xs">
                    <option value="">Select account</option>
                    {accounts.map((acc: ChartOfAccount) => <option key={acc.id} value={acc.id}>{acc.account_code} - {acc.account_name}</option>)}
                  </select>
                </div>
                <div className="flex-1">
                  <input type="text" value={line.description} onChange={(e) => updateLine(idx, "description", e.target.value)} placeholder="Line desc" className="w-full px-2 py-1.5 rounded border border-border text-xs" />
                </div>
                <div className="w-20">
                  <input type="number" step="0.01" value={line.debit} onChange={(e) => updateLine(idx, "debit", e.target.value)} placeholder="Debit" className="w-full px-2 py-1.5 rounded border border-border text-xs" />
                </div>
                <div className="w-20">
                  <input type="number" step="0.01" value={line.credit} onChange={(e) => updateLine(idx, "credit", e.target.value)} placeholder="Credit" className="w-full px-2 py-1.5 rounded border border-border text-xs" />
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
