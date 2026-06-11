import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React from "react";
import { Pressable, View } from "react-native";

import { ChildSwitcher } from "@/components/ChildSwitcher";
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
import { Parent, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

import { useChild } from "@/lib/parentChild";

export default function ParentMore() {
  const { t } = useI18n();
  const colors = useColors();
  const { user } = useAuth();
  const { selected } = useChild();

  const conduct = useQuery({
    queryKey: ["parent", "conduct", selected?.id],
    queryFn: () => Parent.childConduct(selected!.id),
    enabled: !!selected,
  });
  const ann = useQuery({
    queryKey: ["parent", "announcements"],
    queryFn: Parent.announcements,
  });

  const conductItems = asArray(conduct.data);
  const announcements = asArray(ann.data);

  return (
    <Screen scroll>
      <H1 style={{ marginBottom: 12 }}>{t("tabs.more")}</H1>
      <ChildSwitcher />

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
        <H2>{t("parent.conduct")}</H2>
        <View style={{ height: 8 }} />
        {!selected ? (
          <EmptyState icon="users" title={t("common.selectChild")} />
        ) : conductItems.length === 0 ? (
          <EmptyState icon="check-circle" title={t("common.empty")} />
        ) : (
          conductItems.slice(0, 10).map((c: any) => (
            <View
              key={c.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                gap: 4,
              }}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                  {c.category ?? c.type ?? "Note"}
                </Body>
                <Body muted style={{ fontSize: 12 }}>
                  {c.created_at
                    ? new Date(c.created_at).toLocaleDateString()
                    : ""}
                </Body>
              </Row>
              <Body muted style={{ fontSize: 13 }}>
                {c.note ?? c.description ?? ""}
              </Body>
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
          announcements.slice(0, 10).map((a: any) => (
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
