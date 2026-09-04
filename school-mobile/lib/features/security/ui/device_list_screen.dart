import 'package:flutter/material.dart';

import '../../../core/i18n/generated/app_localizations.dart';
import '../../../core/i18n/i18n_scope.dart';
import '../../../shared/shared.dart';
import '../domain/registered_device.dart';
import 'device_list_controller.dart';

/// The devices signed in to this account, with a way to end any of them.
class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({required this.controller, super.key});

  final DeviceListController controller;

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
  }

  Future<void> _confirmRevoke(RegisteredDevice device) async {
    final l10n = AppLocalizations.of(context);
    final own = widget.controller.isThisDevice(device);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('revoke-confirm'),
        title: Text(l10n.deviceRevokeConfirmTitle),
        content: Text(
          own ? l10n.deviceRevokeSelfBody : l10n.deviceRevokeConfirmBody,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            key: const Key('revoke-confirm-accept'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );

    if (confirmed == true) await widget.controller.revoke(device);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => ListScaffold<List<RegisteredDevice>>(
        title: l10n.devicesTitle,
        state: widget.controller.state,
        onRefresh: widget.controller.load,
        emptyBody: l10n.devicesEmpty,
        builder: (context, devices) => ListView.separated(
          itemCount: devices.length + 1,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsetsDirectional.all(Dimens.gutter),
                child: Text(
                  l10n.devicesBody,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final device = devices[index - 1];
            final own = widget.controller.isThisDevice(device);
            final lastSeen = device.lastSeenAt;

            return ValueRow(
              key: Key('device-${device.deviceId}'),
              leading: Icon(
                own ? Icons.phone_android : Icons.devices_other,
                color: own ? Theme.of(context).colorScheme.primary : null,
              ),
              label: Text(
                own ? l10n.deviceThisDevice : _describe(device),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              secondary: Text(
                lastSeen == null
                    ? _describe(device)
                    : '${l10n.deviceLastSeen}: ${formats.dateTime(lastSeen)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: TextButton(
                key: Key('revoke-${device.deviceId}'),
                onPressed: () => _confirmRevoke(device),
                child: Text(l10n.deviceRevoke),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Platform and versions only. A device label is never a person's name.
  static String _describe(RegisteredDevice device) => <String>[
        device.platform,
        if (device.osVersion != null) device.osVersion!,
        if (device.appVersion != null) 'v${device.appVersion}',
      ].where((part) => part.isNotEmpty).join(' · ');
}
