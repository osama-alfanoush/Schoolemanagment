import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../domain/teacher_day.dart';
import 'teacher_day_controller.dart';

/// Today's periods in order, each saying honestly where its attendance stands.
///
/// The three states are deliberately distinct. "Waiting to send" is not
/// "received by the school": a teacher who reads a queued submission as done
/// stops chasing it, and a roll call nobody has is the failure this whole
/// feature exists to prevent.
class TeacherTodayScreen extends StatefulWidget {
  const TeacherTodayScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenAttendance,
    super.key,
  });

  final TeacherDayController controller;
  final bool isOffline;
  final void Function(TeacherPeriod period)? onOpenAttendance;

  @override
  State<TeacherTodayScreen> createState() => _TeacherTodayScreenState();
}

class _TeacherTodayScreenState extends State<TeacherTodayScreen> {
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

        return ListScaffold<TeacherDayView>(
          title: l10n.teacherTodayTitle,
          state: widget.controller.state,
          onRefresh: widget.controller.refresh,
          isOffline: widget.isOffline,
          emptyBody: l10n.teacherNoPeriods,
          lastUpdatedLabel: widget.controller.isShowingCache && fetchedAt != null
              ? formats.dateTime(fetchedAt)
              : null,
          builder: (context, view) => ListView(
            key: const Key('teacher-today-list'),
            padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
            children: <Widget>[
              if (!view.day.window.isOpen)
                _WindowClosedNotice(window: view.day.window),
              if (view.rejectedCount > 0)
                _RejectedNotice(count: view.rejectedCount),
              if (view.day.periods.isEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                  child: Text(l10n.teacherNoPeriods),
                )
              else
                for (final period in view.day.periods)
                  _PeriodRow(
                    period: period,
                    progress: view.progressOf(period),
                    onTap: widget.onOpenAttendance == null
                        ? null
                        : () => widget.onOpenAttendance!(period),
                  ),
            ],
          ),
        );
      },
    );
  }
}

class _PeriodRow extends StatelessWidget {
  const _PeriodRow({
    required this.period,
    required this.progress,
    this.onTap,
  });

  final TeacherPeriod period;
  final AttendanceProgress progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final time = <String?>[period.startTime, period.endTime]
        .whereType<String>()
        .map(_shortTime)
        .join(' – ');

    return ValueRow(
      key: Key('period-${period.id}'),
      onTap: onTap,
      leading: Icon(
        switch (progress) {
          AttendanceProgress.submitted => Icons.cloud_done_outlined,
          AttendanceProgress.queued => Icons.cloud_upload_outlined,
          AttendanceProgress.outstanding => Icons.radio_button_unchecked,
        },
        color: switch (progress) {
          AttendanceProgress.submitted => theme.colorScheme.primary,
          AttendanceProgress.queued => theme.colorScheme.tertiary,
          AttendanceProgress.outstanding => theme.colorScheme.outline,
        },
      ),
      label: Text(
        period.className ?? period.subject ?? '',
        style: theme.textTheme.titleSmall,
      ),
      secondary: Text(
        <String>[
          if (period.subject != null && period.className != null) period.subject!,
          if (time.isNotEmpty) time,
          if (period.room != null) period.room!,
        ].join(' · '),
        style: theme.textTheme.bodySmall,
      ),
      value: Text(
        key: Key('period-${period.id}-progress'),
        switch (progress) {
          AttendanceProgress.submitted => l10n.attendanceSubmitted,
          AttendanceProgress.queued => l10n.attendanceQueued,
          AttendanceProgress.outstanding => l10n.attendanceOutstanding,
        },
        style: theme.textTheme.labelLarge?.copyWith(
          color: switch (progress) {
            AttendanceProgress.submitted => theme.colorScheme.primary,
            AttendanceProgress.queued => theme.colorScheme.tertiary,
            AttendanceProgress.outstanding => theme.colorScheme.onSurfaceVariant,
          },
        ),
      ),
    );
  }

  /// `08:45:00` reads as a duration; `08:45` reads as a time.
  static String _shortTime(String value) {
    final parts = value.split(':');

    return parts.length >= 2 ? '${parts[0]}:${parts[1]}' : value;
  }
}

/// Says the day is shut, in the server's own words where it gave them.
class _WindowClosedNotice extends StatelessWidget {
  const _WindowClosedNotice({required this.window});

  final AttendanceWindow window;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(Dimens.gutter),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.lock_clock, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: Dimens.gapSmall),
          Expanded(
            child: Text(
              key: const Key('attendance-window-closed'),
              // The server's reason, verbatim. Paraphrasing it is how a client
              // ends up explaining a rule that has since changed.
              window.reason ?? l10n.attendanceWindowClosed,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Work the sync engine gave up on, shown apart from work still in flight.
class _RejectedNotice extends StatelessWidget {
  const _RejectedNotice({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      key: const Key('attendance-rejected-notice'),
      margin: const EdgeInsetsDirectional.all(Dimens.gutter),
      padding: const EdgeInsetsDirectional.all(Dimens.gap),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.report_gmailerrorred_outlined,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: Dimens.gapSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.attendanceRejectedTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  l10n.failedSyncCount(count),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
