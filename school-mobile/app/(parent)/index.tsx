import { useQuery } from "@tanstack/react-query";
import React, { useState } from "react";
import { RefreshControl, View } from "react-native";

import { ChildSwitcher } from "@/components/ChildSwitcher";
import {
  Body,
  Card,
  EmptyState,
  H1,
  H2,
  LoadingView,
  OfflineBadge,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Parent, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

import { useChild } from "@/lib/parentChild";

export default function ParentHome() {
  const { t } = useI18n();
  const colors = useColors();
  const { selected, loading } = useChild();
  const [refreshing, setRefreshing] = useState(false);

  const overview = useQuery({
    queryKey: ["parent", "overview", selected?.id],
    queryFn: () => Parent.childOverview(selected!.id),
    enabled: !!selected,
  });
  const assignments = useQuery({
    queryKey: ["parent", "assignments", selected?.id],
    queryFn: () => Parent.childAssignments(selected!.id),
    enabled: !!selected,
  });
  const ovCache = useOfflineCache(`parent.overview.${selected?.id}`, overview);

  const onRefresh = async () => {
    setRefreshing(true);
    await Promise.all([overview.refetch(), assignments.refetch()]);
    setRefreshing(false);
  };

  if (loading) return <LoadingView />;

  const ov: any = ovCache.data ?? {};
  const recentGrades = asArray(ov.recent_grades ?? ov.grades);
  const att = ov.attendance_summary ?? ov.attendance ?? {};
  const items = asArray(assignments.data);

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={ovCache.usingCache} />
      <H1 style={{ marginBottom: 12 }}>{t("parent.overview")}</H1>
      <ChildSwitcher />

      {!selected ? (
        <EmptyState icon="users" title={t("parent.myChildren")} />
      ) : (
        <>
          <Card>
            <H2>{t("tabs.attendance")}</H2>
            <View style={{ height: 8 }} />
            <Row style={{ justifyContent: "space-between" }}>
              <Stat label={t("parent.presentDays")} value={att.present ?? 0} color="#16a34a" />
              <Stat label={t("parent.absentDays")} value={att.absent ?? 0} color="#dc2626" />
              <Stat label={t("parent.lateDays")} value={att.late ?? 0} color="#d97706" />
            </Row>
          </Card>

          <Card>
            <H2>{t("student.recentGrades")}</H2>
            <View style={{ height: 8 }} />
            {recentGrades.length === 0 ? (
              <EmptyState icon="bar-chart-2" title={t("common.empty")} />
            ) : (
              recentGrades.slice(0, 5).map((g: any, i: number) => (
                <Row
                  key={g.id ?? i}
                  style={{
                    paddingVertical: 10,
                    borderTopWidth: 1,
                    borderTopColor: colors.border,
                    justifyContent: "space-between",
                  }}
                >
                  <View style={{ flex: 1 }}>
                    <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                      {g.subject?.name ?? g.subject_name ?? "—"}
                    </Body>
                    <Body muted style={{ fontSize: 12 }}>
                      {g.component?.name ?? g.component_name ?? ""}
                    </Body>
                  </View>
                  <Body style={{ fontFamily: "Inter_700Bold" }}>
                    {g.score}
                    {g.max_score ?? g.component?.max_score
                      ? `/${g.max_score ?? g.component?.max_score}`
                      : ""}
                  </Body>
                </Row>
              ))
            )}
          </Card>

          <Card>
            <H2>{t("parent.homework")}</H2>
            <View style={{ height: 8 }} />
            {items.length === 0 ? (
              <EmptyState icon="book" title={t("common.empty")} />
            ) : (
              items.slice(0, 6).map((a: any) => {
                const submitted = a.submission ?? a.my_submission;
                const due = a.due_at ?? a.due_date;
                const overdue =
                  due && new Date(due).getTime() < Date.now() && !submitted;
                return (
                  <Row
                    key={a.id}
                    style={{
                      paddingVertical: 10,
                      borderTopWidth: 1,
                      borderTopColor: colors.border,
                      justifyContent: "space-between",
                    }}
                  >
                    <View style={{ flex: 1 }}>
                      <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                        {a.title}
                      </Body>
                      <Body muted style={{ fontSize: 12 }}>
                        {a.subject?.name ?? a.subject_name ?? ""}
                        {due
                          ? ` · ${new Date(due).toLocaleDateString()}`
                          : ""}
                      </Body>
                    </View>
                    {submitted ? (
                      <Pill label={t("student.submitted")} tone="success" />
                    ) : overdue ? (
                      <Pill label={t("student.overdue")} tone="danger" />
                    ) : (
                      <Pill label={t("student.pending")} tone="warning" />
                    )}
                  </Row>
                );
              })
            )}
          </Card>
        </>
      )}
    </Screen>
  );
}

function Stat({
  label,
  value,
  color,
}: {
  label: string;
  value: any;
  color: string;
}) {
  return (
    <View style={{ alignItems: "center", flex: 1, gap: 2 }}>
      <Body style={{ fontFamily: "Inter_700Bold", fontSize: 22, color }}>
        {String(value)}
      </Body>
      <Body muted style={{ fontSize: 11, textAlign: "center" }}>
        {label}
      </Body>
    </View>
  );
}
