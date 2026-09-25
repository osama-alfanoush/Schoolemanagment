import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/api/token_store.dart';
import '../domain/mfa_failure.dart';

/// Changes the signed-in user's password.
///
/// The server rotates the whole token family on a successful change — it
/// deletes every token and issues a new pair — so the new tokens are written
/// here before anything else runs. Skipping that step would leave the app
/// holding credentials the server has already destroyed, and the next call
/// would 401 for no visible reason.
class PasswordApi {
  PasswordApi({required this.dio, required this.tokenStore});

  final Dio dio;
  final TokenStore tokenStore;

  Future<void> change({
    required String currentPassword,
    required String newPassword,
  }) async {
    final Response<Object?> response;
    try {
      response = await dio.post<Object?>(
        '/auth/change-password',
        data: <String, Object?>{
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
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

    if (accessToken is String &&
        accessToken.isNotEmpty &&
        refreshToken is String &&
        refreshToken.isNotEmpty) {
      await tokenStore.writeAccessToken(accessToken);
      await tokenStore.writeRefreshToken(refreshToken);
    }
  }

  PasswordChangeFailure _failureFrom(DioException error) {
    final response = error.response;
    final requestId = requestIdOf(response);
    final status = response?.statusCode;

    if (status == HttpStatus.unprocessableEntity) {
      final mapped = apiErrorOf(error.error);
      final fieldErrors =
          mapped is ValidationError ? mapped.fieldErrors : const <String, List<String>>{};

      if (fieldErrors.containsKey('current_password')) {
        return PasswordChangeFailure(
          PasswordChangeFailureKind.currentPasswordIncorrect,
          requestId: requestId,
        );
      }

      return PasswordChangeFailure(
        PasswordChangeFailureKind.newPasswordRejected,
        serverMessage: fieldErrors['new_password']?.first,
        requestId: requestId,
      );
    }

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return PasswordChangeFailure(
        PasswordChangeFailureKind.offline,
        requestId: requestId,
      );
    }

    return PasswordChangeFailure(
      PasswordChangeFailureKind.server,
      requestId: requestId,
    );
  }
}
