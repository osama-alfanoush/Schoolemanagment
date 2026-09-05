import 'package:flutter/foundation.dart';

/// One lesson on the student's day.
@immutable
class Lesson {
  const Lesson({
    required this.id,
    this.subject,
    this.startTime,
    this.endTime,
    this.room,
  });

  final int id;
  final String? subject;
  final String? startTime;
  final String? endTime;
  final String? room;

  static Lesson? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return Lesson(
      id: id,
      subject: json['subject'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      room: json['room'] as String?,
    );
  }
}

/// The next thing this student owes.
@immutable
class NextDue {
  const NextDue({required this.assignmentId, required this.title, this.dueAt});

  final int assignmentId;
  final String title;
  final DateTime? dueAt;

  static NextDue? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['assignment_id']}');
    if (id == null) return null;

    return NextDue(
      assignmentId: id,
      title: '${json['title'] ?? ''}',
      dueAt: DateTime.tryParse('${json['due_at']}'),
    );
  }
}

/// The student's own home screen.
///
/// Carries `student_user_id` so a screen can assert whose record it is showing.
/// The server takes no student id at all, so this is a check that the answer
/// matches the session rather than a parameter that could be changed.
@immutable
class StudentHome {
  const StudentHome({
    required this.studentUserId,
    required this.lessons,
    required this.unreadCount,
    this.className,
    this.nextDue,
    this.presentPercent,
    this.absentDays,
  });

  final int studentUserId;
  final List<Lesson> lessons;
  final int unreadCount;
  final String? className;
  final NextDue? nextDue;
  final int? presentPercent;
  final int? absentDays;

  static StudentHome fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const StudentHome(
        studentUserId: 0,
        lessons: <Lesson>[],
        unreadCount: 0,
      );
    }

    final lessons = data['today'];
    final attendance = data['attendance'];

    return StudentHome(
      studentUserId: int.tryParse('${data['student_user_id']}') ?? 0,
      className: data['class_name'] as String?,
      unreadCount: int.tryParse('${data['unread_count']}') ?? 0,
      nextDue: NextDue.tryFrom(data['next_due']),
      lessons: lessons is Iterable
          ? lessons.map(Lesson.tryFrom).whereType<Lesson>().toList()
          : const <Lesson>[],
      presentPercent: attendance is Map
          ? int.tryParse('${attendance['present_percent']}')
          : null,
      absentDays:
          attendance is Map ? int.tryParse('${attendance['absent_days']}') : null,
    );
  }
}

/// How a hand-in stands.
enum HandInState { none, submitted, late, marked }

HandInState handInStateOf(Object? value) => switch ('$value') {
      'submitted' => HandInState.submitted,
      'late' => HandInState.late,
      'graded' => HandInState.marked,
      _ => HandInState.none,
    };

/// One piece of homework, and what this student has done about it.
@immutable
class StudentAssignment {
  const StudentAssignment({
    required this.id,
    required this.title,
    required this.state,
    this.subject,
    this.instructions,
    this.dueAt,
    this.score,
    this.feedback,
    this.hasAttachment = false,
    this.hasFile = false,
  });

  final int id;
  final String title;

  /// The server's word on the hand-in. `none` means nothing has arrived — and
  /// nothing on this screen may claim otherwise while a send is in flight.
  final HandInState state;

  final String? subject;
  final String? instructions;
  final DateTime? dueAt;
  final String? score;
  final String? feedback;
  final bool hasAttachment;
  final bool hasFile;

  bool get isOverdue =>
      state == HandInState.none &&
      dueAt != null &&
      dueAt!.isBefore(DateTime.now());

  static StudentAssignment? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    final submission = json['submission'];

    return StudentAssignment(
      id: id,
      title: '${json['title'] ?? ''}',
      state: submission is Map
          ? handInStateOf(submission['status'])
          : HandInState.none,
      subject: json['subject'] as String?,
      instructions: json['instructions'] as String?,
      dueAt: DateTime.tryParse('${json['due_at']}'),
      score: submission is Map ? submission['score'] as String? : null,
      feedback: submission is Map ? submission['feedback'] as String? : null,
      hasAttachment: json['has_attachment'] == true,
      hasFile: submission is Map && submission['has_file'] == true,
    );
  }

  static List<StudentAssignment> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <StudentAssignment>[];

    final rows = data['assignments'];

    return rows is Iterable
        ? rows
            .map(StudentAssignment.tryFrom)
            .whereType<StudentAssignment>()
            .toList()
        : const <StudentAssignment>[];
  }
}

/// Where a hand-in has got to on this device.
sealed class HandInProgress {
  const HandInProgress();
}

class HandInIdle extends HandInProgress {
  const HandInIdle();
}

class HandInSending extends HandInProgress {
  const HandInSending(this.progress);

  final double? progress;
}

class HandInAccepted extends HandInProgress {
  const HandInAccepted(this.state);

  /// What the server recorded: submitted, or late.
  final HandInState state;
}

/// A hand-in that did not go through.
///
/// Shown as failed, never as done. A student who believes their work is in
/// stops carrying it, and the teacher marks a blank.
class HandInFailed extends HandInProgress {
  const HandInFailed(this.isOffline);

  final bool isOffline;
}

/// A week of lessons, keyed by ISO day of week.
@immutable
class StudentTimetable {
  const StudentTimetable({
    required this.days,
    this.studentUserId = 0,
    this.today,
  });

  /// ISO day of week ("1" = Monday) to that day's lessons.
  final Map<String, List<Lesson>> days;

  final int studentUserId;

  /// Which day to open on, as the server reckons it. A device clock in another
  /// timezone would otherwise open the wrong day at the start of a week.
  final String? today;

  List<Lesson> on(String isoDayOfWeek) => days[isoDayOfWeek] ?? const <Lesson>[];

  bool get isEmpty => days.values.every((lessons) => lessons.isEmpty);

  static StudentTimetable fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const StudentTimetable(days: <String, List<Lesson>>{});

    final days = data['days'];
    final parsed = <String, List<Lesson>>{};

    if (days is Map) {
      days.forEach((key, value) {
        parsed['$key'] = value is Iterable
            ? value.map(Lesson.tryFrom).whereType<Lesson>().toList()
            : const <Lesson>[];
      });
    }

    return StudentTimetable(
      days: parsed,
      studentUserId: int.tryParse('${data['student_user_id']}') ?? 0,
      today: data['today'] as String?,
    );
  }
}
