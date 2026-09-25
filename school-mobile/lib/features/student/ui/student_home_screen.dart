import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/student_repository.dart';
import '../domain/student_record.dart';

/// Drives the student's home screen.
class StudentHomeController extends ChangeNotifier {
  StudentHomeController({required this.repository});

  final StudentRepository repository;

  ScreenState<StudentHome> _state = const ScreenLoading<StudentHome>();
  bool _fromCache = false;
  DateTime? _fetchedAt;
  bool _disposed = false;

  ScreenState<StudentHome> get state => _state;

  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  Future<void> load() async {
    final cached = await repository.cachedHome();
    if (cached != null) _apply(cached);

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply(await repository.refreshHome());
    } on ApiError catch (error) {
      if (keepShowingCacheOnFailure && _state is ScreenData<StudentHome>) {
        _notify();

        return;
      }

      _state = ScreenError<StudentHome>(error);
      _notify();
    }
  }

  void _apply(StudentCached<StudentHome> result) {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;
    _state = ScreenData<StudentHome>(result.value);
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

/// The student's own day: today's lessons, attendance, and what is due next.
///
/// Read-only. Nothing on this screen reaches another student — there is no
/// class list, no ranking and no way to message a classmate, by design.
class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenAssignment,
    super.key,
  });

  final StudentHomeController controller;
  final bool isOffline;
  final void Function(NextDue due)? onOpenAssignment;

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
      builder: (context, _) {
        final fetchedAt = widget.controller.fetchedAt;

        return ListScaffold<StudentHome>(
          title: l10n.studentHomeTitle,
          state: widget.controller.state,
          onRefresh: widget.controller.refresh,
          isOffline: widget.isOffline,
          emptyBody: l10n.studentNoLessons,
          lastUpdatedLabel: widget.controller.isShowingCache && fetchedAt != null
              ? formats.dateTime(fetchedAt)
              : null,
          builder: (context, home) => ListView(
            key: const Key('student-home-list'),
            padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
            children: <Widget>[
              if (home.className != null)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(
                    home.className!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              if (home.presentPercent != null)
                ValueRow(
                  key: const Key('student-attendance-summary'),
                  leading: const Icon(Icons.event_available_outlined),
                  label: Text(l10n.studentAttendanceTitle),
                  value: Text(formats.percent(home.presentPercent!)),
                ),
              if (home.nextDue != null)
                ValueRow(
                  key: const Key('student-next-due'),
                  onTap: widget.onOpenAssignment == null
                      ? null
                      : () => widget.onOpenAssignment!(home.nextDue!),
                  leading: const Icon(Icons.assignment_outlined),
                  label: Text(home.nextDue!.title),
                  secondary: Text(l10n.studentNextDue),
                  value: Text(
                    home.nextDue!.dueAt == null
                        ? ''
                        : formats.shortDate(home.nextDue!.dueAt!),
                  ),
                ),
              const Divider(height: Dimens.gapLarge),
              if (home.lessons.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(l10n.studentNoLessons),
                )
              else
                for (final lesson in home.lessons)
                  ValueRow(
                    key: Key('lesson-${lesson.id}'),
                    leading: const Icon(Icons.schedule),
                    label: Text(lesson.subject ?? ''),
                    secondary: lesson.room == null ? null : Text(lesson.room!),
                    value: Text(_timeRange(lesson)),
                  ),
            ],
          ),
        );
      },
    );
  }

  /// `08:45:00` reads as a duration; `08:45` reads as a time.
  static String _timeRange(Lesson lesson) {
    String short(String? value) {
      if (value == null) return '';
      final parts = value.split(':');

      return parts.length >= 2 ? '${parts[0]}:${parts[1]}' : value;
    }

    final from = short(lesson.startTime);
    final to = short(lesson.endTime);

    return to.isEmpty ? from : '$from – $to';
  }
}
