import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React, { useState } from "react";
import { Pressable, RefreshControl, View } from "react-native";

import {
  Body,
  Card,
  EmptyState,
  ErrorView,
  H1,
  LoadingView,
  OfflineBadge,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Teacher, asArray } from "@/lib/api";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

export default function TeacherClasses() {
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);

  const q = useQuery({ queryKey: ["teacher", "classes"], queryFn: Teacher.classes });
  const cache = useOfflineCache("teacher.classes", q);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  if (!cache.data && q.isLoading) return <LoadingView />;
  if (!cache.data && q.isError)
    return <ErrorView onRetry={() => q.refetch()} />;

  const classes = asArray(cache.data);

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={cache.usingCache} />
      <H1 style={{ marginBottom: 16 }}>{t("teacher.myClasses")}</H1>

      {classes.length === 0 ? (
        <EmptyState icon="users" title={t("common.empty")} />
      ) : (
        classes.map((c: any) => (
          <Pressable
            key={c.id}
            onPress={() => router.push(`/(teacher)/class/${c.id}`)}
            accessibilityLabel={`${t("teacher.classStudents")}: ${c.name}`}
          >
            {({ pressed }) => (
              <Card style={{ opacity: pressed ? 0.7 : 1 }}>
                <Row style={{ justifyContent: "space-between" }}>
                  <View style={{ flex: 1, gap: 4 }}>
                    <Body style={{ fontFamily: "Inter_600SemiBold", fontSize: 16 }}>
                      {c.name}
                    </Body>
                    <Body muted style={{ fontSize: 12 }}>
                      {[c.grade, c.section].filter(Boolean).join(" · ")}
                    </Body>
                    <Row style={{ gap: 6, flexWrap: "wrap", marginTop: 4 }}>
                      {asArray(c.subjects).map((s: any) => (
                        <Pill key={s.id} label={s.name} tone="info" />
                      ))}
                    </Row>
                  </View>
                  <View style={{ alignItems: "flex-end", gap: 6 }}>
                    <Pill
                      label={`${c.students_count ?? "—"} ${t("teacher.students")}`}
                      tone="neutral"
                    />
                    <Feather
                      name="chevron-right"
                      size={18}
                      color={colors.mutedForeground}
                    />
                  </View>
                </Row>
              </Card>
            )}
          </Pressable>
        ))
      )}
    </Screen>
  );
}
