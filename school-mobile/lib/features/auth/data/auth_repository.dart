import '../../../core/api/token_store.dart';
import '../../../core/session/session.dart';
import '../domain/login_result.dart';
import 'auth_api.dart';
import 'mfa_api.dart';
import 'password_api.dart';

/// Turns an authenticated call into a [SessionController] state change.
///
/// The one place that decides "there is a user now", so nothing else has to
/// know how a `user` payload becomes an [AppSession].
class AuthRepository {
  AuthRepository({
    required this.api,
    required this.tokenStore,
    required this.controller,
    this.localData,
    MfaApi? mfa,
    PasswordApi? passwords,
  })  : mfa = mfa ?? MfaApi(dio: api.dio, tokenStore: tokenStore),
        passwords = passwords ??
            PasswordApi(dio: api.dio, tokenStore: tokenStore);

  final AuthApi api;
  final MfaApi mfa;
  final PasswordApi passwords;
  final TokenStore tokenStore;
  final SessionController controller;

  /// Who this device's cached data belongs to.
  ///
  /// Optional so the auth layer can be exercised without a database, but in
  /// the real app it is always present: without it, a school tablet carries
  /// one family's records into the next family's session.
  final LocalDataOwner? localData;

  /// What the last sign-in did to data already on the device.
  ///
  /// Read by the UI after a sign-in so a discarded queue can be reported. Null
  /// until a sign-in has happened.
  LocalDataClaim? get lastClaim => _lastClaim;
  LocalDataClaim? _lastClaim;

  /// Signs in and, on success, moves the controller to signed-in.
  ///
  /// An MFA challenge is returned rather than applied: no session exists until
  /// the second factor is satisfied, and putting the user into a shell here
  /// would be exactly the bypass the challenge is there to prevent.
  Future<LoginResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await api.login(email: email, password: password);

    if (result is LoginSucceeded) {
      controller.signedIn(
        sessionFrom(result.user),
        mustChangePassword: result.mustChangePassword,
      );
      await _claimDevice(result.user);
    }

    return result;
  }

  /// Answers a two-factor challenge and, on success, opens the session.
  ///
  /// The challenge response carries tokens but no user, so the user is fetched
  /// afterwards. Until that returns there is deliberately no session: a shell
  /// rendered from a half-known user is how someone sees the wrong child.
  Future<void> completeMfaChallenge({
    required String challengeToken,
    String? code,
    String? recoveryCode,
  }) async {
    await mfa.completeChallenge(
      challengeToken: challengeToken,
      code: code,
      recoveryCode: recoveryCode,
    );

    final user = await api.me();
    controller.signedIn(
      sessionFrom(user),
      mustChangePassword: user['must_change_password'] == true,
    );
    await _claimDevice(user);
  }

  /// Replaces a temporary password and unblocks the app.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await passwords.change(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    controller.passwordChanged();
  }

  /// Ends the session on this device.
  ///
  /// The local wipe happens whether or not the server call succeeds. A user who
  /// taps sign out on a train with no signal must still end up signed out —
  /// leaving their child's records on screen because a request failed is the
  /// wrong way round.
  Future<void> signOut({bool discardUnsentWork = false}) async {
    // Checked before anything is revoked. Signing out is the last moment the
    // person who made those writes is present to be asked about them, and a
    // register queued in a classroom with no signal is exactly the kind of
    // work that is sitting here.
    final owner = localData;
    if (owner != null && !discardUnsentWork) {
      final unsent = await owner.unsentWrites();
      if (unsent > 0) throw UnsentWorkPending(unsent);
    }

    try {
      await api.logout();
    } on LoginFailure {
      // Nothing to do: the local credentials go regardless.
    }

    await tokenStore.clear();

    // The cache stays. It still belongs to this user, and if they sign back in
    // on the same device they should not pay for a cold start; the next
    // *different* user is what clears it, at claim time.
    controller.signedOut();
  }

  /// Clears another user's data from this device, if there is any.
  Future<void> _claimDevice(Map<String, Object?> user) async {
    final owner = localData;
    final userId = int.tryParse('${user['id']}');
    if (owner == null || userId == null) return;

    _lastClaim = await owner.claim(userId);
  }

  /// Restores a session on a cold start.
  ///
  /// The tokens survive a restart; the user object does not, and rendering a
  /// stale copy of it is how someone sees last term's child list. So a stored
  /// token is re-checked against `/auth/me` rather than trusted on its own.
  Future<void> restore() async {
    final token = await tokenStore.readAccessToken();

    if (token == null || token.isEmpty) {
      controller.signedOut();

      return;
    }

    try {
      final user = await api.me();
      controller.signedIn(
        sessionFrom(user),
        // A deactivated account never gets here: EnsureAccountIsActive answers
        // 401 and deletes every token, which surfaces as a LoginFailure below.
        mustChangePassword: user['must_change_password'] == true,
      );
      // A cold start is also a moment where the person holding the phone can
      // have changed -- a token restored on a device someone else last used.
      await _claimDevice(user);
    } on LoginFailure {
      // Includes the token having been revoked from another device.
      controller.signedOut();
    }
  }

  /// Builds a session from the server's `user` object.
  ///
  /// **Known gap:** `/auth/login` and `/auth/me` return a single `role`. The
  /// server can hold several — `school_user_roles` is keyed on
  /// `(school_id, user_id, role)` — but neither endpoint exposes them, so a
  /// teacher whose child attends the school arrives here as a teacher only.
  /// A `roles` array is read when present, so the day bootstrap returns one
  /// this starts working with no change here. Until then the role switcher is
  /// reachable only for accounts the server reports as multi-role.
  static AppSession sessionFrom(Map<String, Object?> user) {
    final roles = user['roles'];

    return AppSession(
      userId: '${user['id'] ?? ''}',
      displayName: '${user['name'] ?? ''}',
      roles: roles is Iterable
          ? AppRole.allFromWire(roles)
          : AppRole.allFromWire(<Object?>[user['role']]),
    );
  }
}

/// Raised when signing out would discard writes the server has not accepted.
///
/// The count, not the content: what was queued is the user's own data and does
/// not belong in an exception, a log or a crash report.
class UnsentWorkPending implements Exception {
  const UnsentWorkPending(this.count);

  final int count;

  @override
  String toString() => 'UnsentWorkPending($count)';
}
