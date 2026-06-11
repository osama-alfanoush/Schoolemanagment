import { useQuery } from "@tanstack/react-query";
import { useLocation } from "wouter";
import { Warehouse } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { renderDate, renderStatus, renderProgress } from "@/lib/tableHelpers";
import { useTranslation } from "react-i18next";
import { toArray } from "@/lib/response";

export default function WarehouseDashboard() {
  const [, navigate] = useLocation();
  const { t } = useTranslation();

  const { data: stats, isLoading } = useQuery({
    queryKey: ["warehouse-dashboard"],
    queryFn: () => Warehouse.dashboard(),
  }) as any;

  const { data: lowStockData } = useQuery({
    queryKey: ["low-stock-items"],
    queryFn: () => Warehouse.items({ status: "low-stock", per_page: 6 }),
  }) as any;

  const { data: recentMovements } = useQuery({
    queryKey: ["recent-movements"],
    queryFn: () => Warehouse.movements({ per_page: 6 }),
  }) as any;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-brand-purple border-t-transparent" />
      </div>
    );
  }

  const lowStockItems = toArray(lowStockData);
  const movements = toArray(recentMovements);

  return (
    <div className="space-y-6">
      <PageHeader icon="🏭" title={t("warehouseDashboard.title")} subtitle={t("warehouseDashboard.subtitle")} />

      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <StatCard title={t("warehouseDashboard.totalItems")} value={stats?.total_items ?? 0} icon={<span className="text-lg">📦</span>} />
        <StatCard title={t("warehouseDashboard.lowStockText")} value={stats?.low_stock_count ?? 0} icon={<span className="text-lg">⚠️</span>} />
        <div className="relative overflow-hidden rounded-2xl p-6 text-white" style={{ background: "linear-gradient(135deg, #fca5a5, #f87171)" }}>
          <div className="absolute -bottom-6 -right-6 h-32 w-32 rounded-full bg-card/10" />
          <div className="ml-auto flex h-10 w-10 items-center justify-center rounded-xl bg-card/20">
            <span className="text-lg">🚫</span>
          </div>
          <p className="mt-3 text-sm opacity-80">{t("warehouseDashboard.outOfStock")}</p>
          <p className="font-display text-3xl font-bold">{stats?.out_of_stock ?? 0}</p>
        </div>
        <StatCard title={t("warehouseDashboard.pendingRequests")} value={stats?.pending_requests ?? 0} icon={<span className="text-lg">🛒</span>} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
        <BrandCard className="!p-0 overflow-hidden">
          <div className="flex items-center justify-between p-5 pb-3">
            <h3 className="font-display text-base font-bold text-ink-dark">{t("warehouseDashboard.lowStockAlerts")}</h3>
            <BrandButton variant="ghost" size="sm" onClick={() => navigate("/warehouse/items")}>{t("studentDashboard.viewAll")}</BrandButton>
          </div>
          <div className="px-5 pb-5">
            {lowStockItems.length > 0 ? (
              <div className="flex flex-col divide-y divide-gray-50">
                {lowStockItems.map((item: any) => (
                  <div key={item.id} className="flex items-center justify-between py-3">
                    <div>
                      <p className="text-sm font-medium text-foreground">{item.name}</p>
                      <p className="text-xs text-muted-foreground/70">{item.category_name}</p>
                    </div>
                    <div className="flex-1 mx-4">{renderProgress(item.current_stock, item.minimum_stock * 2)}</div>
                    <div className="text-right rtl:text-left">
                      {renderStatus("low-stock")}
                      <p className="text-xs text-muted-foreground mt-0.5">{item.current_stock} {t("warehouseDashboard.left")}</p>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground/70 text-center py-8">{t("warehouseDashboard.allStocked")}</p>
            )}
          </div>
        </BrandCard>

        <BrandCard className="!p-0 overflow-hidden">
          <div className="flex items-center justify-between p-5 pb-3">
            <h3 className="font-display text-base font-bold text-ink-dark">{t("warehouseDashboard.recentMovements")}</h3>
            <BrandButton variant="ghost" size="sm" onClick={() => navigate("/warehouse/movements")}>{t("studentDashboard.viewAll")}</BrandButton>
          </div>
          <div className="px-5 pb-5">
            {movements.length > 0 ? (
              <div className="flex flex-col divide-y divide-gray-50">
                {movements.map((m: any) => {
                  const typeCfg: Record<string, { bg: string; text: string; icon: string }> = {
                    in: { bg: "bg-green-50", text: "text-green-600", icon: "↑" },
                    out: { bg: "bg-red-50", text: "text-red-600", icon: "↓" },
                    transfer: { bg: "bg-blue-50", text: "text-blue-600", icon: "↔" },
                    adjustment: { bg: "bg-amber-50", text: "text-amber-600", icon: "~" },
                  };
                  const cfg = typeCfg[m.movement_type] ?? typeCfg.adjustment;
                  const isIn = m.movement_type === "in";
                  return (
                    <div key={m.id} className="flex items-center gap-3 py-3">
                      <div className={`w-8 h-8 rounded-lg flex items-center justify-center text-sm flex-shrink-0 ${cfg.bg} ${cfg.text}`}>{cfg.icon}</div>
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium text-foreground">{m.item_name}</p>
                        <p className="text-xs text-muted-foreground/70">{renderDate(m.movement_date)}</p>
                      </div>
                      <div className="text-right rtl:text-left">
                        <p className={`text-sm font-bold ${isIn ? "text-green-600" : "text-red-600"}`}>{isIn ? "+" : "-"}{m.quantity}</p>
                        <p className="text-xs text-muted-foreground/70">{m.unit ?? "units"}</p>
                      </div>
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground/70 text-center py-8">{t("warehouseDashboard.noMovements")}</p>
            )}
          </div>
        </BrandCard>
      </div>
    </div>
  );
}
