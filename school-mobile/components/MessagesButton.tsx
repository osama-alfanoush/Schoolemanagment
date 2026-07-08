import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React from "react";
import { Pressable, Text, View } from "react-native";

import { useColors } from "@/hooks/useColors";
import { Messaging } from "@/lib/api";

/** Header button opening the messaging screen, with an unread-count badge. */
export function MessagesButton() {
  const colors = useColors();
  const unread = useQuery({
    queryKey: ["notifications", "unread-count"],
    queryFn: Messaging.unreadCount,
    refetchInterval: 60_000,
    retry: false,
  });
  const count =
    (unread.data as any)?.total_unread ??
    ((unread.data?.messages ?? 0) + (unread.data?.notifications ?? 0));

  return (
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
      {count > 0 ? (
        <View
          style={{
            position: "absolute",
            top: 2,
            right: 2,
            backgroundColor: colors.destructive,
            borderRadius: 9,
            minWidth: 18,
            height: 18,
            alignItems: "center",
            justifyContent: "center",
            paddingHorizontal: 4,
          }}
        >
          <Text
            style={{
              color: colors.destructiveForeground,
              fontSize: 10,
              fontFamily: "Inter_700Bold",
            }}
          >
            {count > 99 ? "99+" : count}
          </Text>
        </View>
      ) : null}
    </Pressable>
  );
}
