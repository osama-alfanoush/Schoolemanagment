import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../shared/shared.dart';
import '../data/auth_repository.dart';
import '../domain/mfa_failure.dart';

@immutable
class ChangePasswordState {
  const ChangePasswordState({this.submitting = false, this.failure});

  final bool submitting;
  final PasswordChangeFailure? failure;
}

/// Drives the forced password-change screen.
class ChangePasswordController extends ChangeNotifier {
  ChangePasswordController({required this.repository});

  final AuthRepository repository;

  ChangePasswordState _state = const ChangePasswordState();

  ChangePasswordState get state => _state;

  void inputChanged() {
    if (_state.failure == null) return;

    _set(const ChangePasswordState());
  }

  Future<void> submit({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (_state.submitting) return;

    _set(const ChangePasswordState(submitting: true));

    try {
      await repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      _set(const ChangePasswordState());
    } on PasswordChangeFailure catch (failure) {
      _set(ChangePasswordState(failure: failure));
    }
  }

  void _set(ChangePasswordState next) {
    _state = next;
    notifyListeners();
  }
}

/// Blocks the app until a temporary password has been replaced.
///
/// There is no way past it but a successful change or signing out, which is
/// the same shape the server enforces: while `must_change_password` holds it
/// answers 403 to every route except `/auth/me`, `/auth/logout` and
/// `/auth/change-password`.
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    required this.controller,
    this.onSignOut,
    super.key,
  });

  final ChangePasswordController controller;
  final VoidCallback? onSignOut;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await widget.controller.submit(
      currentPassword: _current.text,
      newPassword: _next.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopScope(
      // Backing out would land on a shell where every call returns 403.
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.changePasswordTitle),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            if (widget.onSignOut != null)
              TextButton(
                key: const Key('change-password-sign-out'),
                onPressed: widget.onSignOut,
                child: Text(l10n.signOut),
              ),
          ],
        ),
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
                          Text(
                            l10n.changePasswordBody,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: Dimens.gapLarge),
                          if (state.failure != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: Dimens.gap,
                              ),
                              child: Semantics(
                                liveRegion: true,
                                child: Text(
                                  key: const Key('change-password-failure'),
                                  _messageFor(state.failure!, l10n),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          _PasswordField(
                            fieldKey: const Key('current-password'),
                            controller: _current,
                            label: l10n.currentPasswordLabel,
                            enabled: !state.submitting,
                            onChanged: widget.controller.inputChanged,
                            validator: (value) => (value ?? '').isEmpty
                                ? l10n.passwordRequired
                                : null,
                          ),
                          const SizedBox(height: Dimens.gap),
                          _PasswordField(
                            fieldKey: const Key('new-password'),
                            controller: _next,
                            label: l10n.newPasswordLabel,
                            enabled: !state.submitting,
                            onChanged: widget.controller.inputChanged,
                            validator: (value) => _validateNew(value, l10n),
                          ),
                          const SizedBox(height: Dimens.gap),
                          _PasswordField(
                            fieldKey: const Key('confirm-password'),
                            controller: _confirm,
                            label: l10n.confirmPasswordLabel,
                            enabled: !state.submitting,
                            onChanged: widget.controller.inputChanged,
                            validator: (value) => value == _next.text
                                ? null
                                : l10n.passwordsDoNotMatch,
                          ),
                          const SizedBox(height: Dimens.gapLarge),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: Dimens.minTapTarget,
                            ),
                            child: FilledButton(
                              key: const Key('change-password-submit'),
                              onPressed: state.submitting ? null : _submit,
                              child: state.submitting
                                  ? const SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(l10n.changePasswordAction),
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
      ),
    );
  }

  /// The server's rules, checked here so a user is told before a round trip:
  /// at least eight characters, one capital letter, one digit.
  static String? _validateNew(String? value, AppLocalizations l10n) {
    final password = value ?? '';
    if (password.isEmpty) return l10n.passwordRequired;
    if (password.length < 8) return l10n.passwordTooShort;
    if (!RegExp('[A-Z]').hasMatch(password)) return l10n.passwordNeedsUppercase;
    if (!RegExp('[0-9]').hasMatch(password)) return l10n.passwordNeedsDigit;

    return null;
  }

  static String _messageFor(
    PasswordChangeFailure failure,
    AppLocalizations l10n,
  ) =>
      switch (failure.kind) {
        PasswordChangeFailureKind.currentPasswordIncorrect =>
          l10n.currentPasswordIncorrect,
        // The server knows rules the client does not; its own text is the only
        // thing that can say which one was broken.
        PasswordChangeFailureKind.newPasswordRejected =>
          failure.serverMessage ?? l10n.loginFailedGeneric,
        PasswordChangeFailureKind.offline => l10n.errorOfflineBody,
        PasswordChangeFailureKind.server => l10n.loginFailedGeneric,
      };
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.fieldKey,
    required this.controller,
    required this.label,
    required this.enabled,
    required this.onChanged,
    required this.validator,
  });

  final Key fieldKey;
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final VoidCallback onChanged;
  final String? Function(String?) validator;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: !_visible,
      autocorrect: false,
      enableSuggestions: false,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          tooltip: _visible ? l10n.hidePassword : l10n.showPassword,
          icon: Icon(_visible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined),
          onPressed: () => setState(() => _visible = !_visible),
        ),
      ),
      onChanged: (_) => widget.onChanged(),
      validator: widget.validator,
    );
  }
}
