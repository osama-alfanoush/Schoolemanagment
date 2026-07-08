import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React, { useState } from "react";
import { Pressable, View } from "react-native";

import {
  Body,
  Btn,
  Card,
  EmptyState,
  H1,
  H2,
  Pill,
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

      <LibraryCard />
      <TransportCard />
    </Screen>
  );
}

function LibraryCard() {
  const { t } = useI18n();
  const colors = useColors();
  const [busy, setBusy] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);

  const books = useQuery({
    queryKey: ["student", "library", "books"],
    queryFn: () => Student.libraryBooks(),
  });
  const mine = useQuery({
    queryKey: ["student", "library", "mine"],
    queryFn: Student.myBorrowings,
  });

  const borrow = async (id: number) => {
    setBusy(id);
    setError(null);
    try {
      await Student.borrowBook(id);
      await Promise.all([books.refetch(), mine.refetch()]);
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setBusy(null);
    }
  };

  const giveBack = async (borrowingId: number) => {
    setBusy(borrowingId);
    setError(null);
    try {
      await Student.returnBook(borrowingId);
      await Promise.all([books.refetch(), mine.refetch()]);
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setBusy(null);
    }
  };

  const bookList = asArray(books.data);
  const borrowings = asArray(mine.data).filter((b: any) => !b.returned_at);

  return (
    <Card>
      <H2>{t("student.library")}</H2>
      <View style={{ height: 8 }} />
      {error ? (
        <Body style={{ color: colors.destructive, marginBottom: 8 }}>{error}</Body>
      ) : null}

      {borrowings.length > 0 ? (
        <View style={{ marginBottom: 8 }}>
          <Body style={{ fontFamily: "Inter_600SemiBold", marginBottom: 4 }}>
            {t("student.myBorrowings")}
          </Body>
          {borrowings.map((b: any) => (
            <Row
              key={b.id}
              style={{
                paddingVertical: 8,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                justifyContent: "space-between",
              }}
            >
              <View style={{ flex: 1, gap: 2 }}>
                <Body style={{ fontFamily: "Inter_500Medium" }}>
                  {b.book?.title ?? b.title ?? "—"}
                </Body>
                {b.due_date ? (
                  <Body muted style={{ fontSize: 12 }}>
                    {t("student.due")}: {String(b.due_date).slice(0, 10)}
                  </Body>
                ) : null}
              </View>
              <Btn
                title={t("student.return")}
                variant="secondary"
                loading={busy === b.id}
                onPress={() => giveBack(b.id)}
                style={{ paddingVertical: 10, paddingHorizontal: 12 }}
              />
            </Row>
          ))}
        </View>
      ) : null}

      {bookList.length === 0 ? (
        <EmptyState icon="book" title={t("common.empty")} />
      ) : (
        bookList.slice(0, 8).map((bk: any) => (
          <Row
            key={bk.id}
            style={{
              paddingVertical: 8,
              borderTopWidth: 1,
              borderTopColor: colors.border,
              justifyContent: "space-between",
            }}
          >
            <View style={{ flex: 1, gap: 2 }}>
              <Body style={{ fontFamily: "Inter_500Medium" }}>{bk.title}</Body>
              <Body muted style={{ fontSize: 12 }}>
                {[bk.author, bk.category].filter(Boolean).join(" · ")}
              </Body>
            </View>
            {(bk.available_copies ?? bk.copies_available ?? 1) > 0 ? (
              <Btn
                title={t("student.borrow")}
                variant="ghost"
                loading={busy === bk.id}
                onPress={() => borrow(bk.id)}
                style={{ paddingVertical: 10, paddingHorizontal: 12 }}
              />
            ) : (
              <Pill label="0" tone="neutral" />
            )}
          </Row>
        ))
      )}
    </Card>
  );
}

function TransportCard() {
  const { t } = useI18n();
  const colors = useColors();
  const route = useQuery({
    queryKey: ["student", "transport"],
    queryFn: Student.transportRoute,
    retry: false,
  });

  const data: any = route.data ?? {};
  const r = data.route ?? data.data ?? data;
  const stops = asArray(r?.stops);

  return (
    <Card>
      <H2>{t("student.transport")}</H2>
      <View style={{ height: 8 }} />
      {route.isLoading ? (
        <Body muted>{t("common.loading")}</Body>
      ) : !r || (!r.name && !r.id) ? (
        <EmptyState icon="truck" title={t("common.empty")} />
      ) : (
        <View style={{ gap: 6 }}>
          <Row style={{ justifyContent: "space-between" }}>
            <Body style={{ fontFamily: "Inter_600SemiBold" }}>
              {t("student.route")}
            </Body>
            <Body>{r.name ?? "—"}</Body>
          </Row>
          {r.vehicle?.plate_number || r.vehicle?.model ? (
            <Row style={{ justifyContent: "space-between" }}>
              <Body muted>{t("student.vehicle")}</Body>
              <Body>
                {[r.vehicle?.model, r.vehicle?.plate_number]
                  .filter(Boolean)
                  .join(" · ")}
              </Body>
            </Row>
          ) : null}
          {r.driver_name || r.vehicle?.driver_name ? (
            <Row style={{ justifyContent: "space-between" }}>
              <Body muted>{t("student.driver")}</Body>
              <Body>{r.driver_name ?? r.vehicle?.driver_name}</Body>
            </Row>
          ) : null}
          {stops.length > 0 ? (
            <View style={{ marginTop: 4 }}>
              <Body style={{ fontFamily: "Inter_600SemiBold", marginBottom: 4 }}>
                {t("student.stops")}
              </Body>
              {stops.map((s: any, i: number) => (
                <Row
                  key={s.id ?? i}
                  style={{
                    paddingVertical: 6,
                    borderTopWidth: 1,
                    borderTopColor: colors.border,
                    justifyContent: "space-between",
                  }}
                >
                  <Body>{s.name ?? s.stop_name ?? `#${i + 1}`}</Body>
                  <Body muted style={{ fontSize: 12 }}>
                    {(s.pickup_time ?? s.time ?? "").slice(0, 5)}
                  </Body>
                </Row>
              ))}
            </View>
          ) : null}
        </View>
      )}
    </Card>
  );
}
