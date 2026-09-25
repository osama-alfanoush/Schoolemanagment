import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/router/router.dart';
import '../../../shared/shared.dart';
import '../domain/mfa_failure.dart';
import 'mfa_controller.dart';

/// The Google2FA challenge.
///
/// Nothing on this screen can move the app forward except a valid code: there
/// is no skip, no remember-me and no "continue without". The only other exit
/// is back to sign-in, which discards the challenge grant.
class MfaChallengeScreen extends StatefulWidget {
  const MfaChallengeScreen({
    required this.controller,
    required this.onCancel,
    super.key,
  });

  final MfaController controller;

  /// Returns to the sign-in form and drops the challenge.
  final VoidCallback onCancel;

  @override
  State<MfaChallengeScreen> createState() => _MfaChallengeScreenState();
}

class _MfaChallengeScreenState extends State<MfaChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _entry = TextEditingController();

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await widget.controller.submit(_entry.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;
        final usingRecovery = state.credential == MfaCredential.recoveryCode;

        // Some failures cannot be retyped past: the grant is gone, or the
        // account never finished enrolling. Say so and send the user back
        // rather than leaving them typing codes at a dead endpoint.
        final failure = state.failure;
        if (failure != null && failure.needsFreshSignIn) {
          return MessageScreen(
            key: const Key('mfa-dead-end'),
            icon: Icons.lock_clock,
            title: failure.kind == MfaFailureKind.enrollmentIncomplete
                ? l10n.mfaEnrollmentRequiredTitle
                : l10n.mfaTitle,
            body: failure.kind == MfaFailureKind.enrollmentIncomplete
                ? l10n.mfaEnrollmentRequiredBody
                : l10n.mfaChallengeExpired,
            actionLabel: l10n.backToSignIn,
            onAction: widget.onCancel,
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.mfaTitle),
            leading: IconButton(
              key: const Key('mfa-cancel'),
              tooltip: l10n.backToSignIn,
              icon: const Icon(Icons.arrow_back),
              onPressed: widget.onCancel,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                          l10n.mfaBody,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: Dimens.gapLarge),
                        if (failure != null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: Dimens.gap,
                            ),
                            child: Semantics(
                              liveRegion: true,
                              child: Text(
                                key: const Key('mfa-failure'),
                                _messageFor(failure, l10n),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                        TextFormField(
                          key: const Key('mfa-entry'),
                          controller: _entry,
                          enabled: !state.submitting,
                          autofocus: true,
                          keyboardType: usingRecovery
                              ? TextInputType.text
                              : TextInputType.number,
                          inputFormatters: usingRecovery
                              ? null
                              : <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                          // A code is Latin digits or a Latin recovery string
                          // even in an Arabic UI; laying it out RTL reverses
                          // what the user sees as they type.
                          textDirection: TextDirection.ltr,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: usingRecovery
                                ? l10n.mfaRecoveryCodeLabel
                                : l10n.mfaCodeLabel,
                            prefixIcon: Icon(usingRecovery
                                ? Icons.vpn_key_outlined
                                : Icons.pin_outlined),
                          ),
                          onChanged: (_) => widget.controller.inputChanged(),
                          onFieldSubmitted: (_) => _submit(),
                          validator: (value) =>
                              _validate(value, usingRecovery, l10n),
                        ),
                        const SizedBox(height: Dimens.gapLarge),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.minTapTarget,
                          ),
                          child: FilledButton(
                            key: const Key('mfa-submit'),
                            onPressed: state.submitting ? null : _submit,
                            child: state.submitting
                                ? const SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(l10n.mfaVerifyAction),
                          ),
                        ),
                        const SizedBox(height: Dimens.gap),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.minTapTarget,
                          ),
                          child: TextButton(
                            key: const Key('mfa-toggle-credential'),
                            onPressed: state.submitting
                                ? null
                                : () {
                                    _entry.clear();
                                    usingRecovery
                                        ? widget.controller
                                            .useAuthenticatorCode()
                                        : widget.controller.useRecoveryCode();
                                  },
                            child: Text(usingRecovery
                                ? l10n.mfaUseAuthenticatorCode
                                : l10n.mfaUseRecoveryCode),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static String? _validate(
    String? value,
    bool usingRecovery,
    AppLocalizations l10n,
  ) {
    final entry = (value ?? '').trim();
    if (entry.isEmpty) return l10n.mfaCodeRequired;

    // The server takes exactly six digits; checking here saves a round trip
    // and, more importantly, saves burning an attempt on a typo.
    if (!usingRecovery && entry.length != 6) return l10n.mfaCodeIncomplete;

    return null;
  }

  static String _messageFor(MfaFailure failure, AppLocalizations l10n) =>
      switch (failure.kind) {
        MfaFailureKind.invalidCode => l10n.mfaInvalidCode,
        MfaFailureKind.challengeExpired => l10n.mfaChallengeExpired,
        MfaFailureKind.enrollmentIncomplete => l10n.mfaEnrollmentRequiredBody,
        MfaFailureKind.tooManyAttempts => l10n.loginTooManyAttempts,
        MfaFailureKind.offline => l10n.errorOfflineBody,
        MfaFailureKind.server => l10n.loginFailedGeneric,
      };
}
