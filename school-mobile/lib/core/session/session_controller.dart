import 'package:flutter/foundation.dart';

import 'app_role.dart';
import 'app_session.dart';
import 'app_version.dart';

/// Whether anyone is signed in, and whether we have found out yet.
enum SessionStatus {
  /// Startup: the token store has not been read. Nothing may be routed on this
  /// — a redirect that treats "not yet known" as "signed out" flashes the
  /// login screen at a user who is already signed in.
  unknown,

  signedOut,

  signedIn,
}

/// The whole of what the router needs to decide where the user belongs.
@immutable
class SessionState {
  const SessionState({
    this.status = SessionStatus.unknown,
    this.session,
    this.upgrade = UpgradeRequirement.none,
    this.recommendedUpgradeDismissed = false,
  });

  final SessionStatus status;
  final AppSession? session;
  final UpgradeRequirement upgrade;

  /// The user has waved away the soft-upgrade prompt for this run.
  final bool recommendedUpgradeDismissed;

  bool get isSignedIn => status == SessionStatus.signedIn && session != null;

  bool get mustUpgrade => upgrade == UpgradeRequirement.required;

  bool get shouldSuggestUpgrade =>
      upgrade == UpgradeRequirement.recommended && !recommendedUpgradeDismissed;

  SessionState copyWith({
    SessionStatus? status,
    AppSession? session,
    bool clearSession = false,
    UpgradeRequirement? upgrade,
    bool? recommendedUpgradeDismissed,
  }) =>
      SessionState(
        status: status ?? this.status,
        session: clearSession ? null : (session ?? this.session),
        upgrade: upgrade ?? this.upgrade,
        recommendedUpgradeDismissed:
            recommendedUpgradeDismissed ?? this.recommendedUpgradeDismissed,
      );

  @override
  bool operator ==(Object other) =>
      other is SessionState &&
      other.status == status &&
      other.session == session &&
      other.upgrade == upgrade &&
      other.recommendedUpgradeDismissed == recommendedUpgradeDismissed;

  @override
  int get hashCode =>
      Object.hash(status, session, upgrade, recommendedUpgradeDismissed);
}

/// Holds [SessionState] and tells the router when it moves.
///
/// A plain [ChangeNotifier] rather than a state-management framework: this
/// object is passed straight to `GoRouter.refreshListenable`, and `lib/core/`
/// is frozen at the end of this phase, so it should not commit every later
/// feature to one library's idioms.
class SessionController extends ChangeNotifier {
  SessionController({
    this.currentVersion = const AppVersion(0, 1, 0),
    SessionState initialState = const SessionState(),
  }) : _state = initialState;

  /// The version of this build, compared against the server's policy.
  final AppVersion currentVersion;

  SessionState _state;

  SessionState get state => _state;

  /// The token store has been read and there is nobody signed in.
  void signedOut() => _set(const SessionState(status: SessionStatus.signedOut));

  void signedIn(AppSession session) => _set(_state.copyWith(
        status: SessionStatus.signedIn,
        session: session,
      ));

  /// Show a different one of this user's own roles.
  ///
  /// Deliberately does nothing when the role is not held: a deep link or a
  /// stale button must not be able to put a parent into a teacher shell.
  void switchRole(AppRole role) {
    final current = _state.session;
    if (current == null || !current.holds(role)) return;

    final switched = current.switchedTo(role);
    if (switched == current) return;

    _set(_state.copyWith(session: switched));
  }

  /// Apply the version policy bootstrap returned.
  void applyUpgradePolicy(UpgradePolicy policy) {
    final requirement = policy.evaluate(currentVersion);
    if (requirement == _state.upgrade) return;

    _set(_state.copyWith(
      upgrade: requirement,
      // A newly-raised recommendation is worth showing again.
      recommendedUpgradeDismissed: false,
    ));
  }

  void dismissRecommendedUpgrade() {
    if (_state.recommendedUpgradeDismissed) return;

    _set(_state.copyWith(recommendedUpgradeDismissed: true));
  }

  void _set(SessionState next) {
    if (next == _state) return;

    _state = next;
    notifyListeners();
  }
}
