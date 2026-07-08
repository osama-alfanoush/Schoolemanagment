import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React, { useState } from "react";
import { Pressable, RefreshControl, View } from "react-native";

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
import { Teacher, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useOfflineCache } from "@/lib/cache";
import { useI18n } from "@/lib/i18n";

export default function TeacherDashboard() {
  const { user } = useAuth();
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = useState(false);

  const tt = useQuery({
    queryKey: ["teacher", "timetable"],
    queryFn: Teacher.timetable,
  });
  const ttCache = useOfflineCache("teacher.timetable", tt);
  const ann = useQuery({
    queryKey: ["teacher", "announcements"],
    queryFn: Teacher.announcements,
  });

  const onRefresh = async () => {
    setRefreshing(true);
    await Promise.all([tt.refetch(), ann.refetch()]);
    setRefreshing(false);
  };

  if (!ttCache.data && tt.isLoading) return <LoadingView />;

  const today = new Date().getDay();
  const todaySlots = asArray(ttCache.data)
    .filter((e: any) => (e.day_of_week ?? e.day) === today)
    .sort((a: any, b: any) =>
      String(a.start_time ?? "").localeCompare(String(b.start_time ?? "")),
    );
  const announcements = asArray(ann.data);

  const quickActions: {
    icon: keyof typeof Feather.glyphMap;
    label: string;
  }[] = [
    { icon: "check-square", label: t("teacher.markAttendance") },
    { icon: "file-plus", label: t("teacher.createAssignment") },
    { icon: "edit-3", label: t("teacher.enterGrades") },
  ];

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <OfflineBadge visible={ttCache.usingCache} />
      <View style={{ marginBottom: 18 }}>
        <Body muted>{t("common.welcome")},</Body>
        <H1>{user?.name ?? ""}</H1>
      </View>

      <Card>
        <H2>{t("teacher.quickActions")}</H2>
        <View style={{ height: 10 }} />
        <Row style={{ gap: 10 }}>
          {quickActions.map((qa) => (
            <Pressable
              key={qa.label}
              onPress={() => router.push("/(teacher)/classes")}
              accessibilityLabel={qa.label}
              style={({ pressed }) => ({
                flex: 1,
                backgroundColor: colors.secondary,
                borderRadius: colors.radius,
                paddingVertical: 14,
                paddingHorizontal: 8,
                alignItems: "center",
                gap: 8,
                opacity: pressed ? 0.7 : 1,
              })}
            >
              <Feather name={qa.icon} size={20} color={colors.secondaryForeground} />
              <Body
                style={{
                  color: colors.secondaryForeground,
                  fontFamily: "Inter_600SemiBold",
                  fontSize: 12,
                  textAlign: "center",
                }}
              >
                {qa.label}
              </Body>
            </Pressable>
          ))}
        </Row>
      </Card>

      <Card>
        <H2>{t("teacher.todayClasses")}</H2>
        <View style={{ height: 8 }} />
        {todaySlots.length === 0 ? (
          <EmptyState icon="coffee" title={t("teacher.noClassesToday")} />
        ) : (
          todaySlots.map((e: any) => (
            <Row
              key={e.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                justifyContent: "space-between",
              }}
            >
              <View style={{ flex: 1, gap: 2 }}>
                <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                  {e.subject?.name ?? e.subject_name ?? "—"}
                </Body>
                <Body muted style={{ fontSize: 12 }}>
                  {e.class_room?.name ?? e.classRoom?.name ?? ""}
                  {e.room ? ` · ${t("teacher.room")} ${e.room}` : ""}
                </Body>
              </View>
              <Body muted style={{ fontSize: 12 }}>
                {(e.start_time ?? "").slice(0, 5)} — {(e.end_time ?? "").slice(0, 5)}
              </Body>
            </Row>
          ))
        )}
      </Card>

      <Card>
        <H2>{t("teacher.announcements")}</H2>
        <View style={{ height: 8 }} />
        {announcements.length === 0 ? (
          <EmptyState icon="info" title={t("common.empty")} />
        ) : (
          announcements.slice(0, 3).map((a: any) => (
            <View
              key={a.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                gap: 4,
              }}
            >
              <Body style={{ fontFamily: "Inter_600SemiBold" }}>{a.title}</Body>
              <Body muted style={{ fontSize: 13 }}>
                {a.body}
              </Body>
            </View>
          ))
        )}
      </Card>
    </Screen>
  );
}
