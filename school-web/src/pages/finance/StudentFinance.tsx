import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { FinanceWorkspace, type User } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { Search, UserRound, ReceiptText, CalendarClock, WalletCards } from "lucide-react";

type Tab = "timeline" | "invoices" | "installments" | "payments" | "statement";

export default function StudentFinance() {
  const [term, setTerm] = useState("");
  const [selectedId, setSelectedId] = useState<number | null>(null);
  const [tab, setTab] = useState<Tab>("timeline");
  const [statementPage, setStatementPage] = useState(1);

  const search = useQuery({
    queryKey: ["finance-student-search", term],
    queryFn: () => FinanceWorkspace.searchStudents(term),
    enabled: term.trim().length > 0,
  });
  const profile = useQuery({
    queryKey: ["student-finance-profile", selectedId],
    queryFn: () => FinanceWorkspace.studentProfile(selectedId!),
    enabled: selectedId !== null,
  });
  const statement = useQuery({
    queryKey: ["student-statement", selectedId, statementPage],
    queryFn: () => FinanceWorkspace.studentStatement(selectedId!, { page: statementPage, per_page: 20 }),
    enabled: selectedId !== null && tab === "statement",
  });

  const students = search.data?.data ?? [];
  const data = profile.data;
  const classroom = data?.student.student_profile?.class_room;
  const tabs: Array<{ key: Tab; label: string }> = [
    { key: "timeline", label: "الحركات" },
    { key: "invoices", label: "الرسوم والفواتير" },
    { key: "installments", label: "الأقساط" },
    { key: "payments", label: "الدفعات" },
    { key: "statement", label: "كشف الحساب" },
  ];

  return (
    <div className="space-y-6" dir="rtl">
      <PageHeader title="الملف المالي للطالب" subtitle="بحث موحّد وحركات مالية من المصدر المحاسبي نفسه" icon="💳" />

      <BrandCard className="p-4">
        <label htmlFor="student-finance-search" className="mb-2 block text-sm font-semibold">ابحث عن طالب</label>
        <div className="relative">
          <Search className="absolute end-3 top-3 h-4 w-4 text-muted-foreground" />
          <input
            id="student-finance-search"
            value={term}
            onChange={(event) => setTerm(event.target.value)}
            placeholder="رقم الطالب، الاسم، الهاتف أو ولي الأمر"
            className="w-full rounded-xl border border-border bg-background px-4 py-2.5 pe-10 text-sm focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)]/30"
          />
        </div>
        {term && !selectedId && (
          <div className="mt-3 divide-y divide-border rounded-xl border border-border">
            {students.map((student: User) => (
              <button
                type="button"
                key={student.id}
                onClick={() => { setSelectedId(student.id); setTerm(student.name); }}
                className="flex w-full items-center gap-3 p-3 text-start hover:bg-muted/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-[var(--color-primary)]"
              >
                <UserRound className="h-5 w-5 text-[var(--color-primary)]" />
                <span className="font-medium">{student.name}</span>
                <span className="text-xs text-muted-foreground">{student.student_profile?.admission_no ?? `#${student.id}`}</span>
                <span className="ms-auto text-xs text-muted-foreground">{student.phone}</span>
              </button>
            ))}
            {!search.isLoading && students.length === 0 && <p className="p-3 text-sm text-muted-foreground">لا توجد نتائج مطابقة.</p>}
          </div>
        )}
      </BrandCard>

      {!selectedId ? (
        <BrandEmptyState icon="🔎" title="اختر طالباً لفتح ملفه المالي" subtitle="تظهر الرسوم والخصومات والدفعات والأقساط وكشف الحساب في مساحة واحدة." />
      ) : profile.isLoading ? (
        <BrandCard className="animate-pulse p-8 text-center text-muted-foreground">جارٍ تحميل الملف المالي…</BrandCard>
      ) : data ? (
        <>
          <BrandCard className="sticky top-2 z-10 border-[var(--color-primary)]/20 bg-card/95 p-4 backdrop-blur">
            <div className="flex flex-wrap items-center gap-4">
              <div className="flex min-w-52 items-center gap-3">
                <div className="rounded-xl bg-[var(--color-primary-light)] p-3"><UserRound className="h-6 w-6 text-[var(--color-primary)]" /></div>
                <div>
                  <h2 className="font-bold">{data.student.name}</h2>
                  <p className="text-xs text-muted-foreground">
                    {data.student.student_profile?.admission_no ?? `#${data.student.id}`} — {classroom?.grade ?? "—"} / {classroom?.section ?? classroom?.name ?? "—"} — {classroom?.academic_year?.name ?? "—"}
                  </p>
                </div>
              </div>
              <div className="ms-auto grid grid-cols-2 gap-3 sm:grid-cols-4">
                {[
                  ["المستحق", data.summary.amount_due],
                  ["المدفوع", data.summary.paid],
                  ["المتبقي", data.summary.remaining],
                  ["المتأخر", data.summary.overdue],
                ].map(([label, value]) => (
                  <div key={String(label)} className="rounded-lg bg-muted/40 px-3 py-2 text-center">
                    <p className="text-[11px] text-muted-foreground">{label}</p>
                    <p className="font-bold tabular-nums">{renderCurrency(Number(value))}</p>
                  </div>
                ))}
              </div>
            </div>
          </BrandCard>

          <div className="flex gap-2 overflow-x-auto border-b border-border pb-2" role="tablist" aria-label="تبويبات الملف المالي">
            {tabs.map((item) => (
              <button key={item.key} type="button" role="tab" aria-selected={tab === item.key} onClick={() => setTab(item.key)}
                className={`whitespace-nowrap rounded-lg px-4 py-2 text-sm font-medium ${tab === item.key ? "bg-[var(--color-primary)] text-white" : "bg-muted/40 text-muted-foreground hover:text-foreground"}`}>
                {item.label}
              </button>
            ))}
          </div>

          {tab === "timeline" && <FinanceRows rows={data.timeline} />}
          {tab === "invoices" && <InvoiceRows invoices={data.invoices} />}
          {tab === "installments" && (
            <div className="grid gap-4 lg:grid-cols-2">
              {data.payment_plans.map((plan) => <BrandCard key={plan.id} className="p-4">
                <div className="mb-3 flex items-center justify-between"><strong>{plan.plan_no}</strong>{renderStatus(plan.status)}</div>
                <p className="mb-3 text-sm text-muted-foreground">الإجمالي {renderCurrency(plan.total_amount)} — البداية {renderDate(plan.start_date)}</p>
                <div className="space-y-2">{plan.installments?.map((item) => <div key={item.id} className="flex items-center rounded-lg bg-muted/30 p-2 text-sm">
                  <CalendarClock className="me-2 h-4 w-4" /><span>القسط {item.sequence_no} — {renderDate(item.due_date)}</span><span className="ms-auto font-semibold">{renderCurrency(item.amount - item.paid_amount)}</span>
                </div>)}</div>
              </BrandCard>)}
            </div>
          )}
          {tab === "payments" && <FinanceRows rows={data.timeline.filter((row) => row.type === "payment")} />}
          {tab === "statement" && statement.data && (
            <>
              <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
                {[["رصيد افتتاحي", statement.data.opening_balance], ["مدين", statement.data.period_debit], ["دائن", statement.data.period_credit], ["رصيد ختامي", statement.data.closing_balance]].map(([label, value]) =>
                  <BrandCard key={String(label)} className="p-3"><p className="text-xs text-muted-foreground">{label}</p><p className="mt-1 font-bold">{renderCurrency(Number(value))}</p></BrandCard>)}
              </div>
              <FinanceRows rows={statement.data.data} />
              <div className="flex justify-center gap-2">
                <button className="rounded border px-3 py-1 disabled:opacity-40" disabled={statementPage <= 1} onClick={() => setStatementPage((p) => p - 1)}>السابق</button>
                <span className="px-3 py-1 text-sm">{statementPage} / {statement.data.last_page}</span>
                <button className="rounded border px-3 py-1 disabled:opacity-40" disabled={statementPage >= statement.data.last_page} onClick={() => setStatementPage((p) => p + 1)}>التالي</button>
              </div>
            </>
          )}
        </>
      ) : null}
    </div>
  );
}

function InvoiceRows({ invoices }: { invoices: Array<{ id: number; invoice_no: string; description: string; amount: number; paid_amount: number; due_date: string; status: string }> }) {
  return <BrandCard className="overflow-x-auto p-0"><table className="w-full text-sm"><thead className="bg-muted/40"><tr><th className="p-3 text-start">الفاتورة</th><th className="p-3 text-start">البيان</th><th className="p-3">الاستحقاق</th><th className="p-3">المبلغ</th><th className="p-3">المدفوع</th><th className="p-3">الحالة</th></tr></thead><tbody>
    {invoices.map((invoice) => <tr key={invoice.id} className="border-t border-border"><td className="p-3 font-mono text-xs">{invoice.invoice_no}</td><td className="p-3">{invoice.description}</td><td className="p-3 text-center">{renderDate(invoice.due_date)}</td><td className="p-3 text-center">{renderCurrency(invoice.amount)}</td><td className="p-3 text-center">{renderCurrency(invoice.paid_amount)}</td><td className="p-3 text-center">{renderStatus(invoice.status)}</td></tr>)}
  </tbody></table></BrandCard>;
}

function FinanceRows({ rows }: { rows: Array<{ date: string; type: string; status: string; description: string; reference?: string | null; debit: number; credit: number; balance?: number }> }) {
  if (rows.length === 0) return <BrandEmptyState icon="📄" title="لا توجد حركات" subtitle="ستظهر الحركات المالية هنا عند تسجيلها." />;
  return <BrandCard className="overflow-x-auto p-0"><table className="w-full text-sm"><thead className="bg-muted/40"><tr><th className="p-3 text-start">التاريخ</th><th className="p-3 text-start">المصدر</th><th className="p-3 text-start">البيان</th><th className="p-3">مدين</th><th className="p-3">دائن</th><th className="p-3">الرصيد</th><th className="p-3">الحالة</th></tr></thead><tbody>
    {rows.map((row, index) => <tr key={`${row.type}-${row.reference}-${index}`} className="border-t border-border"><td className="p-3">{renderDate(row.date)}</td><td className="p-3"><span className="inline-flex items-center gap-1 font-mono text-xs"><ReceiptText className="h-3.5 w-3.5" />{row.reference ?? row.type}</span></td><td className="p-3">{row.description}</td><td className="p-3 text-center tabular-nums">{row.debit ? renderCurrency(row.debit) : "—"}</td><td className="p-3 text-center tabular-nums">{row.credit ? renderCurrency(row.credit) : "—"}</td><td className="p-3 text-center font-semibold tabular-nums">{row.balance === undefined ? <WalletCards className="mx-auto h-4 w-4 text-muted-foreground" /> : renderCurrency(row.balance)}</td><td className="p-3 text-center">{renderStatus(row.status)}</td></tr>)}
  </tbody></table></BrandCard>;
}
