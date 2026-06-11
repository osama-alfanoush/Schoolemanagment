import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React from "react";
import { Pressable, RefreshControl, ScrollView, View } from "react-native";

import {
  Body,
  EmptyState,
  H2,
  LoadingView,
  Row,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Messaging, asArray } from "@/lib/api";
import { useI18n } from "@/lib/i18n";

export default function MessagingScreen() {
  const { t } = useI18n();
  const colors = useColors();
  const [refreshing, setRefreshing] = React.useState(false);
  const q = useQuery({ queryKey: ["msg", "threads"], queryFn: Messaging.threads });

  if (q.isLoading) return <LoadingView />;
  const threads = asArray(q.data);

  const onRefresh = async () => {
    setRefreshing(true);
    await q.refetch();
    setRefreshing(false);
  };

  return (
    <ScrollView
      style={{ flex: 1, backgroundColor: colors.background }}
      contentContainerStyle={{ padding: 16 }}
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      {threads.length === 0 ? (
        <EmptyState icon="message-circle" title={t("common.empty")} />
      ) : (
        threads.map((thread: any) => {
          const other = thread.other_user ?? thread.other ?? thread.user ?? {};
          const last = thread.last_message ?? {};
          const unread = thread.unread_count ?? 0;
          return (
            <Pressable
              key={other.id ?? thread.id}
              onPress={() => router.push(`/conversation/${other.id}`)}
              style={({ pressed }) => ({
                paddingVertical: 14,
                borderBottomWidth: 1,
                borderBottomColor: colors.border,
                opacity: pressed ? 0.6 : 1,
              })}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <View
                  style={{
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                    backgroundColor: colors.secondary,
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <Body
                    style={{
                      fontFamily: "Inter_700Bold",
                      color: colors.secondaryForeground,
                    }}
                  >
                    {(other.name ?? "?").charAt(0).toUpperCase()}
                  </Body>
                </View>
                <View style={{ flex: 1 }}>
                  <H2 style={{ fontSize: 15 }}>{other.name ?? "—"}</H2>
                  <Body muted style={{ fontSize: 13 }} numberOfLines={1}>
                    {last.body ?? ""}
                  </Body>
                </View>
                {unread > 0 ? (
                  <View
                    style={{
                      backgroundColor: colors.primary,
                      borderRadius: 12,
                      paddingHorizontal: 8,
                      paddingVertical: 2,
                      minWidth: 22,
                      alignItems: "center",
                    }}
                  >
                    <Body
                      style={{
                        color: colors.primaryForeground,
                        fontSize: 11,
                        fontFamily: "Inter_700Bold",
                      }}
                    >
                      {unread}
                    </Body>
                  </View>
                ) : (
                  <Feather name="chevron-right" size={18} color={colors.mutedForeground} />
                )}
              </Row>
            </Pressable>
          );
        })
      )}
    </ScrollView>
  );
}
