import 'package:flutter/foundation.dart';

/// How a child was marked on one day.
enum AttendanceStatus { present, absent, late, excused, unknown }

AttendanceStatus attendanceStatusFrom(Object? raw) => switch ('$raw') {
      'present' => AttendanceStatus.present,
      'absent' => AttendanceStatus.absent,
      'late' => AttendanceStatus.late,
      'excused' => AttendanceStatus.excused,
      // A status this build does not know is not quietly treated as present.
      _ => AttendanceStatus.unknown,
    };

/// One marked day.
@immutable
class AttendanceDay {
  const AttendanceDay({
    required this.id,
    required this.date,
    required this.status,
    required this.explainable,
    this.subject,
    this.note,
    this.explanation,
  });

  final int id;
  final DateTime date;
  final AttendanceStatus status;

  /// The server's word on whether this day can still be explained.
  final bool explainable;

  final String? subject;

  /// The teacher's own note about the day.
  final String? note;

  /// The guardian's account of why. A different claim by a different person,
  /// which is why it is a separate field and never overwrites [note].
  final String? explanation;

  static AttendanceDay? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    final date = DateTime.tryParse('${json['date']}');
    if (id == null || date == null) return null;

    return AttendanceDay(
      id: id,
      date: DateTime(date.year, date.month, date.day),
      status: attendanceStatusFrom(json['status']),
      explainable: json['explainable'] == true,
      subject: json['subject'] as String?,
      note: json['note'] as String?,
      explanation: json['explanation'] as String?,
    );
  }
}

/// A child's attendance over a window.
@immutable
class ChildAttendance {
  const ChildAttendance({
    required this.days,
    required this.recordedDays,
    required this.absentDays,
    required this.lateDays,
    this.presentPercent,
  });

  final List<AttendanceDay> days;
  final int recordedDays;
  final int absentDays;
  final int lateDays;

  /// Null when nothing was marked. Not 100%: an unmarked window is not a
  /// window of perfect attendance.
  final int? presentPercent;

  AttendanceDay? on(DateTime day) {
    for (final marked in days) {
      if (marked.date.year == day.year &&
          marked.date.month == day.month &&
          marked.date.day == day.day) {
        return marked;
      }
    }

    return null;
  }

  static ChildAttendance fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const ChildAttendance(
        days: <AttendanceDay>[],
        recordedDays: 0,
        absentDays: 0,
        lateDays: 0,
      );
    }

    final days = data['days'];

    return ChildAttendance(
      days: days is Iterable
          ? days.map(AttendanceDay.tryFrom).whereType<AttendanceDay>().toList()
          : const <AttendanceDay>[],
      recordedDays: int.tryParse('${data['recorded_days']}') ?? 0,
      absentDays: int.tryParse('${data['absent_days']}') ?? 0,
      lateDays: int.tryParse('${data['late_days']}') ?? 0,
      presentPercent: int.tryParse('${data['present_percent']}'),
    );
  }
}

/// One component of a subject's mark.
@immutable
class GradeComponentLine {
  const GradeComponentLine({
    required this.id,
    required this.name,
    required this.score,
    required this.maxScore,
    this.type,
    this.period,
  });

  final int id;
  final String name;
  final String score;
  final String maxScore;
  final String? type;
  final String? period;

  static GradeComponentLine? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return GradeComponentLine(
      id: id,
      name: '${json['name'] ?? ''}',
      score: '${json['score'] ?? ''}',
      maxScore: '${json['max_score'] ?? ''}',
      type: json['type'] as String?,
      period: json['period'] as String?,
    );
  }
}

/// A subject's published marks.
@immutable
class SubjectGrades {
  const SubjectGrades({
    required this.subject,
    required this.components,
    this.percent,
  });

  final String subject;
  final List<GradeComponentLine> components;
  final int? percent;

  static SubjectGrades? tryFrom(Object? json) {
    if (json is! Map) return null;

    final components = json['components'];

    return SubjectGrades(
      subject: '${json['subject'] ?? ''}',
      components: components is Iterable
          ? components
              .map(GradeComponentLine.tryFrom)
              .whereType<GradeComponentLine>()
              .toList()
          : const <GradeComponentLine>[],
      percent: int.tryParse('${json['percent']}'),
    );
  }

  static List<SubjectGrades> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <SubjectGrades>[];

    final subjects = data['subjects'];

    return subjects is Iterable
        ? subjects.map(SubjectGrades.tryFrom).whereType<SubjectGrades>().toList()
        : const <SubjectGrades>[];
  }
}

/// A report card that has actually been issued.
///
/// There is no unissued form of this type. A report card the school has not
/// signed off does not exist on the client at all, which is what makes it
/// unreachable rather than merely hidden.
@immutable
class IssuedReportCard {
  const IssuedReportCard({
    required this.id,
    required this.version,
    this.period,
    this.issuedAt,
  });

  final int id;
  final int version;
  final String? period;
  final DateTime? issuedAt;

  static IssuedReportCard? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return IssuedReportCard(
      id: id,
      version: int.tryParse('${json['version']}') ?? 1,
      period: json['period'] as String?,
      issuedAt: DateTime.tryParse('${json['issued_at']}'),
    );
  }

  static List<IssuedReportCard> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <IssuedReportCard>[];

    final cards = data['report_cards'];

    return cards is Iterable
        ? cards.map(IssuedReportCard.tryFrom).whereType<IssuedReportCard>().toList()
        : const <IssuedReportCard>[];
  }
}

/// Everything the academics screen shows for one child.
@immutable
class ChildAcademics {
  const ChildAcademics({
    required this.attendance,
    required this.subjects,
    required this.reportCards,
  });

  final ChildAttendance attendance;
  final List<SubjectGrades> subjects;
  final List<IssuedReportCard> reportCards;
}
