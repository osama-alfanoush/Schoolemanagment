import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Accounting, AuditTrailEntry } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { renderUser } from "@/lib/tableHelpers";
import { paginationMeta, toArray } from "@/lib/response";

export default function AuditTrail() {
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [dateFilter, setDateFilter] = useState<{ from?: string; to?: string }>({});

  const { data, isLoading } = useQuery({
    queryKey: ["audit-trail", search, page, dateFilter],
    queryFn: () => Accounting.auditTrail({ search, page, per_page: 25, ...dateFilter }),
  }) as any;

  const entries = toArray<AuditTrailEntry>(data);
  const meta = paginationMeta(data);

  const applyDateFilter = () => {
    setDateFilter({ from: fromDate || undefined, to: toDate || undefined });
    setPage(1);
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Audit Trail" subtitle="Complete log of all financial transactions" />

      <DataTable
        title="Audit Log"
        compact
        columns={[
          { key: "created_at", label: "Timestamp", sortable: true, render: (v) => <span className="font-mono text-xs text-muted-foreground">{new Date(v).toLocaleString()}</span> },
          { key: "user_name", label: "User", render: (v, row) => renderUser(v ?? "-", row.user_role) },
          { key: "action", label: "Action", render: (v) => (
            <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${v?.includes("delete") ? "bg-red-50 text-red-700" : v?.includes("create") ? "bg-green-50 text-green-700" : "bg-blue-50 text-blue-700"}`}>{v}</span>
          )},
          { key: "entity_type", label: "Entity", sortable: true },
          { key: "description", label: "Details", render: (v) => <span className="text-xs text-muted-foreground line-clamp-1">{v}</span> },
          { key: "ip_address", label: "IP", render: (v) => <span className="font-mono text-xs text-muted-foreground/70">{v}</span>, hide: "md" as const },
        ]}
        data={entries}
        isLoading={isLoading}
        toolbar={
          <div className="flex items-center gap-2 w-full">
            <SearchAndFilter placeholder="Search audit log..." value={search} onChange={setSearch} />
            <div className="flex items-center gap-2 ml-auto">
              <input type="date" value={fromDate} onChange={(e) => setFromDate(e.target.value)} className="px-2 py-1.5 rounded-lg border border-border text-xs" />
              <span className="text-xs text-muted-foreground/70">to</span>
              <input type="date" value={toDate} onChange={(e) => setToDate(e.target.value)} className="px-2 py-1.5 rounded-lg border border-border text-xs" />
              <BrandButton variant="secondary" size="sm" onClick={applyDateFilter}>Filter</BrandButton>
            </div>
          </div>
        }
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? entries.length, perPage: 25, onPageChange: setPage }}
        emptyMessage="No audit log entries found."
      />
    </div>
  );
}
