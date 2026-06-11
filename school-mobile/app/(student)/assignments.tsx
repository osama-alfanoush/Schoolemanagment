import { Feather } from "@expo/vector-icons";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import * as ImagePicker from "expo-image-picker";
import React, { useState } from "react";
import { Alert, Modal, Platform, Pressable, RefreshControl, View } from "react-native";

import {
  Body,
  Btn,
  Card,
  EmptyState,
  H1,
  H2,
  Input,
  LoadingView,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Student, asArray } from "@/lib/api";
import { useI18n } from "@/lib/i18n";

export default function StudentAssignments() {
  const { t } = useI18n();
  const colors = useColors();
  const qc = useQueryClient();
  const [refreshing, setRefreshing] = useState(false);
  const [openId, setOpenId] = useState<number | null>(null);
  const [text, setText] = useState("");
  const [file, setFile] = useState<{
    uri: string;
    name: string;
    type: string;
  } | null>(null);

  const list = useQuery({
    queryKey: ["student", "assignments"],
    queryFn: Student.assignments,
  });
  const submit = useMutation({
    mutationFn: () =>
      Student.submitAssignment(
        openId!,
        text || undefined,
        file
          ? ({
              uri: file.uri,
              name: file.name,
              type: file.type,
            } as any)
          : undefined,
      ),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["student", "assignments"] });
      qc.invalidateQueries({ queryKey: ["student", "dashboard"] });
      setOpenId(null);
      setText("");
      setFile(null);
      Alert.alert(t("student.submitted"));
    },
    onError: (e: any) =>
      Alert.alert(t("common.error"), e?.message ?? "Failed"),
  });

  const onPickFile = async () => {
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) return;
    const r = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.All,
      quality: 0.85,
    });
    if (r.canceled || !r.assets[0]) return;
    const a = r.assets[0];
    setFile({
      uri: a.uri,
      name: a.fileName ?? `upload-${Date.now()}.${(a.uri.split(".").pop() || "jpg")}`,
      type: a.mimeType ?? "image/jpeg",
    });
  };

  const onRefresh = async () => {
    setRefreshing(true);
    await list.refetch();
    setRefreshing(false);
  };

  if (list.isLoading) return <LoadingView />;
  const assignments = asArray(list.data);

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <H1 style={{ marginBottom: 16 }}>{t("tabs.homework")}</H1>
      {assignments.length === 0 ? (
        <EmptyState icon="book" title={t("common.empty")} />
      ) : (
        assignments.map((a: any) => {
          const submitted = a.submission ?? a.my_submission;
          const due = a.due_at ?? a.due_date;
          const isOverdue = due && new Date(due).getTime() < Date.now() && !submitted;
          return (
            <Card key={a.id}>
              <Row style={{ justifyContent: "space-between" }}>
                <View style={{ flex: 1, gap: 2 }}>
                  <Body style={{ fontFamily: "Inter_600SemiBold", fontSize: 16 }}>
                    {a.title}
                  </Body>
                  <Body muted style={{ fontSize: 12 }}>
                    {a.subject?.name ?? a.subject_name ?? "—"}
                  </Body>
                </View>
                {submitted ? (
                  <Pill label={t("student.submitted")} tone="success" />
                ) : isOverdue ? (
                  <Pill label={t("student.overdue")} tone="danger" />
                ) : (
                  <Pill label={t("student.pending")} tone="warning" />
                )}
              </Row>

              {a.instructions || a.description ? (
                <Body muted style={{ marginTop: 8, fontSize: 13 }}>
                  {a.instructions ?? a.description}
                </Body>
              ) : null}

              {due ? (
                <Row style={{ marginTop: 10 }}>
                  <Feather name="clock" size={12} color={colors.mutedForeground} />
                  <Body muted style={{ fontSize: 12 }}>
                    {t("student.due")}: {new Date(due).toLocaleString()}
                  </Body>
                </Row>
              ) : null}

              {!submitted ? (
                <View style={{ marginTop: 12 }}>
                  <Btn
                    title={t("student.submitWork")}
                    icon="upload"
                    onPress={() => setOpenId(a.id)}
                  />
                </View>
              ) : submitted.score != null ? (
                <Row style={{ marginTop: 12 }}>
                  <Feather name="award" size={14} color={colors.primary} />
                  <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                    {t("student.score")}: {submitted.score}
                    {a.max_score ? `/${a.max_score}` : ""}
                  </Body>
                </Row>
              ) : (
                <Row style={{ marginTop: 12 }}>
                  <Feather name="clock" size={14} color={colors.mutedForeground} />
                  <Body muted>{t("student.notGraded")}</Body>
                </Row>
              )}
            </Card>
          );
        })
      )}

      <Modal
        visible={openId != null}
        animationType="slide"
        onRequestClose={() => setOpenId(null)}
        presentationStyle={Platform.OS === "ios" ? "pageSheet" : undefined}
      >
        <View
          style={{
            flex: 1,
            backgroundColor: colors.background,
            padding: 24,
            paddingTop: Platform.OS === "ios" ? 24 : 48,
            gap: 16,
          }}
        >
          <Row style={{ justifyContent: "space-between" }}>
            <H2>{t("student.submitWork")}</H2>
            <Pressable onPress={() => setOpenId(null)} accessibilityLabel="Close">
              <Feather name="x" size={22} color={colors.foreground} />
            </Pressable>
          </Row>
          <Body muted>{t("student.yourAnswer")}</Body>
          <Input
            value={text}
            onChangeText={setText}
            placeholder=""
            multiline
            style={{ minHeight: 120, textAlignVertical: "top" }}
          />
          <Btn
            title={file ? file.name : t("student.pickFile")}
            icon="paperclip"
            variant="secondary"
            onPress={onPickFile}
          />
          <Btn
            title={t("common.submit")}
            icon="send"
            onPress={() => submit.mutate()}
            loading={submit.isPending}
            disabled={!text && !file}
          />
        </View>
      </Modal>
    </Screen>
  );
}
