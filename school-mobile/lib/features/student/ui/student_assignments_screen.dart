import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/student_repository.dart';
import '../domain/student_record.dart';

/// A file the student picked, described without a platform dependency.
@immutable
class StudentFile {
  const StudentFile({required this.path, required this.name});

  final String path;
  final String name;
}

/// Chooses a file to hand in. Injected so the screen stays testable.
typedef StudentFilePicker = Future<StudentFile?> Function();

/// Drives the student's homework list and the one write in the app.
class StudentAssignmentsController extends ChangeNotifier {
  StudentAssignmentsController({required this.repository});

  final StudentRepository repository;

  ScreenState<List<StudentAssignment>> _state =
      const ScreenLoading<List<StudentAssignment>>();
  HandInProgress _progress = const HandInIdle();
  int? _sendingFor;
  bool _disposed = false;

  ScreenState<List<StudentAssignment>> get state => _state;

  HandInProgress get progress => _progress;

  /// Which assignment the current hand-in belongs to, so one failure does not
  /// mark every other piece of homework as failed.
  int? get sendingFor => _sendingFor;

  Future<void> load() async {
    final cached = await repository.cachedAssignments();
    if (cached != null) _apply(cached.value);

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply((await repository.refreshAssignments()).value);
    } on ApiError catch (error) {
      if (keepShowingCacheOnFailure &&
          _state is ScreenData<List<StudentAssignment>>) {
        _notify();

        return;
      }

      _state = ScreenError<List<StudentAssignment>>(error);
      _notify();
    }
  }

  /// Hands in work for one assignment.
  ///
  /// Returns false when it did not go through — and leaves [progress] on
  /// [HandInFailed], because a student who believes their work is in stops
  /// carrying it and the teacher marks a blank.
  Future<bool> handIn(
    int assignmentId, {
    String? text,
    StudentFile? file,
  }) async {
    if (_progress is HandInSending) return false;

    _sendingFor = assignmentId;
    _progress = const HandInSending(null);
    _notify();

    try {
      final state = await repository.handIn(
        assignmentId: assignmentId,
        text: text,
        filePath: file?.path,
        fileName: file?.name,
        onProgress: (sent, total) {
          if (_disposed) return;

          _progress = HandInSending(total > 0 ? sent / total : null);
          notifyListeners();
        },
      );

      _progress = HandInAccepted(state);
      await refresh();

      return true;
    } on ApiError catch (error) {
      _progress =
          HandInFailed(error is OfflineError || error is TimeoutError);
      _notify();

      return false;
    }
  }

  void clearProgress() {
    _progress = const HandInIdle();
    _sendingFor = null;
    _notify();
  }

  void _apply(List<StudentAssignment> assignments) {
    _state = assignments.isEmpty
        ? const ScreenEmpty<List<StudentAssignment>>()
        : ScreenData<List<StudentAssignment>>(assignments);
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

/// The student's homework, and the only place in this app that writes.
class StudentAssignmentsScreen extends StatefulWidget {
  const StudentAssignmentsScreen({
    required this.controller,
    this.picker,
    this.isOffline = false,
    super.key,
  });

  final StudentAssignmentsController controller;

  /// Null hides the attach action, which is what a build with no file picker
  /// should do rather than offering a button that cannot work.
  final StudentFilePicker? picker;

  final bool isOffline;

  @override
  State<StudentAssignmentsScreen> createState() =>
      _StudentAssignmentsScreenState();
}

class _StudentAssignmentsScreenState extends State<StudentAssignmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  Future<void> _open(StudentAssignment assignment) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (widget.isOffline) {
      // Never queued. A student shown "handed in" for work sitting on their
      // own phone will stop carrying it, and the deadline is at the school.
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.studentSendOffline)),
      );

      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _HandInSheet(
        assignment: assignment,
        picker: widget.picker,
        onSubmit: (text, file) => widget.controller.handIn(
          assignment.id,
          text: text,
          file: file,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<List<StudentAssignment>>(
        title: l10n.studentAssignmentsTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        emptyBody: l10n.studentNoAssignments,
        builder: (context, assignments) => ListView(
          key: const Key('student-assignments-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            for (final assignment in assignments)
              _AssignmentRow(
                assignment: assignment,
                progress: widget.controller.sendingFor == assignment.id
                    ? widget.controller.progress
                    : const HandInIdle(),
                dueLabel: assignment.dueAt == null
                    ? null
                    : formats.shortDate(assignment.dueAt!),
                onOpen: () => _open(assignment),
              ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentRow extends StatelessWidget {
  const _AssignmentRow({
    required this.assignment,
    required this.progress,
    required this.onOpen,
    this.dueLabel,
  });

  final StudentAssignment assignment;
  final HandInProgress progress;
  final VoidCallback onOpen;
  final String? dueLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      key: Key('assignment-${assignment.id}'),
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.gutter,
        vertical: Dimens.gapSmall,
      ),
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gutter),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(assignment.title, style: theme.textTheme.titleMedium),
              if (assignment.subject != null)
                Text(assignment.subject!, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              Wrap(
                spacing: Dimens.gapSmall,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Chip(
                    key: Key('state-${assignment.id}'),
                    label: Text(_stateLabel(assignment.state, l10n)),
                  ),
                  if (dueLabel != null) Text(dueLabel!),
                  if (assignment.score != null)
                    Text(
                      key: Key('score-${assignment.id}'),
                      assignment.score!,
                      style: theme.textTheme.titleSmall,
                    ),
                ],
              ),
              if (assignment.feedback != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 4),
                  child: Text(
                    key: Key('feedback-${assignment.id}'),
                    assignment.feedback!,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              _HandInStatus(progress: progress, assignmentId: assignment.id),
            ],
          ),
        ),
      ),
    );
  }

  static String _stateLabel(HandInState state, AppLocalizations l10n) =>
      switch (state) {
        HandInState.none => l10n.studentNotHandedIn,
        HandInState.submitted => l10n.studentHandedIn,
        HandInState.late => l10n.studentHandedInLate,
        HandInState.marked => l10n.studentMarked,
      };
}

/// A hand-in in flight, accepted, or visibly failed.
class _HandInStatus extends StatelessWidget {
  const _HandInStatus({required this.progress, required this.assignmentId});

  final HandInProgress progress;
  final int assignmentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return switch (progress) {
      HandInIdle() || HandInAccepted() => const SizedBox.shrink(),
      HandInSending(progress: final value) => Padding(
          key: Key('sending-$assignmentId'),
          padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(l10n.studentSending, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              LinearProgressIndicator(value: value),
            ],
          ),
        ),
      // Failed, and said so: the work has *not* reached the school.
      HandInFailed() => Padding(
          key: Key('send-failed-$assignmentId'),
          padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
          child: Semantics(
            liveRegion: true,
            child: Text(
              l10n.studentSendFailed,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ),
        ),
    };
  }
}

/// The hand-in form.
class _HandInSheet extends StatefulWidget {
  const _HandInSheet({
    required this.assignment,
    required this.onSubmit,
    this.picker,
  });

  final StudentAssignment assignment;
  final StudentFilePicker? picker;
  final Future<bool> Function(String? text, StudentFile? file) onSubmit;

  @override
  State<_HandInSheet> createState() => _HandInSheetState();
}

class _HandInSheetState extends State<_HandInSheet> {
  // On the State: a controller built in `build` is disposed while the sheet is
  // still animating out, and the field throws on the way off screen.
  final _text = TextEditingController();
  StudentFile? _file;
  bool _sending = false;
  bool _empty = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final picker = widget.picker;
    if (picker == null) return;

    final file = await picker();
    if (file != null && mounted) setState(() => _file = file);
  }

  Future<void> _submit() async {
    final text = _text.text.trim();

    if (text.isEmpty && _file == null) {
      setState(() => _empty = true);

      return;
    }

    setState(() {
      _sending = true;
      _empty = false;
    });

    final sent = await widget.onSubmit(text.isEmpty ? null : text, _file);

    if (!mounted) return;
    if (sent) {
      Navigator.of(context).pop();
    } else {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gutter),
          child: Column(
            key: const Key('hand-in-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.assignment.title, style: theme.textTheme.titleMedium),
              if (widget.assignment.instructions != null)
                Text(widget.assignment.instructions!),
              if (widget.assignment.isOverdue)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
                  child: Text(
                    // Late is accepted and recorded as late. Refusing it
                    // outright means the teacher loses the work as well as the
                    // timestamp.
                    key: const Key('hand-in-late-warning'),
                    l10n.studentLateWarning,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              const SizedBox(height: Dimens.gap),
              TextField(
                key: const Key('hand-in-text'),
                controller: _text,
                minLines: 2,
                maxLines: 6,
                decoration: InputDecoration(labelText: l10n.studentHandInText),
              ),
              if (widget.picker != null) ...<Widget>[
                const SizedBox(height: Dimens.gapSmall),
                OutlinedButton.icon(
                  key: const Key('hand-in-attach'),
                  onPressed: _sending ? null : _pick,
                  icon: const Icon(Icons.attach_file),
                  label: Text(_file?.name ?? l10n.assignmentAttach),
                ),
              ],
              if (_empty)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
                  child: Text(
                    key: const Key('hand-in-empty'),
                    l10n.studentSendEmpty,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              const SizedBox(height: Dimens.gap),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: FilledButton(
                  key: const Key('hand-in-send'),
                  onPressed: _sending ? null : _submit,
                  child: Text(l10n.studentHandIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
