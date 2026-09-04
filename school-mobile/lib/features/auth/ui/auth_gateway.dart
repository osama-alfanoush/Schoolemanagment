import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/router/router.dart';
import '../data/auth_repository.dart';
import '../data/mfa_api.dart';
import '../domain/login_result.dart';
import 'login_controller.dart';
import 'login_screen.dart';
import 'mfa_challenge_screen.dart';
import 'mfa_controller.dart';

/// Everything that happens before a session exists.
///
/// The sign-in form and the two-factor challenge live behind one route rather
/// than two. A challenge is not a session — the router sends anyone without one
/// to `/login` — so giving MFA its own path would need an exception carved into
/// the redirect, and an exception in a redirect is how a bypass gets built by
/// accident.
class AuthGateway extends StatefulWidget {
  const AuthGateway({required this.repository, super.key});

  final AuthRepository repository;

  @override
  State<AuthGateway> createState() => _AuthGatewayState();
}

class _AuthGatewayState extends State<AuthGateway> {
  late final LoginController _login;
  MfaController? _mfa;

  @override
  void initState() {
    super.initState();
    _login = LoginController(repository: widget.repository)
      ..addListener(_onLoginState);
  }

  @override
  void dispose() {
    _login
      ..removeListener(_onLoginState)
      ..dispose();
    _mfa?.dispose();
    super.dispose();
  }

  void _onLoginState() {
    final challenge = _login.state.challenge;
    if (challenge == null || _mfa?.challenge == challenge) return;

    setState(() {
      _mfa?.dispose();
      _mfa = MfaController(
        repository: widget.repository,
        challenge: challenge,
      );
    });
  }

  /// Drops the challenge grant and returns to the form.
  void _cancelMfa() {
    setState(() {
      _mfa?.dispose();
      _mfa = null;
    });
    _login.reset();
  }

  @override
  Widget build(BuildContext context) {
    final mfa = _mfa;
    if (mfa == null) return LoginScreen(controller: _login);

    // An account that requires MFA but has never enrolled cannot finish here:
    // enrolling means showing a secret and a QR code, which this order does not
    // build. Telling the user where to go is better than a screen that quietly
    // refuses every code they type.
    if (!canCompleteOnDevice(mfa.challenge)) {
      final l10n = AppLocalizations.of(context);

      return MessageScreen(
        key: const Key('mfa-enrollment-required'),
        icon: Icons.shield_outlined,
        title: l10n.mfaEnrollmentRequiredTitle,
        body: l10n.mfaEnrollmentRequiredBody,
        actionLabel: l10n.backToSignIn,
        onAction: _cancelMfa,
      );
    }

    return MfaChallengeScreen(controller: mfa, onCancel: _cancelMfa);
  }
}

/// Convenience for wiring: the challenge a login produced, if any.
LoginNeedsMfa? challengeOf(LoginState state) => state.challenge;
