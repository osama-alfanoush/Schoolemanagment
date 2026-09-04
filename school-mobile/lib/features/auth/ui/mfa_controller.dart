import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';
import '../domain/login_result.dart';
import '../domain/mfa_failure.dart';

/// Which credential the user is entering.
enum MfaCredential { authenticatorCode, recoveryCode }

@immutable
class MfaState {
  const MfaState({
    this.credential = MfaCredential.authenticatorCode,
    this.submitting = false,
    this.failure,
  });

  final MfaCredential credential;
  final bool submitting;
  final MfaFailure? failure;

  MfaState copyWith({
    MfaCredential? credential,
    bool? submitting,
    MfaFailure? failure,
    bool clearFailure = false,
  }) =>
      MfaState(
        credential: credential ?? this.credential,
        submitting: submitting ?? this.submitting,
        failure: clearFailure ? null : (failure ?? this.failure),
      );
}

/// Drives the two-factor challenge screen.
class MfaController extends ChangeNotifier {
  MfaController({required this.repository, required this.challenge});

  final AuthRepository repository;

  /// The short-lived grant this screen exists to spend. Held in memory only.
  final LoginNeedsMfa challenge;

  MfaState _state = const MfaState();

  MfaState get state => _state;

  void useRecoveryCode() =>
      _set(_state.copyWith(credential: MfaCredential.recoveryCode, clearFailure: true));

  void useAuthenticatorCode() => _set(_state.copyWith(
        credential: MfaCredential.authenticatorCode,
        clearFailure: true,
      ));

  void inputChanged() {
    if (_state.failure == null) return;

    _set(_state.copyWith(clearFailure: true));
  }

  Future<void> submit(String value) async {
    if (_state.submitting) return;

    _set(_state.copyWith(submitting: true, clearFailure: true));

    try {
      final entry = value.trim();
      await repository.completeMfaChallenge(
        challengeToken: challenge.challengeToken,
        code: _state.credential == MfaCredential.authenticatorCode ? entry : null,
        recoveryCode:
            _state.credential == MfaCredential.recoveryCode ? entry : null,
      );

      // On success the session controller has already moved; this screen is
      // about to be replaced, so nothing else needs setting here.
      _set(const MfaState());
    } on MfaFailure catch (failure) {
      _set(MfaState(credential: _state.credential, failure: failure));
    }
  }

  void _set(MfaState next) {
    _state = next;
    notifyListeners();
  }
}
