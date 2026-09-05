import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/guardian_dialer.dart';
import '../data/teacher_repository.dart';
import '../domain/roster.dart';

/// Drives one class's roster for one date.
class ClassRosterController extends ChangeNotifier {
  ClassRosterController({
    required this.repository,
    required this.classRoomId,
    required this.date,
  });

  final TeacherRepository repository;
  final int classRoomId;
  final String date;

  ScreenState<ClassRoster> _state = const ScreenLoading<ClassRoster>();
  bool _fromCache = false;
  DateTime? _fetchedAt;
  String _query = '';

  ScreenState<ClassRoster> get state => _state;

  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  String get query => _query;

  /// Filters the roll by name or admission number.
  ///
  /// Local, over the list already on screen. A search that goes to the server
  /// is a search that does not work in a corridor, and a class is thirty rows.
  List<RosterStudent> visible(ClassRoster roster) {
    final needle = _query.trim().toLowerCase();
    if (needle.isEmpty) return roster.students;

    return roster.students
        .where((student) =>
            student.name.toLowerCase().contains(needle) ||
            (student.admissionNo ?? '').toLowerCase().contains(needle))
        .toList();
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> load() async {
    final cached = await repository.cachedRoster(classRoomId, date);
    if (cached != null) _apply(cached);

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply(await repository.refreshRoster(classRoomId, date));
    } on ApiError catch (error) {
      // Yesterday's roll is still the right roll. Blanking it because the
      // network is down loses the teacher the only copy they have.
      if (keepShowingCacheOnFailure && _state is ScreenData<ClassRoster>) {
        notifyListeners();

        return;
      }

      _state = ScreenError<ClassRoster>(error);
      notifyListeners();
    }
  }

  void _apply(Cached<ClassRoster> result) {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;
    _state = result.value.students.isEmpty
        ? const ScreenEmpty<ClassRoster>()
        : ScreenData<ClassRoster>(result.value);
    notifyListeners();
  }
}

/// One class's roll: photos, a search box, and a way to reach a guardian.
class ClassRosterScreen extends StatefulWidget {
  const ClassRosterScreen({
    required this.controller,
    required this.dialer,
    this.title = '',
    this.isOffline = false,
    this.photoUrlFor,
    super.key,
  });

  final ClassRosterController controller;
  final GuardianDialer dialer;
  final String title;
  final bool isOffline;

  /// Where a student's photo lives. Null hides avatars entirely, which is what
  /// a test wants and what a school with no photos on file gets anyway.
  final String Function(int studentUserId)? photoUrlFor;

  @override
  State<ClassRosterScreen> createState() => _ClassRosterScreenState();
}

class _ClassRosterScreenState extends State<ClassRosterScreen> {
  // Held on the State, not built in `build`. A controller created during a
  // build is disposed while the sheet that owns it is still animating out.
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _contact(RosterStudent student) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    await showModalBottomSheet<void>(
      context: context,
      // Scrollable: at 200% text scale a list of three guardians is taller
      // than the sheet, and an unscrollable sheet simply overflows.
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            key: const Key('guardian-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                child: Text(
                  l10n.guardianContactTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (student.guardians.isEmpty)
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: Dimens.gutter),
                  child: Text(
                    key: const Key('guardian-none'),
                    l10n.guardianNone,
                  ),
                ),
              for (final guardian in student.guardians)
                ValueRow(
                  key: Key('guardian-${guardian.userId}'),
                  leading: const Icon(Icons.person_outline),
                  label: Text(guardian.name),
                  secondary: Text(
                    guardian.isReachable
                        ? guardian.phone!
                        : l10n.guardianNoPhone,
                  ),
                  // No button at all when there is no number. A call button
                  // that cannot call is worse than none: it costs a tap and
                  // teaches the teacher the app is unreliable.
                  value: guardian.isReachable
                      ? FilledButton.tonalIcon(
                          key: Key('call-${guardian.userId}'),
                          onPressed: () async {
                            final placed =
                                await widget.dialer.call(guardian.phone!);
                            if (!placed) {
                              messenger.showSnackBar(SnackBar(
                                content: Text(l10n.guardianCallFailed),
                              ));
                            }
                          },
                          icon: const Icon(Icons.call),
                          label: Text(l10n.guardianCall),
                        )
                      : const SizedBox.shrink(),
                ),
              const SizedBox(height: Dimens.gapLarge),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<ClassRoster>(
        title: widget.title.isEmpty ? l10n.rosterTitle : widget.title,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        emptyBody: l10n.rosterEmpty,
        builder: (context, roster) {
          final visible = widget.controller.visible(roster);

          return ListView(
            key: const Key('roster-list'),
            padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                child: TextField(
                  key: const Key('roster-search'),
                  controller: _search,
                  onChanged: widget.controller.search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: l10n.rosterSearchHint,
                  ),
                ),
              ),
              if (visible.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(
                    key: const Key('roster-no-match'),
                    l10n.rosterNoMatch,
                  ),
                )
              else
                for (final student in visible)
                  ValueRow(
                    key: Key('student-${student.userId}'),
                    onTap: () => _contact(student),
                    leading: _Avatar(
                      student: student,
                      photoUrlFor: widget.photoUrlFor,
                    ),
                    label: Text(student.name),
                    secondary: student.admissionNo == null
                        ? null
                        : Text(
                            student.admissionNo!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                    value: Icon(
                      student.guardians.any((g) => g.isReachable)
                          ? Icons.call_outlined
                          : Icons.call_end_outlined,
                      color: student.guardians.any((g) => g.isReachable)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline,
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

/// A student's photo, or their initial.
///
/// The network image is requested only when the server said one exists.
/// Asking for thirty photos and collecting thirty 404s is a bad trade on a
/// school connection.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.student, this.photoUrlFor});

  final RosterStudent student;
  final String Function(int studentUserId)? photoUrlFor;

  @override
  Widget build(BuildContext context) {
    final url = photoUrlFor;
    final initial = student.name.trim().isEmpty
        ? '?'
        : student.name.trim().characters.first;

    return CircleAvatar(
      key: Key('avatar-${student.userId}'),
      radius: 20,
      foregroundImage: student.hasPhoto && url != null
          ? NetworkImage(url(student.userId))
          : null,
      child: Text(initial),
    );
  }
}
