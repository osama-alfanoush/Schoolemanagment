import { Feather } from "@expo/vector-icons";
import React from "react";
import {
  ActivityIndicator,
  Platform,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  TextInputProps,
  TextProps,
  View,
  ViewProps,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";

import { useColors } from "@/hooks/useColors";
import { useI18n } from "@/lib/i18n";

export function Screen({
  children,
  style,
  scroll = false,
  refreshControl,
  ...rest
}: ViewProps & {
  scroll?: boolean;
  refreshControl?: React.ReactElement;
}) {
  const colors = useColors();
  const insets = useSafeAreaInsets();
  const isWeb = Platform.OS === "web";
  const containerStyle = [
    {
      flex: 1,
      backgroundColor: colors.background,
      paddingBottom: isWeb ? 84 : insets.bottom + 70,
    },
    style,
  ];

  if (scroll) {
    const { ScrollView } = require("react-native");
    return (
      <ScrollView
        style={{ flex: 1, backgroundColor: colors.background }}
        contentContainerStyle={[{ padding: 16, paddingBottom: isWeb ? 100 : insets.bottom + 80 }]}
        refreshControl={refreshControl}
      >
        {children}
      </ScrollView>
    );
  }
  return (
    <View style={containerStyle} {...rest}>
      {children}
    </View>
  );
}

export function H1({ style, ...p }: TextProps) {
  const colors = useColors();
  const { isRTL } = useI18n();
  return (
    <Text
      {...p}
      style={[
        {
          fontFamily: "Inter_700Bold",
          fontSize: 24,
          color: colors.foreground,
          writingDirection: isRTL ? "rtl" : "ltr",
          textAlign: isRTL ? "right" : "left",
        },
        style,
      ]}
    />
  );
}

export function H2({ style, ...p }: TextProps) {
  const colors = useColors();
  const { isRTL } = useI18n();
  return (
    <Text
      {...p}
      style={[
        {
          fontFamily: "Inter_600SemiBold",
          fontSize: 18,
          color: colors.foreground,
          writingDirection: isRTL ? "rtl" : "ltr",
          textAlign: isRTL ? "right" : "left",
        },
        style,
      ]}
    />
  );
}

export function Body({ style, muted, ...p }: TextProps & { muted?: boolean }) {
  const colors = useColors();
  const { isRTL } = useI18n();
  return (
    <Text
      {...p}
      style={[
        {
          fontFamily: "Inter_400Regular",
          fontSize: 14,
          color: muted ? colors.mutedForeground : colors.foreground,
          writingDirection: isRTL ? "rtl" : "ltr",
          textAlign: isRTL ? "right" : "left",
        },
        style,
      ]}
    />
  );
}

export function Card({ style, children, ...p }: ViewProps) {
  const colors = useColors();
  return (
    <View
      {...p}
      style={[
        {
          backgroundColor: colors.card,
          borderRadius: 14,
          padding: 16,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: colors.border,
          marginBottom: 12,
        },
        style,
      ]}
    >
      {children}
    </View>
  );
}

export function Btn({
  title,
  onPress,
  variant = "primary",
  loading,
  disabled,
  icon,
  style,
}: {
  title: string;
  onPress?: () => void;
  variant?: "primary" | "secondary" | "ghost" | "destructive";
  loading?: boolean;
  disabled?: boolean;
  icon?: keyof typeof Feather.glyphMap;
  style?: any;
}) {
  const colors = useColors();
  const bg =
    variant === "primary"
      ? colors.primary
      : variant === "secondary"
        ? colors.secondary
        : variant === "destructive"
          ? colors.destructive
          : "transparent";
  const fg =
    variant === "primary"
      ? colors.primaryForeground
      : variant === "destructive"
        ? colors.destructiveForeground
        : variant === "secondary"
          ? colors.secondaryForeground
          : colors.foreground;
  const isDisabled = disabled || loading;
  return (
    <Pressable
      onPress={onPress}
      disabled={isDisabled}
      style={({ pressed }) => [
        {
          backgroundColor: bg,
          borderRadius: 12,
          paddingHorizontal: 18,
          paddingVertical: 14,
          alignItems: "center",
          justifyContent: "center",
          flexDirection: "row",
          gap: 8,
          opacity: isDisabled ? 0.5 : pressed ? 0.85 : 1,
          borderWidth: variant === "ghost" ? 1 : 0,
          borderColor: colors.border,
        },
        style,
      ]}
    >
      {loading ? (
        <ActivityIndicator color={fg} />
      ) : (
        <>
          {icon ? <Feather name={icon} size={16} color={fg} /> : null}
          <Text
            style={{
              color: fg,
              fontFamily: "Inter_600SemiBold",
              fontSize: 15,
            }}
          >
            {title}
          </Text>
        </>
      )}
    </Pressable>
  );
}

export function Input(props: TextInputProps) {
  const colors = useColors();
  const { isRTL } = useI18n();
  return (
    <TextInput
      placeholderTextColor={colors.mutedForeground}
      {...props}
      style={[
        {
          backgroundColor: colors.background,
          borderColor: colors.input,
          borderWidth: 1,
          borderRadius: 12,
          paddingHorizontal: 14,
          paddingVertical: 12,
          fontSize: 15,
          color: colors.foreground,
          fontFamily: "Inter_400Regular",
          textAlign: isRTL ? "right" : "left",
          writingDirection: isRTL ? "rtl" : "ltr",
        },
        props.style as any,
      ]}
    />
  );
}

export function Pill({
  label,
  tone = "neutral",
}: {
  label: string;
  tone?: "neutral" | "success" | "warning" | "danger" | "info";
}) {
  const colors = useColors();
  const palette = {
    neutral: { bg: colors.muted, fg: colors.mutedForeground },
    success: { bg: "#dcfce7", fg: "#166534" },
    warning: { bg: "#fef3c7", fg: "#92400e" },
    danger: { bg: "#fee2e2", fg: "#991b1b" },
    info: { bg: "#dbeafe", fg: "#1e40af" },
  }[tone];
  return (
    <View
      style={{
        backgroundColor: palette.bg,
        paddingHorizontal: 10,
        paddingVertical: 4,
        borderRadius: 999,
        alignSelf: "flex-start",
      }}
    >
      <Text
        style={{
          color: palette.fg,
          fontSize: 12,
          fontFamily: "Inter_600SemiBold",
        }}
      >
        {label}
      </Text>
    </View>
  );
}

export function LoadingView() {
  const colors = useColors();
  return (
    <View
      style={{
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        padding: 24,
        backgroundColor: colors.background,
      }}
    >
      <ActivityIndicator color={colors.primary} />
    </View>
  );
}

export function EmptyState({
  icon = "inbox",
  title,
  hint,
}: {
  icon?: keyof typeof Feather.glyphMap;
  title: string;
  hint?: string;
}) {
  const colors = useColors();
  return (
    <View
      style={{
        alignItems: "center",
        justifyContent: "center",
        padding: 32,
        gap: 8,
      }}
    >
      <Feather name={icon} size={36} color={colors.mutedForeground} />
      <Text
        style={{
          color: colors.foreground,
          fontFamily: "Inter_600SemiBold",
          fontSize: 16,
          textAlign: "center",
        }}
      >
        {title}
      </Text>
      {hint ? (
        <Text
          style={{
            color: colors.mutedForeground,
            fontFamily: "Inter_400Regular",
            fontSize: 13,
            textAlign: "center",
          }}
        >
          {hint}
        </Text>
      ) : null}
    </View>
  );
}

export function ErrorView({
  message,
  onRetry,
}: {
  message?: string;
  onRetry?: () => void;
}) {
  const { t } = useI18n();
  return (
    <View
      style={{
        alignItems: "center",
        justifyContent: "center",
        padding: 32,
        gap: 12,
      }}
    >
      <Feather name="alert-triangle" size={36} color="#b45309" />
      <Body muted style={{ textAlign: "center" }}>
        {message ?? t("common.error")}
      </Body>
      {onRetry ? <Btn title={t("common.retry")} onPress={onRetry} variant="secondary" /> : null}
    </View>
  );
}

export function Row({
  children,
  style,
  ...p
}: ViewProps) {
  const { isRTL } = useI18n();
  return (
    <View
      {...p}
      style={[
        {
          flexDirection: isRTL ? "row-reverse" : "row",
          alignItems: "center",
          gap: 12,
        },
        style,
      ]}
    >
      {children}
    </View>
  );
}

export function OfflineBadge({ visible }: { visible: boolean }) {
  const { t } = useI18n();
  if (!visible) return null;
  return (
    <View
      style={{
        backgroundColor: "#fef3c7",
        padding: 10,
        borderRadius: 10,
        marginBottom: 12,
        flexDirection: "row",
        alignItems: "center",
        gap: 8,
      }}
    >
      <Feather name="wifi-off" size={14} color="#92400e" />
      <Text
        style={{
          color: "#92400e",
          fontSize: 12,
          fontFamily: "Inter_500Medium",
        }}
      >
        {t("common.offline")}
      </Text>
    </View>
  );
}
