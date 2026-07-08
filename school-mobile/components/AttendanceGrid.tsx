import React from "react";
import { Pressable, Text, View } from "react-native";

import { Avatar, Body, Row } from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { useI18n } from "@/lib/i18n";

export type AttendanceStatus = "present" | "absent" | "late" | "excused";

export const ATTENDANCE_STATUSES: {
  value: AttendanceStatus;
  labelKey: string;
  bg: string;
  fg: string;
}[] = [
  { value: "present", labelKey: "attendance.present", bg: "#dcfce7", fg: "#166534" },
  { value: "absent", labelKey: "attendance.absent", bg: "#fee2e2", fg: "#991b1b" },
  { value: "late", labelKey: "attendance.late", bg: "#fef3c7", fg: "#92400e" },
  { value: "excused", labelKey: "attendance.excused", bg: "#dbeafe", fg: "#1e40af" },
];

export interface AttendanceStudent {
  id: number;
  name: string;
  photo_path?: string | null;
}

/**
 * Reusable per-student attendance marking grid: one row per student with
 * a chip selector for present / absent / late / excused.
 */
export function AttendanceGrid({
  students,
  value,
  onChange,
}: {
  students: AttendanceStudent[];
  value: Record<number, AttendanceStatus>;
  onChange: (studentId: number, status: AttendanceStatus) => void;
}) {
  const colors = useColors();
  const { t } = useI18n();

  return (
    <View>
      {students.map((s, i) => (
        <View
          key={s.id}
          style={{
            paddingVertical: 12,
            gap: 10,
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
          <Row style={{ gap: 8, flexWrap: "wrap" }}>
            {ATTENDANCE_STATUSES.map((st) => {
              const selected = value[s.id] === st.value;
              return (
                <Pressable
                  key={st.value}
                  onPress={() => onChange(s.id, st.value)}
                  accessibilityLabel={`${s.name}: ${t(st.labelKey)}`}
                  style={({ pressed }) => ({
                    backgroundColor: selected ? st.bg : colors.muted,
                    borderWidth: 1,
                    borderColor: selected ? st.fg : colors.border,
                    paddingHorizontal: 12,
                    paddingVertical: 8,
                    borderRadius: 999,
                    minHeight: 36,
                    justifyContent: "center",
                    opacity: pressed ? 0.7 : 1,
                  })}
                >
                  <Text
                    style={{
                      color: selected ? st.fg : colors.mutedForeground,
                      fontFamily: "Inter_600SemiBold",
                      fontSize: 12,
                    }}
                  >
                    {t(st.labelKey)}
                  </Text>
                </Pressable>
              );
            })}
          </Row>
        </View>
      ))}
    </View>
  );
}
