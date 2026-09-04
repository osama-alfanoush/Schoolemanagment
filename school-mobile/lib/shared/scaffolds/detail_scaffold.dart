import 'package:flutter/material.dart';

import '../../core/sync/sync_status.dart';
import '../layout/dimens.dart';
import '../state/state_views.dart';
import '../status/offline_banner.dart';
import '../status/pending_sync_badge.dart';
import 'list_scaffold.dart';

/// The standard detail screen: one record, optionally with an action pinned to
/// the bottom.
///
/// The action bar is pinned rather than left at the end of the content because
/// the actions here are the ones people came for — pay this installment,
/// submit this attendance — and a button below the fold on a long invoice is a
/// button nobody presses.
class DetailScaffold<T> extends StatelessWidget {
  const DetailScaffold({
    required this.title,
    required this.state,
    required this.builder,
    this.onRefresh,
    this.actions,
    this.isOffline = false,
    this.syncStatus,
    this.lastUpdatedLabel,
    this.bottomAction,
    this.emptyTitle,
    this.emptyBody,
    super.key,
  });

  final String title;
  final ScreenState<T> state;

  /// Builds the record's body. Unlike [ListScaffold] this may return plain
  /// widgets: the scaffold provides the scroll view.
  final Widget Function(BuildContext context, T value) builder;

  final Future<void> Function()? onRefresh;
  final List<Widget>? actions;
  final bool isOffline;
  final SyncStatus? syncStatus;
  final String? lastUpdatedLabel;

  /// Pinned above the system navigation. Sized to the minimum tap target.
  final Widget? bottomAction;

  final String? emptyTitle;
  final String? emptyBody;

  @override
  Widget build(BuildContext context) {
    final status = syncStatus;
    final lastUpdated = lastUpdatedLabel;
    final action = bottomAction;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (status != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: Dimens.gapSmall),
              child: PendingSyncBadge(status: status),
            ),
          ...?actions,
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            OfflineBanner(isOffline: isOffline),
            if (lastUpdated != null) StalenessLabel(formattedTime: lastUpdated),
            Expanded(child: _withRefresh(_content(context))),
          ],
        ),
      ),
      bottomNavigationBar: action == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.all(Dimens.gutter),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: Dimens.minTapTarget),
                child: action,
              ),
            ),
    );
  }

  Widget _content(BuildContext context) => switch (state) {
        ScreenLoading<T>() => const LoadingView(),
        ScreenError<T>(error: final error) =>
          ErrorView(error: error, onRetry: onRefresh),
        ScreenEmpty<T>() => EmptyView(title: emptyTitle, body: emptyBody),
        ScreenData<T>(value: final value) => LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsetsDirectional.all(Dimens.gutter),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - Dimens.gutter * 2,
                ),
                child: builder(context, value),
              ),
            ),
          ),
      };

  Widget _withRefresh(Widget content) {
    final refresh = onRefresh;
    if (refresh == null) return content;

    return RefreshIndicator(
      key: const Key('pull-to-refresh'),
      onRefresh: refresh,
      child: content,
    );
  }
}
