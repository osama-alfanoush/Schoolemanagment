import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React from "react";
import { Pressable, View } from "react-native";

import {
  Body,
  Card,
  EmptyState,
  H1,
  H2,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Student, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

const DAYS_EN = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const DAYS_AR = ["الأحد", "الإثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة", "السبت"];

export default function StudentMore() {
  const { t, locale } = useI18n();
  const { user } = useAuth();
  const colors = useColors();

  const tt = useQuery({ queryKey: ["student", "timetable"], queryFn: Student.timetable });
  const ann = useQuery({
    queryKey: ["student", "announcements"],
    queryFn: Student.announcements,
  });

  const entries = asArray(tt.data);
  const byDay = new Map<number, any[]>();
  for (const e of entries) {
    const d = e.day_of_week ?? e.day;
    if (typeof d === "number") {
      if (!byDay.has(d)) byDay.set(d, []);
      byDay.get(d)!.push(e);
    }
  }
  const days = locale === "ar" ? DAYS_AR : DAYS_EN;
  const announcements = asArray(ann.data);

  return (
    <Screen scroll>
      <H1 style={{ marginBottom: 16 }}>{t("tabs.more")}</H1>

      <Card>
        <Row style={{ justifyContent: "space-between" }}>
          <View style={{ gap: 2 }}>
            <Body style={{ fontFamily: "Inter_600SemiBold", fontSize: 16 }}>
              {user?.name}
            </Body>
            <Body muted>{user?.email}</Body>
          </View>
          <Pressable
            onPress={() => router.push("/profile")}
            accessibilityLabel="Profile"
          >
            <Feather name="settings" size={20} color={colors.foreground} />
          </Pressable>
        </Row>
      </Card>

      <Card>
        <H2>{t("student.timetable")}</H2>
        <View style={{ height: 8 }} />
        {entries.length === 0 ? (
          <EmptyState icon="calendar" title={t("common.empty")} />
        ) : (
          Array.from({ length: 7 })
            .map((_, i) => i)
            .filter((d) => byDay.has(d))
            .map((d) => (
              <View key={d} style={{ marginTop: 8 }}>
                <Body style={{ fontFamily: "Inter_600SemiBold", marginBottom: 4 }}>
                  {days[d]}
                </Body>
                {byDay.get(d)!.map((e: any) => (
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
                        {e.teacher?.name ?? e.teacher_name ?? ""}
                      </Body>
                    </View>
                    <Body muted style={{ fontSize: 12 }}>
                      {(e.start_time ?? "").slice(0, 5)} —{" "}
                      {(e.end_time ?? "").slice(0, 5)}
                    </Body>
                  </Row>
                ))}
              </View>
            ))
        )}
      </Card>

      <Card>
        <H2>{t("student.announcements")}</H2>
        <View style={{ height: 8 }} />
        {announcements.length === 0 ? (
          <EmptyState icon="info" title={t("common.empty")} />
        ) : (
          announcements.slice(0, 8).map((a: any) => (
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
