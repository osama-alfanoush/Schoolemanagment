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
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Student } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

type SubjectRow = {
  scores: any[];
  cumulative_pct?: number | null;
};

function subjectsFromGrades(payload: any): [string, SubjectRow][] {
  const bySubject = payload?.by_subject ?? payload?.data?.by_subject;
  if (bySubject && typeof bySubject === "object" && !Array.isArray(bySubject)) {
    return Object.entries(bySubject).map(([subject, row]: [string, any]) => [
      subject,
      {
        scores: Array.isArray(row?.scores) ? row.scores : [],
        cumulative_pct: row?.cumulative_pct ?? null,
      },
    ]);
  }

  const rows = Array.isArray(payload) ? payload : Array.isArray(payload?.data) ? payload.data : [];
  const grouped = new Map<string, SubjectRow>();
  for (const grade of rows) {
    const subject =
      grade.subject?.name ??
      grade.subject_name ??
      grade.component?.subject?.name ??
      "Unknown";
    const row = grouped.get(subject) ?? { scores: [], cumulative_pct: null };
    row.scores.push(grade);
    grouped.set(subject, row);
  }

  return Array.from(grouped.entries()).map(([subject, row]) => {
    const pcts = row.scores
      .map((grade: any) => {
        const max = grade.max_score ?? grade.component?.max_score;
        return max ? (Number(grade.score) / Number(max)) * 100 : null;
      })
      .filter((value: number | null): value is number => value != null && !isNaN(value));
    return [
      subject,
      {
        ...row,
        cumulative_pct: pcts.length
          ? Math.round(pcts.reduce((a, b) => a + b, 0) / pcts.length)
          : null,
      },
    ];
  });
}

export default function StudentGrades() {
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);
  const q = useQuery({ queryKey: ["student", "grades"], queryFn: Student.grades });
  const cache = useOfflineCache("student.grades", q);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  const bySubject = useMemo(() => subjectsFromGrades(cache.data), [cache.data]);
  const overallAvg = useMemo(() => {
    const pcts = bySubject
      .map(([, row]) => row.cumulative_pct)
      .filter((value): value is number => value != null && !isNaN(value));
    if (!pcts.length) return null;
    return Math.round(pcts.reduce((a, b) => a + b, 0) / pcts.length);
  }, [bySubject]);

  if (!cache.data && q.isLoading) return <LoadingView />;

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <H1 style={{ marginBottom: 16 }}>{t("tabs.grades")}</H1>

      {overallAvg != null ? (
        <Card>
          <Row style={{ justifyContent: "space-between" }}>
            <Body muted>{t("common.overall")}</Body>
            <Body style={{ fontFamily: "Inter_700Bold", fontSize: 28 }}>
              {overallAvg}%
            </Body>
          </Row>
        </Card>
      ) : null}

      {bySubject.length === 0 ? (
        <EmptyState icon="bar-chart-2" title={t("common.empty")} />
      ) : (
        bySubject.map(([subject, row]) => {
          const avg = row.cumulative_pct != null ? Math.round(Number(row.cumulative_pct)) : null;
          return (
            <Card key={subject}>
              <Row style={{ justifyContent: "space-between" }}>
                <H2>{subject}</H2>
                {avg != null ? (
                  <Pill
                    label={`${avg}%`}
                    tone={avg >= 80 ? "success" : avg >= 60 ? "info" : avg >= 40 ? "warning" : "danger"}
                  />
                ) : null}
              </Row>
              <View style={{ marginTop: 10, gap: 10 }}>
                {row.scores.slice(0, 8).map((grade: any, index: number) => {
                  const max = grade.max_score ?? grade.component?.max_score ?? 100;
                  const score = Number(grade.score);
                  const pct = Math.max(0, Math.min(100, (score / Number(max)) * 100));
                  return (
                    <View key={grade.id ?? index} style={{ gap: 4 }}>
                      <Row style={{ justifyContent: "space-between" }}>
                        <Body style={{ fontSize: 13 }}>
                          {grade.component?.name ?? grade.component_name ?? grade.component ?? "Score"}
                        </Body>
                        <Body muted style={{ fontSize: 12, fontFamily: "Inter_600SemiBold" }}>
                          {grade.score}/{max}
                        </Body>
                      </Row>
                      <View
                        style={{
                          height: 6,
                          borderRadius: 999,
                          backgroundColor: colors.muted,
                          overflow: "hidden",
                        }}
                      >
                        <View
                          style={{
                            height: 6,
                            width: `${pct}%`,
                            backgroundColor: colors.primary,
                          }}
                        />
                      </View>
                    </View>
                  );
                })}
              </View>
            </Card>
          );
        })
      )}
    </Screen>
  );
}
