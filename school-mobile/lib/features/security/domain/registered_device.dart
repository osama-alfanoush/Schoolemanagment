import 'package:flutter/foundation.dart';

/// A device the server has on record for this user.
///
/// Read leniently: the list screen is a security control, and it should render
/// what it can rather than fail closed on an unexpected field. A device that
/// cannot be parsed at all is dropped rather than shown half-formed.
@immutable
class RegisteredDevice {
  const RegisteredDevice({
    required this.deviceId,
    required this.platform,
    this.appVersion,
    this.osVersion,
    this.lastSeenAt,
  });

  /// The client-generated id the server binds token families to.
  final String deviceId;

  final String platform;
  final String? appVersion;
  final String? osVersion;
  final DateTime? lastSeenAt;

  static RegisteredDevice? tryFrom(Object? json) {
    if (json is! Map) return null;

    final deviceId = json['device_id'];
    if (deviceId is! String || deviceId.isEmpty) return null;

    return RegisteredDevice(
      deviceId: deviceId,
      platform: '${json['platform'] ?? ''}',
      appVersion: _stringOrNull(json['app_version']),
      osVersion: _stringOrNull(json['os_version']),
      lastSeenAt: DateTime.tryParse('${json['last_seen_at']}'),
    );
  }

  static String? _stringOrNull(Object? value) =>
      value is String && value.isNotEmpty ? value : null;

  @override
  bool operator ==(Object other) =>
      other is RegisteredDevice && other.deviceId == deviceId;

  @override
  int get hashCode => deviceId.hashCode;

  @override
  String toString() => 'RegisteredDevice($platform)';
}
