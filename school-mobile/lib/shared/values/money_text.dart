import 'package:flutter/material.dart';

import '../../core/i18n/i18n_scope.dart';
import '../../core/i18n/money.dart';

/// How an amount reads on screen.
enum MoneyTone {
  /// Ordinary amount.
  neutral,

  /// Money owed, past its due date.
  overdue,

  /// Money already settled.
  settled,
}

/// Renders an exact amount.
///
/// Takes a [Money] and nothing else. There is deliberately no `double` and no
/// `String` constructor: an amount that reached a widget as a double already
/// lost a fil somewhere upstream, and a pre-formatted string would sidestep the
/// user's digit-shape preference. Both are the kind of mistake that only shows
/// up on an invoice a parent is holding.
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.amount, {
    this.tone = MoneyTone.neutral,
    this.style,
    this.showCurrency = true,
    this.textAlign,
    super.key,
  });

  final Money amount;
  final MoneyTone tone;
  final TextStyle? style;
  final bool showCurrency;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);
    final formatted = formats.money(amount, showCurrency: showCurrency);

    final base = style ?? theme.textTheme.titleMedium;
    final coloured = switch (tone) {
      MoneyTone.neutral => base,
      MoneyTone.overdue => base?.copyWith(color: theme.colorScheme.error),
      MoneyTone.settled => base?.copyWith(color: theme.colorScheme.primary),
    };

    return Text(
      formatted,
      textAlign: textAlign,
      style: coloured?.copyWith(
        // Amounts in a column line up only with tabular figures; a ragged
        // fee schedule is hard to scan and easy to misread.
        fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
      ),
    );
  }
}
