import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/db/database_errors.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/teacher_repository.dart';
import '../domain/attendance_draft.dart';
import '../domain/roster.dart';
import '../domain/teacher_day.dart';

/// What the attendance screen shows.
@immutable
class AttendanceView {
  const AttendanceView({
    required this.roster,
    required this.draft,
    required this.isQueued,
    required this.rejected,
  });

  final ClassRoster roster;
  final AttendanceDraft draft;

  /// True when a batch for this class and date is still owed to the server.
  /// Displayed as pending. Never as saved.
  final bool isQueued;

  /// Submissions for this class and date the engine gave up on.
  final List<RejectedSubmission> rejected;

  AttendanceWindow get window => roster.window;
}

/// Drives one class's register.
///
/// Every mark is local until the teacher submits, and submitting queues rather
/// than sends. The screen never touches the network: a classroom is exactly
/// where there is no signal, and a register that needs one is a register that
/// gets written on paper instead.
class AttendanceController extends ChangeNotifier {
  AttendanceController({
    required this.repository,
    required this.classRoomId,
    required this.date,
    this.subjectId,
  });

  final TeacherRepository repository;
  final int classRoomId;
  final String date;

  /// Null for the homeroom register, set when marking one subject's period.
  final int? subjectId;

  ScreenState<AttendanceView> _state = const ScreenLoading<AttendanceView>();
  ClassRoster? _roster;
  AttendanceDraft? _draft;
  bool _submitting = false;
  bool _disposed = false;
  bool _couldNotSaveLocally = false;

  ScreenState<AttendanceView> get state => _state;

  bool get submitting => _submitting;

  /// True when the device itself refused the write — a full disk, most often.
  /// Kept apart from every server-side refusal: nothing was recorded at all.
  bool get couldNotSaveLocally => _couldNotSaveLocally;

  Future<void> load() async {
    final cached = await repository.cachedRoster(classRoomId, date);
    if (cached != null) await _adopt(cached.value);

    try {
      await _adopt((await repository.refreshRoster(classRoomId, date)).value);
    } on ApiError catch (error) {
      // A roster on disk is still the right roll. Only a cold start with
      // nothing cached leaves the teacher with nothing to mark.
      if (_roster == null && !_disposed) {
        _state = ScreenError<AttendanceView>(error);
        notifyListeners();
      }
    }
  }

  /// Sets one student's status.
  void mark(int studentUserId, AttendanceStatus status) {
    final draft = _draft;
    if (draft == null) return;

    _draft = draft.withMark(studentUserId, status);
    _publish();
  }

  /// Toggles between present and absent.
  ///
  /// The single tap the screen is built around: absence is the exception a
  /// teacher is marking, and everything else is a longer gesture.
  void toggle(int studentUserId) {
    final draft = _draft;
    if (draft == null) return;

    mark(
      studentUserId,
      draft.statusOf(studentUserId) == AttendanceStatus.present
          ? AttendanceStatus.absent
          : AttendanceStatus.present,
    );
  }

  void note(int studentUserId, String note) {
    final draft = _draft;
    if (draft == null) return;

    _draft = draft.withNote(studentUserId, note);
    _publish();
  }

  /// Queues the register. Returns false when the window has closed.
  ///
  /// The window is checked here as well as by the server. Not as a substitute
  /// — the server's answer is the one that counts — but because queueing a
  /// batch that is certain to be refused turns a clear "you cannot edit this
  /// day" into a rejection arriving hours later.
  Future<bool> submit() async {
    final draft = _draft;
    final roster = _roster;
    if (draft == null || roster == null || _submitting) return false;
    if (!roster.window.isOpen) return false;

    _submitting = true;
    _couldNotSaveLocally = false;
    notifyListeners();

    try {
      await repository.queueAttendance(draft);
    } on LocalDatabaseException {
      // Nothing was written, so nothing may be claimed. Saying "saved on this
      // phone" here is the one lie this screen must never tell.
      _submitting = false;
      _couldNotSaveLocally = true;
      if (!_disposed) notifyListeners();

      return false;
    }

    _submitting = false;
    if (_disposed) return true;

    await _publishAsync();

    return true;
  }

  /// Awaited, not fired and forgotten. The queue read inside decides whether
  /// the screen says "waiting to send", and a screen that renders before that
  /// answer arrives shows a spinner that never resolves.
  Future<void> _adopt(ClassRoster roster) async {
    _roster = roster;
    // The draft is rebuilt from the server's roll, which pre-fills any marks
    // already recorded. Local edits are discarded on a refresh; a refresh only
    // happens on open, before anything has been marked.
    _draft = AttendanceDraft.from(roster, subjectId: subjectId);
    await _publishAsync();
  }

  void _publish() {
    final roster = _roster;
    final draft = _draft;
    if (roster == null || draft == null || _disposed) return;

    final current = _state;
    _state = ScreenData<AttendanceView>(AttendanceView(
      roster: roster,
      draft: draft,
      isQueued: current is ScreenData<AttendanceView>
          ? current.value.isQueued
          : false,
      rejected: current is ScreenData<AttendanceView>
          ? current.value.rejected
          : const <RejectedSubmission>[],
    ));
    notifyListeners();
  }

  Future<void> _publishAsync() async {
    final roster = _roster;
    final draft = _draft;
    if (roster == null || draft == null || _disposed) return;

    final isQueued = await repository.hasQueuedAttendance(classRoomId, date);
    final rejected = (await repository.rejectedAttendance())
        .where((row) => row.classRoomId == classRoomId && row.date == date)
        .toList();

    // The screen may have been popped during those two reads. Notifying a
    // disposed controller throws, and the throw lands in an async gap where
    // nothing catches it.
    if (_disposed) return;

    _state = ScreenData<AttendanceView>(AttendanceView(
      roster: roster,
      draft: draft,
      isQueued: isQueued,
      rejected: rejected,
    ));
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Marks a whole class, offline, in as few gestures as possible.
///
/// Everyone starts present and the teacher touches only the exceptions: one
/// tap for absent, a swipe for late or excused, a long press for the full
/// chooser and a note. The measure this screen has to meet is a real teacher
/// with a stopwatch against a paper register — if it is slower than paper it
/// will not be used, and no amount of polish repairs that.
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({
    required this.controller,
    this.title = '',
    this.isOffline = false,
    this.onSubmitted,
    super.key,
  });

  final AttendanceController controller;
  final String title;
  final bool isOffline;

  /// Called after a submission is queued, so the day screen can re-read the
  /// queue and show the period as pending.
  final VoidCallback? onSubmitted;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (await widget.controller.submit()) {
      // "Saved on this phone", not "saved". The distinction is the whole
      // point: a teacher who reads a queued register as filed stops chasing
      // it, and the class with no roll call is the one nobody notices.
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.attendanceQueuedToast)),
      );
      widget.onSubmitted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;
        final view = state is ScreenData<AttendanceView> ? state.value : null;
        final canSubmit = view != null &&
            view.window.isOpen &&
            !widget.controller.submitting;

        return ListScaffold<AttendanceView>(
          title: widget.title.isEmpty ? l10n.attendanceTitle : widget.title,
          state: state,
          isOffline: widget.isOffline,
          emptyBody: l10n.rosterEmpty,
          floatingActionButton: canSubmit
              ? FloatingActionButton.extended(
                  key: const Key('attendance-submit'),
                  onPressed: _submit,
                  icon: const Icon(Icons.check),
                  label: Text(l10n.attendanceSubmit),
                )
              : null,
          builder: (context, value) => ListView(
            key: const Key('attendance-list'),
            // Room for the extended FAB, which otherwise covers the last
            // student in the class — reliably the same child every day.
            padding: const EdgeInsetsDirectional.only(bottom: 96),
            children: <Widget>[
              _Summary(draft: value.draft),
              if (widget.controller.couldNotSaveLocally)
                Container(
                  key: const Key('attendance-local-write-failed'),
                  margin: const EdgeInsetsDirectional.all(Dimens.gutter),
                  padding: const EdgeInsetsDirectional.all(Dimens.gap),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      l10n.localWriteFailed,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                  ),
                ),
              if (!value.window.isOpen) _ClosedWindow(window: value.window),
              if (value.isQueued) const _QueuedNotice(),
              for (final rejection in value.rejected)
                _RejectedDetail(rejection: rejection),
              for (final student in value.roster.students)
                _StudentRow(
                  student: student,
                  status: value.draft.statusOf(student.userId),
                  note: value.draft.notes[student.userId],
                  enabled: value.window.isOpen,
                  onToggle: () => widget.controller.toggle(student.userId),
                  onMark: (status) =>
                      widget.controller.mark(student.userId, status),
                  onOpenSheet: () => _openSheet(value, student),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openSheet(AttendanceView view, RosterStudent student) async {
    if (!view.window.isOpen) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _MarkSheet(
        student: student,
        status: view.draft.statusOf(student.userId),
        note: view.draft.notes[student.userId],
        onMark: (status) => widget.controller.mark(student.userId, status),
        onNote: (note) => widget.controller.note(student.userId, note),
      ),
    );
  }
}

/// One student. Tap toggles, swipe marks late or excused, long press opens
/// the full chooser.
class _StudentRow extends StatelessWidget {
  const _StudentRow({
    required this.student,
    required this.status,
    required this.enabled,
    required this.onToggle,
    required this.onMark,
    required this.onOpenSheet,
    this.note,
  });

  final RosterStudent student;
  final AttendanceStatus status;
  final String? note;
  final bool enabled;
  final VoidCallback onToggle;
  final void Function(AttendanceStatus status) onMark;
  final VoidCallback onOpenSheet;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final row = InkWell(
      // The key lives on the row rather than on the Dismissible, because the
      // Dismissible is not built when the window has closed and a test that
      // cannot find the row cannot check that it refuses to be marked.
      key: Key('student-${student.userId}'),
      onTap: enabled ? onToggle : null,
      onLongPress: enabled ? onOpenSheet : null,
      child: ConstrainedBox(
        // 48dp is the floor, and this row is tapped thirty times a morning.
        constraints: const BoxConstraints(minHeight: Dimens.minTapTarget),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Dimens.gutter,
            vertical: Dimens.gapSmall,
          ),
          child: Row(
            children: <Widget>[
              Icon(_iconOf(status), color: _colorOf(status, theme)),
              const SizedBox(width: Dimens.gap),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(student.name, style: theme.textTheme.bodyLarge),
                    if (note != null)
                      Text(note!, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.gapSmall),
              Text(
                key: Key('status-${student.userId}'),
                _labelOf(status, l10n),
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: _colorOf(status, theme)),
              ),
            ],
          ),
        ),
      ),
    );

    if (!enabled) return row;

    // Dismissible, but nothing is dismissed: `confirmDismiss` applies the mark
    // and then refuses, so the row springs back with its new status. A swipe
    // that removed the student from the list would be the opposite of what a
    // register needs.
    return Dismissible(
      key: Key('swipe-${student.userId}'),
      confirmDismiss: (direction) async {
        onMark(
          direction == DismissDirection.startToEnd
              ? AttendanceStatus.late
              : AttendanceStatus.excused,
        );

        return false;
      },
      background: _SwipeHint(
        alignment: AlignmentDirectional.centerStart,
        icon: Icons.schedule,
        label: l10n.statusLate,
        color: theme.colorScheme.tertiaryContainer,
        foreground: theme.colorScheme.onTertiaryContainer,
      ),
      secondaryBackground: _SwipeHint(
        alignment: AlignmentDirectional.centerEnd,
        icon: Icons.event_available,
        label: l10n.statusExcused,
        color: theme.colorScheme.secondaryContainer,
        foreground: theme.colorScheme.onSecondaryContainer,
      ),
      child: row,
    );
  }

  static IconData _iconOf(AttendanceStatus status) => switch (status) {
        AttendanceStatus.present => Icons.check_circle,
        AttendanceStatus.absent => Icons.cancel,
        AttendanceStatus.late => Icons.schedule,
        AttendanceStatus.excused => Icons.event_available,
      };

  static Color _colorOf(AttendanceStatus status, ThemeData theme) =>
      switch (status) {
        AttendanceStatus.present => theme.colorScheme.primary,
        AttendanceStatus.absent => theme.colorScheme.error,
        AttendanceStatus.late => theme.colorScheme.tertiary,
        AttendanceStatus.excused => theme.colorScheme.secondary,
      };

  static String _labelOf(AttendanceStatus status, AppLocalizations l10n) =>
      switch (status) {
        AttendanceStatus.present => l10n.statusPresent,
        AttendanceStatus.absent => l10n.statusAbsent,
        AttendanceStatus.late => l10n.statusLate,
        AttendanceStatus.excused => l10n.statusExcused,
      };
}

class _SwipeHint extends StatelessWidget {
  const _SwipeHint({
    required this.alignment,
    required this.icon,
    required this.label,
    required this.color,
    required this.foreground,
  });

  final AlignmentDirectional alignment;
  final IconData icon;
  final String label;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        alignment: alignment,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.gutter,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: foreground),
            const SizedBox(width: Dimens.gapSmall),
            Text(label, style: TextStyle(color: foreground)),
          ],
        ),
      );
}

/// The counts, so a teacher can check the register without reading thirty rows.
class _Summary extends StatelessWidget {
  const _Summary({required this.draft});

  final AttendanceDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(Dimens.gutter),
      child: draft.isAllPresent
          ? Text(
              key: const Key('attendance-summary'),
              l10n.attendanceAllPresent,
              style: theme.textTheme.titleSmall,
            )
          : Wrap(
              key: const Key('attendance-summary'),
              spacing: Dimens.gap,
              runSpacing: Dimens.gapSmall,
              children: <Widget>[
                for (final status in AttendanceStatus.values)
                  if (draft.countOf(status) > 0)
                    Chip(
                      key: Key('count-${status.name}'),
                      label: Text(
                        '${_StudentRow._labelOf(status, l10n)}: '
                        '${draft.countOf(status)}',
                      ),
                    ),
              ],
            ),
    );
  }
}

class _ClosedWindow extends StatelessWidget {
  const _ClosedWindow({required this.window});

  final AttendanceWindow window;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      key: const Key('attendance-window-closed'),
      margin: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.gutter),
      padding: const EdgeInsetsDirectional.all(Dimens.gap),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.lock_clock),
          const SizedBox(width: Dimens.gapSmall),
          // The server's own words. The screen does not paraphrase a rule it
          // does not own.
          Expanded(child: Text(window.reason ?? l10n.attendanceWindowClosed)),
        ],
      ),
    );
  }
}

class _QueuedNotice extends StatelessWidget {
  const _QueuedNotice();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.gutter,
        vertical: Dimens.gapSmall,
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.cloud_upload_outlined, color: theme.colorScheme.tertiary),
          const SizedBox(width: Dimens.gapSmall),
          Expanded(
            child: Text(
              key: const Key('attendance-queued-notice'),
              l10n.attendanceQueuedExplained,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// A submission the engine gave up on: which one, why, and what to do.
class _RejectedDetail extends StatelessWidget {
  const _RejectedDetail({required this.rejection});

  final RejectedSubmission rejection;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      key: Key('rejected-${rejection.outboxRowId}'),
      margin: const EdgeInsetsDirectional.all(Dimens.gutter),
      padding: const EdgeInsetsDirectional.all(Dimens.gap),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.attendanceRejectedTitle,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
          Text(
            // Which submission, from the row this device wrote.
            l10n.attendanceRejectedOn(
              rejection.date ?? '',
              rejection.recordCount ?? 0,
            ),
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
          const SizedBox(height: Dimens.gapSmall),
          Text(
            // Why, derived from the status. The server's message body is
            // deliberately never stored: it can quote submitted values.
            switch (rejection.statusCode) {
              422 => l10n.attendanceRejectedWindow,
              409 || 412 => l10n.attendanceRejectedConflict,
              _ => l10n.attendanceRejectedRefused,
            },
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
          Text(
            l10n.attendanceRejectedRetry,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
        ],
      ),
    );
  }
}

/// The full chooser: every status, plus a note.
class _MarkSheet extends StatefulWidget {
  const _MarkSheet({
    required this.student,
    required this.status,
    required this.onMark,
    required this.onNote,
    this.note,
  });

  final RosterStudent student;
  final AttendanceStatus status;
  final String? note;
  final void Function(AttendanceStatus status) onMark;
  final void Function(String note) onNote;

  @override
  State<_MarkSheet> createState() => _MarkSheetState();
}

class _MarkSheetState extends State<_MarkSheet> {
  // On the State, not built in `build`: a controller created during a build is
  // disposed while the sheet that owns it is still animating out, and the
  // field then throws on the way off screen.
  late final TextEditingController _note =
      TextEditingController(text: widget.note ?? '');

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          key: const Key('mark-sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.all(Dimens.gutter),
              child: Text(
                widget.student.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            RadioGroup<AttendanceStatus>(
              groupValue: widget.status,
              onChanged: (value) {
                if (value != null) widget.onMark(value);
                Navigator.of(context).pop();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final status in AttendanceStatus.values)
                    RadioListTile<AttendanceStatus>(
                      key: Key('mark-${status.name}'),
                      value: status,
                      title: Text(_StudentRow._labelOf(status, l10n)),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(Dimens.gutter),
              child: TextField(
                key: const Key('mark-note'),
                controller: _note,
                onChanged: widget.onNote,
                decoration: InputDecoration(labelText: l10n.attendanceNoteHint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
