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
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Parent, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

import { useChild } from "@/lib/parentChild";

export default function ParentGrades() {
  const { t } = useI18n();
  const colors = useColors();
  const { selected } = useChild();
  const [refreshing, setRefreshing] = useState(false);

  const q = useQuery({
    queryKey: ["parent", "grades", selected?.id],
    queryFn: () => Parent.childGrades(selected!.id),
    enabled: !!selected,
  });
  const cache = useOfflineCache(`parent.grades.${selected?.id}`, q);

  const grades = asArray(cache.data);
  const bySubject = useMemo(() => {
    const map = new Map<string, any[]>();
    for (const g of grades) {
      const key =
        g.subject?.name ?? g.subject_name ?? g.component?.subject?.name ?? g.subject_id?.toString() ?? "—";
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(g);
    }
    return Array.from(map.entries());
  }, [grades]);

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
      <H1 style={{ marginBottom: 12 }}>{t("tabs.grades")}</H1>
      <ChildSwitcher />

      {bySubject.length === 0 ? (
        <EmptyState icon="bar-chart-2" title={t("common.empty")} />
      ) : (
        bySubject.map(([subject, items]) => {
          const pcts = items
            .map((g: any) => {
              const max = g.max_score ?? g.component?.max_score;
              return max ? (Number(g.score) / Number(max)) * 100 : null;
            })
            .filter((v): v is number => v != null && !isNaN(v));
          const avg =
            pcts.length > 0
              ? Math.round(pcts.reduce((a, b) => a + b, 0) / pcts.length)
              : null;
          return (
            <Card key={subject}>
              <Row style={{ justifyContent: "space-between" }}>
                <H2>{subject}</H2>
                {avg != null ? (
                  <Pill
                    label={`${avg}%`}
                    tone={
                      avg >= 80
                        ? "success"
                        : avg >= 60
                          ? "info"
                          : avg >= 40
                            ? "warning"
                            : "danger"
                    }
                  />
                ) : null}
              </Row>
              <View style={{ marginTop: 8, gap: 8 }}>
                {items.slice(0, 8).map((g: any, i: number) => {
                  const max = g.max_score ?? g.component?.max_score ?? 100;
                  const pct = Math.max(
                    0,
                    Math.min(100, (Number(g.score) / Number(max)) * 100),
                  );
                  return (
                    <View key={g.id ?? i} style={{ gap: 4 }}>
                      <Row style={{ justifyContent: "space-between" }}>
                        <Body style={{ fontSize: 13 }}>
                          {g.component?.name ?? g.component_name ?? "—"}
                        </Body>
                        <Body
                          muted
                          style={{ fontSize: 12, fontFamily: "Inter_600SemiBold" }}
                        >
                          {g.score}/{max}
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
