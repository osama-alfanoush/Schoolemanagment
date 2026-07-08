import React, { useState } from "react";
import { View } from "react-native";

import { Avatar, Body, Btn, Input, Row } from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Teacher } from "@/lib/api";
import { useI18n } from "@/lib/i18n";

export interface GradeEntryStudent {
  id: number;
  name: string;
  photo_path?: string | null;
}

/**
 * Reusable grade entry list for one grade component: a score input per
 * student, each saved individually via POST /teacher/grades.
 */
export function GradeEntry({
  students,
  component,
  onSaved,
}: {
  students: GradeEntryStudent[];
  component: { id: number; name: string; max_score?: number | null };
  onSaved?: (studentId: number, score: number) => void;
}) {
  const colors = useColors();
  const { t } = useI18n();
  const [scores, setScores] = useState<Record<number, string>>({});
  const [saving, setSaving] = useState<Record<number, boolean>>({});
  const [saved, setSaved] = useState<Record<number, boolean>>({});
  const [errors, setErrors] = useState<Record<number, string>>({});

  const save = async (studentId: number) => {
    const raw = scores[studentId];
    const score = Number(raw);
    if (raw == null || raw === "" || Number.isNaN(score)) return;
    if (component.max_score != null && score > Number(component.max_score)) {
      setErrors((e) => ({
        ...e,
        [studentId]: `${t("teacher.maxScore")}: ${component.max_score}`,
      }));
      return;
    }
    setErrors((e) => ({ ...e, [studentId]: "" }));
    setSaving((s) => ({ ...s, [studentId]: true }));
    try {
      await Teacher.enterGrade({
        student_user_id: studentId,
        grade_component_id: component.id,
        score,
      });
      setSaved((s) => ({ ...s, [studentId]: true }));
      onSaved?.(studentId, score);
    } catch (e: any) {
      setErrors((er) => ({
        ...er,
        [studentId]: e?.message ?? t("common.error"),
      }));
    } finally {
      setSaving((s) => ({ ...s, [studentId]: false }));
    }
  };

  return (
    <View>
      {students.map((s, i) => (
        <View
          key={s.id}
          style={{
            paddingVertical: 12,
            gap: 8,
            borderTopWidth: i === 0 ? 0 : 1,
            borderTopColor: colors.border,
          }}
        >
          <Row>
            <Avatar name={s.name} uri={s.photo_path} size={32} />
            <Body style={{ fontFamily: "Inter_600SemiBold", flex: 1 }}>
              {s.name}
            </Body>
          </Row>
          <Row style={{ gap: 8 }}>
            <Input
              value={scores[s.id] ?? ""}
              onChangeText={(v) => {
                setScores((sc) => ({ ...sc, [s.id]: v }));
                setSaved((sv) => ({ ...sv, [s.id]: false }));
              }}
              keyboardType="numeric"
              placeholder={
                component.max_score != null
                  ? `0–${component.max_score}`
                  : t("student.score")
              }
              style={{ flex: 1 }}
              accessibilityLabel={`${t("student.score")}: ${s.name}`}
            />
            <Btn
              title={saved[s.id] ? "✓" : t("common.save")}
              variant={saved[s.id] ? "secondary" : "primary"}
              loading={!!saving[s.id]}
              disabled={!scores[s.id]}
              onPress={() => save(s.id)}
              style={{ paddingVertical: 12 }}
            />
          </Row>
          {errors[s.id] ? (
            <Body style={{ color: colors.destructive, fontSize: 12 }}>
              {errors[s.id]}
            </Body>
          ) : null}
        </View>
      ))}
    </View>
  );
}
