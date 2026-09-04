import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_store.dart';
import '../../../shared/shared.dart';
import '../data/device_api.dart';
import '../domain/registered_device.dart';

/// Drives the device list.
class DeviceListController extends ChangeNotifier {
  DeviceListController({
    required this.api,
    required this.tokenStore,
    required this.onOwnDeviceRevoked,
  });

  final DeviceApi api;
  final TokenStore tokenStore;

  /// Called when the user ends the session on the device they are holding.
  ///
  /// The server has already revoked the tokens by then, so every later call
  /// would 401. Signing out immediately is the honest response — the
  /// alternative is a screen that appears to work until the next tap.
  final Future<void> Function() onOwnDeviceRevoked;

  ScreenState<List<RegisteredDevice>> _state =
      const ScreenLoading<List<RegisteredDevice>>();
  String? _thisDeviceId;

  ScreenState<List<RegisteredDevice>> get state => _state;

  /// The id of the device the app is running on, once known.
  String? get thisDeviceId => _thisDeviceId;

  bool isThisDevice(RegisteredDevice device) =>
      _thisDeviceId != null && device.deviceId == _thisDeviceId;

  Future<void> load() async {
    _thisDeviceId ??= await tokenStore.readDeviceId();

    try {
      final devices = await api.list();

      _set(devices.isEmpty
          ? const ScreenEmpty<List<RegisteredDevice>>()
          : ScreenData<List<RegisteredDevice>>(devices));
    } on DioException catch (error) {
      _set(ScreenError<List<RegisteredDevice>>(
        apiErrorOf(error.error) ?? const UnknownError(),
      ));
    }
  }

  Future<void> revoke(RegisteredDevice device) async {
    final own = isThisDevice(device);

    try {
      await api.revoke(device.deviceId);
    } on DioException catch (error) {
      _set(ScreenError<List<RegisteredDevice>>(
        apiErrorOf(error.error) ?? const UnknownError(),
      ));

      return;
    }

    if (own) {
      await onOwnDeviceRevoked();

      return;
    }

    await load();
  }

  void _set(ScreenState<List<RegisteredDevice>> next) {
    _state = next;
    notifyListeners();
  }
}
