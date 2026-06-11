import { Feather } from "@expo/vector-icons";
import React from "react";
import { Modal, Pressable, ScrollView, View } from "react-native";

import { Body, H2, Row } from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { useI18n } from "@/lib/i18n";
import { useChild } from "@/lib/parentChild";

export function ChildSwitcher() {
  const colors = useColors();
  const { t } = useI18n();
  const { children, selected, setSelectedId } = useChild();
  const [open, setOpen] = React.useState(false);

  if (children.length === 0) return null;

  return (
    <>
      <Pressable
        onPress={() => children.length > 1 && setOpen(true)}
        style={({ pressed }) => ({
          flexDirection: "row",
          alignItems: "center",
          gap: 10,
          padding: 12,
          backgroundColor: colors.secondary,
          borderRadius: 12,
          marginBottom: 16,
          opacity: pressed ? 0.7 : 1,
        })}
      >
        <View
          style={{
            width: 40,
            height: 40,
            borderRadius: 20,
            backgroundColor: colors.primary,
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <Body
            style={{
              color: colors.primaryForeground,
              fontFamily: "Inter_700Bold",
            }}
          >
            {(selected?.name ?? "?").charAt(0).toUpperCase()}
          </Body>
        </View>
        <View style={{ flex: 1 }}>
          <Body muted style={{ fontSize: 11 }}>
            {t("common.selectChild")}
          </Body>
          <Body style={{ fontFamily: "Inter_600SemiBold" }}>
            {selected?.name ?? "—"}
          </Body>
        </View>
        {children.length > 1 ? (
          <Feather name="chevron-down" size={18} color={colors.foreground} />
        ) : null}
      </Pressable>

      <Modal
        visible={open}
        transparent
        animationType="fade"
        onRequestClose={() => setOpen(false)}
      >
        <Pressable
          onPress={() => setOpen(false)}
          style={{
            flex: 1,
            backgroundColor: "rgba(0,0,0,0.4)",
            justifyContent: "center",
            padding: 24,
          }}
        >
          <Pressable
            onPress={() => {}}
            style={{
              backgroundColor: colors.background,
              borderRadius: 16,
              padding: 16,
            }}
          >
            <H2>{t("common.selectChild")}</H2>
            <View style={{ height: 12 }} />
            <ScrollView style={{ maxHeight: 360 }}>
              {children.map((c) => (
                <Pressable
                  key={c.id}
                  onPress={() => {
                    setSelectedId(c.id);
                    setOpen(false);
                  }}
                  style={({ pressed }) => ({
                    paddingVertical: 12,
                    paddingHorizontal: 8,
                    borderRadius: 10,
                    backgroundColor:
                      selected?.id === c.id ? colors.secondary : "transparent",
                    opacity: pressed ? 0.6 : 1,
                  })}
                >
                  <Row style={{ justifyContent: "space-between" }}>
                    <Body style={{ fontFamily: "Inter_500Medium" }}>{c.name}</Body>
                    {selected?.id === c.id ? (
                      <Feather name="check" size={16} color={colors.primary} />
                    ) : null}
                  </Row>
                </Pressable>
              ))}
            </ScrollView>
          </Pressable>
        </Pressable>
      </Modal>
    </>
  );
}
