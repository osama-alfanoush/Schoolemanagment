import 'package:flutter/material.dart';

import '../../core/api/api_error.dart';
import '../../core/sync/sync_status.dart';
import '../layout/dimens.dart';
import '../state/state_views.dart';
import '../status/offline_banner.dart';
import '../status/pending_sync_badge.dart';

/// What a screen currently has to show.
///
/// Sealed so a screen cannot forget a case: adding a state here makes every
/// `switch` over it fail to compile until it has been handled, which is how
/// "we never built the error state" gets caught before a pilot does.
sealed class ScreenState<T> {
  const ScreenState();
}

class ScreenLoading<T> extends ScreenState<T> {
  const ScreenLoading();
}

class ScreenError<T> extends ScreenState<T> {
  const ScreenError(this.error);

  final ApiError error;
}

class ScreenEmpty<T> extends ScreenState<T> {
  const ScreenEmpty();
}

class ScreenData<T> extends ScreenState<T> {
  const ScreenData(this.value);

  final T value;
}

/// The standard list screen: app bar, offline banner, staleness label, sync
/// badge, pull-to-refresh, and one of loading / empty / error / content.
///
/// Assembled once so every list in the app shows the same thing in the same
/// place. The refresh gesture is always attached, even over the empty and error
/// states — an error screen you cannot pull to retry is a dead end, and that is
/// the moment a user closes the app.
class ListScaffold<T> extends StatelessWidget {
  const ListScaffold({
    required this.title,
    required this.state,
    required this.builder,
    this.onRefresh,
    this.actions,
    this.isOffline = false,
    this.syncStatus,
    this.lastUpdatedLabel,
    this.emptyTitle,
    this.emptyBody,
    this.floatingActionButton,
    super.key,
  });

  final String title;
  final ScreenState<T> state;

  /// Builds the content for [ScreenData].
  ///
  /// Must return a scrollable — a `ListView`, a `CustomScrollView`. It is
  /// placed directly inside the refresh gesture, which needs a scrollable
  /// descendant to attach to, and wrapping it here instead would nest two
  /// scroll views and break every long list in the app.
  final Widget Function(BuildContext context, T value) builder;

  final Future<void> Function()? onRefresh;
  final List<Widget>? actions;
  final bool isOffline;
  final SyncStatus? syncStatus;

  /// Already formatted by `AppFormats`, so its digits follow the preference.
  final String? lastUpdatedLabel;

  final String? emptyTitle;
  final String? emptyBody;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final status = syncStatus;
    final lastUpdated = lastUpdatedLabel;

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
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            OfflineBanner(isOffline: isOffline),
            if (lastUpdated != null) StalenessLabel(formattedTime: lastUpdated),
            Expanded(child: _withRefresh(_content(context))),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) => switch (state) {
        ScreenLoading<T>() => const LoadingView(),
        ScreenError<T>(error: final error) => ErrorView(
            error: error,
            onRetry: onRefresh,
          ),
        ScreenEmpty<T>() => EmptyView(title: emptyTitle, body: emptyBody),
        ScreenData<T>(value: final value) => builder(context, value),
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
