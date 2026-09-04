import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../domain/login_result.dart';
import 'login_controller.dart';

/// The sign-in screen.
///
/// Arabic-first and mobile-first: one column, large targets, no side-by-side
/// layout to break under RTL, and everything scrollable so the form is still
/// usable with the keyboard up at 200% text scale.
class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.controller, super.key});

  final LoginController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Read once, at submit. The password is never copied into widget state.
    await widget.controller.submit(
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) {
            final state = widget.controller.state;

            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(Dimens.gapLarge),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: Dimens.contentMaxWidth),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: Dimens.gapLarge),
                        Text(
                          l10n.appTitle,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Dimens.gapSmall),
                        Text(
                          l10n.signInSubtitle,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Dimens.gapLarge),
                        if (state.failure != null)
                          _FailureNotice(failure: state.failure!),
                        TextFormField(
                          key: const Key('login-email'),
                          controller: _email,
                          enabled: !state.submitting,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          autofillHints: const <String>[AutofillHints.username],
                          // The address itself is Latin even in an Arabic UI;
                          // laying it out RTL puts the dots in the wrong place.
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            labelText: l10n.emailLabel,
                            prefixIcon: const Icon(Icons.alternate_email),
                          ),
                          onChanged: (_) => widget.controller.inputChanged(),
                          validator: (value) => _validateEmail(value, l10n),
                        ),
                        const SizedBox(height: Dimens.gap),
                        TextFormField(
                          key: const Key('login-password'),
                          controller: _password,
                          enabled: !state.submitting,
                          obscureText: !_passwordVisible,
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          enableSuggestions: false,
                          autofillHints: const <String>[AutofillHints.password],
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            labelText: l10n.passwordLabel,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              key: const Key('login-password-visibility'),
                              tooltip: _passwordVisible
                                  ? l10n.hidePassword
                                  : l10n.showPassword,
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () => setState(
                                () => _passwordVisible = !_passwordVisible,
                              ),
                            ),
                          ),
                          onChanged: (_) => widget.controller.inputChanged(),
                          onFieldSubmitted: (_) => _submit(),
                          validator: (value) => (value ?? '').isEmpty
                              ? l10n.passwordRequired
                              : null,
                        ),
                        const SizedBox(height: Dimens.gapLarge),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.minTapTarget,
                          ),
                          child: FilledButton(
                            key: const Key('login-submit'),
                            onPressed: state.submitting ? null : _submit,
                            child: state.submitting
                                ? const SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(l10n.signInAction),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static String? _validateEmail(String? value, AppLocalizations l10n) {
    final email = (value ?? '').trim();
    if (email.isEmpty) return l10n.emailRequired;

    // Shape only. The server is the authority on whether it exists.
    if (!RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$').hasMatch(email)) {
      return l10n.emailInvalid;
    }

    return null;
  }
}

/// The failure banner above the form.
///
/// Every case is a translated sentence, never a raw server string or a status
/// code: a parent shown `422 Unprocessable Entity` phones the school.
class _FailureNotice extends StatelessWidget {
  const _FailureNotice({required this.failure});

  final LoginFailure failure;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final message = switch (failure.kind) {
      LoginFailureKind.invalidCredentials => l10n.loginInvalidCredentials,
      LoginFailureKind.accountLocked =>
        l10n.loginAccountLocked(failure.retryInMinutes),
      LoginFailureKind.tooManyAttempts => l10n.loginTooManyAttempts,
      LoginFailureKind.noSchoolAccess => l10n.loginNoSchoolAccess,
      LoginFailureKind.deviceNotReady => l10n.loginDeviceNotReady,
      LoginFailureKind.offline => l10n.errorOfflineBody,
      LoginFailureKind.server || LoginFailureKind.unknown =>
        l10n.loginFailedGeneric,
    };

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: Dimens.gapLarge),
      child: Semantics(
        liveRegion: true,
        child: Container(
          key: const Key('login-failure'),
          padding: const EdgeInsetsDirectional.all(Dimens.gap),
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(Dimens.gapSmall),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: Dimens.gap),
                  Expanded(
                    child: Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
              // Only on a server-side failure. A wrong password is not
              // something support needs a correlation id for, and printing one
              // on every typo teaches people to ignore it.
              if (failure.requestId != null &&
                  (failure.kind == LoginFailureKind.server ||
                      failure.kind == LoginFailureKind.unknown)) ...<Widget>[
                const SizedBox(height: Dimens.gap),
                RequestIdCard(requestId: failure.requestId!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
