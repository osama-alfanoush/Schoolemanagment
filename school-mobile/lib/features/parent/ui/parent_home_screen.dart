import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/parent_home_repository.dart';
import '../domain/parent_home.dart';

/// Drives the parent home screen.
class ParentHomeController extends ChangeNotifier {
  ParentHomeController({required this.repository});

  final ParentHomeRepository repository;

  ScreenState<ParentHome> _state = const ScreenLoading<ParentHome>();
  bool _fromCache = false;
  DateTime? _fetchedAt;

  ScreenState<ParentHome> get state => _state;

  /// True when what is on screen came off disk rather than off the wire.
  bool get isShowingCache => _fromCache;

  DateTime? get fetchedAt => _fetchedAt;

  /// Cache first, then revalidate in the background.
  ///
  /// The cached copy is rendered before the request is even sent, so a cold
  /// start on a bad connection shows last night's numbers immediately rather
  /// than a spinner for as long as the network takes.
  Future<void> load() async {
    final cached = await repository.cached();
    if (cached != null) {
      _apply(cached);
    }

    await refresh(keepShowingCacheOnFailure: cached != null);
  }

  /// Goes to the network. Used by pull-to-refresh.
  Future<void> refresh({bool keepShowingCacheOnFailure = true}) async {
    try {
      _apply(await repository.refresh());
    } on ApiError catch (error) {
      // A failed revalidate must not blank a screen that is already showing
      // something. Being offline with yesterday's numbers is useful; being
      // offline with an error page is not.
      if (keepShowingCacheOnFailure && _state is ScreenData<ParentHome>) {
        notifyListeners();

        return;
      }

      _state = ScreenError<ParentHome>(error);
      notifyListeners();
    }
  }

  void _apply(CachedHome result) {
    _fromCache = result.fromCache;
    _fetchedAt = result.fetchedAt;
    _state = result.home.children.isEmpty
        ? const ScreenEmpty<ParentHome>()
        : ScreenData<ParentHome>(result.home);
    notifyListeners();
  }
}

/// One card per child: attendance, the next payment, the latest grade and
/// today's lessons.
///
/// There is no child picker. A guardian with one child sees one card and a
/// guardian with three sees three — a picker in front of a single-child family
/// is a tap that exists only because the screen was built for the harder case.
class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenChild,
    this.onPayInstallment,
    super.key,
  });

  final ParentHomeController controller;
  final bool isOffline;
  final void Function(ChildCard child)? onOpenChild;
  final void Function(ChildCard child, NextInstallment installment)? onPayInstallment;

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
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

        return ListScaffold<ParentHome>(
          title: l10n.parentHomeTitle,
          state: widget.controller.state,
          onRefresh: widget.controller.refresh,
          isOffline: widget.isOffline,
          emptyBody: l10n.parentHomeEmpty,
          // Only when the numbers are not live. Labelling a fresh screen as
          // stale trains people to ignore the label.
          lastUpdatedLabel: widget.controller.isShowingCache && fetchedAt != null
              ? formats.dateTime(fetchedAt)
              : null,
          builder: (context, home) => ListView.builder(
            padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
            itemCount: home.children.length,
            itemBuilder: (context, index) => _ChildCardTile(
              key: Key('child-card-${home.children[index].id}'),
              child: home.children[index],
              onOpen: widget.onOpenChild,
              onPay: widget.onPayInstallment,
            ),
          ),
        );
      },
    );
  }
}

class _ChildCardTile extends StatelessWidget {
  const _ChildCardTile({required this.child, this.onOpen, this.onPay, super.key});

  final ChildCard child;
  final void Function(ChildCard child)? onOpen;
  final void Function(ChildCard child, NextInstallment installment)? onPay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);
    final installment = child.nextInstallment;

    return Card(
      margin: const EdgeInsetsDirectional.fromSTEB(
        Dimens.gutter,
        Dimens.gap,
        Dimens.gutter,
        0,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen == null ? null : () => onOpen!(child),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(child.name, style: theme.textTheme.titleMedium),
              if (child.className != null)
                Text(child.className!, style: theme.textTheme.bodySmall),
              const SizedBox(height: Dimens.gap),

              ValueRow(
                padding: EdgeInsets.zero,
                label: Text(l10n.attendanceThisWeek,
                    style: theme.textTheme.bodyMedium),
                value: Text(
                  child.attendancePercent == null
                      // Null is not zero and not 100: nothing was marked.
                      ? l10n.attendanceNotRecorded
                      : formats.percent(child.attendancePercent!),
                  style: theme.textTheme.titleSmall,
                ),
              ),

              ValueRow(
                padding: EdgeInsets.zero,
                label: Text(l10n.nextPayment, style: theme.textTheme.bodyMedium),
                secondary: installment == null
                    ? null
                    : Text(
                        _dueLabel(installment, l10n),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: installment.overdue
                              ? theme.colorScheme.error
                              : null,
                        ),
                      ),
                value: installment == null
                    ? Text(l10n.noPaymentDue, style: theme.textTheme.bodySmall)
                    : MoneyText(
                        installment.amount,
                        tone: installment.overdue
                            ? MoneyTone.overdue
                            : MoneyTone.neutral,
                      ),
              ),

              ValueRow(
                padding: EdgeInsets.zero,
                label: Text(l10n.latestGrade, style: theme.textTheme.bodyMedium),
                secondary: child.latestGrade?.subject == null
                    ? null
                    : Text(child.latestGrade!.subject!,
                        style: theme.textTheme.bodySmall),
                value: Text(
                  child.latestGrade?.score == null
                      ? l10n.noGradeYet
                      : '${child.latestGrade!.score}',
                  style: theme.textTheme.titleSmall,
                ),
              ),

              const Divider(),
              Text(l10n.todaySchedule, style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              if (child.today.isEmpty)
                Text(l10n.noLessonsToday, style: theme.textTheme.bodySmall)
              else
                for (final lesson in child.today)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 2),
                    child: Text(
                      <String>[
                        if (lesson.startTime != null) lesson.startTime!,
                        if (lesson.subject != null) lesson.subject!,
                      ].join(' · '),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),

              if (installment != null && onPay != null) ...<Widget>[
                const SizedBox(height: Dimens.gap),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: Dimens.minTapTarget),
                  child: FilledButton(
                    key: Key('pay-${child.id}'),
                    onPressed: () => onPay!(child, installment),
                    child: Text(l10n.nextPayment),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static String _dueLabel(NextInstallment installment, AppLocalizations l10n) =>
      installment.overdue
          ? l10n.daysOverdue(installment.daysRemaining.abs())
          : l10n.daysRemaining(installment.daysRemaining);
}
