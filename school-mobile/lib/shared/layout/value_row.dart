import 'package:flutter/material.dart';

import 'dimens.dart';

/// A label with a value beside it — a fee line, a grade, a due date.
///
/// Exists because `ListTile` does not survive this app's content. Put a money
/// amount in a `ListTile.trailing` and set the system text scale to 200% — the
/// setting an older parent actually uses — and the tile throws: the trailing
/// widget consumes the whole width and the title has nowhere to go. Every fee
/// row in the app is exactly that shape, so the layout is solved once here
/// rather than clipped on each screen.
///
/// Above a modest scale the row becomes a column. Wrapping is the only thing
/// that works: an Arabic label plus a three-decimal amount will not fit side by
/// side on a phone at 200%, however the space is divided.
class ValueRow extends StatelessWidget {
  const ValueRow({
    required this.label,
    required this.value,
    this.secondary,
    this.leading,
    this.onTap,
    this.padding = const EdgeInsetsDirectional.symmetric(
      horizontal: Dimens.gutter,
      vertical: Dimens.gap,
    ),
    super.key,
  });

  /// Usually a [Text]. Takes the remaining width in row form.
  final Widget label;

  /// Usually a `MoneyText` or a `DateText`.
  final Widget value;

  /// Optional second line under the label — a due date, a subject name.
  final Widget? secondary;

  final Widget? leading;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// Beyond this scale the row stacks. 1.3 is where a label and a
  /// three-decimal JOD amount stop fitting together on a 360dp phone.
  static const double stackAboveTextScale = 1.3;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
    final stacked = scale > stackAboveTextScale;

    final content = Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (leading != null) ...<Widget>[
            leading!,
            const SizedBox(width: Dimens.gap),
          ],
          Expanded(
            child: stacked
                ? Column(
                    // Without this the column takes the whole viewport height
                    // and drags the row with it, which puts the amount in the
                    // middle of the screen instead of beside its label.
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      label,
                      if (secondary != null) ...<Widget>[
                        const SizedBox(height: 2),
                        secondary!,
                      ],
                      const SizedBox(height: Dimens.gapSmall),
                      value,
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            label,
                            if (secondary != null) ...<Widget>[
                              const SizedBox(height: 2),
                              secondary!,
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimens.gap),
                      Flexible(child: value),
                    ],
                  ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.minTapTarget),
        child: content,
      );
    }

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.minTapTarget),
        child: content,
      ),
    );
  }
}
