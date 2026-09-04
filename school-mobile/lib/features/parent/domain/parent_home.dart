import 'package:flutter/foundation.dart';

import '../../../core/i18n/money.dart';

/// One line of a child's timetable.
@immutable
class LessonSlot {
  const LessonSlot({
    required this.id,
    this.subject,
    this.teacher,
    this.startTime,
    this.endTime,
    this.room,
  });

  final String id;
  final String? subject;
  final String? teacher;
  final String? startTime;
  final String? endTime;
  final String? room;

  static LessonSlot? tryFrom(Object? json) {
    if (json is! Map) return null;

    return LessonSlot(
      id: '${json['id'] ?? ''}',
      subject: _text(json['subject']),
      teacher: _text(json['teacher']),
      startTime: _text(json['start_time']),
      endTime: _text(json['end_time']),
      room: _text(json['room']),
    );
  }
}

/// The next unpaid installment.
@immutable
class NextInstallment {
  const NextInstallment({
    required this.id,
    required this.amount,
    required this.daysRemaining,
    required this.overdue,
    this.dueDate,
  });

  final int id;
  final Money amount;

  /// Negative once the due date has passed.
  final int daysRemaining;

  final bool overdue;
  final DateTime? dueDate;

  static NextInstallment? tryFrom(Object? json) {
    if (json is! Map) return null;

    final amount = _money(json['outstanding']) ?? _money(json['amount']);
    if (amount == null) return null;

    return NextInstallment(
      id: int.tryParse('${json['id']}') ?? 0,
      amount: amount,
      daysRemaining: int.tryParse('${json['days_remaining']}') ?? 0,
      overdue: json['overdue'] == true,
      dueDate: DateTime.tryParse('${json['due_date']}'),
    );
  }
}

/// The most recent grade a parent is allowed to see.
@immutable
class LatestGrade {
  const LatestGrade({this.subject, this.component, this.score, this.maxScore});

  final String? subject;
  final String? component;
  final String? score;
  final String? maxScore;

  static LatestGrade? tryFrom(Object? json) {
    if (json is! Map) return null;

    return LatestGrade(
      subject: _text(json['subject']),
      component: _text(json['component']),
      score: _text(json['score']),
      maxScore: _text(json['max_score']),
    );
  }
}

/// One child's card on the home screen.
@immutable
class ChildCard {
  const ChildCard({
    required this.id,
    required this.name,
    this.className,
    this.attendancePercent,
    this.absentDays = 0,
    this.nextInstallment,
    this.latestGrade,
    this.today = const <LessonSlot>[],
  });

  final int id;
  final String name;
  final String? className;

  /// Null when no register was taken this week. **Not** 100% — an unmarked
  /// week is not a perfect one, and rendering it as one is a lie a parent
  /// acts on.
  final int? attendancePercent;

  final int absentDays;
  final NextInstallment? nextInstallment;
  final LatestGrade? latestGrade;
  final List<LessonSlot> today;

  static ChildCard? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    final attendance = json['attendance'];
    final lessons = json['today'];

    return ChildCard(
      id: id,
      name: '${json['name'] ?? ''}',
      className: _text(json['class_name']),
      attendancePercent: attendance is Map
          ? int.tryParse('${attendance['present_percent']}')
          : null,
      absentDays: attendance is Map
          ? int.tryParse('${attendance['absent_days']}') ?? 0
          : 0,
      nextInstallment: NextInstallment.tryFrom(json['next_installment']),
      latestGrade: LatestGrade.tryFrom(json['latest_grade']),
      today: lessons is Iterable
          ? lessons.map(LessonSlot.tryFrom).whereType<LessonSlot>().toList()
          : const <LessonSlot>[],
    );
  }
}

/// The whole parent home payload.
@immutable
class ParentHome {
  const ParentHome({
    required this.children,
    this.unreadCount = 0,
    this.generatedAt,
  });

  final List<ChildCard> children;
  final int unreadCount;

  /// When the server built this. Shown as a staleness label when the screen is
  /// rendered from cache.
  final DateTime? generatedAt;

  /// A guardian with one child never sees a picker; the card is the screen.
  bool get hasSingleChild => children.length == 1;

  static ParentHome fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const ParentHome(children: <ChildCard>[]);

    final children = data['children'];

    return ParentHome(
      children: children is Iterable
          ? children.map(ChildCard.tryFrom).whereType<ChildCard>().toList()
          : const <ChildCard>[],
      unreadCount: int.tryParse('${data['unread_count']}') ?? 0,
      generatedAt: DateTime.tryParse('${data['generated_at']}'),
    );
  }
}

String? _text(Object? value) =>
    value is String && value.isNotEmpty ? value : null;

/// Reads a `{minor, currency, decimals}` block.
///
/// Returns null rather than zero when the shape is wrong: a silently-zero fee
/// is worse than a missing one, because nobody notices it until the money is
/// wrong.
Money? _money(Object? json) {
  if (json is! Map) return null;

  final minor = int.tryParse('${json['minor']}');
  final currency = json['currency'];
  final decimals = int.tryParse('${json['decimals']}');

  if (minor == null || currency is! String || decimals == null) return null;

  return Money(minor: minor, currency: currency, decimals: decimals);
}
