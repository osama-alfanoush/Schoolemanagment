import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import React, { useState } from "react";
import { RefreshControl, View } from "react-native";

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
import { Student, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

export default function StudentDashboard() {
  const { user } = useAuth();
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);

  const dash = useQuery({
    queryKey: ["student", "dashboard"],
    queryFn: Student.dashboard,
  });
  const cache = useOfflineCache("student.dashboard", dash);

  const onRefresh = async () => {
    setRefreshing(true);
    await dash.refetch();
    setRefreshing(false);
  };

  if (!cache.data && dash.isLoading) return <LoadingView />;

  const data: any = cache.data ?? {};
  const upcoming = asArray(data.upcoming_assignments ?? data.assignments);
  const recentGrades = asArray(data.recent_grades ?? data.grades);
  const announcements = asArray(data.announcements);

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <View style={{ marginBottom: 18 }}>
        <Body muted>{t("common.welcome")},</Body>
        <H1>{user?.name ?? ""}</H1>
      </View>

      <Card>
        <H2>{t("student.upcoming")}</H2>
        <View style={{ height: 8 }} />
        {upcoming.length === 0 ? (
          <EmptyState icon="check-circle" title={t("common.empty")} />
        ) : (
          upcoming.slice(0, 5).map((a: any) => (
            <View
              key={a.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
              }}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <View style={{ flex: 1, gap: 2 }}>
                  <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                    {a.title}
                  </Body>
                  <Body muted style={{ fontSize: 12 }}>
                    {a.subject?.name ?? a.subject_name ?? ""}
                    {a.due_at || a.due_date
                      ? ` · ${t("student.due")}: ${new Date(
                          a.due_at ?? a.due_date,
                        ).toLocaleDateString()}`
                      : ""}
                  </Body>
                </View>
                <DueStatusPill assignment={a} />
              </Row>
            </View>
          ))
        )}
      </Card>

      <Card>
        <H2>{t("student.recentGrades")}</H2>
        <View style={{ height: 8 }} />
        {recentGrades.length === 0 ? (
          <EmptyState icon="bar-chart-2" title={t("common.empty")} />
        ) : (
          recentGrades.slice(0, 5).map((g: any, i: number) => (
            <View
              key={g.id ?? i}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
              }}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <View style={{ flex: 1, gap: 2 }}>
                  <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                    {g.subject?.name ?? g.subject_name ?? "—"}
                  </Body>
                  <Body muted style={{ fontSize: 12 }}>
                    {g.component?.name ?? g.component_name ?? ""}
                  </Body>
                </View>
                <ScoreBadge score={g.score} max={g.max_score ?? g.component?.max_score} />
              </Row>
            </View>
          ))
        )}
      </Card>

      {announcements.length > 0 ? (
        <Card>
          <H2>{t("student.announcements")}</H2>
          <View style={{ height: 8 }} />
          {announcements.slice(0, 3).map((a: any) => (
            <View
              key={a.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                gap: 4,
              }}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <Body style={{ fontFamily: "Inter_600SemiBold", flex: 1 }}>
                  {a.title}
                </Body>
                <Feather name="info" size={14} color={colors.mutedForeground} />
              </Row>
              <Body muted style={{ fontSize: 13 }}>
                {a.body}
              </Body>
            </View>
          ))}
        </Card>
      ) : null}
    </Screen>
  );
}

function DueStatusPill({ assignment }: { assignment: any }) {
  const { t } = useI18n();
  const submitted =
    assignment.submission ?? assignment.my_submission ?? assignment.submitted;
  if (submitted) return <Pill label={t("student.submitted")} tone="success" />;
  const due = assignment.due_at ?? assignment.due_date;
  if (due && new Date(due).getTime() < Date.now())
    return <Pill label={t("student.overdue")} tone="danger" />;
  return <Pill label={t("student.pending")} tone="warning" />;
}

function ScoreBadge({ score, max }: { score: any; max: any }) {
  const colors = useColors();
  if (score == null) return <Pill label="—" tone="neutral" />;
  const pct = max ? Math.round((Number(score) / Number(max)) * 100) : null;
  const tone =
    pct == null
      ? "neutral"
      : pct >= 80
        ? "success"
        : pct >= 60
          ? "info"
          : pct >= 40
            ? "warning"
            : "danger";
  return (
    <View style={{ alignItems: "flex-end", gap: 2 }}>
      <Body style={{ fontFamily: "Inter_700Bold", fontSize: 16 }}>
        {String(score)}
        {max ? `/${max}` : ""}
      </Body>
      {pct != null ? <Pill label={`${pct}%`} tone={tone as any} /> : null}
      <Body muted style={{ fontSize: 10, color: colors.mutedForeground }}>
        {""}
      </Body>
    </View>
  );
}
