import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/lock/lock.dart';
import '../../../core/session/session.dart';
import '../../../shared/shared.dart';
import '../data/activation_api.dart';
import '../domain/activation_failure.dart';

/// What the activation screen is doing.
@immutable
class ActivationState {
  const ActivationState({
    this.submitting = false,
    this.failure,
    this.activated = false,
  });

  final bool submitting;
  final ActivationFailure? failure;

  /// The code was spent and a session exists. The screen now offers the lock.
  final bool activated;
}

/// Drives guardian activation.
class ActivationController extends ChangeNotifier {
  ActivationController({
    required this.api,
    required this.session,
    required this.lock,
  });

  final ActivationApi api;
  final SessionController session;
  final AppLockController lock;

  ActivationState _state = const ActivationState();

  ActivationState get state => _state;

  void inputChanged() {
    if (_state.failure == null) return;

    _set(const ActivationState());
  }

  Future<void> submit(String code) async {
    if (_state.submitting) return;

    _set(const ActivationState(submitting: true));

    try {
      final user = await api.activate(code);

      // The session is held back until the lock step is answered, so the
      // parent is offered the lock once rather than dropped straight into a
      // shell and never asked.
      _pending = user;
      _set(const ActivationState(activated: true));
    } on ActivationFailure catch (failure) {
      _set(ActivationState(failure: failure));
    }
  }

  Map<String, Object?>? _pending;

  /// Turns the app-lock on, then opens the session.
  ///
  /// The lock is the "device PIN" step: it uses the phone's own fingerprint or
  /// screen-lock credential rather than an app-specific PIN. Inventing a second
  /// PIN would mean storing another credential on the device to protect a
  /// session the token already governs, and it would protect nothing the OS
  /// does not already.
  Future<bool> enableLockAndFinish() async {
    final enabled = await lock.enable();
    _finish();

    return enabled;
  }

  /// Opens the session without turning the lock on.
  void skipLockAndFinish() => _finish();

  void _finish() {
    final user = _pending;
    if (user == null) return;

    _pending = null;
    session.signedIn(_sessionFrom(user));
  }

  static AppSession _sessionFrom(Map<String, Object?> user) => AppSession(
        userId: '${user['id'] ?? ''}',
        displayName: '${user['name'] ?? ''}',
        roles: AppRole.allFromWire(<Object?>[user['role']]),
      );

  void _set(ActivationState next) {
    _state = next;
    notifyListeners();
  }
}

/// Activation from a school-issued code.
class ActivationScreen extends StatefulWidget {
  const ActivationScreen({
    required this.controller,
    required this.onCancel,
    super.key,
  });

  final ActivationController controller;
  final VoidCallback onCancel;

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await widget.controller.submit(_code.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;

        if (state.activated) {
          return _ProtectStep(controller: widget.controller);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.activateTitle),
            leading: IconButton(
              key: const Key('activate-cancel'),
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
                        Text(l10n.activateBody,
                            style: theme.textTheme.bodyMedium),
                        const SizedBox(height: Dimens.gapLarge),
                        if (state.failure != null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: Dimens.gap,
                            ),
                            child: Semantics(
                              liveRegion: true,
                              child: Text(
                                key: const Key('activate-failure'),
                                _messageFor(state.failure!, l10n),
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: theme.colorScheme.error),
                              ),
                            ),
                          ),
                        TextFormField(
                          key: const Key('activate-code'),
                          controller: _code,
                          enabled: !state.submitting,
                          autofocus: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          textCapitalization: TextCapitalization.characters,
                          // The code is Latin letters and digits even in an
                          // Arabic UI; laying it out RTL reverses what the
                          // parent sees against the slip in their hand.
                          textDirection: TextDirection.ltr,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(20),
                          ],
                          decoration: InputDecoration(
                            labelText: l10n.activateCodeLabel,
                            hintText: 'XXXX-XXXX-XXXX',
                            hintTextDirection: TextDirection.ltr,
                            prefixIcon: const Icon(Icons.confirmation_number_outlined),
                          ),
                          onChanged: (_) => widget.controller.inputChanged(),
                          onFieldSubmitted: (_) => _submit(),
                          validator: (value) => _validate(value, l10n),
                        ),
                        const SizedBox(height: Dimens.gapLarge),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.minTapTarget,
                          ),
                          child: FilledButton(
                            key: const Key('activate-submit'),
                            onPressed: state.submitting ? null : _submit,
                            child: state.submitting
                                ? const SizedBox.square(
                                    dimension: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(l10n.activateAction),
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

  /// Separators are optional — a parent typing off a printed slip will do
  /// either — so the check is on the letters and digits alone.
  static String? _validate(String? value, AppLocalizations l10n) {
    final entry = (value ?? '').replaceAll(RegExp('[^0-9A-Za-z]'), '');
    if (entry.isEmpty) return l10n.activateCodeRequired;
    if (entry.length < 12) return l10n.activateCodeIncomplete;

    return null;
  }

  static String _messageFor(
    ActivationFailure failure,
    AppLocalizations l10n,
  ) =>
      switch (failure.kind) {
        ActivationFailureKind.codeRejected => l10n.activateCodeRejected,
        ActivationFailureKind.noSchoolAccess => l10n.activateNoSchoolAccess,
        ActivationFailureKind.tooManyAttempts => l10n.loginTooManyAttempts,
        ActivationFailureKind.deviceNotReady => l10n.loginDeviceNotReady,
        ActivationFailureKind.offline => l10n.errorOfflineBody,
        ActivationFailureKind.server => l10n.loginFailedGeneric,
      };
}

/// The "device PIN" step: offers the OS lock, once, right after activation.
class _ProtectStep extends StatelessWidget {
  const _ProtectStep({required this.controller});

  final ActivationController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      key: const Key('activate-protect'),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(Dimens.gapLarge),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: Dimens.contentMaxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: Dimens.gap),
                  Text(
                    l10n.activateProtectTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: Dimens.gap),
                  Text(
                    l10n.activateProtectBody,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: Dimens.gapLarge),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: Dimens.minTapTarget),
                    child: FilledButton(
                      key: const Key('activate-enable-lock'),
                      onPressed: controller.enableLockAndFinish,
                      child: Text(l10n.activateProtectEnable),
                    ),
                  ),
                  const SizedBox(height: Dimens.gap),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: Dimens.minTapTarget),
                    child: TextButton(
                      key: const Key('activate-skip-lock'),
                      onPressed: controller.skipLockAndFinish,
                      child: Text(l10n.skip),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
