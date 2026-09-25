import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/calendar.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/app_formats.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/parent_academics_repository.dart';
import '../domain/academics.dart';

/// Drives the academics screen.
class ParentAcademicsController extends ChangeNotifier {
  ParentAcademicsController({
    required this.repository,
    required this.studentUserId,
    DateTime? month,
  }) : _month = month ?? DateTime.now();

  final ParentAcademicsRepository repository;
  final int studentUserId;

  ScreenState<ChildAcademics> _state = const ScreenLoading<ChildAcademics>();
  bool _fromCache = false;
  DateTime? _fetchedAt;
  DateTime _month;
  String? _notice;

  ScreenState<ChildAcademics> get state => _state;

  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  /// The month the calendar is showing.
  DateTime get month => DateTime(_month.year, _month.month);

  /// A one-off message, e.g. that an explanation was filed.
  String? get notice => _notice;

  void showMonth(DateTime month) {
    _month = DateTime(month.year, month.month);
    notifyListeners();
  }

  void dismissNotice() {
    if (_notice == null) return;

    _notice = null;
    notifyListeners();
  }

  Future<void> load() async {
    final cached = await repository.cached(studentUserId);
    if (cached != null) _apply(cached);

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply(await repository.refresh(studentUserId));
    } on ApiError catch (error) {
      // A failed revalidate must not blank a screen that is already showing
      // something. Yesterday's register, clearly labelled, beats an error page.
      if (keepShowingCacheOnFailure && _state is ScreenData<ChildAcademics>) {
        notifyListeners();

        return;
      }

      _state = ScreenError<ChildAcademics>(error);
      notifyListeners();
    }
  }

  /// Files an explanation and reloads, so the day shows it immediately.
  Future<bool> explain(AttendanceDay day, String reason, AppLocalizations l10n) async {
    try {
      await repository.explainAbsence(day.id, reason);
      _notice = l10n.explanationFiled;
      await refresh();

      return true;
    } on ApiError {
      return false;
    }
  }

  void _apply(CachedAcademics result) {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;
    _state = ScreenData<ChildAcademics>(result.academics);
    notifyListeners();
  }
}

/// Attendance, marks and issued report cards for one child.
///
/// Everything here is published-only by construction: the client has no
/// unpublished mark and no unissued report card to render, because the server
/// does not send one.
class ParentAcademicsScreen extends StatefulWidget {
  const ParentAcademicsScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenReportCard,
    super.key,
  });

  final ParentAcademicsController controller;
  final bool isOffline;
  final void Function(IssuedReportCard card)? onOpenReportCard;

  @override
  State<ParentAcademicsScreen> createState() => _ParentAcademicsScreenState();
}

class _ParentAcademicsScreenState extends State<ParentAcademicsScreen> {
  /// Owned by the State, not by the sheet.
  ///
  /// A controller disposed as soon as `showModalBottomSheet` returns is still
  /// being read by the sheet's closing animation, which throws. Its lifetime
  /// belongs to the screen.
  final _reason = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _explain(AttendanceDay day) async {
    final l10n = AppLocalizations.of(context);
    final controller = _reason..clear();
    final formKey = GlobalKey<FormState>();

    final reason = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          // Scrollable: an `isScrollControlled` sheet gives its child an
          // unbounded height, and a multi-line field inside a bare Column
          // there grows without limit. It also keeps the field reachable once
          // the keyboard is up.
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(Dimens.gapLarge),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    l10n.explainAbsenceTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimens.gapSmall),
                  // States plainly what this does and does not do.
                  Text(
                    l10n.explainAbsenceBody,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: Dimens.gap),
                  TextFormField(
                    key: const Key('explain-reason'),
                    controller: controller,
                    autofocus: true,
                    minLines: 2,
                    maxLines: 4,
                    maxLength: 1000,
                    decoration: InputDecoration(labelText: l10n.explainAbsenceHint),
                    validator: (value) => (value ?? '').trim().length < 3
                        ? l10n.explainAbsenceRequired
                        : null,
                  ),
                  const SizedBox(height: Dimens.gap),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: Dimens.minTapTarget),
                    child: FilledButton(
                      key: const Key('explain-submit'),
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop(controller.text.trim());
                        }
                      },
                      child: Text(l10n.explainAbsenceSubmit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (reason != null && reason.isNotEmpty && mounted) {
      await widget.controller.explain(day, reason, l10n);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final fetchedAt = widget.controller.fetchedAt;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<ChildAcademics>(
        title: l10n.academicsTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.refresh,
        isOffline: widget.isOffline,
        // Only when the numbers are not live.
        lastUpdatedLabel: widget.controller.isShowingCache && fetchedAt != null
            ? formats.dateTime(fetchedAt)
            : null,
        builder: (context, academics) => ListView(
          key: const Key('academics-list'),
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            if (widget.controller.notice != null)
              _Notice(
                message: widget.controller.notice!,
                onDismiss: widget.controller.dismissNotice,
              ),
            _Section(title: l10n.attendanceSection),
            _AttendanceCalendar(
              attendance: academics.attendance,
              month: widget.controller.month,
              onExplain: _explain,
            ),
            _Section(title: l10n.gradesSection),
            if (academics.subjects.isEmpty)
              _Hint(text: l10n.gradesEmpty)
            else
              for (final subject in academics.subjects)
                _SubjectCard(subject: subject),
            _Section(title: l10n.reportCardsSection),
            if (academics.reportCards.isEmpty)
              _Hint(text: l10n.reportCardsEmpty)
            else
              for (final card in academics.reportCards)
                ValueRow(
                  key: Key('report-card-${card.id}'),
                  label: Text(card.period ?? '—'),
                  secondary: Text(l10n.reportCardVersion(card.version)),
                  value: TextButton(
                    key: Key('open-report-card-${card.id}'),
                    onPressed: widget.onOpenReportCard == null
                        ? null
                        : () => widget.onOpenReportCard!(card),
                    child: Text(l10n.reportCardDownload),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

/// The month grid.
///
/// Weeks start on Sunday, because the school week here runs Sunday to
/// Thursday. A Monday-first grid puts the weekend in the middle of the row.
class _AttendanceCalendar extends StatelessWidget {
  const _AttendanceCalendar({
    required this.attendance,
    required this.month,
    required this.onExplain,
  });

  final ChildAttendance attendance;
  final DateTime month;
  final Future<void> Function(AttendanceDay day) onExplain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);

    final first = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // dayOfWeek where Sunday is 0, so the first cell lands in the right column.
    final leading = first.weekday % DateTime.daysPerWeek;

    if (attendance.days.isEmpty) {
      return _Hint(text: l10n.attendanceEmpty);
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.gutter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            formats.gregorianDate(first),
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: Dimens.gapSmall),
          GridView.builder(
            key: const Key('attendance-calendar'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: DateTime.daysPerWeek,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: leading + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leading) return const SizedBox.shrink();

              final date = DateTime(month.year, month.month, index - leading + 1);
              final marked = attendance.on(date);

              return _DayCell(
                // Keyed by date so a test can name one cell: the day number
                // alone is not unique on a screen full of numbers.
                key: Key('day-${date.year}-${date.month}-${date.day}'),
                date: date,
                day: marked,
                onExplain: onExplain,
              );
            },
          ),
          const SizedBox(height: Dimens.gap),
          const Wrap(
            spacing: Dimens.gap,
            runSpacing: 4,
            children: <Widget>[
              _LegendChip(status: AttendanceStatus.present),
              _LegendChip(status: AttendanceStatus.absent),
              _LegendChip(status: AttendanceStatus.late),
              _LegendChip(status: AttendanceStatus.excused),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.onExplain,
    this.day,
    super.key,
  });

  final DateTime date;
  final AttendanceDay? day;
  final Future<void> Function(AttendanceDay day) onExplain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);
    final marked = day;

    final background = marked == null
        ? (SchoolCalendar.isWeekend(date)
            ? theme.colorScheme.surfaceContainerHighest
            : Colors.transparent)
        : _colourFor(marked.status, theme);

    return Semantics(
      label: marked == null
          ? formats.shortDate(date)
          : '${formats.shortDate(date)}: ${_labelFor(marked.status, l10n)}',
      button: marked?.explainable ?? false,
      excludeSemantics: true,
      child: InkWell(
        onTap: marked == null ? null : () => _showDay(context, marked, l10n, formats),
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          alignment: Alignment.center,
          child: Text(
            formats.integer(date.day),
            style: theme.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

  Future<void> _showDay(
    BuildContext context,
    AttendanceDay marked,
    AppLocalizations l10n,
    AppFormats formats,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gapLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                formats.date(marked.date),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(_labelFor(marked.status, l10n)),
              if (marked.subject != null) Text(marked.subject!),
              if (marked.note != null) ...<Widget>[
                const SizedBox(height: Dimens.gap),
                Text(
                  l10n.explanationFromSchool,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(marked.note!),
              ],
              if (marked.explanation != null) ...<Widget>[
                const SizedBox(height: Dimens.gap),
                Text(
                  l10n.explanationFromYou,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(marked.explanation!),
              ],
              if (marked.explainable) ...<Widget>[
                const SizedBox(height: Dimens.gapLarge),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: Dimens.minTapTarget),
                  child: FilledButton(
                    key: Key('explain-${marked.id}'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onExplain(marked);
                    },
                    child: Text(l10n.explainAbsenceAction),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.status});

  final AttendanceStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: _colourFor(status, theme),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          _labelFor(status, AppLocalizations.of(context)),
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

Color _colourFor(AttendanceStatus status, ThemeData theme) => switch (status) {
      AttendanceStatus.present => theme.colorScheme.primaryContainer,
      AttendanceStatus.absent => theme.colorScheme.errorContainer,
      AttendanceStatus.late => theme.colorScheme.tertiaryContainer,
      AttendanceStatus.excused => theme.colorScheme.secondaryContainer,
      // An unknown status is not coloured as present.
      AttendanceStatus.unknown => theme.colorScheme.surfaceContainerHighest,
    };

String _labelFor(AttendanceStatus status, AppLocalizations l10n) =>
    switch (status) {
      AttendanceStatus.present => l10n.statusPresent,
      AttendanceStatus.absent => l10n.statusAbsent,
      AttendanceStatus.late => l10n.statusLate,
      AttendanceStatus.excused => l10n.statusExcused,
      AttendanceStatus.unknown => '—',
    };

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({required this.subject});

  final SubjectGrades subject;

  @override
  Widget build(BuildContext context) {
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);

    return Card(
      key: Key('subject-${subject.subject}'),
      margin: const EdgeInsetsDirectional.fromSTEB(
        Dimens.gutter,
        Dimens.gapSmall,
        Dimens.gutter,
        0,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(Dimens.gutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ValueRow(
              padding: EdgeInsets.zero,
              label: Text(subject.subject, style: theme.textTheme.titleSmall),
              value: Text(
                subject.percent == null ? '—' : formats.percent(subject.percent!),
                style: theme.textTheme.titleSmall,
              ),
            ),
            for (final component in subject.components)
              ValueRow(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 2),
                label: Text(component.name, style: theme.textTheme.bodyMedium),
                secondary: component.period == null
                    ? null
                    : Text(component.period!, style: theme.textTheme.bodySmall),
                value: Text(
                  '${component.score} / ${component.maxScore}',
                  style: theme.textTheme.bodyMedium,
                  textDirection: TextDirection.ltr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.gutter,
          Dimens.gapLarge,
          Dimens.gutter,
          Dimens.gapSmall,
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      );
}

class _Hint extends StatelessWidget {
  const _Hint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.gutter,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      liveRegion: true,
      child: Container(
        key: const Key('academics-notice'),
        margin: const EdgeInsetsDirectional.fromSTEB(
          Dimens.gutter,
          Dimens.gap,
          Dimens.gutter,
          0,
        ),
        padding: const EdgeInsetsDirectional.all(Dimens.gap),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(Dimens.gapSmall),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(message, style: theme.textTheme.bodyMedium),
            ),
            TextButton(
              key: const Key('academics-notice-dismiss'),
              onPressed: onDismiss,
              child: Text(AppLocalizations.of(context).later),
            ),
          ],
        ),
      ),
    );
  }
}
