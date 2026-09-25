import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { Parent } from "@/lib/api";
import { renderUser, renderProgress } from "@/lib/tableHelpers";
import { useLocation } from "wouter";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

/**
 * The API serialises the relation as `student_profile` and carries the class
 * on the nested `class_room`; reading a camelCase `grade_level`/`class_name`
 * that the payload never had rendered every child as "Grade ? - ".
 */
function childClass(child: any): string {
  const room = child.student_profile?.class_room;
  if (room?.name) return room.name;
  const grade = room?.grade ?? child.student_profile?.grade_level;
  return grade ? `Grade ${grade}${room?.section ? ` - ${room.section}` : ""}` : "—";
}

export default function ParentChildren() {
  const { t } = useTranslation();
  const [, navigate] = useLocation();

  const { data: children, isLoading } = useQuery({
    queryKey: ["parent-children"],
    queryFn: () => Parent.children(),
  }) as any;
const list = Array.isArray(children) ? children : children?.data ?? [];

  if (isLoading) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title={t("parentPages.childrenTitle")} subtitle={t("parentPages.childrenSubtitle")} />
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {Array.from({ length: 2 }).map((_, i) => (
            <div key={i} className="rounded-2xl p-6 bg-card shadow-card animate-pulse">
              <div className="flex items-center gap-4 mb-4">
                <div className="w-12 h-12 rounded-full bg-muted/50" />
                <div className="flex-1 space-y-2">
                  <div className="w-32 h-4 bg-muted/50 rounded" />
                  <div className="w-24 h-3 bg-muted/30 rounded" />
                </div>
              </div>
              <div className="grid grid-cols-3 gap-3 pt-4 border-t border-border/50">
                {Array.from({ length: 3 }).map((_, j) => (
                  <div key={j} className="text-center">
                    <div className="w-12 h-6 bg-muted/50 rounded mx-auto" />
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (list.length === 0) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title={t("parentPages.childrenTitle")} subtitle={t("parentPages.childrenSubtitle")} />
        <BrandEmptyState icon="UI" title={t("parentPages.noChildren")} subtitle={t("parentPages.noChildrenHint")} />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("parentPages.childrenTitle")} subtitle={t("parentPages.childrenSubtitle")} />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {list.map((child: any) => (
          <BrandCard
            key={child.id}
            onClick={() => navigate(`/parent/children/${child.id}`)}
          >
            <div className="flex items-center gap-4 mb-4">
              {renderUser(child.name, childClass(child))}
              <BrandButton variant="ghost" size="sm">{t("parentPages.viewDetails")}</BrandButton>
            </div>

            <div className="grid grid-cols-3 gap-3 pt-4 border-t border-border/50">
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.attendance_rate ?? "-"}%
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">{t("parentPages.attendance")}</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.average_grade ?? "-"}%
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">{t("parentPages.avgGrade")}</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.pending_assignments ?? 0}
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">{t("parentPages.pendingTasks")}</p>
              </div>
            </div>

            <div className="mt-4">
              <p className="text-xs text-muted-foreground mb-2">{t("parentPages.overallPerformance")}</p>
              {renderProgress(child.average_grade ?? 0, 100)}
            </div>

            <div className="flex gap-2 mt-4 flex-wrap">
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>{t("parentPages.overview")}</BrandButton>
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>{t("parentPages.grades")}</BrandButton>
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>{t("parentPages.attendance")}</BrandButton>
            </div>
          </BrandCard>
        ))}
      </div>
    </div>
  );
}

