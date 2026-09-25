import { useState } from "react";
import { useTranslation } from "react-i18next";
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
  const { t } = useTranslation();
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
    void downloadBlob(apiCall, filename, (e: unknown) => {
      toast({ variant: "destructive", title: t("warehouse.downloadFailed"), description: (e as Error)?.message });
    });
  };

  const setCurrentMonth = () => {
    setMonth(today.getMonth() + 1);
    setYear(today.getFullYear());
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="WR" title={t("warehouse.reportsTitle")} subtitle={t("warehouse.reportsSubtitle")} />

      <div className="flex items-center gap-3 mb-6 flex-wrap">
        <label htmlFor="warehouse-report-month" className="text-sm text-muted-foreground">{t("warehouse.month")}</label>
        <select id="warehouse-report-month" value={month} onChange={(e) => setMonth(Number(e.target.value))} className="px-3 py-1.5 rounded-lg border border-border text-sm">
          {Array.from({ length: 12 }, (_, i) => i + 1).map((m) => (
            <option key={m} value={m}>{m}</option>
          ))}
        </select>
        <label htmlFor="warehouse-report-year" className="text-sm text-muted-foreground">{t("warehouse.year")}</label>
        <input id="warehouse-report-year" type="number" value={year} onChange={(e) => setYear(Number(e.target.value))} className="w-24 px-3 py-1.5 rounded-lg border border-border text-sm" />
        <BrandButton variant="secondary" size="sm" onClick={setCurrentMonth}>{t("warehouse.currentMonth")}</BrandButton>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-amber to-brand-orange flex items-center justify-center text-lg font-semibold text-white">CR</div>
            <h3 className="font-display text-base font-bold text-ink-dark">{t("warehouse.consumptionReport")}</h3>
            <p className="text-sm text-muted-foreground">Track stock usage and consumption patterns.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Warehouse.consumptionPdf(reportParams), "consumption.pdf")}>
              <DownloadIcon /> {t("warehouse.downloadPdf")}
            </BrandButton>
          </div>
        </BrandCard>

        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-teal to-brand-mint flex items-center justify-center text-lg font-semibold text-white">IR</div>
            <h3 className="font-display text-base font-bold text-ink-dark">{t("warehouse.inventoryReport")}</h3>
            <p className="text-sm text-muted-foreground">Complete inventory snapshot with valuations.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Warehouse.inventoryPdf(reportParams), "inventory.pdf")}>
              <DownloadIcon /> {t("warehouse.downloadPdf")}
            </BrandButton>
          </div>
        </BrandCard>
      </div>

      <DataTable
        title={t("warehouse.consumptionPreview")}
        compact
        columns={[
          { key: "item_name", label: t("warehouse.item") },
          { key: "sku", label: t("warehouse.sku") },
          { key: "department", label: t("warehouse.department") },
          { key: "total_quantity", label: t("warehouse.qtyUsed"), align: "center" as const },
          { key: "unit", label: t("warehouse.unitLabel") },
        ]}
        data={consumptionRows}
        emptyMessage={t("warehouse.noConsumption")}
      />
    </div>
  );
}
