import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/teacher_repository.dart';
import '../domain/gradebook.dart';

/// What the grade entry screen shows.
@immutable
class GradeEntryView {
  const GradeEntryView({
    required this.sheet,
    required this.draft,
    required this.queuedItemIds,
    required this.rejected,
  });

  final MarkSheet sheet;

  /// Null until a grade item is chosen — entry is per item, never a whole
  /// spreadsheet on a phone screen.
  final GradeDraft? draft;

  /// Items with a batch still owed to the server. Never rendered as saved.
  final Set<int> queuedItemIds;

  /// Batches the engine gave up on, newest first.
  final List<RejectedSubmission> rejected;
}

/// Drives entry for one class and subject.
class GradeEntryController extends ChangeNotifier {
  GradeEntryController({
    required this.repository,
    required this.classRoomId,
    required this.subjectId,
  });

  final TeacherRepository repository;
  final int classRoomId;
  final int subjectId;

  ScreenState<GradeEntryView> _state = const ScreenLoading<GradeEntryView>();
  MarkSheet? _sheet;
  GradeDraft? _draft;
  int? _selectedItemId;
  bool _submitting = false;
  bool _disposed = false;

  ScreenState<GradeEntryView> get state => _state;

  bool get submitting => _submitting;

  int? get selectedItemId => _selectedItemId;

  Future<void> load() async {
    final cached = await repository.cachedMarkSheet(classRoomId, subjectId);
    if (cached != null) await _adopt(cached.value);

    try {
      await _adopt((await repository.refreshMarkSheet(classRoomId, subjectId)).value);
    } on ApiError catch (error) {
      if (_sheet == null && !_disposed) {
        _state = ScreenError<GradeEntryView>(error);
        notifyListeners();
      }
    }
  }

  /// Switches to another assessment, discarding nothing: each item keeps its
  /// own draft only while it is selected, and a switch re-reads the sheet's
  /// recorded marks rather than carrying the previous column across.
  Future<void> select(int gradeItemId) async {
    final sheet = _sheet;
    if (sheet == null) return;

    _selectedItemId = gradeItemId;
    _draft = GradeDraft.of(sheet, gradeItemId);
    await _publish();
  }

  void enter(int studentUserId, String score) {
    final draft = _draft;
    if (draft == null) return;

    _draft = draft.withScore(studentUserId, score);
    _publishSync();
  }

  /// Queues the current column. Returns false when there is nothing to send,
  /// the sheet is locked, or an entry is not a mark the server would accept.
  Future<bool> submit() async {
    final sheet = _sheet;
    final draft = _draft;
    if (sheet == null || draft == null || _submitting) return false;
    if (!sheet.isEditable || draft.isEmpty) return false;
    if (invalidEntries().isNotEmpty) return false;

    _submitting = true;
    notifyListeners();

    await repository.queueGrades(draft);

    _submitting = false;
    if (_disposed) return true;
    await _publish();

    return true;
  }

  /// Students whose typed value the server would refuse.
  List<int> invalidEntries() {
    final sheet = _sheet;
    final draft = _draft;
    if (sheet == null || draft == null) return const <int>[];

    final item = sheet.items
        .where((candidate) => candidate.id == draft.gradeItemId)
        .firstOrNull;

    return draft.invalidEntries(maxScore: item?.maxScoreValue);
  }

  Future<void> _adopt(MarkSheet sheet) async {
    _sheet = sheet;
    // Keep the chosen item across a refresh where it still exists, so a
    // background revalidate does not throw the teacher back to the top.
    final keep = sheet.items.any((item) => item.id == _selectedItemId);
    _selectedItemId = keep ? _selectedItemId : sheet.items.firstOrNull?.id;

    final itemId = _selectedItemId;
    _draft = itemId == null ? null : GradeDraft.of(sheet, itemId);

    await _publish();
  }

  Future<void> _publish() async {
    final sheet = _sheet;
    if (sheet == null || _disposed) return;

    final queued = await repository.queuedGradeItems(classRoomId, subjectId);
    final rejected = await repository.rejectedGrades(classRoomId, subjectId);

    // The screen may have been popped during those reads.
    if (_disposed) return;

    _state = ScreenData<GradeEntryView>(GradeEntryView(
      sheet: sheet,
      draft: _draft,
      queuedItemIds: queued,
      rejected: rejected,
    ));
    notifyListeners();
  }

  /// A keystroke must not wait on two database reads.
  void _publishSync() {
    final sheet = _sheet;
    final current = _state;
    if (sheet == null || _disposed || current is! ScreenData<GradeEntryView>) {
      return;
    }

    _state = ScreenData<GradeEntryView>(GradeEntryView(
      sheet: sheet,
      draft: _draft,
      queuedItemIds: current.value.queuedItemIds,
      rejected: current.value.rejected,
    ));
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Marks for one assessment at a time, offline, with the workflow state on
/// screen rather than discovered at submission.
///
/// A gradebook that is submitted, approved or finalised does not take edits.
/// Showing an editable column and refusing it later is how a teacher loses an
/// afternoon's work and stops trusting the app.
class GradeEntryScreen extends StatefulWidget {
  const GradeEntryScreen({
    required this.controller,
    this.title = '',
    this.isOffline = false,
    this.onSubmitted,
    super.key,
  });

  final GradeEntryController controller;
  final String title;
  final bool isOffline;
  final VoidCallback? onSubmitted;

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
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
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.gradesQueuedToast)),
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
        final view = state is ScreenData<GradeEntryView> ? state.value : null;
        final canSubmit = view != null &&
            view.sheet.isEditable &&
            view.draft != null &&
            !view.draft!.isEmpty &&
            widget.controller.invalidEntries().isEmpty &&
            !widget.controller.submitting;

        return ListScaffold<GradeEntryView>(
          title: widget.title.isEmpty ? l10n.gradesTitle : widget.title,
          state: state,
          isOffline: widget.isOffline,
          emptyBody: l10n.gradesNoItems,
          floatingActionButton: canSubmit
              ? FloatingActionButton.extended(
                  key: const Key('grades-submit'),
                  onPressed: _submit,
                  icon: const Icon(Icons.check),
                  label: Text(l10n.gradesSave),
                )
              : null,
          builder: (context, value) => ListView(
            key: const Key('grades-list'),
            padding: const EdgeInsetsDirectional.only(bottom: 96),
            children: <Widget>[
              _StateBanner(gradebook: value.sheet.gradebook),
              for (final rejection in value.rejected)
                _RejectedGrades(rejection: rejection),
              if (value.sheet.items.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(l10n.gradesNoItems),
                )
              else ...<Widget>[
                _ItemPicker(
                  items: value.sheet.items,
                  selectedId: widget.controller.selectedItemId,
                  queuedItemIds: value.queuedItemIds,
                  onSelect: widget.controller.select,
                ),
                if (value.draft != null)
                  for (final student in value.sheet.students)
                    _GradeRow(
                      student: student,
                      draft: value.draft!,
                      enabled: value.sheet.isEditable,
                      isQueued:
                          value.queuedItemIds.contains(value.draft!.gradeItemId),
                      isInvalid: widget.controller
                          .invalidEntries()
                          .contains(student.userId),
                      onEntered: (score) =>
                          widget.controller.enter(student.userId, score),
                    ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// The workflow state, said plainly and always on screen.
class _StateBanner extends StatelessWidget {
  const _StateBanner({required this.gradebook});

  final GradebookStatus? gradebook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final book = gradebook;

    if (book == null) {
      return Padding(
        padding: const EdgeInsetsDirectional.all(Dimens.gutter),
        child: Text(
          key: const Key('gradebook-missing'),
          l10n.gradesNoGradebook,
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsetsDirectional.all(Dimens.gutter),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                book.isEditable ? Icons.edit_outlined : Icons.lock_outline,
                color: book.isEditable
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
              ),
              const SizedBox(width: Dimens.gapSmall),
              Expanded(
                child: Text(
                  key: const Key('gradebook-state'),
                  labelOf(book.state, l10n),
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          if (!book.isEditable)
            Padding(
              padding: const EdgeInsetsDirectional.only(top: Dimens.gapSmall),
              child: Text(
                key: const Key('gradebook-locked'),
                l10n.gradesLockedBody,
                style: theme.textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }

  static String labelOf(String state, AppLocalizations l10n) => switch (state) {
        'draft' => l10n.gradebookStateDraft,
        'submitted' => l10n.gradebookStateSubmitted,
        'approved' => l10n.gradebookStateApproved,
        'finalized' => l10n.gradebookStateFinalized,
        'returned' => l10n.gradebookStateReturned,
        'reopened' => l10n.gradebookStateReopened,
        _ => state,
      };
}

/// Which assessment is being marked.
class _ItemPicker extends StatelessWidget {
  const _ItemPicker({
    required this.items,
    required this.selectedId,
    required this.queuedItemIds,
    required this.onSelect,
  });

  final List<GradeItem> items;
  final int? selectedId;
  final Set<int> queuedItemIds;
  final void Function(int id) onSelect;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.gutter,
        ),
        child: Wrap(
          spacing: Dimens.gapSmall,
          runSpacing: Dimens.gapSmall,
          children: <Widget>[
            for (final item in items)
              ChoiceChip(
                key: Key('item-${item.id}'),
                selected: item.id == selectedId,
                onSelected: (_) => onSelect(item.id),
                avatar: queuedItemIds.contains(item.id)
                    ? const Icon(Icons.cloud_upload_outlined, size: 18)
                    : null,
                label: Text(item.name),
              ),
          ],
        ),
      );
}

/// One student's mark for the selected assessment.
class _GradeRow extends StatefulWidget {
  const _GradeRow({
    required this.student,
    required this.draft,
    required this.enabled,
    required this.isQueued,
    required this.isInvalid,
    required this.onEntered,
  });

  final GradedStudent student;
  final GradeDraft draft;
  final bool enabled;
  final bool isQueued;
  final bool isInvalid;
  final void Function(String score) onEntered;

  @override
  State<_GradeRow> createState() => _GradeRowState();
}

class _GradeRowState extends State<_GradeRow> {
  // One controller per row, held on the State. Rebuilding it in `build` would
  // move the caret to the start on every keystroke.
  late final TextEditingController _score = TextEditingController(
    text: widget.draft.scores[widget.student.userId] ?? '',
  );

  @override
  void didUpdateWidget(_GradeRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only when the column changed underneath us — a refresh or a different
    // assessment. Writing the draft back on every rebuild would fight the user.
    if (oldWidget.draft.gradeItemId != widget.draft.gradeItemId) {
      _score.text = widget.draft.scores[widget.student.userId] ?? '';
    }
  }

  @override
  void dispose() {
    _score.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ValueRow(
      key: Key('grade-${widget.student.userId}'),
      label: Text(widget.student.name),
      secondary: widget.isQueued
          ? Text(
              key: Key('queued-${widget.student.userId}'),
              l10n.gradesQueuedItem,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.tertiary),
            )
          : null,
      value: SizedBox(
        width: 96,
        child: TextField(
          key: Key('score-${widget.student.userId}'),
          controller: _score,
          enabled: widget.enabled,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          onChanged: widget.onEntered,
          decoration: InputDecoration(
            isDense: true,
            errorText: widget.isInvalid ? l10n.gradesInvalidEntry : null,
          ),
        ),
      ),
    );
  }
}

/// A refused column: which marks, and why, with the server's copy left intact.
class _RejectedGrades extends StatelessWidget {
  const _RejectedGrades({required this.rejection});

  final RejectedSubmission rejection;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isConflict =
        rejection.statusCode == 409 || rejection.statusCode == 412;

    return Container(
      key: Key('grades-rejected-${rejection.outboxRowId}'),
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
            isConflict ? l10n.gradesConflictTitle : l10n.gradesRefusedTitle,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
          Text(
            // Server wins, and the teacher is told so explicitly rather than
            // left to notice that their marks are not there.
            isConflict ? l10n.gradesConflictBody : l10n.attendanceRejectedRetry,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onErrorContainer),
          ),
          const SizedBox(height: Dimens.gapSmall),
          // The refused values themselves, so nothing is lost silently: the
          // teacher can read what they entered and type it again.
          for (final entry in rejection.entries)
            Text(
              key: Key(
                'rejected-grade-${rejection.outboxRowId}-'
                '${entry['student_user_id']}',
              ),
              '${entry['student_user_id']} · ${entry['score']}',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onErrorContainer),
            ),
        ],
      ),
    );
  }
}
