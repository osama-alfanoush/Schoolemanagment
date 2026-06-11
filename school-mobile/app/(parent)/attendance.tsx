import { useQuery } from "@tanstack/react-query";
import React, { useMemo, useState } from "react";
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
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Parent, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

import { useChild } from "@/lib/parentChild";

export default function ParentAttendance() {
  const { t } = useI18n();
  const colors = useColors();
  const { selected } = useChild();
  const [refreshing, setRefreshing] = useState(false);
  const q = useQuery({
    queryKey: ["parent", "attendance", selected?.id],
    queryFn: () => Parent.childAttendance(selected!.id),
    enabled: !!selected,
  });
  const cache = useOfflineCache(`parent.attendance.${selected?.id}`, q);

  const records = asArray(cache.data);
  const summary = useMemo(() => {
    const s = { present: 0, absent: 0, late: 0, excused: 0 };
    for (const r of records) {
      const k = (r.status as keyof typeof s) ?? "present";
      if (k in s) s[k]++;
    }
    return s;
  }, [records]);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  if (!selected || (!cache.data && q.isLoading)) return <LoadingView />;

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <H1 style={{ marginBottom: 12 }}>{t("tabs.attendance")}</H1>
      <ChildSwitcher />

      <Card>
        <Row style={{ justifyContent: "space-between" }}>
          <Stat label={t("attendance.present")} value={summary.present} color="#16a34a" />
          <Stat label={t("attendance.absent")} value={summary.absent} color="#dc2626" />
          <Stat label={t("attendance.late")} value={summary.late} color="#d97706" />
          <Stat label={t("attendance.excused")} value={summary.excused} color={colors.mutedForeground} />
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
                <Body>{new Date(r.date).toLocaleDateString()}</Body>
                <View
                  style={{
                    paddingHorizontal: 10,
                    paddingVertical: 4,
                    borderRadius: 999,
                    backgroundColor: bg(r.status, colors.muted),
                  }}
                >
                  <Body
                    style={{
                      fontFamily: "Inter_600SemiBold",
                      color: fg(r.status),
                      fontSize: 12,
                    }}
                  >
                    {t(`attendance.${r.status}`)}
                  </Body>
                </View>
              </Row>
            ))
        )}
      </Card>
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
function bg(status: string, fallback: string) {
  return (
    {
      present: "#dcfce7",
      absent: "#fee2e2",
      late: "#fef3c7",
      excused: "#dbeafe",
    }[status] ?? fallback
  );
}
function fg(status: string) {
  return (
    {
      present: "#166534",
      absent: "#991b1b",
      late: "#92400e",
      excused: "#1e40af",
    }[status] ?? "#0a0a0a"
  );
}
