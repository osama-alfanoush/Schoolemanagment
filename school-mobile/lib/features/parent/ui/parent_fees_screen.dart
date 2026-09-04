import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../data/parent_finance_repository.dart';
import '../domain/finance.dart';

/// The fee summary plus every child's schedule.
@immutable
class FeesView {
  const FeesView({required this.summary, required this.plans});

  final FeeSummary summary;

  /// Keyed by student, in the order the summary lists them.
  final Map<int, List<InstallmentPlan>> plans;
}

/// What a payment attempt is doing.
enum PaymentPhase { idle, working, succeeded, failed, offline, settled }

/// Drives the fees screen and the payment attempt.
class ParentFeesController extends ChangeNotifier {
  ParentFeesController({required this.repository});

  final ParentFinanceRepository repository;

  ScreenState<FeesView> _state = const ScreenLoading<FeesView>();
  PaymentPhase _phase = PaymentPhase.idle;
  PaymentIntent? _intent;
  int? _payingInstallmentId;

  ScreenState<FeesView> get state => _state;

  PaymentPhase get phase => _phase;

  PaymentIntent? get intent => _intent;

  /// The installment a payment is currently running for, if any.
  int? get payingInstallmentId => _payingInstallmentId;

  Future<void> load() async {
    try {
      final summary = await repository.summary();
      final plans = <int, List<InstallmentPlan>>{};

      for (final child in summary.children) {
        plans[child.studentUserId] =
            await repository.installmentsFor(child.studentUserId);
      }

      _state = summary.children.isEmpty
          ? const ScreenEmpty<FeesView>()
          : ScreenData<FeesView>(FeesView(summary: summary, plans: plans));
    } on ApiError catch (error) {
      _state = ScreenError<FeesView>(error);
    }

    notifyListeners();
  }

  /// Starts — or retries — the payment for [installment].
  ///
  /// The idempotency key lives in the repository and is reused across retries,
  /// so a tap that times out and a tap that follows it are one payment.
  Future<void> pay(InstallmentLine installment, {bool isOffline = false}) async {
    if (_phase == PaymentPhase.working) return;

    if (isOffline) {
      // Deliberately not queued. A payment replayed hours later against a
      // balance that has moved is a charge nobody authorised.
      _set(PaymentPhase.offline, installmentId: installment.id);

      return;
    }

    _set(PaymentPhase.working, installmentId: installment.id);

    try {
      _intent = await repository.createIntent(installment.id);
      _set(PaymentPhase.succeeded, installmentId: installment.id);
      await load();
    } on ApiError catch (error) {
      _set(
        error is ValidationError ? PaymentPhase.settled : PaymentPhase.failed,
        installmentId: installment.id,
      );
    }
  }

  void dismissPaymentResult() => _set(PaymentPhase.idle);

  void _set(PaymentPhase phase, {int? installmentId}) {
    _phase = phase;
    _payingInstallmentId = phase == PaymentPhase.idle ? null : installmentId;
    notifyListeners();
  }
}

/// The screen that justifies the app to the school owner.
///
/// Paying is three taps from the home screen and two from here: **Pay**, then
/// **Confirm**. The confirmation is not ceremony — it is the last point at
/// which the amount is on screen next to the child's name, which is what stops
/// the wrong installment being paid.
class ParentFeesScreen extends StatefulWidget {
  const ParentFeesScreen({
    required this.controller,
    this.isOffline = false,
    this.onOpenInvoices,
    super.key,
  });

  final ParentFeesController controller;
  final bool isOffline;
  final VoidCallback? onOpenInvoices;

  @override
  State<ParentFeesScreen> createState() => _ParentFeesScreenState();
}

class _ParentFeesScreenState extends State<ParentFeesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  Future<void> _confirmAndPay(ChildBalance child, InstallmentLine line) async {
    final l10n = AppLocalizations.of(context);

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(Dimens.gapLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.payConfirmTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Dimens.gap),
              // The amount beside the child's name, one last time.
              ValueRow(
                padding: EdgeInsets.zero,
                label: Text(child.name),
                value: MoneyText(line.outstanding),
              ),
              const SizedBox(height: Dimens.gapLarge),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: FilledButton(
                  key: const Key('pay-confirm'),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(l10n.payConfirmAction),
                ),
              ),
              const SizedBox(height: Dimens.gapSmall),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.cancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true) {
      await widget.controller.pay(line, isOffline: widget.isOffline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<FeesView>(
        title: l10n.feesTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.load,
        isOffline: widget.isOffline,
        emptyBody: l10n.feesNothingDue,
        actions: <Widget>[
          if (widget.onOpenInvoices != null)
            IconButton(
              key: const Key('open-invoices'),
              tooltip: l10n.invoicesTitle,
              icon: const Icon(Icons.receipt_long_outlined),
              onPressed: widget.onOpenInvoices,
            ),
        ],
        builder: (context, view) => ListView(
          padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
          children: <Widget>[
            _BalanceHeader(summary: view.summary),
            if (widget.controller.phase != PaymentPhase.idle &&
                widget.controller.phase != PaymentPhase.working)
              _PaymentOutcome(controller: widget.controller),
            for (final child in view.summary.children)
              _ChildFees(
                child: child,
                plans: view.plans[child.studentUserId] ?? const <InstallmentPlan>[],
                busyInstallmentId:
                    widget.controller.phase == PaymentPhase.working
                        ? widget.controller.payingInstallmentId
                        : null,
                onPay: (line) => _confirmAndPay(child, line),
              ),
          ],
        ),
      ),
    );
  }
}

class _BalanceHeader extends StatelessWidget {
  const _BalanceHeader({required this.summary});

  final FeeSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(Dimens.gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.feesBalance, style: theme.textTheme.labelLarge),
          const SizedBox(height: 4),
          MoneyText(
            key: const Key('fees-balance'),
            summary.totalOutstanding,
            tone: summary.overdueCount > 0
                ? MoneyTone.overdue
                : MoneyTone.neutral,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: Dimens.gap),
          ValueRow(
            padding: EdgeInsets.zero,
            label: Text(l10n.feesBilled, style: theme.textTheme.bodyMedium),
            value: MoneyText(summary.total, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _PaymentOutcome extends StatelessWidget {
  const _PaymentOutcome({required this.controller});

  final ParentFeesController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final (title, body, tone) = switch (controller.phase) {
      PaymentPhase.offline => (
          l10n.payOfflineTitle,
          l10n.payOfflineBody,
          theme.colorScheme.tertiaryContainer,
        ),
      PaymentPhase.failed => (
          l10n.payFailed,
          '',
          theme.colorScheme.errorContainer,
        ),
      PaymentPhase.settled => (
          l10n.payAlreadySettled,
          '',
          theme.colorScheme.secondaryContainer,
        ),
      PaymentPhase.succeeded => (
          l10n.payStarted,
          '${l10n.paymentReference}: ${controller.intent?.reference ?? ''}',
          theme.colorScheme.secondaryContainer,
        ),
      _ => ('', '', theme.colorScheme.surface),
    };

    return Semantics(
      liveRegion: true,
      child: Container(
        key: const Key('payment-outcome'),
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.gutter,
        ),
        padding: const EdgeInsetsDirectional.all(Dimens.gap),
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(Dimens.gapSmall),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: theme.textTheme.titleSmall),
            if (body.isNotEmpty)
              Text(body, style: theme.textTheme.bodySmall),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                key: const Key('payment-outcome-dismiss'),
                onPressed: controller.dismissPaymentResult,
                child: Text(l10n.later),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChildFees extends StatelessWidget {
  const _ChildFees({
    required this.child,
    required this.plans,
    required this.onPay,
    this.busyInstallmentId,
  });

  final ChildBalance child;
  final List<InstallmentPlan> plans;
  final void Function(InstallmentLine line) onPay;
  final int? busyInstallmentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);

    return Card(
      key: Key('fees-child-${child.studentUserId}'),
      margin: const EdgeInsetsDirectional.fromSTEB(
        Dimens.gutter,
        Dimens.gap,
        Dimens.gutter,
        0,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(Dimens.gutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(child.name, style: theme.textTheme.titleMedium),
            ValueRow(
              padding: EdgeInsets.zero,
              label: Text(l10n.feesBalance, style: theme.textTheme.bodyMedium),
              value: MoneyText(
                child.outstanding,
                tone: child.overdueCount > 0
                    ? MoneyTone.overdue
                    : MoneyTone.neutral,
              ),
            ),
            const Divider(),
            Text(l10n.feesSchedule, style: theme.textTheme.labelLarge),
            for (final plan in plans) ...<Widget>[
              if (!plan.reconciles)
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
                  child: Text(
                    key: const Key('schedule-mismatch'),
                    l10n.feesScheduleMismatch,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              for (final line in plan.installments)
                ValueRow(
                  key: Key('installment-${line.id}'),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
                  label: Text(
                    line.dueDate == null
                        ? '#${formats.integer(line.sequenceNo)}'
                        : formats.shortDate(line.dueDate!),
                    style: theme.textTheme.bodyMedium,
                  ),
                  secondary: line.overdue
                      ? Text(
                          l10n.daysOverdue(line.daysRemaining.abs()),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.error),
                        )
                      : null,
                  // Wrap, not Row: at 200% text scale an amount and a button
                  // side by side do not fit on a phone, and a Row there
                  // overflows rather than moving the button under the amount.
                  value: Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: Dimens.gapSmall,
                    runSpacing: Dimens.gapSmall,
                    children: <Widget>[
                      MoneyText(
                        line.outstanding,
                        tone: line.overdue
                            ? MoneyTone.overdue
                            : MoneyTone.neutral,
                      ),
                      if (line.payable)
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.minTapTarget,
                          ),
                          child: FilledButton(
                            key: Key('pay-installment-${line.id}'),
                            onPressed: busyInstallmentId == line.id
                                ? null
                                : () => onPay(line),
                            child: busyInstallmentId == line.id
                                ? const SizedBox.square(
                                    dimension: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(l10n.payAction),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
