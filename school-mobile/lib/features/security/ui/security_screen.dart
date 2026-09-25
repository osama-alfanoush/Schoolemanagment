import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../core/lock/lock.dart';
import '../../../shared/shared.dart';

/// Where the app-lock is turned on and the device list is reached.
///
/// The lock is opt-in and the toggle refuses to turn on when the device has no
/// screen lock of its own: a lock the OS cannot enforce is a checkbox, not a
/// control.
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    required this.lock,
    required this.onOpenDevices,
    this.onOpenDiagnostics,
    this.onSignOut,
    super.key,
  });

  final AppLockController lock;
  final VoidCallback onOpenDevices;
  final VoidCallback? onOpenDiagnostics;
  final VoidCallback? onSignOut;

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  Future<void> _setEnabled(bool enabled) async {
    if (!enabled) {
      await widget.lock.disable();

      return;
    }

    final turnedOn = await widget.lock.enable();
    if (!turnedOn && mounted) {
      // The device has no biometric and no screen-lock credential, so the OS
      // has nothing to prompt with. Saying so beats a switch that silently
      // slides back.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).appLockUnsupported),
        ),
      );
    }
  }

  String _timeoutLabel(Duration timeout, AppLocalizations l10n) {
    if (timeout == Duration.zero) return l10n.appLockTimeoutImmediate;

    final formats = AppI18nScope.of(context);

    return '${formats.integer(timeout.inMinutes)} ${l10n.appLockTimeoutSetting}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: widget.lock,
      builder: (context, _) {
        final lock = widget.lock;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.securityTitle),
            actions: <Widget>[
              if (widget.onSignOut != null)
                TextButton(
                  key: const Key('security-sign-out'),
                  onPressed: widget.onSignOut,
                  child: Text(l10n.signOut),
                ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  key: const Key('app-lock-toggle'),
                  value: lock.isEnabled,
                  onChanged: _setEnabled,
                  title: Text(l10n.appLockSetting),
                  subtitle: Text(
                    lock.isAvailable
                        ? l10n.appLockSettingBody
                        : l10n.appLockUnsupported,
                  ),
                  secondary: const Icon(Icons.fingerprint),
                ),
                if (lock.isEnabled)
                  ListTile(
                    key: const Key('app-lock-timeout'),
                    minTileHeight: Dimens.minTapTarget,
                    leading: const Icon(Icons.timer_outlined),
                    title: Text(l10n.appLockTimeoutSetting),
                    subtitle: Text(_timeoutLabel(lock.timeout, l10n)),
                    trailing: DropdownButton<Duration>(
                      key: const Key('app-lock-timeout-choice'),
                      value: lock.timeout,
                      onChanged: (value) {
                        if (value != null) lock.setTimeout(value);
                      },
                      items: <DropdownMenuItem<Duration>>[
                        for (final choice
                            in AppLockController.timeoutChoices)
                          DropdownMenuItem<Duration>(
                            value: choice,
                            child: Text(_timeoutLabel(choice, l10n)),
                          ),
                      ],
                    ),
                  ),
                const Divider(height: 1),
                ListTile(
                  key: const Key('open-devices'),
                  minTileHeight: Dimens.minTapTarget,
                  leading: const Icon(Icons.devices_other),
                  title: Text(l10n.devicesTitle),
                  subtitle: Text(l10n.devicesBody),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: widget.onOpenDevices,
                ),
                if (widget.onOpenDiagnostics != null)
                  ListTile(
                    key: const Key('open-diagnostics'),
                    minTileHeight: Dimens.minTapTarget,
                    leading: const Icon(Icons.rule),
                    title: Text(l10n.diagnosticsTitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: widget.onOpenDiagnostics,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
