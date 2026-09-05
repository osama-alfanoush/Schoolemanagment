import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../../parent/domain/academics.dart';
import '../data/student_repository.dart';
import '../domain/student_record.dart';

/// A read-only screen over one part of the student's own record.
///
/// One controller for three screens because they differ only in which endpoint
/// they read. Three near-copies would be three places for the cache-first
/// order and the offline behaviour to drift apart.
class StudentRecordController<T> extends ChangeNotifier {
  StudentRecordController({
    required this.readCached,
    required this.readFresh,
    required this.isEmpty,
  });

  final Future<StudentCached<T>?> Function() readCached;
  final Future<StudentCached<T>> Function() readFresh;

  /// Whether the payload is worth rendering. Kept out of the widget so an
  /// empty screen is an explicit state rather than an empty list.
  final bool Function(T value) isEmpty;

  ScreenState<T> _state = ScreenLoading<T>();
  bool _fromCache = false;
  DateTime? _fetchedAt;
  bool _disposed = false;

  ScreenState<T> get state => _state;

  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  Future<void> load() async {
    final cached = await readCached();
    if (cached != null) _apply(cached);

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply(await readFresh());
    } on ApiError catch (error) {
      if (keepShowingCacheOnFailure && _state is ScreenData<T>) {
        _notify();

        return;
      }

      _state = ScreenError<T>(error);
      _notify();
    }
  }

  void _apply(StudentCached<T> result) {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;
    _state = isEmpty(result.value) ? ScreenEmpty<T>() : ScreenData<T>(result.value);
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Builds the three record controllers from one repository.
class StudentRecordControllers {
  const StudentRecordControllers._();

  static StudentRecordController<StudentTimetable> timetable(
    StudentRepository repository,
  ) =>
      StudentRecordController<StudentTimetable>(
        readCached: repository.cachedTimetable,
        readFresh: repository.refreshTimetable,
        isEmpty: (value) => value.isEmpty,
      );

  static StudentRecordController<List<SubjectGrades>> grades(
    StudentRepository repository,
  ) =>
      StudentRecordController<List<SubjectGrades>>(
        readCached: repository.cachedGrades,
        readFresh: repository.refreshGrades,
        isEmpty: (value) => value.isEmpty,
      );

  static StudentRecordController<ChildAttendance> attendance(
    StudentRepository repository,
  ) =>
      StudentRecordController<ChildAttendance>(
        readCached: repository.cachedAttendance,
        readFresh: repository.refreshAttendance,
        // An unmarked window is not an empty screen: "nothing recorded" is
        // itself the answer, and hiding it would read as perfect attendance.
        isEmpty: (value) => false,
      );
}

/// The student's week.
class StudentTimetableScreen extends StatefulWidget {
  const StudentTimetableScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final StudentRecordController<StudentTimetable> controller;
  final bool isOffline;

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<StudentTimetable>(
        title: l10n.studentTimetableTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        emptyBody: l10n.timetableEmpty,
        builder: (context, timetable) => ListView(
          key: const Key('student-timetable-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            for (final day in _orderedDays(timetable))
              ExpansionTile(
                key: Key('day-$day'),
                // The server says which day today is. A device clock in
                // another timezone would otherwise open the wrong one.
                initiallyExpanded: day == timetable.today,
                title: Text(_dayName(day, context)),
                children: <Widget>[
                  for (final lesson in timetable.on(day))
                    ValueRow(
                      key: Key('lesson-${lesson.id}'),
                      label: Text(lesson.subject ?? ''),
                      secondary:
                          lesson.room == null ? null : Text(lesson.room!),
                      value: Text(lesson.startTime ?? ''),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static List<String> _orderedDays(StudentTimetable timetable) {
    final days = timetable.days.keys.toList()
      ..sort((a, b) => (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0));

    return days;
  }

  /// The weekday's name in the active locale.
  ///
  /// Derived from `intl` rather than from seven translated strings: 2024-01-01
  /// was a Monday, so day N of that week is ISO weekday N, and the names then
  /// follow the locale automatically.
  static String _dayName(String iso, BuildContext context) {
    final day = int.tryParse(iso);
    if (day == null || day < 1 || day > 7) return iso;

    return AppI18nScope.of(context).weekdayName(DateTime.utc(2024, 1, day));
  }
}

/// The student's published marks.
///
/// Only finalized gradebooks reach this screen, and the filtering happens on
/// the server: a mark a teacher has not submitted does not exist here.
class StudentGradesScreen extends StatefulWidget {
  const StudentGradesScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final StudentRecordController<List<SubjectGrades>> controller;
  final bool isOffline;

  @override
  State<StudentGradesScreen> createState() => _StudentGradesScreenState();
}

class _StudentGradesScreenState extends State<StudentGradesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<List<SubjectGrades>>(
        title: l10n.studentGradesTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        emptyBody: l10n.studentNoGrades,
        builder: (context, subjects) => ListView(
          key: const Key('student-grades-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            // No class average, no position, no comparison with anyone. A
            // student's mark is their own business.
            for (final subject in subjects)
              ExpansionTile(
                key: Key('subject-${subject.subject}'),
                title: Text(subject.subject),
                subtitle: subject.percent == null
                    ? null
                    : Text(formats.percent(subject.percent!)),
                children: <Widget>[
                  for (final line in subject.components)
                    ValueRow(
                      label: Text(line.name),
                      value: Text('${line.score} / ${line.maxScore}'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// The student's own attendance.
class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final StudentRecordController<ChildAttendance> controller;
  final bool isOffline;

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<ChildAttendance>(
        title: l10n.studentAttendanceTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        builder: (context, attendance) => ListView(
          key: const Key('student-attendance-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            ValueRow(
              key: const Key('attendance-present-percent'),
              label: Text(l10n.attendancePresentPercent),
              // Null, not 100%. An unmarked window is not a window of perfect
              // attendance, and rendering it as one is a lie a family acts on.
              value: Text(
                attendance.presentPercent == null
                    ? '—'
                    : formats.percent(attendance.presentPercent!),
              ),
            ),
            ValueRow(
              key: const Key('attendance-absent-days'),
              label: Text(l10n.attendanceAbsentDays),
              value: Text(formats.integer(attendance.absentDays)),
            ),
            const Divider(height: Dimens.gapLarge),
            for (final day in attendance.days)
              ValueRow(
                key: Key('day-${day.date.year}-${day.date.month}-${day.date.day}'),
                label: Text(formats.shortDate(day.date)),
                value: Text(_statusLabel(day.status, l10n)),
              ),
          ],
        ),
      ),
    );
  }

  static String _statusLabel(AttendanceStatus status, AppLocalizations l10n) =>
      switch (status) {
        AttendanceStatus.present => l10n.statusPresent,
        AttendanceStatus.absent => l10n.statusAbsent,
        AttendanceStatus.late => l10n.statusLate,
        AttendanceStatus.excused => l10n.statusExcused,
        // A status this build does not know is shown as itself rather than
        // guessed at. Guessing "present" is the dangerous direction.
        AttendanceStatus.unknown => status.name,
      };
}
