import { Feather } from "@expo/vector-icons";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useQuery } from "@tanstack/react-query";
import * as ImagePicker from "expo-image-picker";
import { Stack, useLocalSearchParams } from "expo-router";
import React, { useEffect, useMemo, useState } from "react";
import { Pressable, RefreshControl, Text, View } from "react-native";

import {
  AttendanceGrid,
  AttendanceStatus,
} from "@/components/AttendanceGrid";
import { GradeEntry } from "@/components/GradeEntry";
import {
  Avatar,
  Body,
  Btn,
  Card,
  EmptyState,
  ErrorView,
  H2,
  Input,
  LoadingView,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Teacher, asArray } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { useI18n } from "@/lib/i18n";

type Section = "students" | "attendance" | "assignments" | "grades";

/**
 * The backend has no "list my assignments" endpoint, so assignments created
 * from this device are remembered locally per teacher to drive the
 * submissions-grading flow.
 */
const ASSIGNMENTS_KEY = (teacherId: number) => `sm_teacher_assignments_${teacherId}`;

interface LocalAssignment {
  id: number;
  title: string;
  subject_name?: string;
  class_room_id: number;
  due_at?: string;
}

function todayISO(): string {
  return new Date().toISOString().slice(0, 10);
}

export default function ClassDetail() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const classId = Number(id);
  const { t } = useI18n();
  const colors = useColors();
  const [section, setSection] = useState<Section>("students");
  const [refreshing, setRefreshing] = useState(false);

  const classesQ = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes,
  });
  const studentsQ = useQuery({
    queryKey: ["teacher", "class", classId, "students"],
    queryFn: () => Teacher.classStudents(classId),
    enabled: Number.isFinite(classId),
  });

  const cls = asArray(classesQ.data).find((c: any) => c.id === classId);
  const subjects = asArray(cls?.subjects);
  const students = asArray(studentsQ.data).map((u: any) => ({
    id: u.id,
    name: u.name,
    photo_path: u.photo_path,
    admission_no: u.student_profile?.admission_no,
  }));

  const onRefresh = async () => {
    setRefreshing(true);
    await Promise.all([classesQ.refetch(), studentsQ.refetch()]);
    setRefreshing(false);
  };

  if (studentsQ.isLoading || classesQ.isLoading) return <LoadingView />;
  if (studentsQ.isError)
    return <ErrorView onRetry={() => studentsQ.refetch()} />;

  const sections: { key: Section; label: string; icon: keyof typeof Feather.glyphMap }[] = [
    { key: "students", label: t("teacher.students"), icon: "users" },
    { key: "attendance", label: t("tabs.attendance"), icon: "check-square" },
    { key: "assignments", label: t("teacher.assignments"), icon: "book" },
    { key: "grades", label: t("tabs.grades"), icon: "edit-3" },
  ];

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <Stack.Screen options={{ title: cls?.name ?? t("teacher.classStudents") }} />

      <Row style={{ gap: 8, marginBottom: 16, flexWrap: "wrap" }}>
        {sections.map((s) => {
          const active = section === s.key;
          return (
            <Pressable
              key={s.key}
              onPress={() => setSection(s.key)}
              accessibilityLabel={s.label}
              style={({ pressed }) => ({
                flexDirection: "row",
                alignItems: "center",
                gap: 6,
                backgroundColor: active ? colors.primary : colors.muted,
                paddingHorizontal: 14,
                paddingVertical: 10,
                borderRadius: 999,
                opacity: pressed ? 0.7 : 1,
              })}
            >
              <Feather
                name={s.icon}
                size={14}
                color={active ? colors.primaryForeground : colors.mutedForeground}
              />
              <Text
                style={{
                  color: active ? colors.primaryForeground : colors.mutedForeground,
                  fontFamily: "Inter_600SemiBold",
                  fontSize: 13,
                }}
              >
                {s.label}
              </Text>
            </Pressable>
          );
        })}
      </Row>

      {section === "students" ? <StudentsSection students={students} /> : null}
      {section === "attendance" ? (
        <AttendanceSection classId={classId} students={students} subjects={subjects} />
      ) : null}
      {section === "assignments" ? (
        <AssignmentsSection classId={classId} subjects={subjects} />
      ) : null}
      {section === "grades" ? (
        <GradesSection classId={classId} students={students} subjects={subjects} />
      ) : null}
    </Screen>
  );
}

// ---------------------------------------------------------------------------
// Students
// ---------------------------------------------------------------------------

function StudentsSection({ students }: { students: any[] }) {
  const { t } = useI18n();
  const colors = useColors();
  if (students.length === 0)
    return <EmptyState icon="users" title={t("common.empty")} />;
  return (
    <Card>
      <H2>{t("teacher.classStudents")}</H2>
      <View style={{ height: 8 }} />
      {students.map((s, i) => (
        <Row
          key={s.id}
          style={{
            paddingVertical: 10,
            borderTopWidth: i === 0 ? 0 : 1,
            borderTopColor: colors.border,
          }}
        >
          <Avatar name={s.name} uri={s.photo_path} size={38} />
          <View style={{ flex: 1, gap: 2 }}>
            <Body style={{ fontFamily: "Inter_600SemiBold" }}>{s.name}</Body>
            {s.admission_no ? (
              <Body muted style={{ fontSize: 12 }}>
                {s.admission_no}
              </Body>
            ) : null}
          </View>
        </Row>
      ))}
    </Card>
  );
}

// ---------------------------------------------------------------------------
// Attendance
// ---------------------------------------------------------------------------

function AttendanceSection({
  classId,
  students,
  subjects,
}: {
  classId: number;
  students: any[];
  subjects: any[];
}) {
  const { t } = useI18n();
  const colors = useColors();
  const [date, setDate] = useState(todayISO());
  const [subjectId, setSubjectId] = useState<number | null>(null);
  const [records, setRecords] = useState<Record<number, AttendanceStatus>>({});
  const [saving, setSaving] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Default everyone to present so the teacher only marks exceptions.
  useEffect(() => {
    setRecords((prev) => {
      const next = { ...prev };
      for (const s of students) if (!next[s.id]) next[s.id] = "present";
      return next;
    });
  }, [students]);

  const submit = async () => {
    setSaving(true);
    setError(null);
    setDone(false);
    try {
      await Teacher.markAttendance({
        class_room_id: classId,
        subject_id: subjectId ?? undefined,
        date,
        records: students.map((s) => ({
          student_user_id: s.id,
          status: records[s.id] ?? "present",
        })),
      });
      setDone(true);
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Card>
      <H2>{t("teacher.markAttendance")}</H2>
      <View style={{ height: 10 }} />
      <Body muted style={{ marginBottom: 4, fontSize: 12 }}>
        {t("teacher.date")} (YYYY-MM-DD)
      </Body>
      <Input value={date} onChangeText={setDate} placeholder="2026-01-31" />
      {subjects.length > 0 ? (
        <Row style={{ gap: 8, flexWrap: "wrap", marginTop: 10 }}>
          {subjects.map((s: any) => {
            const active = subjectId === s.id;
            return (
              <Pressable
                key={s.id}
                onPress={() => setSubjectId(active ? null : s.id)}
                style={{
                  backgroundColor: active ? colors.secondary : colors.muted,
                  paddingHorizontal: 12,
                  paddingVertical: 8,
                  borderRadius: 999,
                }}
                accessibilityLabel={`${t("teacher.selectSubject")}: ${s.name}`}
              >
                <Text
                  style={{
                    color: active
                      ? colors.secondaryForeground
                      : colors.mutedForeground,
                    fontFamily: "Inter_600SemiBold",
                    fontSize: 12,
                  }}
                >
                  {s.name}
                </Text>
              </Pressable>
            );
          })}
        </Row>
      ) : null}
      <View style={{ height: 8 }} />
      {students.length === 0 ? (
        <EmptyState icon="users" title={t("common.empty")} />
      ) : (
        <AttendanceGrid
          students={students}
          value={records}
          onChange={(id, status) => {
            setDone(false);
            setRecords((r) => ({ ...r, [id]: status }));
          }}
        />
      )}
      {error ? (
        <Body style={{ color: colors.destructive, marginBottom: 8 }}>{error}</Body>
      ) : null}
      {done ? (
        <Body style={{ color: "#166534", marginBottom: 8 }}>
          {t("teacher.attendanceSaved")}
        </Body>
      ) : null}
      <Btn
        title={t("teacher.saveAttendance")}
        onPress={submit}
        loading={saving}
        disabled={students.length === 0}
        icon="check"
      />
    </Card>
  );
}

// ---------------------------------------------------------------------------
// Assignments (create + grade submissions)
// ---------------------------------------------------------------------------

function AssignmentsSection({
  classId,
  subjects,
}: {
  classId: number;
  subjects: any[];
}) {
  const { t } = useI18n();
  const colors = useColors();
  const { user } = useAuth();

  const [title, setTitle] = useState("");
  const [instructions, setInstructions] = useState("");
  const [dueAt, setDueAt] = useState(todayISO());
  const [maxScore, setMaxScore] = useState("100");
  const [subjectId, setSubjectId] = useState<number | null>(
    subjects.length === 1 ? subjects[0].id : null,
  );
  const [file, setFile] = useState<{ uri: string; name: string; type: string } | null>(
    null,
  );
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const [local, setLocal] = useState<LocalAssignment[]>([]);
  const [openId, setOpenId] = useState<number | null>(null);

  const storageKey = user ? ASSIGNMENTS_KEY(user.id) : null;

  useEffect(() => {
    if (!storageKey) return;
    AsyncStorage.getItem(storageKey)
      .then((raw) => {
        if (raw) setLocal(JSON.parse(raw));
      })
      .catch(() => {});
  }, [storageKey]);

  const persist = async (list: LocalAssignment[]) => {
    setLocal(list);
    if (storageKey)
      await AsyncStorage.setItem(storageKey, JSON.stringify(list)).catch(() => {});
  };

  const pickFile = async () => {
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) return;
    const r = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.All,
      quality: 0.8,
    });
    if (r.canceled || !r.assets?.[0]) return;
    const a = r.assets[0];
    setFile({
      uri: a.uri,
      name: a.fileName ?? `upload-${Date.now()}.${a.uri.split(".").pop() || "jpg"}`,
      type: a.mimeType ?? "application/octet-stream",
    });
  };

  const create = async () => {
    if (!subjectId || !title || !instructions || !dueAt) return;
    setCreating(true);
    setError(null);
    setNotice(null);
    try {
      const created = await Teacher.createAssignment({
        class_room_ids: [classId],
        subject_id: subjectId,
        title,
        instructions,
        due_at: dueAt,
        max_score: maxScore ? Number(maxScore) : undefined,
        attachment: file ?? undefined,
      });
      const createdList = asArray(created);
      const first = createdList[0] ?? created;
      if (first?.id) {
        await persist([
          {
            id: first.id,
            title,
            subject_name: subjects.find((s: any) => s.id === subjectId)?.name,
            class_room_id: classId,
            due_at: dueAt,
          },
          ...local,
        ]);
      }
      setNotice(t("teacher.assignmentCreated"));
      setTitle("");
      setInstructions("");
      setFile(null);
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setCreating(false);
    }
  };

  const classAssignments = local.filter((a) => a.class_room_id === classId);

  return (
    <View>
      <Card>
        <H2>{t("teacher.createAssignment")}</H2>
        <View style={{ height: 10, gap: 0 }} />
        <Row style={{ gap: 8, flexWrap: "wrap", marginBottom: 10 }}>
          {subjects.map((s: any) => {
            const active = subjectId === s.id;
            return (
              <Pressable
                key={s.id}
                onPress={() => setSubjectId(s.id)}
                style={{
                  backgroundColor: active ? colors.secondary : colors.muted,
                  paddingHorizontal: 12,
                  paddingVertical: 8,
                  borderRadius: 999,
                }}
                accessibilityLabel={`${t("teacher.selectSubject")}: ${s.name}`}
              >
                <Text
                  style={{
                    color: active
                      ? colors.secondaryForeground
                      : colors.mutedForeground,
                    fontFamily: "Inter_600SemiBold",
                    fontSize: 12,
                  }}
                >
                  {s.name}
                </Text>
              </Pressable>
            );
          })}
        </Row>
        <View style={{ gap: 10 }}>
          <Input
            value={title}
            onChangeText={setTitle}
            placeholder={t("teacher.title")}
          />
          <Input
            value={instructions}
            onChangeText={setInstructions}
            placeholder={t("teacher.instructions")}
            multiline
            style={{ minHeight: 80, textAlignVertical: "top" }}
          />
          <Row style={{ gap: 10 }}>
            <View style={{ flex: 1, gap: 4 }}>
              <Body muted style={{ fontSize: 12 }}>
                {t("teacher.dueDate")}
              </Body>
              <Input value={dueAt} onChangeText={setDueAt} placeholder="2026-02-01" />
            </View>
            <View style={{ flex: 1, gap: 4 }}>
              <Body muted style={{ fontSize: 12 }}>
                {t("teacher.maxScore")}
              </Body>
              <Input
                value={maxScore}
                onChangeText={setMaxScore}
                keyboardType="numeric"
                placeholder="100"
              />
            </View>
          </Row>
          <Btn
            title={file ? file.name : t("student.pickFile")}
            variant="ghost"
            icon="paperclip"
            onPress={pickFile}
          />
          {error ? <Body style={{ color: colors.destructive }}>{error}</Body> : null}
          {notice ? <Body style={{ color: "#166534" }}>{notice}</Body> : null}
          <Btn
            title={t("teacher.createAssignment")}
            onPress={create}
            loading={creating}
            disabled={!subjectId || !title || !instructions || !dueAt}
            icon="plus"
          />
        </View>
      </Card>

      <Card>
        <H2>{t("teacher.gradeSubmissions")}</H2>
        <View style={{ height: 8 }} />
        {classAssignments.length === 0 ? (
          <EmptyState
            icon="book"
            title={t("common.empty")}
            hint={t("teacher.createAssignment")}
          />
        ) : (
          classAssignments.map((a, i) => (
            <View
              key={a.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: i === 0 ? 0 : 1,
                borderTopColor: colors.border,
              }}
            >
              <Pressable
                onPress={() => setOpenId(openId === a.id ? null : a.id)}
                accessibilityLabel={`${t("teacher.submissions")}: ${a.title}`}
              >
                <Row style={{ justifyContent: "space-between" }}>
                  <View style={{ flex: 1, gap: 2 }}>
                    <Body style={{ fontFamily: "Inter_600SemiBold" }}>{a.title}</Body>
                    <Body muted style={{ fontSize: 12 }}>
                      {[a.subject_name, a.due_at].filter(Boolean).join(" · ")}
                    </Body>
                  </View>
                  <Feather
                    name={openId === a.id ? "chevron-up" : "chevron-down"}
                    size={18}
                    color={colors.mutedForeground}
                  />
                </Row>
              </Pressable>
              {openId === a.id ? <SubmissionsList assignmentId={a.id} /> : null}
            </View>
          ))
        )}
      </Card>
    </View>
  );
}

function SubmissionsList({ assignmentId }: { assignmentId: number }) {
  const { t } = useI18n();
  const colors = useColors();
  const q = useQuery({
    queryKey: ["teacher", "assignment", assignmentId, "submissions"],
    queryFn: () => Teacher.assignmentSubmissions(assignmentId),
  });

  if (q.isLoading) return <LoadingView />;
  if (q.isError) return <ErrorView onRetry={() => q.refetch()} />;

  const data: any = q.data ?? {};
  const assignment = data.assignment;
  const students = asArray(data.students);

  return (
    <View style={{ marginTop: 8 }}>
      {students.length === 0 ? (
        <EmptyState icon="inbox" title={t("common.empty")} />
      ) : (
        students.map((s: any) => (
          <SubmissionRow
            key={s.id}
            student={s}
            maxScore={assignment?.max_score}
            onGraded={() => q.refetch()}
          />
        ))
      )}
    </View>
  );
}

function SubmissionRow({
  student,
  maxScore,
  onGraded,
}: {
  student: any;
  maxScore?: number | null;
  onGraded: () => void;
}) {
  const { t } = useI18n();
  const colors = useColors();
  const sub = asArray(student.submissions)[0];
  const [score, setScore] = useState(sub?.score != null ? String(sub.score) : "");
  const [feedback, setFeedback] = useState(sub?.feedback ?? "");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const save = async () => {
    if (!sub) return;
    const n = Number(score);
    if (score === "" || Number.isNaN(n)) return;
    setSaving(true);
    setError(null);
    try {
      await Teacher.gradeSubmission(sub.id, n, feedback || undefined);
      onGraded();
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setSaving(false);
    }
  };

  return (
    <View
      style={{
        paddingVertical: 10,
        borderTopWidth: 1,
        borderTopColor: colors.border,
        gap: 8,
      }}
    >
      <Row style={{ justifyContent: "space-between" }}>
        <Row style={{ flex: 1 }}>
          <Avatar name={student.name} uri={student.photo_path} size={30} />
          <Body style={{ fontFamily: "Inter_600SemiBold", flex: 1 }}>
            {student.name}
          </Body>
        </Row>
        {sub ? (
          sub.score != null ? (
            <Pill label={`${t("teacher.graded")}: ${sub.score}`} tone="success" />
          ) : (
            <Pill label={t("student.submitted")} tone="info" />
          )
        ) : (
          <Pill label={t("teacher.notSubmitted")} tone="neutral" />
        )}
      </Row>
      {sub?.content_text ? (
        <Body muted style={{ fontSize: 13 }}>
          {sub.content_text}
        </Body>
      ) : null}
      {sub ? (
        <View style={{ gap: 8 }}>
          <Row style={{ gap: 8 }}>
            <Input
              value={score}
              onChangeText={setScore}
              keyboardType="numeric"
              placeholder={maxScore != null ? `0–${maxScore}` : t("student.score")}
              style={{ flex: 1 }}
              accessibilityLabel={`${t("student.score")}: ${student.name}`}
            />
            <Btn
              title={t("common.save")}
              onPress={save}
              loading={saving}
              disabled={score === ""}
              style={{ paddingVertical: 12 }}
            />
          </Row>
          <Input
            value={feedback}
            onChangeText={setFeedback}
            placeholder={t("teacher.feedback")}
          />
          {error ? (
            <Body style={{ color: colors.destructive, fontSize: 12 }}>{error}</Body>
          ) : null}
        </View>
      ) : null}
    </View>
  );
}

// ---------------------------------------------------------------------------
// Grades (components + entry)
// ---------------------------------------------------------------------------

function GradesSection({
  classId,
  students,
  subjects,
}: {
  classId: number;
  students: any[];
  subjects: any[];
}) {
  const { t } = useI18n();
  const colors = useColors();
  const [subjectId, setSubjectId] = useState<number | null>(
    subjects.length === 1 ? subjects[0].id : null,
  );
  const [componentId, setComponentId] = useState<number | null>(null);
  const [showNew, setShowNew] = useState(false);
  const [compName, setCompName] = useState("");
  const [compType, setCompType] = useState<"quiz" | "homework" | "exam">("quiz");
  const [compWeight, setCompWeight] = useState("10");
  const [compMax, setCompMax] = useState("100");
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const compsQ = useQuery({
    queryKey: ["teacher", "components", classId, subjectId],
    queryFn: () => Teacher.gradeComponents(classId, subjectId!),
    enabled: subjectId != null,
  });
  const components = asArray(compsQ.data);
  const selected = components.find((c: any) => c.id === componentId);

  const createComponent = async () => {
    if (!subjectId || !compName) return;
    setCreating(true);
    setError(null);
    try {
      await Teacher.createGradeComponent(classId, subjectId, {
        name: compName,
        type: compType,
        weight: Number(compWeight) || 0,
        max_score: Number(compMax) || 100,
      });
      setCompName("");
      setShowNew(false);
      await compsQ.refetch();
    } catch (e: any) {
      setError(e?.message ?? t("common.error"));
    } finally {
      setCreating(false);
    }
  };

  return (
    <Card>
      <H2>{t("teacher.enterGrades")}</H2>
      <View style={{ height: 10 }} />

      <Body muted style={{ fontSize: 12, marginBottom: 6 }}>
        {t("teacher.selectSubject")}
      </Body>
      <Row style={{ gap: 8, flexWrap: "wrap", marginBottom: 12 }}>
        {subjects.map((s: any) => {
          const active = subjectId === s.id;
          return (
            <Pressable
              key={s.id}
              onPress={() => {
                setSubjectId(s.id);
                setComponentId(null);
              }}
              style={{
                backgroundColor: active ? colors.secondary : colors.muted,
                paddingHorizontal: 12,
                paddingVertical: 8,
                borderRadius: 999,
              }}
              accessibilityLabel={`${t("teacher.selectSubject")}: ${s.name}`}
            >
              <Text
                style={{
                  color: active
                    ? colors.secondaryForeground
                    : colors.mutedForeground,
                  fontFamily: "Inter_600SemiBold",
                  fontSize: 12,
                }}
              >
                {s.name}
              </Text>
            </Pressable>
          );
        })}
      </Row>

      {subjectId != null ? (
        <>
          {compsQ.isLoading ? (
            <LoadingView />
          ) : (
            <>
              <Body muted style={{ fontSize: 12, marginBottom: 6 }}>
                {t("student.component")}
              </Body>
              <Row style={{ gap: 8, flexWrap: "wrap", marginBottom: 8 }}>
                {components.map((c: any) => {
                  const active = componentId === c.id;
                  return (
                    <Pressable
                      key={c.id}
                      onPress={() => setComponentId(c.id)}
                      style={{
                        backgroundColor: active ? colors.primary : colors.muted,
                        paddingHorizontal: 12,
                        paddingVertical: 8,
                        borderRadius: 999,
                      }}
                      accessibilityLabel={`${t("student.component")}: ${c.name}`}
                    >
                      <Text
                        style={{
                          color: active
                            ? colors.primaryForeground
                            : colors.mutedForeground,
                          fontFamily: "Inter_600SemiBold",
                          fontSize: 12,
                        }}
                      >
                        {c.name} ({c.type})
                      </Text>
                    </Pressable>
                  );
                })}
                <Pressable
                  onPress={() => setShowNew((v) => !v)}
                  style={{
                    borderWidth: 1,
                    borderColor: colors.border,
                    borderStyle: "dashed",
                    paddingHorizontal: 12,
                    paddingVertical: 8,
                    borderRadius: 999,
                  }}
                  accessibilityLabel={t("teacher.newComponent")}
                >
                  <Text
                    style={{
                      color: colors.mutedForeground,
                      fontFamily: "Inter_600SemiBold",
                      fontSize: 12,
                    }}
                  >
                    + {t("teacher.newComponent")}
                  </Text>
                </Pressable>
              </Row>

              {showNew ? (
                <View style={{ gap: 10, marginBottom: 12 }}>
                  <Input
                    value={compName}
                    onChangeText={setCompName}
                    placeholder={t("teacher.componentName")}
                  />
                  <Row style={{ gap: 8 }}>
                    {(["quiz", "homework", "exam"] as const).map((ty) => (
                      <Pressable
                        key={ty}
                        onPress={() => setCompType(ty)}
                        style={{
                          backgroundColor:
                            compType === ty ? colors.secondary : colors.muted,
                          paddingHorizontal: 12,
                          paddingVertical: 8,
                          borderRadius: 999,
                        }}
                        accessibilityLabel={ty}
                      >
                        <Text
                          style={{
                            color:
                              compType === ty
                                ? colors.secondaryForeground
                                : colors.mutedForeground,
                            fontFamily: "Inter_600SemiBold",
                            fontSize: 12,
                          }}
                        >
                          {ty}
                        </Text>
                      </Pressable>
                    ))}
                  </Row>
                  <Row style={{ gap: 10 }}>
                    <View style={{ flex: 1, gap: 4 }}>
                      <Body muted style={{ fontSize: 12 }}>
                        {t("teacher.weight")}
                      </Body>
                      <Input
                        value={compWeight}
                        onChangeText={setCompWeight}
                        keyboardType="numeric"
                      />
                    </View>
                    <View style={{ flex: 1, gap: 4 }}>
                      <Body muted style={{ fontSize: 12 }}>
                        {t("teacher.maxScore")}
                      </Body>
                      <Input
                        value={compMax}
                        onChangeText={setCompMax}
                        keyboardType="numeric"
                      />
                    </View>
                  </Row>
                  {error ? (
                    <Body style={{ color: colors.destructive }}>{error}</Body>
                  ) : null}
                  <Btn
                    title={t("common.save")}
                    onPress={createComponent}
                    loading={creating}
                    disabled={!compName}
                  />
                </View>
              ) : null}

              {selected ? (
                <GradeEntry
                  students={students}
                  component={{
                    id: selected.id,
                    name: selected.name,
                    max_score: selected.max_score,
                  }}
                />
              ) : components.length === 0 && !showNew ? (
                <EmptyState
                  icon="edit-3"
                  title={t("common.empty")}
                  hint={t("teacher.newComponent")}
                />
              ) : null}
            </>
          )}
        </>
      ) : (
        <EmptyState icon="book-open" title={t("teacher.selectSubject")} />
      )}
    </Card>
  );
}
