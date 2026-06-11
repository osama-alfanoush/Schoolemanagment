import { useQuery } from "@tanstack/react-query";
import React, { useMemo, useState } from "react";
import { RefreshControl, View } from "react-native";

import {
  Body,
  Card,
  EmptyState,
  H1,
  H2,
  LoadingView,
  OfflineBadge,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Student, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

export default function StudentAttendance() {
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);
  const q = useQuery({
    queryKey: ["student", "attendance"],
    queryFn: Student.attendance,
  });
  const cache = useOfflineCache("student.attendance", q);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  const records = asArray(cache.data);

  const summary = useMemo(() => {
    const s = { present: 0, absent: 0, late: 0, excused: 0 };
    for (const r of records) {
      const k = (r.status as keyof typeof s) ?? "present";
      if (k in s) s[k]++;
    }
    return s;
  }, [records]);

  if (!cache.data && q.isLoading) return <LoadingView />;
  if (!cache.data && q.error) {
    return (
      <Screen>
        <H1 style={{ marginBottom: 16 }}>{t("tabs.attendance")}</H1>
        <EmptyState icon="alert-circle" title={(q.error as Error)?.message || t("common.error")} />
      </Screen>
    );
  }

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <H1 style={{ marginBottom: 16 }}>{t("tabs.attendance")}</H1>

      <Card>
        <Row style={{ justifyContent: "space-between" }}>
          <SummaryStat label={t("attendance.present")} value={summary.present} color="#16a34a" />
          <SummaryStat label={t("attendance.absent")} value={summary.absent} color="#dc2626" />
          <SummaryStat label={t("attendance.late")} value={summary.late} color="#d97706" />
          <SummaryStat label={t("attendance.excused")} value={summary.excused} color={colors.mutedForeground} />
        </Row>
      </Card>

      <Card>
        <H2>{t("tabs.attendance")}</H2>
        <View style={{ height: 8 }} />
        {records.length === 0 ? (
          <EmptyState icon="calendar" title={t("common.empty")} />
        ) : (
          records
            .slice()
            .sort(
              (a: any, b: any) =>
                new Date(b.date).getTime() - new Date(a.date).getTime(),
            )
            .slice(0, 30)
            .map((r: any) => (
              <Row
                key={r.id ?? r.date}
                style={{
                  paddingVertical: 10,
                  borderTopWidth: 1,
                  borderTopColor: colors.border,
                  justifyContent: "space-between",
                }}
              >
                <Body>{r.date ? new Date(r.date).toLocaleDateString() : "-"}</Body>
                <View
                  style={{
                    paddingHorizontal: 10,
                    paddingVertical: 4,
                    borderRadius: 999,
                    backgroundColor: tone(r.status, colors.muted),
                  }}
                >
                  <Body
                    style={{
                      fontFamily: "Inter_600SemiBold",
                      color: toneText(r.status),
                      fontSize: 12,
                    }}
                  >
                    {t(`attendance.${r.status}`) || r.status}
                  </Body>
                </View>
              </Row>
            ))
        )}
      </Card>
    </Screen>
  );
}

function SummaryStat({
  label,
  value,
  color,
}: {
  label: string;
  value: number;
  color: string;
}) {
  return (
    <View style={{ alignItems: "center", flex: 1, gap: 2 }}>
      <Body style={{ fontFamily: "Inter_700Bold", fontSize: 22, color }}>
        {value}
      </Body>
      <Body muted style={{ fontSize: 11, textAlign: "center" }}>
        {label}
      </Body>
    </View>
  );
}

function tone(status: string, fallback: string) {
  return (
    {
      present: "#dcfce7",
      absent: "#fee2e2",
      late: "#fef3c7",
      excused: "#dbeafe",
    }[status] ?? fallback
  );
}
function toneText(status: string) {
  return (
    {
      present: "#166534",
      absent: "#991b1b",
      late: "#92400e",
      excused: "#1e40af",
    }[status] ?? "#0a0a0a"
  );
}
