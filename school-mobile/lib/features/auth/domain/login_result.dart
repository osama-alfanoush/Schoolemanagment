import 'package:flutter/foundation.dart';

/// What the server said about a login attempt.
///
/// Sealed rather than a nullable-field record: the MFA branch and the
/// signed-in branch carry different things, and a `switch` over this cannot
/// silently skip the MFA case the way an `if (mfaToken != null)` can.
sealed class LoginResult {
  const LoginResult();
}

/// Signed in. Tokens are already persisted by the time this is returned.
class LoginSucceeded extends LoginResult {
  const LoginSucceeded({
    required this.mustChangePassword,
    required this.user,
  });

  /// A temporary password. The app is blocked until it is changed — the same
  /// rule the web client enforces.
  final bool mustChangePassword;

  /// The `user` object as the server returned it.
  final Map<String, Object?> user;
}

/// The account requires a second factor. No session exists yet.
///
/// The challenge token is short-lived and can do nothing but complete the
/// challenge — it is not an access token and is deliberately not persisted
/// here. Completing the challenge belongs to the MFA order.
class LoginNeedsMfa extends LoginResult {
  const LoginNeedsMfa({
    required this.challengeToken,
    required this.enrollmentRequired,
    required this.expiresIn,
  });

  final String challengeToken;

  /// True when the account has never enrolled and must set MFA up first.
  final bool enrollmentRequired;

  final Duration expiresIn;
}

/// Why a login attempt did not produce a session.
///
/// The server deliberately does not distinguish a wrong password from a
/// deactivated account — both come back as the same message, so an attacker
/// cannot use the login form to discover which emails are registered. This
/// enum keeps that property: there is no `accountInactive` case to leak.
enum LoginFailureKind {
  /// Wrong email, wrong password, or a deactivated account. Indistinguishable
  /// by design.
  invalidCredentials,

  /// Locked after repeated failures. Carries the wait in [LoginFailure.retryIn].
  accountLocked,

  /// The login rate limiter rejected the request. Not the same as a lockout:
  /// this one is about request volume, not this account's failures.
  tooManyAttempts,

  /// Authenticated, but the account has no active school assignment, so no
  /// token can be issued for it.
  noSchoolAccess,

  /// The device id could not be provisioned, so no attempt was made.
  ///
  /// The request is not sent without one. The server binds refresh-token
  /// families to the device id and revokes by that binding, so a session
  /// established without it could never be revoked remotely.
  deviceNotReady,

  offline,

  server,

  unknown,
}

/// A login attempt that failed, in a form the UI can render.
///
/// Carries no credential material: not the password, not the email, not a
/// token. [requestId] is the server's correlation id so support can find the
/// request.
@immutable
class LoginFailure implements Exception {
  const LoginFailure(this.kind, {this.retryIn, this.requestId});

  final LoginFailureKind kind;

  /// How long until another attempt is worth making, when the server said.
  final Duration? retryIn;

  final String? requestId;

  /// Whole minutes to wait, rounded up, for the lockout message.
  int get retryInMinutes {
    final wait = retryIn;
    if (wait == null || wait.inSeconds <= 0) return 0;

    return (wait.inSeconds / Duration.secondsPerMinute).ceil();
  }

  @override
  String toString() => 'LoginFailure(${kind.name})';
}
