import 'package:flutter/foundation.dart';

/// Why an activation code did not open a session.
enum ActivationFailureKind {
  /// Unknown, spent, expired, or burned by too many guesses. The server
  /// answers all four identically so the endpoint cannot be used to discover
  /// which codes exist, and this client does not pretend to know better.
  codeRejected,

  /// The account activated, but has no active school assignment.
  noSchoolAccess,

  /// The rate limiter refused the attempt.
  tooManyAttempts,

  /// No device id could be provisioned, so nothing was sent.
  deviceNotReady,

  offline,

  server,
}

/// A failed activation, carrying its kind and the server's correlation id.
/// Never the code.
@immutable
class ActivationFailure implements Exception {
  const ActivationFailure(this.kind, {this.requestId});

  final ActivationFailureKind kind;
  final String? requestId;

  @override
  String toString() => 'ActivationFailure(${kind.name})';
}
