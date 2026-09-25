import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/api/token_store.dart';
import '../domain/activation_failure.dart';

/// Activates a guardian account from a school-issued code.
///
/// No password is involved at any point: the code is the whole credential, it
/// is spent on first use, and what comes back is an ordinary token pair. A
/// Jordanian parent will not manage a password reset — every failure of one
/// becomes a phone call to the school office — so the flow that has to work is
/// the one where the office hands over a slip of paper.
class ActivationApi {
  ActivationApi({
    required this.dio,
    required this.tokenStore,
    this.deviceName = 'android',
  });

  final Dio dio;
  final TokenStore tokenStore;
  final String deviceName;

  /// Redeems [code] and stores the resulting tokens.
  ///
  /// Returns the `user` object the server sent, which is enough to open a
  /// session without a second call.
  Future<Map<String, Object?>> activate(String code) async {
    // Required here, not optional as it is on login: the refresh family the
    // server creates is bound to it, and a session that could never be revoked
    // remotely must not be established at all.
    final deviceId = await tokenStore.readDeviceId();
    if (deviceId == null || deviceId.isEmpty) {
      throw const ActivationFailure(ActivationFailureKind.deviceNotReady);
    }

    await tokenStore.clear();

    final Response<Object?> response;
    try {
      response = await dio.post<Object?>(
        '/mobile/v1/onboarding/activate',
        data: <String, Object?>{
          'code': code.trim(),
          'device_id': deviceId,
          'device_name': deviceName,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
    } on DioException catch (error) {
      throw _failureFrom(error);
    }

    final body = response.data;
    final map = body is Map
        ? body.map((key, value) => MapEntry('$key', value))
        : const <String, Object?>{};

    final accessToken = map['access_token'];
    final refreshToken = map['refresh_token'];

    if (accessToken is! String ||
        accessToken.isEmpty ||
        refreshToken is! String ||
        refreshToken.isEmpty) {
      throw ActivationFailure(
        ActivationFailureKind.server,
        requestId: requestIdOf(response),
      );
    }

    await tokenStore.writeAccessToken(accessToken);
    await tokenStore.writeRefreshToken(refreshToken);

    final user = map['user'];

    return user is Map
        ? user.map((key, value) => MapEntry('$key', value))
        : const <String, Object?>{};
  }

  ActivationFailure _failureFrom(DioException error) {
    final requestId = requestIdOf(error.response);
    final status = error.response?.statusCode;

    // The server answers an unknown code, a spent one and an expired one
    // identically, so this client cannot tell them apart either — and must not
    // guess, because guessing wrong sends a parent to the office for the
    // wrong reason.
    if (status == HttpStatus.unprocessableEntity) {
      return ActivationFailure(
        ActivationFailureKind.codeRejected,
        requestId: requestId,
      );
    }
    if (status == HttpStatus.forbidden) {
      return ActivationFailure(
        ActivationFailureKind.noSchoolAccess,
        requestId: requestId,
      );
    }
    if (status == HttpStatus.tooManyRequests) {
      return ActivationFailure(
        ActivationFailureKind.tooManyAttempts,
        requestId: requestId,
      );
    }

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return ActivationFailure(
        ActivationFailureKind.offline,
        requestId: requestId,
      );
    }

    return ActivationFailure(ActivationFailureKind.server, requestId: requestId);
  }
}
