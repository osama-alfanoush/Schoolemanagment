import 'package:flutter/foundation.dart';

import '../data/auth_repository.dart';
import '../domain/login_result.dart';

/// What the login screen is doing and what it last heard back.
///
/// Deliberately holds no password. The field's text lives in its
/// `TextEditingController` and is read once, at submit; keeping a copy here
/// would put it in every state snapshot and, from there, into anything that
/// prints one.
@immutable
class LoginState {
  const LoginState({
    this.submitting = false,
    this.failure,
    this.challenge,
  });

  final bool submitting;
  final LoginFailure? failure;

  /// Set when the account needs a second factor. The MFA order picks this up.
  final LoginNeedsMfa? challenge;

  LoginState copyWith({
    bool? submitting,
    LoginFailure? failure,
    bool clearFailure = false,
    LoginNeedsMfa? challenge,
    bool clearChallenge = false,
  }) =>
      LoginState(
        submitting: submitting ?? this.submitting,
        failure: clearFailure ? null : (failure ?? this.failure),
        challenge: clearChallenge ? null : (challenge ?? this.challenge),
      );
}

/// Drives the login screen.
class LoginController extends ChangeNotifier {
  LoginController({required this.repository});

  final AuthRepository repository;

  LoginState _state = const LoginState();

  LoginState get state => _state;

  /// Clears a previous failure as soon as the user edits the form, so a stale
  /// "wrong password" is not still on screen while they retype.
  void inputChanged() {
    if (_state.failure == null) return;

    _set(_state.copyWith(clearFailure: true));
  }

  /// Back to a blank form: no failure, no outstanding challenge.
  void reset() => _set(const LoginState());

  Future<void> submit({required String email, required String password}) async {
    if (_state.submitting) return;

    _set(const LoginState(submitting: true));

    try {
      final result = await repository.signIn(email: email, password: password);

      _set(LoginState(
        challenge: result is LoginNeedsMfa ? result : null,
      ));
    } on LoginFailure catch (failure) {
      // Only the typed failure is kept. Nothing from the request — not the
      // email, not the password, not a token — reaches this state object.
      _set(LoginState(failure: failure));
    }
  }

  void _set(LoginState next) {
    _state = next;
    notifyListeners();
  }
}
