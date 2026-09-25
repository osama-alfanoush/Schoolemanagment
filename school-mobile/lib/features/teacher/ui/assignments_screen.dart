import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/teacher_repository.dart';
import '../domain/publishing.dart';

/// A file the teacher picked, described without any platform dependency.
///
/// The picker itself is a platform channel; this is what it hands back, so
/// every screen below stays testable and the picker can be swapped.
@immutable
class PickedFile {
  const PickedFile({required this.path, required this.name});

  final String path;
  final String name;
}

/// Chooses a file to attach. Injected so the screen can be tested.
typedef FilePicker = Future<PickedFile?> Function();

/// Drives the assignments list and the writes on it.
class AssignmentsController extends ChangeNotifier {
  AssignmentsController({required this.repository});

  final TeacherRepository repository;

  ScreenState<List<TeacherAssignment>> _state =
      const ScreenLoading<List<TeacherAssignment>>();
  UploadState _upload = const UploadIdle();
  int? _uploadingFor;
  bool _busy = false;
  bool _disposed = false;

  ScreenState<List<TeacherAssignment>> get state => _state;

  UploadState get upload => _upload;

  /// Which assignment the current upload belongs to, so one failed upload
  /// does not paint every row red.
  int? get uploadingFor => _uploadingFor;

  bool get busy => _busy;

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
          _state is ScreenData<List<TeacherAssignment>>) {
        _notify();

        return;
      }

      _state = ScreenError<List<TeacherAssignment>>(error);
      _notify();
    }
  }

  /// Creates a draft. Returns null when the write did not happen.
  Future<TeacherAssignment?> create({
    required int classRoomId,
    required int subjectId,
    required String title,
    required String instructions,
    required DateTime dueAt,
  }) async {
    if (_busy) return null;

    _busy = true;
    _notify();

    try {
      final created = await repository.createAssignment(
        classRoomId: classRoomId,
        subjectId: subjectId,
        title: title,
        instructions: instructions,
        dueAt: dueAt,
      );
      _busy = false;
      await refresh();

      return created;
    } on ApiError {
      _busy = false;
      _notify();

      return null;
    }
  }

  /// Uploads an attachment, reporting progress.
  ///
  /// A failure leaves the assignment untouched and the state visible, which is
  /// the whole requirement: never silently.
  Future<bool> attach(int assignmentId, PickedFile file) async {
    _uploadingFor = assignmentId;
    _upload = const UploadRunning(null);
    _notify();

    try {
      await repository.attach(
        assignmentId: assignmentId,
        filePath: file.path,
        fileName: file.name,
        onProgress: (sent, total) {
          if (_disposed) return;

          _upload = UploadRunning(total > 0 ? sent / total : null);
          notifyListeners();
        },
      );

      _upload = const UploadDone();
      await refresh();

      return true;
    } on ApiError catch (error) {
      _upload = UploadFailed(error is OfflineError || error is TimeoutError);
      _notify();

      return false;
    }
  }

  void clearUpload() {
    _upload = const UploadIdle();
    _uploadingFor = null;
    _notify();
  }

  Future<bool> publish(int assignmentId) async {
    if (_busy) return false;

    _busy = true;
    _notify();

    try {
      await repository.publish(assignmentId);
      _busy = false;
      await refresh();

      return true;
    } on ApiError {
      _busy = false;
      _notify();

      return false;
    }
  }

  void _apply(List<TeacherAssignment> assignments) {
    _state = assignments.isEmpty
        ? const ScreenEmpty<List<TeacherAssignment>>()
        : ScreenData<List<TeacherAssignment>>(assignments);
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

/// Homework: drafts, published work, and who has handed in.
class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({
    required this.controller,
    required this.classRoomId,
    required this.subjectId,
    this.picker,
    this.isOffline = false,
    this.onOpenHandIns,
    super.key,
  });

  final AssignmentsController controller;

  /// Which class a new assignment is for. The list shows every assigned class;
  /// creating is scoped to the one the teacher came from.
  final int classRoomId;
  final int subjectId;

  /// Null hides the attach action entirely, which is what a build without a
  /// file picker should do rather than offering a button that does nothing.
  final FilePicker? picker;

  final bool isOffline;
  final void Function(TeacherAssignment assignment)? onOpenHandIns;

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  Future<void> _attach(TeacherAssignment assignment) async {
    final picker = widget.picker;
    if (picker == null) return;

    final file = await picker();
    if (file == null) return;

    await widget.controller.attach(assignment.id, file);
  }

  Future<void> _newAssignment() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    if (widget.isOffline) {
      // Said plainly rather than queued. Homework can wait for a connection;
      // pretending otherwise would leave a draft nobody can attach to.
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.assignmentNeedsConnection)),
      );

      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _NewAssignmentSheet(
        onSubmit: (title, instructions, dueAt) async {
          final created = await widget.controller.create(
            classRoomId: widget.classRoomId,
            subjectId: widget.subjectId,
            title: title,
            instructions: instructions,
            dueAt: dueAt,
          );

          return created != null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<List<TeacherAssignment>>(
        title: l10n.assignmentsTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        emptyBody: l10n.assignmentsEmpty,
        floatingActionButton: FloatingActionButton.extended(
          key: const Key('assignment-new'),
          onPressed: _newAssignment,
          icon: const Icon(Icons.add),
          label: Text(l10n.assignmentNew),
        ),
        builder: (context, assignments) => ListView(
          key: const Key('assignments-list'),
          padding: const EdgeInsetsDirectional.only(bottom: 96),
          children: <Widget>[
            for (final assignment in assignments)
              _AssignmentCard(
                assignment: assignment,
                upload: widget.controller.uploadingFor == assignment.id
                    ? widget.controller.upload
                    : const UploadIdle(),
                dueLabel: assignment.dueAt == null
                    ? null
                    : formats.shortDate(assignment.dueAt!),
                onPublish: () => widget.controller.publish(assignment.id),
                onAttach: widget.picker == null
                    ? null
                    : () => _attach(assignment),
                onOpenHandIns: widget.onOpenHandIns == null
                    ? null
                    : () => widget.onOpenHandIns!(assignment),
              ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({
    required this.assignment,
    required this.upload,
    this.dueLabel,
    this.onPublish,
    this.onAttach,
    this.onOpenHandIns,
  });

  final TeacherAssignment assignment;
  final UploadState upload;
  final String? dueLabel;
  final VoidCallback? onPublish;
  final VoidCallback? onAttach;
  final VoidCallback? onOpenHandIns;

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
      child: Padding(
        padding: const EdgeInsetsDirectional.all(Dimens.gutter),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(assignment.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Wrap(
              spacing: Dimens.gapSmall,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Chip(
                  key: Key('status-${assignment.id}'),
                  label: Text(
                    assignment.isPublished
                        ? l10n.assignmentPublished
                        : l10n.assignmentDraft,
                  ),
                ),
                if (dueLabel != null) Text(dueLabel!),
                if (assignment.hasAttachment)
                  Text(
                    key: Key('attached-${assignment.id}'),
                    l10n.assignmentAttached,
                  ),
              ],
            ),
            if (!assignment.isPublished)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 4),
                child: Text(
                  key: Key('draft-note-${assignment.id}'),
                  l10n.assignmentPublishExplained,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            if (assignment.isPublished)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 4),
                child: Text(
                  key: Key('counts-${assignment.id}'),
                  '${assignment.counts.handedIn} / ${assignment.classSize}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            _UploadStatus(upload: upload, assignmentId: assignment.id),
            const SizedBox(height: Dimens.gapSmall),
            Wrap(
              spacing: Dimens.gapSmall,
              runSpacing: Dimens.gapSmall,
              children: <Widget>[
                if (onAttach != null)
                  OutlinedButton.icon(
                    key: Key('attach-${assignment.id}'),
                    onPressed: onAttach,
                    icon: const Icon(Icons.attach_file),
                    label: Text(
                      upload is UploadFailed
                          ? l10n.assignmentUploadRetry
                          : l10n.assignmentAttach,
                    ),
                  ),
                if (!assignment.isPublished)
                  FilledButton.icon(
                    key: Key('publish-${assignment.id}'),
                    onPressed: onPublish,
                    icon: const Icon(Icons.send),
                    label: Text(l10n.assignmentPublish),
                  ),
                if (assignment.isPublished && onOpenHandIns != null)
                  TextButton.icon(
                    key: Key('hand-ins-${assignment.id}'),
                    onPressed: onOpenHandIns,
                    icon: const Icon(Icons.fact_check_outlined),
                    label: Text(l10n.submissionsTitle),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// An upload that is running, finished, or visibly failed.
class _UploadStatus extends StatelessWidget {
  const _UploadStatus({required this.upload, required this.assignmentId});

  final UploadState upload;
  final int assignmentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return switch (upload) {
      UploadIdle() || UploadDone() => const SizedBox.shrink(),
      UploadRunning(progress: final progress) => Padding(
          key: Key('uploading-$assignmentId'),
          padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(l10n.assignmentUploading, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              LinearProgressIndicator(value: progress),
            ],
          ),
        ),
      // Visible, and with the assignment explicitly still saved: the only
      // thing a failed upload costs is the file.
      UploadFailed() => Padding(
          key: Key('upload-failed-$assignmentId'),
          padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
          child: Semantics(
            liveRegion: true,
            child: Text(
              l10n.assignmentUploadFailed,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ),
        ),
    };
  }
}

/// The new-assignment form.
class _NewAssignmentSheet extends StatefulWidget {
  const _NewAssignmentSheet({required this.onSubmit});

  final Future<bool> Function(String title, String instructions, DateTime dueAt)
      onSubmit;

  @override
  State<_NewAssignmentSheet> createState() => _NewAssignmentSheetState();
}

class _NewAssignmentSheetState extends State<_NewAssignmentSheet> {
  // On the State: a controller built in `build` is disposed while the sheet is
  // still animating out, and the field throws on the way off screen.
  final _title = TextEditingController();
  final _instructions = TextEditingController();
  final DateTime _dueAt = DateTime.now().add(const Duration(days: 2));
  bool _sending = false;

  @override
  void dispose() {
    _title.dispose();
    _instructions.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_sending) return;
    if (_title.text.trim().isEmpty || _instructions.text.trim().isEmpty) return;

    setState(() => _sending = true);
    final saved = await widget.onSubmit(
      _title.text.trim(),
      _instructions.text.trim(),
      _dueAt,
    );

    if (!mounted) return;
    if (saved) {
      Navigator.of(context).pop();
    } else {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gutter),
          child: Column(
            key: const Key('assignment-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                key: const Key('assignment-title'),
                controller: _title,
                decoration:
                    InputDecoration(labelText: l10n.assignmentTitleLabel),
              ),
              const SizedBox(height: Dimens.gap),
              TextField(
                key: const Key('assignment-instructions'),
                controller: _instructions,
                minLines: 2,
                maxLines: 5,
                decoration:
                    InputDecoration(labelText: l10n.assignmentInstructionsLabel),
              ),
              const SizedBox(height: Dimens.gap),
              Text(l10n.assignmentPublishExplained),
              const SizedBox(height: Dimens.gap),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: FilledButton(
                  key: const Key('assignment-save'),
                  onPressed: _sending ? null : _save,
                  child: Text(l10n.assignmentSaveDraft),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Who has handed in, and who has not.
class HandInsController extends ChangeNotifier {
  HandInsController({required this.repository, required this.assignmentId});

  final TeacherRepository repository;
  final int assignmentId;

  ScreenState<HandInReport> _state = const ScreenLoading<HandInReport>();
  bool _disposed = false;

  ScreenState<HandInReport> get state => _state;

  Future<void> load() async {
    try {
      final report = await repository.handIns(assignmentId);
      if (_disposed) return;

      _state = report.students.isEmpty
          ? const ScreenEmpty<HandInReport>()
          : ScreenData<HandInReport>(report);
    } on ApiError catch (error) {
      if (_disposed) return;

      _state = ScreenError<HandInReport>(error);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// The whole class, including the students with nothing against their name.
class HandInsScreen extends StatefulWidget {
  const HandInsScreen({
    required this.controller,
    this.isOffline = false,
    super.key,
  });

  final HandInsController controller;
  final bool isOffline;

  @override
  State<HandInsScreen> createState() => _HandInsScreenState();
}

class _HandInsScreenState extends State<HandInsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<HandInReport>(
        title: l10n.submissionsTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.load,
        isOffline: widget.isOffline,
        builder: (context, report) => ListView(
          key: const Key('hand-ins-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            for (final student in report.students)
              ValueRow(
                key: Key('hand-in-${student.studentUserId}'),
                leading: Icon(
                  switch (student.status) {
                    HandInStatus.pending => Icons.radio_button_unchecked,
                    HandInStatus.submitted => Icons.check_circle_outline,
                    HandInStatus.late => Icons.schedule,
                    HandInStatus.graded => Icons.grading,
                  },
                  color: student.status == HandInStatus.pending
                      ? theme.colorScheme.outline
                      : theme.colorScheme.primary,
                ),
                label: Text(student.name),
                value: Text(
                  switch (student.status) {
                    HandInStatus.pending => l10n.submissionPending,
                    HandInStatus.submitted => l10n.submissionSubmitted,
                    HandInStatus.late => l10n.submissionLate,
                    HandInStatus.graded => l10n.submissionGraded,
                  },
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
