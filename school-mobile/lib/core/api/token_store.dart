/// Storage for the credentials the API layer needs.
///
/// Tokens are bound to a device on the server, so [readDeviceId] travels with
/// them. The device id is an *identifier*, not a credential: it grants nothing
/// on its own, and the server keys a refresh-token family to it. That is why
/// clearing credentials and forgetting the device are separate operations, and
/// every implementation must draw the line in the same place.
abstract class TokenStore {
  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<String?> readDeviceId();

  Future<void> writeAccessToken(String token);

  Future<void> writeRefreshToken(String token);

  Future<void> writeDeviceId(String deviceId);

  /// Drops the credentials — access and refresh token — and **keeps the
  /// device id**. Called when a refresh fails.
  ///
  /// The device identity survives a lost session on purpose: minting a new one
  /// on every failed refresh would make each recovered session look like a
  /// brand new device to the server, defeating the reuse detection that relies
  /// on a stable token family.
  ///
  /// Dropping the device id as well is a separate, explicit "forget this
  /// device" operation, which each implementation exposes as `forgetDevice()`.
  Future<void> clear();
}

/// Non-persistent [TokenStore] for tests and for the pre-login window.
///
/// Matches `SecureTokenStore`'s semantics exactly: [clear] keeps the device id,
/// and [forgetDevice] removes it.
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
  }

  /// Everything [clear] drops, plus the device id. The explicit
  /// "forget this device", mirroring `SecureTokenStore.forgetDevice`.
  Future<void> forgetDevice() async {
    await clear();
    _deviceId = null;
  }
}
