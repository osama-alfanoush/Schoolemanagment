import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Warehouse, PaginatedResponse, PurchaseRequest } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { renderDate, renderCurrency, renderStatus, renderUser } from "@/lib/tableHelpers";
import { CheckIcon, XIcon, EyeIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

export default function PurchaseRequests() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data, isLoading } = useQuery({
    queryKey: ["purchase-requests", activeFilters, page],
    queryFn: () => Warehouse.purchaseRequests({ ...activeFilters, page, per_page: 20 }),
  }) as any;
  const reviewMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: any }) => Warehouse.reviewPurchaseRequest(id, data),
    onSuccess: () => { qc.invalidateQueries({ queryKey: ["purchase-requests"] }); toast({ title: "Request updated" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
  });

  const requests = toArray<PurchaseRequest>(data);
  const meta = paginationMeta(data);

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Purchase Requests" subtitle="Procurement requests and approvals" actions={<BrandButton variant="primary">+ New Request</BrandButton>} />

      <DataTable
        title="Purchase Requests"
        columns={[
          { key: "request_number", label: "Request #", render: (v) => <span className="font-mono text-xs text-muted-foreground">{v ?? "-"}</span> },
          { key: "item_name", label: "Item", sortable: true },
          { key: "requested_by_name", label: "Requested By", render: (v, row) => renderUser(v ?? "-", row.department), hide: "md" as const },
          { key: "quantity", label: "Qty", align: "center" as const, render: (v) => <span className="text-sm font-semibold text-foreground">{v}</span> },
          { key: "estimated_cost", label: "Est. Cost", render: (v) => v ? renderCurrency(v) : <span className="text-muted-foreground/70 text-xs">TBD</span>, align: "right" as const },
          { key: "created_at", label: "Requested", render: (v) => renderDate(v), sortable: true },
          { key: "status", label: "Status", render: (v) => renderStatus(v ?? "pending") },
        ]}
        data={requests}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search purchase requests..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "status", label: "Status", options: [
                { value: "pending", label: "Pending" }, { value: "approved", label: "Approved" }, { value: "rejected", label: "Rejected" },
              ]},
            ]}
          />
        }
        rowActions={[
          { label: "Approve", icon: <CheckIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "approved" } }), show: (row) => row.status === "pending" },
          { label: "Reject", icon: <XIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "rejected" } }), variant: "danger" as const, show: (row) => row.status === "pending" },
          { label: "View", icon: <EyeIcon />, onClick: () => {} },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? requests.length, perPage: 20, onPageChange: setPage }}
        emptyMessage="No purchase requests found."
      />
    </div>
  );
}
