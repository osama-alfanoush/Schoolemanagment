import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import { router } from "expo-router";
import React, { useState } from "react";
import { Pressable, Text, View } from "react-native";

import {
  Body,
  Btn,
  Card,
  EmptyState,
  H1,
  H2,
  Input,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Hr, Teacher, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

export default function TeacherMore() {
  const { t } = useI18n();
  const { user } = useAuth();
  const colors = useColors();

  return (
    <Screen scroll>
      <H1 style={{ marginBottom: 16 }}>{t("tabs.more")}</H1>

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
            accessibilityLabel={t("common.profile")}
          >
            <Feather name="settings" size={20} color={colors.foreground} />
          </Pressable>
        </Row>
      </Card>

      <AnnouncementsCard />
      <ConductCard />
      <HrRequestsCard />
    </Screen>
  );
}

// ---------------------------------------------------------------------------
// Announcements (view + create for one of my classes)
// ---------------------------------------------------------------------------

function AnnouncementsCard() {
  const { t } = useI18n();
  const colors = useColors();
  const [showForm, setShowForm] = useState(false);
  const [classId, setClassId] = useState<number | null>(null);
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const ann = useQuery({
    queryKey: ["teacher", "announcements"],
    queryFn: Teacher.announcements,
  });
  const classesQ = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes,
  });
  const classes = asArray(classesQ.data);
  const announcements = asArray(ann.data);

  const post = async () => {
    if (!classId || !title || !body) return;
    setSaving(true);
    setError(null);
    setNotice(null);
    try {
      await Teacher.announce({ class_room_id: classId, title, body });
      setNotice(t("teacher.announcementPosted"));
      setTitle("");
      setBody("");
      setShowForm(false);
      await ann.refetch();
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Card>
      <Row style={{ justifyContent: "space-between" }}>
        <H2>{t("teacher.announcements")}</H2>
        <Pressable
          onPress={() => setShowForm((v) => !v)}
          accessibilityLabel={t("teacher.postAnnouncement")}
        >
          <Feather
            name={showForm ? "x" : "plus-circle"}
            size={20}
            color={colors.primary}
          />
        </Pressable>
      </Row>
      <View style={{ height: 8 }} />

      {showForm ? (
        <View style={{ gap: 10, marginBottom: 12 }}>
          <Body muted style={{ fontSize: 12 }}>
            {t("teacher.selectClass")}
          </Body>
          <Row style={{ gap: 8, flexWrap: "wrap" }}>
            {classes.map((c: any) => (
              <Pressable
                key={c.id}
                onPress={() => setClassId(c.id)}
                style={{
                  backgroundColor: classId === c.id ? colors.secondary : colors.muted,
                  paddingHorizontal: 12,
                  paddingVertical: 8,
                  borderRadius: 999,
                }}
                accessibilityLabel={`${t("teacher.selectClass")}: ${c.name}`}
              >
                <Text
                  style={{
                    color:
                      classId === c.id
                        ? colors.secondaryForeground
                        : colors.mutedForeground,
                    fontFamily: "Inter_600SemiBold",
                    fontSize: 12,
                  }}
                >
                  {c.name}
                </Text>
              </Pressable>
            ))}
          </Row>
          <Input value={title} onChangeText={setTitle} placeholder={t("teacher.title")} />
          <Input
            value={body}
            onChangeText={setBody}
            placeholder={t("teacher.instructions")}
            multiline
            style={{ minHeight: 70, textAlignVertical: "top" }}
          />
          {error ? <Body style={{ color: colors.destructive }}>{error}</Body> : null}
          <Btn
            title={t("teacher.postAnnouncement")}
            onPress={post}
            loading={saving}
            disabled={!classId || !title || !body}
            icon="send"
          />
        </View>
      ) : null}
      {notice ? (
        <Body style={{ color: "#166534", marginBottom: 8 }}>{notice}</Body>
      ) : null}

      {announcements.length === 0 ? (
        <EmptyState icon="info" title={t("common.empty")} />
      ) : (
        announcements.slice(0, 6).map((a: any) => (
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
  );
}

// ---------------------------------------------------------------------------
// Conduct log
// ---------------------------------------------------------------------------

const CONDUCT_CATEGORIES = ["positive", "warning", "incident"] as const;

function ConductCard() {
  const { t } = useI18n();
  const colors = useColors();
  const [classId, setClassId] = useState<number | null>(null);
  const [studentId, setStudentId] = useState<number | null>(null);
  const [category, setCategory] =
    useState<(typeof CONDUCT_CATEGORIES)[number]>("positive");
  const [title, setTitle] = useState("");
  const [note, setNote] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const classesQ = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes,
  });
  const studentsQ = useQuery({
    queryKey: ["teacher", "class", classId, "students"],
    queryFn: () => Teacher.classStudents(classId!),
    enabled: classId != null,
  });
  const classes = asArray(classesQ.data);
  const students = asArray(studentsQ.data);

  const submit = async () => {
    if (!studentId || !title || !note) return;
    setSaving(true);
    setError(null);
    setNotice(null);
    try {
      await Teacher.logConduct({
        student_user_id: studentId,
        category,
        title,
        note,
      });
      setNotice(t("teacher.conductLogged"));
      setTitle("");
      setNote("");
      setStudentId(null);
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setSaving(false);
    }
  };

  const chip = (
    active: boolean,
    label: string,
    onPress: () => void,
    key?: string | number,
  ) => (
    <Pressable
      key={key ?? label}
      onPress={onPress}
      style={{
        backgroundColor: active ? colors.secondary : colors.muted,
        paddingHorizontal: 12,
        paddingVertical: 8,
        borderRadius: 999,
      }}
      accessibilityLabel={label}
    >
      <Text
        style={{
          color: active ? colors.secondaryForeground : colors.mutedForeground,
          fontFamily: "Inter_600SemiBold",
          fontSize: 12,
        }}
      >
        {label}
      </Text>
    </Pressable>
  );

  return (
    <Card>
      <H2>{t("teacher.logConduct")}</H2>
      <View style={{ height: 10, gap: 0 }} />
      <View style={{ gap: 10 }}>
        <Body muted style={{ fontSize: 12 }}>
          {t("teacher.selectClass")}
        </Body>
        <Row style={{ gap: 8, flexWrap: "wrap" }}>
          {classes.map((c: any) =>
            chip(
              classId === c.id,
              c.name,
              () => {
                setClassId(c.id);
                setStudentId(null);
              },
              c.id,
            ),
          )}
        </Row>
        {classId != null ? (
          <>
            <Body muted style={{ fontSize: 12 }}>
              {t("teacher.selectStudent")}
            </Body>
            <Row style={{ gap: 8, flexWrap: "wrap" }}>
              {students.map((s: any) =>
                chip(studentId === s.id, s.name, () => setStudentId(s.id), s.id),
              )}
            </Row>
          </>
        ) : null}
        <Row style={{ gap: 8 }}>
          {CONDUCT_CATEGORIES.map((c) =>
            chip(category === c, t(`teacher.${c}`), () => setCategory(c), c),
          )}
        </Row>
        <Input value={title} onChangeText={setTitle} placeholder={t("teacher.title")} />
        <Input
          value={note}
          onChangeText={setNote}
          placeholder={t("teacher.reason")}
          multiline
          style={{ minHeight: 60, textAlignVertical: "top" }}
        />
        {error ? <Body style={{ color: colors.destructive }}>{error}</Body> : null}
        {notice ? <Body style={{ color: "#166534" }}>{notice}</Body> : null}
        <Btn
          title={t("teacher.logConduct")}
          onPress={submit}
          loading={saving}
          disabled={!studentId || !title || !note}
          icon="flag"
        />
      </View>
    </Card>
  );
}

// ---------------------------------------------------------------------------
// HR / leave requests
// ---------------------------------------------------------------------------

const HR_TYPES = [
  "leave_sick",
  "leave_annual",
  "leave_emergency",
  "salary_advance",
  "general",
] as const;

function HrRequestsCard() {
  const { t } = useI18n();
  const colors = useColors();
  const [showForm, setShowForm] = useState(false);
  const [type, setType] = useState<(typeof HR_TYPES)[number]>("leave_sick");
  const [subject, setSubject] = useState("");
  const [reason, setReason] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const reqs = useQuery({ queryKey: ["hr", "my-requests"], queryFn: Hr.myRequests });
  const requests = asArray(reqs.data);

  const submit = async () => {
    if (!subject || !reason) return;
    setSaving(true);
    setError(null);
    setNotice(null);
    try {
      await Hr.submitRequest({ type, subject, reason });
      setNotice(t("teacher.requestSubmitted"));
      setSubject("");
      setReason("");
      setShowForm(false);
      await reqs.refetch();
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setSaving(false);
    }
  };

  const statusTone = (s: string) =>
    s === "approved" ? "success" : s === "rejected" ? "danger" : "warning";

  return (
    <Card>
      <Row style={{ justifyContent: "space-between" }}>
        <H2>{t("teacher.leaveRequests")}</H2>
        <Pressable
          onPress={() => setShowForm((v) => !v)}
          accessibilityLabel={t("teacher.newRequest")}
        >
          <Feather
            name={showForm ? "x" : "plus-circle"}
            size={20}
            color={colors.primary}
          />
        </Pressable>
      </Row>
      <View style={{ height: 8 }} />

      {showForm ? (
        <View style={{ gap: 10, marginBottom: 12 }}>
          <Body muted style={{ fontSize: 12 }}>
            {t("teacher.requestType")}
          </Body>
          <Row style={{ gap: 8, flexWrap: "wrap" }}>
            {HR_TYPES.map((ty) => (
              <Pressable
                key={ty}
                onPress={() => setType(ty)}
                style={{
                  backgroundColor: type === ty ? colors.secondary : colors.muted,
                  paddingHorizontal: 12,
                  paddingVertical: 8,
                  borderRadius: 999,
                }}
                accessibilityLabel={ty}
              >
                <Text
                  style={{
                    color:
                      type === ty
                        ? colors.secondaryForeground
                        : colors.mutedForeground,
                    fontFamily: "Inter_600SemiBold",
                    fontSize: 12,
                  }}
                >
                  {ty.replace(/_/g, " ")}
                </Text>
              </Pressable>
            ))}
          </Row>
          <Input
            value={subject}
            onChangeText={setSubject}
            placeholder={t("teacher.title")}
          />
          <Input
            value={reason}
            onChangeText={setReason}
            placeholder={t("teacher.reason")}
            multiline
            style={{ minHeight: 60, textAlignVertical: "top" }}
          />
          {error ? <Body style={{ color: colors.destructive }}>{error}</Body> : null}
          <Btn
            title={t("common.submit")}
            onPress={submit}
            loading={saving}
            disabled={!subject || !reason}
            icon="send"
          />
        </View>
      ) : null}
      {notice ? (
        <Body style={{ color: "#166534", marginBottom: 8 }}>{notice}</Body>
      ) : null}

      {requests.length === 0 ? (
        <EmptyState icon="briefcase" title={t("common.empty")} />
      ) : (
        requests.slice(0, 6).map((r: any) => (
          <Row
            key={r.id}
            style={{
              paddingVertical: 10,
              borderTopWidth: 1,
              borderTopColor: colors.border,
              justifyContent: "space-between",
            }}
          >
            <View style={{ flex: 1, gap: 2 }}>
              <Body style={{ fontFamily: "Inter_600SemiBold" }}>{r.subject}</Body>
              <Body muted style={{ fontSize: 12 }}>
                {String(r.type ?? "").replace(/_/g, " ")}
              </Body>
            </View>
            <Pill
              label={t(`status.${r.status}`) ?? r.status}
              tone={statusTone(r.status) as any}
            />
          </Row>
        ))
      )}
    </Card>
  );
}
