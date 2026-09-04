import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/api/token_store.dart';
import '../domain/login_result.dart';
import '../domain/mfa_failure.dart';

/// Completes a Google2FA challenge.
///
/// The challenge token is **not** written to the token store. It is a
/// short-lived grant that can do exactly one thing, and storing it would make
/// the rest of the app — the auth interceptor, the refresh coordinator, the
/// router — read the app as signed in when it is not. It is passed in
/// explicitly on each call and forgotten when the screen closes.
class MfaApi {
  MfaApi({
    required this.dio,
    required this.tokenStore,
    this.deviceName = 'android',
  });

  final Dio dio;
  final TokenStore tokenStore;
  final String deviceName;

  /// Exchanges a TOTP or recovery code for a real token pair.
  ///
  /// Exactly one of [code] and [recoveryCode] is sent, matching the server's
  /// `required_without` pair.
  Future<void> completeChallenge({
    required String challengeToken,
    String? code,
    String? recoveryCode,
  }) async {
    assert(
      (code == null) != (recoveryCode == null),
      'send exactly one of code and recoveryCode',
    );

    // Exactly one of the two goes on the wire, matching the server's
    // `required_without` pair; sending both is a validation error.
    final payload = <String, Object?>{'device_name': deviceName};
    if (code != null) payload['code'] = code;
    if (recoveryCode != null) payload['recovery_code'] = recoveryCode;

    final Response<Object?> response;
    try {
      response = await dio.post<Object?>(
        '/auth/mfa/challenge',
        data: payload,
        options: Options(
          contentType: Headers.jsonContentType,
          // The challenge token authorises this one call. The auth interceptor
          // only overwrites this when the store holds an access token, and it
          // does not: `AuthApi.login` clears the store before an attempt, so a
          // stale session can never shadow the challenge.
          headers: <String, Object?>{
            'Authorization': 'Bearer $challengeToken',
          },
        ),
      );
    } on DioException catch (error) {
      throw _failureFrom(error);
    }

    final body = response.data;
    final map = body is Map
        ? body.map((key, value) => MapEntry('$key', value))
        : const <String, Object?>{};

    final accessToken = map['access_token'] ?? map['token'];
    final refreshToken = map['refresh_token'];

    if (accessToken is! String ||
        accessToken.isEmpty ||
        refreshToken is! String ||
        refreshToken.isEmpty) {
      throw MfaFailure(
        MfaFailureKind.server,
        requestId: requestIdOf(response),
      );
    }

    await tokenStore.writeAccessToken(accessToken);
    await tokenStore.writeRefreshToken(refreshToken);
  }

  MfaFailure _failureFrom(DioException error) {
    final response = error.response;
    final requestId = requestIdOf(response);
    final status = response?.statusCode;

    // 422 is a wrong code; 401 is the short-lived challenge token having
    // expired or been spent. They need different words: one says try again,
    // the other says start over.
    if (status == HttpStatus.unprocessableEntity) {
      return MfaFailure(MfaFailureKind.invalidCode, requestId: requestId);
    }
    if (status == HttpStatus.unauthorized || status == HttpStatus.forbidden) {
      return MfaFailure(MfaFailureKind.challengeExpired, requestId: requestId);
    }
    if (status == HttpStatus.conflict) {
      return MfaFailure(
        MfaFailureKind.enrollmentIncomplete,
        requestId: requestId,
      );
    }
    if (status == HttpStatus.tooManyRequests) {
      return MfaFailure(MfaFailureKind.tooManyAttempts, requestId: requestId);
    }

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return MfaFailure(MfaFailureKind.offline, requestId: requestId);
    }

    return MfaFailure(MfaFailureKind.server, requestId: requestId);
  }
}

/// Whether a challenge can be attempted at all on this device.
///
/// An account that has never enrolled cannot be enrolled from here: setting up
/// an authenticator means showing a secret and a QR code, which this order does
/// not build. Saying so is the honest outcome — a screen that silently does
/// nothing would leave a privileged user stuck with no explanation.
bool canCompleteOnDevice(LoginNeedsMfa challenge) => !challenge.enrollmentRequired;
