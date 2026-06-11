import { Feather } from "@expo/vector-icons";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useLocalSearchParams } from "expo-router";
import React, { useState } from "react";
import { FlatList, Platform, Pressable, View } from "react-native";
import { KeyboardAvoidingView } from "react-native-keyboard-controller";
import { useSafeAreaInsets } from "react-native-safe-area-context";

import { Body, Input, LoadingView } from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Messaging, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

export default function Conversation() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const otherId = Number(id);
  const { user } = useAuth();
  const colors = useColors();
  const insets = useSafeAreaInsets();
  const { t } = useI18n();
  const qc = useQueryClient();
  const [text, setText] = useState("");

  const q = useQuery({
    queryKey: ["msg", "conv", otherId],
    queryFn: () => Messaging.conversation(otherId),
    enabled: !!otherId,
    refetchInterval: 5000,
  });

  const send = useMutation({
    mutationFn: (body: string) => Messaging.send(otherId, body),
    onSuccess: () => {
      setText("");
      qc.invalidateQueries({ queryKey: ["msg", "conv", otherId] });
      qc.invalidateQueries({ queryKey: ["msg", "threads"] });
    },
  });

  if (q.isLoading) return <LoadingView />;
  const messages = asArray(q.data).slice().sort((a: any, b: any) => {
    const da = new Date(a.created_at ?? 0).getTime();
    const db = new Date(b.created_at ?? 0).getTime();
    return db - da;
  });

  return (
    <KeyboardAvoidingView
      behavior="padding"
      style={{ flex: 1, backgroundColor: colors.background }}
      keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
    >
      <FlatList
        data={messages}
        inverted
        keyExtractor={(item, i) => String(item.id ?? i)}
        contentContainerStyle={{ padding: 16, gap: 8 }}
        keyboardDismissMode="interactive"
        keyboardShouldPersistTaps="handled"
        scrollEnabled={messages.length > 0}
        renderItem={({ item }) => {
          const mine = item.sender_user_id === user?.id || item.sender_id === user?.id;
          return (
            <View
              style={{
                alignSelf: mine ? "flex-end" : "flex-start",
                maxWidth: "80%",
                backgroundColor: mine ? colors.primary : colors.secondary,
                paddingHorizontal: 12,
                paddingVertical: 8,
                borderRadius: 14,
              }}
            >
              <Body
                style={{
                  color: mine ? colors.primaryForeground : colors.secondaryForeground,
                }}
              >
                {item.body}
              </Body>
            </View>
          );
        }}
      />
      <View
        style={{
          flexDirection: "row",
          gap: 8,
          padding: 12,
          paddingBottom: insets.bottom + 12,
          borderTopWidth: 1,
          borderTopColor: colors.border,
          backgroundColor: colors.background,
          alignItems: "flex-end",
        }}
      >
        <Input
          value={text}
          onChangeText={setText}
          placeholder={t("common.typeMessage")}
          style={{ flex: 1, maxHeight: 120 }}
          multiline
        />
        <Pressable
          onPress={() => text.trim() && send.mutate(text.trim())}
          disabled={!text.trim() || send.isPending}
          style={({ pressed }) => ({
            backgroundColor: colors.primary,
            width: 44,
            height: 44,
            borderRadius: 22,
            alignItems: "center",
            justifyContent: "center",
            opacity: !text.trim() || send.isPending ? 0.5 : pressed ? 0.7 : 1,
          })}
          accessibilityLabel={t("common.send")}
        >
          <Feather name="send" size={18} color={colors.primaryForeground} />
        </Pressable>
      </View>
    </KeyboardAvoidingView>
  );
}
