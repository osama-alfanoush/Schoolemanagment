import { Feather } from "@expo/vector-icons";
import * as ImagePicker from "expo-image-picker";
import { router } from "expo-router";
import React, { useState } from "react";
import { Alert, Pressable, ScrollView, View } from "react-native";

import {
  Avatar,
  Body,
  Btn,
  Card,
  H2,
  Input,
  Pill,
  Row,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Auth, getApiBaseUrl } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

function photoUrl(path?: string | null): string | null {
  if (!path) return null;
  if (/^https?:\/\//.test(path)) return path;
  return `${getApiBaseUrl().replace(/\/api$/, "")}/storage/${path}`;
}

export default function Profile() {
  const colors = useColors();
  const { t, locale, setLocale } = useI18n();
  const { user, logout, setUserLocal } = useAuth();
  const [cur, setCur] = useState("");
  const [next, setNext] = useState("");
  const [confirm, setConfirm] = useState("");
  const [busy, setBusy] = useState(false);
  const [uploading, setUploading] = useState(false);

  const pickPhoto = async () => {
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) return;
    const r = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [1, 1],
      quality: 0.8,
    });
    if (r.canceled || !r.assets?.[0]) return;
    const a = r.assets[0];
    setUploading(true);
    try {
      const res = await Auth.uploadProfilePhoto({
        uri: a.uri,
        name: a.fileName ?? `photo-${Date.now()}.jpg`,
        type: a.mimeType ?? "image/jpeg",
      });
      if (res?.user) await setUserLocal(res.user);
    } catch (e: any) {
      Alert.alert(t("common.error"), e?.message ?? "Failed");
    } finally {
      setUploading(false);
    }
  };

  const change = async () => {
    if (!cur || !next || next !== confirm) {
      Alert.alert(t("common.error"), "Passwords do not match");
      return;
    }
    setBusy(true);
    try {
      await Auth.changePassword({
        current_password: cur,
        new_password: next,
        new_password_confirmation: confirm,
      });
      Alert.alert(t("common.save"), "Password updated");
      setCur("");
      setNext("");
      setConfirm("");
    } catch (e: any) {
      Alert.alert(t("common.error"), e?.message ?? "Failed");
    } finally {
      setBusy(false);
    }
  };

  const onLogout = async () => {
    await logout();
    router.replace("/login");
  };

  return (
    <ScrollView
      style={{ flex: 1, backgroundColor: colors.background }}
      contentContainerStyle={{ padding: 16, gap: 12 }}
    >
      <Card>
        <Row>
          <Pressable
            onPress={pickPhoto}
            disabled={uploading}
            accessibilityLabel="Change profile photo"
            style={({ pressed }) => ({ opacity: pressed || uploading ? 0.6 : 1 })}
          >
            <Avatar name={user?.name} uri={photoUrl(user?.photo_path)} size={56} />
            <View
              style={{
                position: "absolute",
                bottom: -2,
                right: -2,
                backgroundColor: colors.primary,
                borderRadius: 10,
                padding: 4,
              }}
            >
              <Feather name="camera" size={10} color={colors.primaryForeground} />
            </View>
          </Pressable>
          <View style={{ flex: 1, gap: 4 }}>
            <Body style={{ fontFamily: "Inter_700Bold", fontSize: 18 }}>
              {user?.name}
            </Body>
            <Body muted>{user?.email}</Body>
            {user?.role ? <Pill label={user.role} tone="info" /> : null}
          </View>
        </Row>
      </Card>

      <Card>
        <H2>{t("common.language")}</H2>
        <View style={{ height: 8 }} />
        <Row>
          {(["en", "ar"] as const).map((l) => (
            <Pressable
              key={l}
              onPress={() => setLocale(l)}
              style={({ pressed }) => ({
                flex: 1,
                paddingVertical: 12,
                borderRadius: 10,
                backgroundColor:
                  locale === l ? colors.primary : colors.secondary,
                alignItems: "center",
                opacity: pressed ? 0.7 : 1,
              })}
            >
              <Body
                style={{
                  color:
                    locale === l ? colors.primaryForeground : colors.foreground,
                  fontFamily: "Inter_600SemiBold",
                }}
              >
                {l === "en" ? t("common.english") : t("common.arabic")}
              </Body>
            </Pressable>
          ))}
        </Row>
      </Card>

      <Card>
        <H2>{t("common.changePassword")}</H2>
        <View style={{ height: 12, gap: 10 }} />
        <View style={{ gap: 10 }}>
          <Input
            value={cur}
            onChangeText={setCur}
            secureTextEntry
            placeholder="Current password"
          />
          <Input
            value={next}
            onChangeText={setNext}
            secureTextEntry
            placeholder="New password"
          />
          <Input
            value={confirm}
            onChangeText={setConfirm}
            secureTextEntry
            placeholder="Confirm new password"
          />
          <Btn
            title={t("common.save")}
            onPress={change}
            loading={busy}
            disabled={!cur || !next || next !== confirm}
          />
        </View>
      </Card>

      <Btn
        title={t("common.signOut")}
        icon="log-out"
        variant="destructive"
        onPress={onLogout}
      />
    </ScrollView>
  );
}
