import { Feather } from "@expo/vector-icons";
import { Tabs, router } from "expo-router";
import React, { useEffect } from "react";
import { Platform, Pressable } from "react-native";

import { useColors } from "@/hooks/useColors";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

export default function StudentTabsLayout() {
  const colors = useColors();
  const { t } = useI18n();
  const { user, loading } = useAuth();
  const isWeb = Platform.OS === "web";

  useEffect(() => {
    if (!loading && (!user || user.role !== "student")) {
      router.replace("/login");
    }
  }, [user, loading]);

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.mutedForeground,
        tabBarStyle: {
          backgroundColor: colors.background,
          borderTopColor: colors.border,
          ...(isWeb ? { height: 84 } : {}),
        },
        headerStyle: { backgroundColor: colors.background },
        headerTitleStyle: {
          fontFamily: "Inter_600SemiBold",
          color: colors.foreground,
        },
        headerRight: () => (
          <Pressable
            onPress={() => router.push("/messaging")}
            style={({ pressed }) => ({
              padding: 8,
              marginRight: 8,
              opacity: pressed ? 0.5 : 1,
            })}
            accessibilityLabel="Messages"
          >
            <Feather name="message-circle" size={20} color={colors.foreground} />
          </Pressable>
        ),
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: t("tabs.home"),
          tabBarIcon: ({ color }) => <Feather name="home" size={22} color={color} />,
        }}
      />
      <Tabs.Screen
        name="assignments"
        options={{
          title: t("tabs.homework"),
          tabBarIcon: ({ color }) => <Feather name="book" size={22} color={color} />,
        }}
      />
      <Tabs.Screen
        name="grades"
        options={{
          title: t("tabs.grades"),
          tabBarIcon: ({ color }) => (
            <Feather name="bar-chart-2" size={22} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="attendance"
        options={{
          title: t("tabs.attendance"),
          tabBarIcon: ({ color }) => (
            <Feather name="calendar" size={22} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="more"
        options={{
          title: t("tabs.more"),
          tabBarIcon: ({ color }) => (
            <Feather name="more-horizontal" size={22} color={color} />
          ),
        }}
      />
    </Tabs>
  );
}
