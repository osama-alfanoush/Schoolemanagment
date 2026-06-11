import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Warehouse, PaginatedResponse, StockMovement } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { renderDate, renderUser } from "@/lib/tableHelpers";
import { paginationMeta, toArray } from "@/lib/response";

export default function Movements() {
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data, isLoading } = useQuery({
    queryKey: ["stock-movements", search, activeFilters, page],
    queryFn: () => Warehouse.movements({ search, ...activeFilters, page, per_page: 25 }),
  }) as any;
  const movements = toArray<StockMovement>(data);
  const meta = paginationMeta(data);

  const typeStyle: Record<string, { bg: string; text: string; icon: string; label: string }> = {
    in: { bg: "#dcfce7", text: "#166534", icon: "up", label: "Stock In" },
    out: { bg: "#fee2e2", text: "#991b1b", icon: "down", label: "Stock Out" },
    transfer: { bg: "#dbeafe", text: "#1e40af", icon: "both", label: "Transfer" },
    adjustment: { bg: "#fef9c3", text: "#854d0e", icon: "~", label: "Adjustment" },
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Stock Movements" subtitle="All stock in/out and transfer records" actions={<BrandButton variant="primary">+ Record Movement</BrandButton>} />

      <DataTable
        title="Movement History"
        columns={[
          { key: "movement_type", label: "Type", render: (v) => {
            const cfg = typeStyle[v] ?? typeStyle.adjustment;
            return <span style={{ backgroundColor: cfg.bg, color: cfg.text, display: "inline-flex", alignItems: "center", gap: "4px", padding: "3px 10px", borderRadius: "9999px", fontSize: "11px", fontWeight: 500 }}>{cfg.icon} {cfg.label}</span>;
          }},
          { key: "item_name", label: "Item", sortable: true, render: (v, row) => (
            <div>
              <div className="text-sm font-medium text-foreground">{v}</div>
              <div className="text-xs text-muted-foreground/70">{row.category_name}</div>
            </div>
          )},
          { key: "quantity", label: "Qty", align: "center" as const, render: (v, row) => (
            <span className={`text-sm font-bold ${row.movement_type === "in" ? "text-green-600" : row.movement_type === "out" ? "text-red-600" : "text-blue-600"}`}>
              {row.movement_type === "in" ? "+" : row.movement_type === "out" ? "-" : ""}{v}
            </span>
          )},
          { key: "movement_date", label: "Date", render: (v) => renderDate(v), sortable: true },
          { key: "performed_by_name", label: "By", render: (v, row) => renderUser(v ?? "-", row.notes), hide: "md" as const },
          { key: "reference", label: "Ref", render: (v) => v ? <span className="font-mono text-xs text-muted-foreground/70">{v}</span> : <span className="text-muted-foreground/50">-</span>, hide: "lg" as const },
        ]}
        data={movements}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search movements..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "type", label: "Movement Type", options: [
                { value: "in", label: "Stock In" }, { value: "out", label: "Stock Out" },
                { value: "transfer", label: "Transfer" }, { value: "adjustment", label: "Adjustment" },
              ]},
            ]}
          />
        }
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? movements.length, perPage: 25, onPageChange: setPage }}
        emptyMessage="No movements recorded."
      />
    </div>
  );
}
