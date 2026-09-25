import 'package:flutter/foundation.dart';

import 'roster.dart';

/// A class's marks as the teacher has them right now.
///
/// Everyone starts present. In a class of thirty, twenty-eight are there, and
/// an app that makes a teacher confirm each of the twenty-eight is slower than
/// the paper register it replaces — at which point it does not get used, and
/// none of the rest of this matters.
@immutable
class AttendanceDraft {
  const AttendanceDraft({
    required this.classRoomId,
    required this.date,
    required this.marks,
    this.notes = const <int, String>{},
    this.subjectId,
  });

  /// Everyone present, except where the server already has a mark for the day.
  ///
  /// Pre-filling from the server matters as much as the default: opening an
  /// empty form on a day already marked is how the same class gets taken twice.
  factory AttendanceDraft.from(ClassRoster roster, {int? subjectId}) {
    final marks = <int, AttendanceStatus>{};
    final notes = <int, String>{};

    for (final student in roster.students) {
      marks[student.userId] = student.status ?? AttendanceStatus.present;
      final note = student.note;
      if (note != null && note.isNotEmpty) notes[student.userId] = note;
    }

    return AttendanceDraft(
      classRoomId: roster.classRoomId,
      date: roster.date,
      marks: marks,
      notes: notes,
      subjectId: subjectId,
    );
  }

  final int classRoomId;
  final String date;
  final Map<int, AttendanceStatus> marks;
  final Map<int, String> notes;

  /// Null for a homeroom register; set when marking one subject's period.
  final int? subjectId;

  AttendanceStatus statusOf(int studentUserId) =>
      marks[studentUserId] ?? AttendanceStatus.present;

  int countOf(AttendanceStatus status) =>
      marks.values.where((value) => value == status).length;

  /// True when nobody is anything but present — the common case, and the one
  /// the screen must let a teacher confirm in a single tap.
  bool get isAllPresent =>
      marks.values.every((status) => status == AttendanceStatus.present);

  AttendanceDraft withMark(int studentUserId, AttendanceStatus status) =>
      AttendanceDraft(
        classRoomId: classRoomId,
        date: date,
        marks: <int, AttendanceStatus>{...marks, studentUserId: status},
        notes: notes,
        subjectId: subjectId,
      );

  AttendanceDraft withNote(int studentUserId, String note) {
    final next = <int, String>{...notes};
    if (note.trim().isEmpty) {
      next.remove(studentUserId);
    } else {
      next[studentUserId] = note.trim();
    }

    return AttendanceDraft(
      classRoomId: classRoomId,
      date: date,
      marks: marks,
      notes: next,
      subjectId: subjectId,
    );
  }

  /// The body the batch endpoint expects.
  ///
  /// Every student is sent, not only the exceptions. A partial roll cannot be
  /// told apart from an unfinished one, and "present" has to be a recorded
  /// fact rather than the absence of a record.
  Map<String, Object?> toPayload() => <String, Object?>{
        'class_room_id': classRoomId,
        if (subjectId != null) 'subject_id': subjectId,
        'date': date,
        'records': <Object?>[
          for (final entry in marks.entries)
            <String, Object?>{
              'student_user_id': entry.key,
              'status': entry.value.name,
              if (notes[entry.key] != null) 'note': notes[entry.key],
            },
        ],
      };
}
