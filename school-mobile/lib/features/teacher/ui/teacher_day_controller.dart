import 'package:flutter/foundation.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/shared.dart';
import '../data/teacher_repository.dart';
import '../domain/teacher_day.dart';

/// The day, plus what this phone still owes the server for it.
@immutable
class TeacherDayView {
  const TeacherDayView({
    required this.day,
    required this.queuedClassIds,
    required this.rejected,
  });

  final TeacherDay day;

  /// Classes with an attendance batch sitting in the outbox for [day].
  final Set<int> queuedClassIds;

  /// Batches the sync engine gave up on. Never folded into the queued set:
  /// a teacher has to be able to tell "still sending" from "nobody has this".
  final List<RejectedSubmission> rejected;

  int get rejectedCount => rejected.length;

  AttendanceProgress progressOf(TeacherPeriod period) =>
      period.progressGiven(queuedClassIds);
}

/// Drives the teacher's day and class list.
///
/// One controller for both tabs because both read the same payload. Two would
/// mean two requests for one screenful and, worse, two answers that can
/// disagree about which classes exist.
class TeacherDayController extends ChangeNotifier {
  TeacherDayController({required this.repository, DateTime? today})
      : _date = _isoOf(today ?? DateTime.now());

  final TeacherRepository repository;

  final String _date;
  ScreenState<TeacherDayView> _state = const ScreenLoading<TeacherDayView>();
  bool _fromCache = false;
  DateTime? _fetchedAt;

  ScreenState<TeacherDayView> get state => _state;

  String get date => _date;

  /// True when what is on screen came off disk rather than off the wire.
  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  /// Cache first, then revalidate.
  Future<void> load() async {
    final cached = await repository.cachedToday(_date);
    if (cached != null) {
      await _apply(cached);
    }

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      await _apply(await repository.refreshToday(_date));
    } on ApiError catch (error) {
      // A failed revalidate must not blank a screen that is already showing
      // something. A teacher in a corridor with this morning's timetable is
      // better served than one looking at an error page.
      if (keepShowingCacheOnFailure && _state is ScreenData<TeacherDayView>) {
        // The queue may still have moved while the network was down, so the
        // pending marks are recomputed even though the day did not change.
        await _refreshQueueOnly();

        return;
      }

      _state = ScreenError<TeacherDayView>(error);
      notifyListeners();
    }
  }

  /// Re-reads the outbox without touching the network.
  ///
  /// Called after queueing or draining, so "waiting to send" disappears the
  /// moment the work actually leaves rather than on the next full refresh.
  Future<void> refreshPending() => _refreshQueueOnly();

  Future<void> _apply(Cached<TeacherDay> result) async {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;

    final view = TeacherDayView(
      day: result.value,
      queuedClassIds: await repository.queuedAttendance(_date),
      rejected: await repository.rejectedAttendance(),
    );

    // A teacher with no periods today still has classes, and a class list is
    // the whole second tab: empty only when both are.
    _state = view.day.periods.isEmpty && view.day.classes.isEmpty
        ? const ScreenEmpty<TeacherDayView>()
        : ScreenData<TeacherDayView>(view);
    notifyListeners();
  }

  Future<void> _refreshQueueOnly() async {
    final current = _state;
    if (current is! ScreenData<TeacherDayView>) {
      notifyListeners();

      return;
    }

    _state = ScreenData<TeacherDayView>(TeacherDayView(
      day: current.value.day,
      queuedClassIds: await repository.queuedAttendance(_date),
      rejected: await repository.rejectedAttendance(),
    ));
    notifyListeners();
  }

  static String _isoOf(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
