import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/api/token_store.dart';
import '../../../generated/model/auth_login_request.dart';
import '../../../generated/serializers.dart';
import '../domain/login_result.dart';

/// Talks to `/auth/login` and `/auth/me`.
///
/// The request body is built and serialised through the **generated**
/// `AuthLoginRequest`, so its shape stays bound to `openapi.yaml` and the
/// `device_id` field cannot be renamed out from under the client.
///
/// The response is read here rather than through the generated response model,
/// for two reasons that are worth stating so nobody "fixes" this later:
///
///  1. The generated `authLogin` binds exactly one success type. Login has
///     two — `200` with tokens and `202` with an MFA challenge — and handing a
///     202 body to the 200 deserialiser throws. A login screen that crashes on
///     every privileged account is not a login screen.
///  2. The contract pins `token_type` and `expires_in` to constant values, so
///     the generated model rejects any other. Changing the server's token TTL
///     would break deserialisation on every existing install.
class AuthApi {
  AuthApi({
    required this.dio,
    required this.tokenStore,
    Serializers? serializers,
    this.deviceName = 'android',
  }) : serializers = serializers ?? standardSerializers;

  /// The configured client from `ApiClient`, so login goes through the same
  /// logging, retry and error mapping as everything else.
  final Dio dio;

  final TokenStore tokenStore;
  final Serializers serializers;

  /// Names the token pair on the server. Not an identifier — [TokenStore]'s
  /// device id is.
  final String deviceName;

  /// Attempts a login. Persists tokens only on a full success.
  ///
  /// Throws [LoginFailure] and nothing else, so a caller cannot accidentally
  /// surface a raw transport error — or a request body — to the user.
  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    // The server binds refresh-token families to this id and
    // `DeviceRegistry.revoke()` kills tokens by that binding. Logging in
    // without it produces a session that remote revocation can never reach, so
    // this fails rather than sending the request.
    final deviceId = await tokenStore.readDeviceId();
    if (deviceId == null || deviceId.isEmpty) {
      throw const LoginFailure(LoginFailureKind.deviceNotReady);
    }

    final request = AuthLoginRequest((builder) => builder
      ..email = email.trim()
      ..password = password
      ..deviceName = deviceName
      ..deviceId = deviceId);

    final Response<Object?> response;
    try {
      response = await dio.post<Object?>(
        '/auth/login',
        data: serializers.serialize(
          request,
          specifiedType: const FullType(AuthLoginRequest),
        ),
        options: Options(
          contentType: Headers.jsonContentType,
          // 202 is the MFA challenge, which is a normal outcome, not a failure.
          validateStatus: (status) =>
              status == HttpStatus.ok || status == HttpStatus.accepted,
        ),
      );
    } on DioException catch (error) {
      throw _failureFrom(error);
    }

    final body = _asMap(response.data);

    if (response.statusCode == HttpStatus.accepted) {
      return _mfaChallenge(body, requestIdOf(response));
    }

    return _succeeded(body, requestIdOf(response));
  }

  /// Re-reads the signed-in user with the stored access token.
  ///
  /// Used on a cold start: the tokens survive a restart, but the user object
  /// does not, and nothing should be rendered from a stale copy of it.
  Future<Map<String, Object?>> me() async {
    try {
      final response = await dio.get<Object?>('/auth/me');
      final user = _asMap(response.data)['user'];

      if (user is! Map) {
        throw const LoginFailure(LoginFailureKind.server);
      }

      return _asMap(user);
    } on DioException catch (error) {
      throw _failureFrom(error);
    }
  }

  Future<LoginResult> _succeeded(
    Map<String, Object?> body,
    String? requestId,
  ) async {
    final accessToken = body['access_token'] ?? body['token'];
    final refreshToken = body['refresh_token'];

    // A bearer client must be given both. The cookie-bearing variant of this
    // response exists for the web client and is not something the app can use.
    if (accessToken is! String ||
        accessToken.isEmpty ||
        refreshToken is! String ||
        refreshToken.isEmpty) {
      throw LoginFailure(LoginFailureKind.server, requestId: requestId);
    }

    await tokenStore.writeAccessToken(accessToken);
    await tokenStore.writeRefreshToken(refreshToken);

    final user = body['user'];

    return LoginSucceeded(
      mustChangePassword: body['must_change_password'] == true,
      user: user is Map ? _asMap(user) : const <String, Object?>{},
    );
  }

  LoginResult _mfaChallenge(Map<String, Object?> body, String? requestId) {
    final token = body['mfa_token'];
    if (token is! String || token.isEmpty) {
      throw LoginFailure(LoginFailureKind.server, requestId: requestId);
    }

    final expires = body['expires_in'];

    return LoginNeedsMfa(
      challengeToken: token,
      enrollmentRequired: body['mfa_enrollment_required'] == true,
      expiresIn: Duration(
        seconds: expires is num ? expires.toInt() : int.tryParse('$expires') ?? 0,
      ),
    );
  }

  /// Maps a transport failure onto the server's actual login responses.
  LoginFailure _failureFrom(DioException error) {
    final response = error.response;
    final requestId = requestIdOf(response);
    final status = response?.statusCode;
    final body = _asMap(response?.data);

    if (status == HttpStatus.unprocessableEntity) {
      // The server answers a wrong password and a deactivated account
      // identically, so the login form cannot be used to enumerate accounts.
      return LoginFailure(
        LoginFailureKind.invalidCredentials,
        requestId: requestId,
      );
    }

    if (status == HttpStatus.tooManyRequests) {
      // Two different things share this status. `locked_until` is this
      // account's lockout; without it, it is the shared rate limiter, and
      // telling the user their account is locked would be wrong.
      final lockedUntil = DateTime.tryParse('${body['locked_until']}');
      if (lockedUntil != null) {
        final wait = lockedUntil.difference(DateTime.now());

        return LoginFailure(
          LoginFailureKind.accountLocked,
          retryIn: wait.isNegative ? Duration.zero : wait,
          requestId: requestId,
        );
      }

      return LoginFailure(
        LoginFailureKind.tooManyAttempts,
        retryIn: _retryAfter(response),
        requestId: requestId,
      );
    }

    if (status == HttpStatus.forbidden) {
      // `SchoolContext` refuses to issue a token without exactly one active
      // school assignment.
      return LoginFailure(
        LoginFailureKind.noSchoolAccess,
        requestId: requestId,
      );
    }

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return LoginFailure(LoginFailureKind.offline, requestId: requestId);
    }
    if (status != null && status >= HttpStatus.internalServerError) {
      return LoginFailure(LoginFailureKind.server, requestId: requestId);
    }

    return LoginFailure(LoginFailureKind.unknown, requestId: requestId);
  }

  static Duration? _retryAfter(Response<Object?>? response) {
    final header = response?.headers.value('Retry-After');
    final seconds = header == null ? null : int.tryParse(header);

    return seconds == null ? null : Duration(seconds: seconds);
  }

  static Map<String, Object?> _asMap(Object? value) {
    if (value is! Map) return const <String, Object?>{};

    return value.map((key, item) => MapEntry('$key', item));
  }
}
