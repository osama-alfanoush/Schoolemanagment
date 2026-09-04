import 'package:flutter/material.dart';

import '../../../core/api/api_error.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/parent_finance_repository.dart';
import '../domain/finance.dart';

/// Drives one invoice.
class InvoiceDetailController extends ChangeNotifier {
  InvoiceDetailController({required this.repository, required this.invoiceId});

  final ParentFinanceRepository repository;
  final int invoiceId;

  ScreenState<InvoiceDetail> _state = const ScreenLoading<InvoiceDetail>();

  ScreenState<InvoiceDetail> get state => _state;

  Future<void> load() async {
    try {
      final invoice = await repository.invoice(invoiceId);
      _state = invoice == null
          ? const ScreenEmpty<InvoiceDetail>()
          : ScreenData<InvoiceDetail>(invoice);
    } on ApiError catch (error) {
      _state = ScreenError<InvoiceDetail>(error);
    }

    notifyListeners();
  }
}

/// One invoice, with its e-invoicing clearance state.
///
/// The QR is shown **only** when the authority has cleared the invoice and
/// returned one. There is no fallback that draws a code from the invoice's own
/// fields: such a code would scan, look official, and verify against nothing —
/// which is worse than no code, because a parent would believe it.
class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({
    required this.controller,
    this.isOffline = false,
    this.onDownloadReceipt,
    super.key,
  });

  final InvoiceDetailController controller;
  final bool isOffline;
  final VoidCallback? onDownloadReceipt;

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
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
      builder: (context, _) => DetailScaffold<InvoiceDetail>(
        title: l10n.invoiceTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.load,
        isOffline: widget.isOffline,
        bottomAction: widget.onDownloadReceipt == null
            ? null
            : FilledButton.icon(
                key: const Key('download-receipt'),
                onPressed: widget.onDownloadReceipt,
                icon: const Icon(Icons.download_outlined),
                label: Text(l10n.downloadReceipt),
              ),
        builder: (context, invoice) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(invoice.invoiceNo, style: theme.textTheme.titleMedium),
            if (invoice.description != null)
              Text(invoice.description!, style: theme.textTheme.bodyMedium),
            const SizedBox(height: Dimens.gap),
            ValueRow(
              padding: EdgeInsets.zero,
              label: Text(l10n.feesBilled, style: theme.textTheme.bodyMedium),
              value: MoneyText(invoice.amount),
            ),
            ValueRow(
              padding: EdgeInsets.zero,
              label: Text(l10n.feesPaid, style: theme.textTheme.bodyMedium),
              value: MoneyText(invoice.paid, tone: MoneyTone.settled),
            ),
            ValueRow(
              padding: EdgeInsets.zero,
              label: Text(l10n.feesBalance, style: theme.textTheme.bodyMedium),
              value: MoneyText(
                key: const Key('invoice-outstanding'),
                invoice.outstanding,
                tone: invoice.outstanding.minor > 0
                    ? MoneyTone.overdue
                    : MoneyTone.settled,
              ),
            ),
            const Divider(height: Dimens.gapLarge),
            _ClearanceBlock(invoice: invoice),
          ],
        ),
      ),
    );
  }
}

class _ClearanceBlock extends StatelessWidget {
  const _ClearanceBlock({required this.invoice});

  final InvoiceDetail invoice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final label = switch (invoice.clearance) {
      ClearanceState.cleared => l10n.clearanceCleared,
      ClearanceState.rejected => l10n.clearanceRejected,
      // Unknown is reported as pending rather than guessed at. An invoice the
      // client cannot classify has certainly not been proven cleared.
      ClearanceState.pending || ClearanceState.unknown => l10n.clearancePending,
    };

    return Column(
      key: const Key('clearance-block'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(l10n.clearanceTitle, style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            Icon(
              invoice.clearance == ClearanceState.cleared
                  ? Icons.verified_outlined
                  : Icons.hourglass_empty,
              size: 20,
              color: invoice.clearance == ClearanceState.rejected
                  ? theme.colorScheme.error
                  : theme.colorScheme.outline,
            ),
            const SizedBox(width: Dimens.gapSmall),
            Expanded(
              child: Text(
                key: const Key('clearance-state'),
                label,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.gapSmall),
        if (invoice.showsQr)
          // The authority's payload, rendered as text. Nothing is generated
          // locally, and nothing is shown when the invoice is not cleared.
          SelectableText(
            key: const Key('clearance-qr'),
            invoice.qr!,
            textDirection: TextDirection.ltr,
            style: theme.textTheme.bodySmall,
          )
        else
          Text(
            key: const Key('clearance-no-qr'),
            l10n.clearanceNoQrYet,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
      ],
    );
  }
}
