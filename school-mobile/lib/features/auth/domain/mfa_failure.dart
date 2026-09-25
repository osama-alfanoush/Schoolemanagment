import 'package:flutter/foundation.dart';

/// Why a two-factor challenge did not produce a session.
enum MfaFailureKind {
  /// Wrong TOTP code or wrong recovery code. Try again.
  invalidCode,

  /// The short-lived challenge grant has expired or was already spent.
  /// Trying again will not help; the user has to sign in from the start.
  challengeExpired,

  /// The account requires MFA but has never finished enrolling.
  enrollmentIncomplete,

  tooManyAttempts,

  offline,

  server,
}

/// A failed two-factor attempt, carrying nothing but its kind and the server's
/// correlation id. Never the code, never a token.
@immutable
class MfaFailure implements Exception {
  const MfaFailure(this.kind, {this.requestId});

  final MfaFailureKind kind;
  final String? requestId;

  /// True when the user has to start again from the sign-in form rather than
  /// retype a code.
  bool get needsFreshSignIn =>
      kind == MfaFailureKind.challengeExpired ||
      kind == MfaFailureKind.enrollmentIncomplete;

  @override
  String toString() => 'MfaFailure(${kind.name})';
}

/// Why a password change did not go through.
enum PasswordChangeFailureKind {
  /// The current password was wrong.
  currentPasswordIncorrect,

  /// The new password did not satisfy the server's rules.
  newPasswordRejected,

  offline,

  server,
}

@immutable
class PasswordChangeFailure implements Exception {
  const PasswordChangeFailure(this.kind, {this.serverMessage, this.requestId});

  final PasswordChangeFailureKind kind;

  /// The server's own rule text for a rejected new password.
  ///
  /// Shown only for [PasswordChangeFailureKind.newPasswordRejected], where the
  /// server knows a rule the client does not. Every other case is a translated
  /// sentence, because a raw English string in an Arabic app is a support call.
  final String? serverMessage;

  final String? requestId;

  @override
  String toString() => 'PasswordChangeFailure(${kind.name})';
}
