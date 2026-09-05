import 'package:flutter/foundation.dart';

/// Whether attendance for a date can still be submitted, as the server says.
///
/// Read from the server rather than computed here on purpose. A client that
/// works the window out for itself eventually disagrees with the server, and
/// the way that disagreement shows up is a teacher filling in a form that is
/// then refused.
@immutable
class AttendanceWindow {
  const AttendanceWindow({
    required this.isOpen,
    this.hours,
    this.closesAt,
    this.reason,
  });

  final bool isOpen;
  final int? hours;
  final DateTime? closesAt;

  /// The server's own words for why it is shut. Displayed, never paraphrased.
  final String? reason;

  static AttendanceWindow fromJson(Object? json) {
    if (json is! Map) {
      // Absent means shut. Guessing "open" produces a form whose submission is
      // refused, which reads to a teacher as the app being broken.
      return const AttendanceWindow(isOpen: false);
    }

    return AttendanceWindow(
      isOpen: json['open'] == true,
      hours: int.tryParse('${json['hours']}'),
      closesAt: DateTime.tryParse('${json['closes_at']}'),
      reason: json['reason'] as String?,
    );
  }
}

/// How far along a period's attendance is.
enum AttendanceProgress {
  /// Nothing recorded and nothing queued.
  outstanding,

  /// Marked on this phone and waiting in the outbox. Not saved at the school.
  queued,

  /// The server has it.
  submitted,
}

/// One period on the teacher's timetable.
@immutable
class TeacherPeriod {
  const TeacherPeriod({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    required this.attendanceTaken,
    this.className,
    this.subject,
    this.startTime,
    this.endTime,
    this.room,
  });

  final int id;
  final int classRoomId;
  final int subjectId;

  /// The server's answer. Says nothing about work still sitting in the outbox.
  final bool attendanceTaken;

  final String? className;
  final String? subject;
  final String? startTime;
  final String? endTime;
  final String? room;

  /// Combines the server's answer with what this phone still owes it.
  ///
  /// [queued] is the set of class ids with an attendance batch waiting in the
  /// outbox for the day being shown. Work on this phone outranks the server's
  /// "not taken", and never masquerades as saved.
  AttendanceProgress progressGiven(Set<int> queued) {
    if (queued.contains(classRoomId)) return AttendanceProgress.queued;

    return attendanceTaken
        ? AttendanceProgress.submitted
        : AttendanceProgress.outstanding;
  }

  static TeacherPeriod? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    final classRoomId = int.tryParse('${json['class_room_id']}');
    if (id == null || classRoomId == null) return null;

    return TeacherPeriod(
      id: id,
      classRoomId: classRoomId,
      subjectId: int.tryParse('${json['subject_id']}') ?? 0,
      attendanceTaken: json['attendance_taken'] == true,
      className: json['class_name'] as String?,
      subject: json['subject'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      room: json['room'] as String?,
    );
  }
}

/// A class this teacher is assigned.
@immutable
class TeacherClass {
  const TeacherClass({
    required this.id,
    required this.name,
    required this.studentCount,
    required this.isHomeroom,
    this.grade,
    this.section,
  });

  final int id;
  final String name;
  final int studentCount;
  final bool isHomeroom;
  final String? grade;
  final String? section;

  static TeacherClass? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return TeacherClass(
      id: id,
      name: '${json['name'] ?? ''}',
      studentCount: int.tryParse('${json['student_count']}') ?? 0,
      isHomeroom: json['is_homeroom'] == true,
      grade: json['grade'] as String?,
      section: json['section'] as String?,
    );
  }
}

/// The teacher's day: their periods and the classes they are assigned.
@immutable
class TeacherDay {
  const TeacherDay({
    required this.date,
    required this.window,
    required this.periods,
    required this.classes,
  });

  final String date;
  final AttendanceWindow window;
  final List<TeacherPeriod> periods;
  final List<TeacherClass> classes;

  static TeacherDay fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const TeacherDay(
        date: '',
        window: AttendanceWindow(isOpen: false),
        periods: <TeacherPeriod>[],
        classes: <TeacherClass>[],
      );
    }

    final periods = data['periods'];
    final classes = data['classes'];

    return TeacherDay(
      date: '${data['date'] ?? ''}',
      window: AttendanceWindow.fromJson(data['attendance_window']),
      periods: periods is Iterable
          ? periods.map(TeacherPeriod.tryFrom).whereType<TeacherPeriod>().toList()
          : const <TeacherPeriod>[],
      classes: classes is Iterable
          ? classes.map(TeacherClass.tryFrom).whereType<TeacherClass>().toList()
          : const <TeacherClass>[],
    );
  }
}
