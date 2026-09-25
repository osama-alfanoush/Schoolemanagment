import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../domain/registered_device.dart';

/// Reads and revokes the devices signed in to this account.
///
/// Revocation is the server's `DeviceRegistry.revoke()`: it marks the device
/// revoked and stamps `revoked_at` on every token bound to that device id. The
/// revoked device then fails its next call with 401, its refresh fails too,
/// and the client's existing unauthenticated path wipes it. Nothing here needs
/// to push anything to the other device — the token binding does the work.
class DeviceApi {
  const DeviceApi({required this.dio});

  final Dio dio;

  /// Every device the server still considers active for this user.
  Future<List<RegisteredDevice>> list() async {
    final response = await dio.get<Object?>('/notifications/devices');
    final body = response.data;

    if (body is! List) return const <RegisteredDevice>[];

    return body
        .map(RegisteredDevice.tryFrom)
        .whereType<RegisteredDevice>()
        .toList(growable: false);
  }

  /// Ends the session on one device.
  ///
  /// Returns false when the server no longer has that device, which is not an
  /// error: someone revoking the same device twice should see it gone, not a
  /// failure.
  Future<bool> revoke(String deviceId) async {
    try {
      await dio.post<Object?>(
        '/notifications/unregister-device',
        data: <String, Object?>{'device_id': deviceId},
        options: Options(contentType: Headers.jsonContentType),
      );

      return true;
    } on DioException catch (error) {
      final mapped = apiErrorOf(error.error);
      if (mapped is NotFoundError) return false;

      rethrow;
    }
  }
}
