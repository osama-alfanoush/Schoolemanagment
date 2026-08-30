/// Storage for the credentials the API layer needs.
///
/// This is an interface only. A secure-storage implementation is a later work
/// order; [InMemoryTokenStore] exists so the HTTP layer can be tested without
/// one.
///
/// Tokens are bound to a device on the server, so [readDeviceId] travels with
/// them.
abstract class TokenStore {
  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<String?> readDeviceId();

  Future<void> writeAccessToken(String token);

  Future<void> writeRefreshToken(String token);

  Future<void> writeDeviceId(String deviceId);

  /// Drops every stored credential. Called when refresh fails.
  Future<void> clear();
}

/// Non-persistent [TokenStore] for tests and for the pre-login window.
class InMemoryTokenStore implements TokenStore {
  InMemoryTokenStore({
    String? accessToken,
    String? refreshToken,
    String? deviceId,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _deviceId = deviceId;
  }

  String? _accessToken;
  String? _refreshToken;
  String? _deviceId;

  @override
  Future<String?> readAccessToken() async => _accessToken;

  @override
  Future<String?> readRefreshToken() async => _refreshToken;

  @override
  Future<String?> readDeviceId() async => _deviceId;

  @override
  Future<void> writeAccessToken(String token) async => _accessToken = token;

  @override
  Future<void> writeRefreshToken(String token) async => _refreshToken = token;

  @override
  Future<void> writeDeviceId(String deviceId) async => _deviceId = deviceId;

  @override
  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _deviceId = null;
  }
}
