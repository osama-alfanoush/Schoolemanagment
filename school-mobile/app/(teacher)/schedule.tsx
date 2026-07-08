import { useQuery } from "@tanstack/react-query";
import React, { useState } from "react";
import { RefreshControl, View } from "react-native";

import {
  Body,
  Card,
  EmptyState,
  H1,
  LoadingView,
  OfflineBadge,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Teacher, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

const DAYS_EN = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const DAYS_AR = ["الأحد", "الإثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة", "السبت"];

export default function TeacherSchedule() {
  const { t, locale } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);

  const q = useQuery({
    queryKey: ["teacher", "timetable"],
    queryFn: Teacher.timetable,
  });
  const cache = useOfflineCache("teacher.timetable", q);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  if (!cache.data && q.isLoading) return <LoadingView />;

  const entries = asArray(cache.data);
  const byDay = new Map<number, any[]>();
  for (const e of entries) {
    const d = e.day_of_week ?? e.day;
    if (typeof d === "number") {
      if (!byDay.has(d)) byDay.set(d, []);
      byDay.get(d)!.push(e);
    }
  }
  const days = locale === "ar" ? DAYS_AR : DAYS_EN;
  const today = new Date().getDay();

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <H1 style={{ marginBottom: 16 }}>{t("tabs.schedule")}</H1>

      {entries.length === 0 ? (
        <EmptyState icon="calendar" title={t("common.empty")} />
      ) : (
        Array.from({ length: 7 })
          .map((_, i) => i)
          .filter((d) => byDay.has(d))
          .map((d) => (
            <Card
              key={d}
              style={
                d === today
                  ? { borderColor: colors.primary, borderWidth: 1 }
                  : undefined
              }
            >
              <Row style={{ justifyContent: "space-between", marginBottom: 4 }}>
                <Body style={{ fontFamily: "Inter_700Bold", fontSize: 15 }}>
                  {days[d]}
                </Body>
                {d === today ? (
                  <Body style={{ color: colors.primary, fontSize: 12 }}>
                    {t("common.today")}
                  </Body>
                ) : null}
              </Row>
              {byDay
                .get(d)!
                .sort((a: any, b: any) =>
                  String(a.start_time ?? "").localeCompare(
                    String(b.start_time ?? ""),
                  ),
                )
                .map((e: any) => (
                  <Row
                    key={e.id}
                    style={{
                      paddingVertical: 8,
                      borderTopWidth: 1,
                      borderTopColor: colors.border,
                      justifyContent: "space-between",
                    }}
                  >
                    <View style={{ flex: 1 }}>
                      <Body style={{ fontFamily: "Inter_500Medium" }}>
                        {e.subject?.name ?? e.subject_name ?? "—"}
                      </Body>
                      <Body muted style={{ fontSize: 12 }}>
                        {e.class_room?.name ?? e.classRoom?.name ?? ""}
                        {e.room ? ` · ${t("teacher.room")} ${e.room}` : ""}
                      </Body>
                    </View>
                    <Body muted style={{ fontSize: 12 }}>
                      {(e.start_time ?? "").slice(0, 5)} —{" "}
                      {(e.end_time ?? "").slice(0, 5)}
                    </Body>
                  </Row>
                ))}
            </Card>
          ))
      )}
    </Screen>
  );
}
