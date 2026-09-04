/// The shared UI kit: the states, banners, badges, scaffolds and value widgets
/// every screen is built from.
///
/// Everything here is presentation only. Nothing fetches, nothing writes, and
/// nothing reaches for a platform plugin — connectivity, sync status and
/// formatting all arrive as arguments or through `AppI18nScope`, so each piece
/// can be pumped in a widget test in both locales without a device.
library;

export 'layout/dimens.dart';
export 'layout/value_row.dart';
export 'scaffolds/detail_scaffold.dart';
export 'scaffolds/list_scaffold.dart';
export 'state/state_views.dart';
export 'status/offline_banner.dart';
export 'status/pending_sync_badge.dart';
export 'values/date_text.dart';
export 'values/money_text.dart';
