import { Feather } from "@expo/vector-icons";
import { router, useLocalSearchParams } from "expo-router";
import React, { useState } from "react";
import {
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  View,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";

import {
  Body,
  Btn,
  Card,
  H1,
  H2,
  Input,
  Pill,
  Row,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";
import { registerPushToken } from "@/lib/notifications";

const DEMO_ACCOUNTS = [
  { role: "student", email: "ali1@school.test" },
  { role: "parent", email: "parent1@school.test" },
];

export default function LoginScreen() {
  const colors = useColors();
  const insets = useSafeAreaInsets();
  const { login } = useAuth();
  const { t, locale, setLocale } = useI18n();
  const params = useLocalSearchParams<{ reason?: string }>();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(
    params.reason === "web-only"
      ? "This account uses the web portal. Sign in there with admin/teacher/finance/HR roles."
      : null,
  );

  const onSubmit = async () => {
    if (!email || !password) return;
    setLoading(true);
    setError(null);
    try {
      const user = await login(email.trim(), password);
      registerPushToken();
      if (user.role === "student") router.replace("/(student)");
      else if (user.role === "parent") router.replace("/(parent)");
      else
        setError(
          "This account uses the web portal. Sign in there with admin/teacher/finance/HR roles.",
        );
    } catch (e: any) {
      const status = e?.status;
      if (status === 401 || status === 422) setError(t("common.invalidLogin"));
      else if (status === undefined) setError(t("common.backendUnreachable"));
      else setError(e?.message ?? t("common.error"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === "ios" ? "padding" : undefined}
      style={{ flex: 1, backgroundColor: colors.background }}
    >
      <ScrollView
        contentContainerStyle={{
          padding: 24,
          paddingTop: insets.top + (Platform.OS === "web" ? 67 : 24),
          paddingBottom: insets.bottom + 24,
          gap: 24,
        }}
        keyboardShouldPersistTaps="handled"
      >
        <Row style={{ justifyContent: "space-between" }}>
          <View
            style={{
              width: 48,
              height: 48,
              borderRadius: 14,
              backgroundColor: colors.primary,
              alignItems: "center",
              justifyContent: "center",
            }}
          >
            <Feather name="book-open" size={22} color={colors.primaryForeground} />
          </View>
          <Pressable
            onPress={() => setLocale(locale === "en" ? "ar" : "en")}
            style={{
              flexDirection: "row",
              alignItems: "center",
              gap: 6,
              paddingHorizontal: 12,
              paddingVertical: 8,
              borderRadius: 999,
              backgroundColor: colors.muted,
            }}
            accessibilityLabel="Toggle language"
          >
            <Feather name="globe" size={14} color={colors.mutedForeground} />
            <Body style={{ fontFamily: "Inter_600SemiBold" }}>
              {locale === "en" ? "العربية" : "English"}
            </Body>
          </Pressable>
        </Row>

        <View style={{ gap: 6 }}>
          <H1>{t("common.app")}</H1>
          <Body muted>{t("common.enterCredentials")}</Body>
        </View>

        <View style={{ gap: 14 }}>
          <View style={{ gap: 6 }}>
            <Body muted>{t("common.email")}</Body>
            <Input
              value={email}
              onChangeText={setEmail}
              autoCapitalize="none"
              keyboardType="email-address"
              autoComplete="email"
              placeholder="parent1@school.test"
              testID="login-email"
            />
          </View>
          <View style={{ gap: 6 }}>
            <Body muted>{t("common.password")}</Body>
            <Input
              value={password}
              onChangeText={setPassword}
              secureTextEntry
              placeholder="••••••••"
              testID="login-password"
            />
          </View>
          {error ? (
            <View
              style={{
                backgroundColor: "#fee2e2",
                padding: 12,
                borderRadius: 10,
              }}
            >
              <Body style={{ color: "#991b1b" }}>{error}</Body>
            </View>
          ) : null}
          <Btn
            title={t("common.signIn")}
            onPress={onSubmit}
            loading={loading}
            disabled={!email || !password}
            icon="log-in"
          />
        </View>

        <Card>
          <H2>{t("common.noAccount")}</H2>
          <View style={{ height: 8 }} />
          {DEMO_ACCOUNTS.map((acct) => (
            <Pressable
              key={acct.email}
              onPress={() => {
                setEmail(acct.email);
                setPassword("password");
              }}
              style={({ pressed }) => ({
                paddingVertical: 10,
                opacity: pressed ? 0.6 : 1,
              })}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <View style={{ gap: 2 }}>
                  <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                    {acct.email}
                  </Body>
                  <Body muted style={{ fontSize: 12 }}>
                    password
                  </Body>
                </View>
                <Pill label={acct.role} tone="info" />
              </Row>
            </Pressable>
          ))}
        </Card>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({});
