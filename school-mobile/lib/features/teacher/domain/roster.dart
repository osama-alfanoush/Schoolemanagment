import 'package:flutter/foundation.dart';

import 'teacher_day.dart';

/// How a student was marked.
///
/// `present` is the default the attendance screen starts from: in a class of
/// thirty, twenty-eight are there, and making the teacher confirm each one is
/// what makes an app slower than paper.
enum AttendanceStatus { present, absent, late, excused }

/// Parses a server status, tolerating one it does not know.
AttendanceStatus? attendanceStatusOf(Object? value) => switch ('$value') {
      'present' => AttendanceStatus.present,
      'absent' => AttendanceStatus.absent,
      'late' => AttendanceStatus.late,
      'excused' => AttendanceStatus.excused,
      _ => null,
    };

/// A guardian a teacher can reach.
@immutable
class Guardian {
  const Guardian({
    required this.userId,
    required this.name,
    this.relation,
    this.phone,
  });

  final int userId;
  final String name;
  final String? relation;

  /// May be absent: not every guardian has a number on file, and an empty
  /// call button is worse than none.
  final String? phone;

  bool get isReachable => phone != null && phone!.trim().isNotEmpty;

  static Guardian? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['guardian_user_id']}');
    if (id == null) return null;

    final phone = json['phone'] as String?;

    return Guardian(
      userId: id,
      name: '${json['name'] ?? ''}',
      relation: json['relation'] as String?,
      phone: phone != null && phone.trim().isEmpty ? null : phone,
    );
  }
}

/// One student on a roster.
@immutable
class RosterStudent {
  const RosterStudent({
    required this.userId,
    required this.name,
    required this.hasPhoto,
    required this.guardians,
    this.admissionNo,
    this.status,
    this.note,
  });

  final int userId;
  final String name;

  /// Whether to ask the file route for a photo at all. Requesting one for
  /// every student on a class of thirty and getting thirty 404s is a bad
  /// trade on a school connection.
  final bool hasPhoto;

  final List<Guardian> guardians;
  final String? admissionNo;

  /// What the server already has for the day, if anything.
  final AttendanceStatus? status;

  final String? note;

  static RosterStudent? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['student_user_id']}');
    if (id == null) return null;

    final guardians = json['guardians'];

    return RosterStudent(
      userId: id,
      name: '${json['name'] ?? ''}',
      hasPhoto: json['has_photo'] == true,
      guardians: guardians is Iterable
          ? guardians.map(Guardian.tryFrom).whereType<Guardian>().toList()
          : const <Guardian>[],
      admissionNo: json['admission_no'] as String?,
      status: attendanceStatusOf(json['status']),
      note: json['note'] as String?,
    );
  }
}

/// One class's roll for one date.
@immutable
class ClassRoster {
  const ClassRoster({
    required this.classRoomId,
    required this.date,
    required this.window,
    required this.students,
  });

  final int classRoomId;
  final String date;
  final AttendanceWindow window;
  final List<RosterStudent> students;

  static ClassRoster fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const ClassRoster(
        classRoomId: 0,
        date: '',
        window: AttendanceWindow(isOpen: false),
        students: <RosterStudent>[],
      );
    }

    final students = data['students'];

    return ClassRoster(
      classRoomId: int.tryParse('${data['class_room_id']}') ?? 0,
      date: '${data['date'] ?? ''}',
      window: AttendanceWindow.fromJson(data['attendance_window']),
      students: students is Iterable
          ? students.map(RosterStudent.tryFrom).whereType<RosterStudent>().toList()
          : const <RosterStudent>[],
    );
  }
}
