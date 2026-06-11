import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { ConsumptionRow, Warehouse } from "@/lib/api";
import { downloadBlob } from "@/lib/utils";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import DataTable from "@/components/ui/DataTable";
import { DownloadIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function WarehouseReports() {
  const { toast } = useToast();
  const today = new Date();
  const [month, setMonth] = useState(today.getMonth() + 1);
  const [year, setYear] = useState(today.getFullYear());

  const reportParams = { month, year };

  const { data: consumptionData } = useQuery({
    queryKey: ["consumption-report", month, year],
    queryFn: () => Warehouse.consumptionReport(reportParams),
  }) as any;
  const consumptionRows = toArray<ConsumptionRow>(consumptionData);

  const handleDownload = (apiCall: Promise<unknown>, filename: string) => {
    downloadBlob(apiCall, filename, (e: unknown) => {
      toast({ variant: "destructive", title: "Download failed", description: (e as Error)?.message });
    });
  };

  const setCurrentMonth = () => {
    setMonth(today.getMonth() + 1);
    setYear(today.getFullYear());
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="WR" title="Warehouse Reports" subtitle="Inventory and consumption analysis" />

      <div className="flex items-center gap-3 mb-6 flex-wrap">
        <label className="text-sm text-muted-foreground">Month:</label>
        <select value={month} onChange={(e) => setMonth(Number(e.target.value))} className="px-3 py-1.5 rounded-lg border border-border text-sm">
          {Array.from({ length: 12 }, (_, i) => i + 1).map((m) => (
            <option key={m} value={m}>{m}</option>
          ))}
        </select>
        <label className="text-sm text-muted-foreground">Year:</label>
        <input type="number" value={year} onChange={(e) => setYear(Number(e.target.value))} className="w-24 px-3 py-1.5 rounded-lg border border-border text-sm" />
        <BrandButton variant="secondary" size="sm" onClick={setCurrentMonth}>Current Month</BrandButton>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-amber to-brand-orange flex items-center justify-center text-lg font-semibold text-white">CR</div>
            <h3 className="font-display text-base font-bold text-ink-dark">Consumption Report</h3>
            <p className="text-sm text-muted-foreground">Track stock usage and consumption patterns.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Warehouse.consumptionPdf(reportParams), "consumption.pdf")}>
              <DownloadIcon /> Download PDF
            </BrandButton>
          </div>
        </BrandCard>

        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-teal to-brand-mint flex items-center justify-center text-lg font-semibold text-white">IR</div>
            <h3 className="font-display text-base font-bold text-ink-dark">Inventory Report</h3>
            <p className="text-sm text-muted-foreground">Complete inventory snapshot with valuations.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Warehouse.inventoryPdf(reportParams), "inventory.pdf")}>
              <DownloadIcon /> Download PDF
            </BrandButton>
          </div>
        </BrandCard>
      </div>

      <DataTable
        title="Consumption Preview"
        compact
        columns={[
          { key: "item_name", label: "Item" },
          { key: "sku", label: "SKU" },
          { key: "department", label: "Department" },
          { key: "total_quantity", label: "Qty Used", align: "center" as const },
          { key: "unit", label: "Unit" },
        ]}
        data={consumptionRows}
        emptyMessage="No consumption data for the selected period."
      />
    </div>
  );
}
