// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_push_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRegisterPushTokenRequestPlatformEnum
_$authRegisterPushTokenRequestPlatformEnum_ios =
    const AuthRegisterPushTokenRequestPlatformEnum._('ios');
const AuthRegisterPushTokenRequestPlatformEnum
_$authRegisterPushTokenRequestPlatformEnum_android =
    const AuthRegisterPushTokenRequestPlatformEnum._('android');
const AuthRegisterPushTokenRequestPlatformEnum
_$authRegisterPushTokenRequestPlatformEnum_web =
    const AuthRegisterPushTokenRequestPlatformEnum._('web');

AuthRegisterPushTokenRequestPlatformEnum
_$authRegisterPushTokenRequestPlatformEnumValueOf(String name) {
  switch (name) {
    case 'ios':
      return _$authRegisterPushTokenRequestPlatformEnum_ios;
    case 'android':
      return _$authRegisterPushTokenRequestPlatformEnum_android;
    case 'web':
      return _$authRegisterPushTokenRequestPlatformEnum_web;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AuthRegisterPushTokenRequestPlatformEnum>
_$authRegisterPushTokenRequestPlatformEnumValues =
    BuiltSet<AuthRegisterPushTokenRequestPlatformEnum>(
      const <AuthRegisterPushTokenRequestPlatformEnum>[
        _$authRegisterPushTokenRequestPlatformEnum_ios,
        _$authRegisterPushTokenRequestPlatformEnum_android,
        _$authRegisterPushTokenRequestPlatformEnum_web,
      ],
    );

Serializer<AuthRegisterPushTokenRequestPlatformEnum>
_$authRegisterPushTokenRequestPlatformEnumSerializer =
    _$AuthRegisterPushTokenRequestPlatformEnumSerializer();

class _$AuthRegisterPushTokenRequestPlatformEnumSerializer
    implements PrimitiveSerializer<AuthRegisterPushTokenRequestPlatformEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ios': 'ios',
    'android': 'android',
    'web': 'web',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ios': 'ios',
    'android': 'android',
    'web': 'web',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AuthRegisterPushTokenRequestPlatformEnum,
  ];
  @override
  final String wireName = 'AuthRegisterPushTokenRequestPlatformEnum';

  @override
  Object serialize(
    Serializers serializers,
    AuthRegisterPushTokenRequestPlatformEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AuthRegisterPushTokenRequestPlatformEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AuthRegisterPushTokenRequestPlatformEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AuthRegisterPushTokenRequest extends AuthRegisterPushTokenRequest {
  @override
  final String deviceId;
  @override
  final String token;
  @override
  final AuthRegisterPushTokenRequestPlatformEnum platform;
  @override
  final String? appVersion;
  @override
  final String? osVersion;

  factory _$AuthRegisterPushTokenRequest([
    void Function(AuthRegisterPushTokenRequestBuilder)? updates,
  ]) => (AuthRegisterPushTokenRequestBuilder()..update(updates))._build();

  _$AuthRegisterPushTokenRequest._({
    required this.deviceId,
    required this.token,
    required this.platform,
    this.appVersion,
    this.osVersion,
  }) : super._();
  @override
  AuthRegisterPushTokenRequest rebuild(
    void Function(AuthRegisterPushTokenRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthRegisterPushTokenRequestBuilder toBuilder() =>
      AuthRegisterPushTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRegisterPushTokenRequest &&
        deviceId == other.deviceId &&
        token == other.token &&
        platform == other.platform &&
        appVersion == other.appVersion &&
        osVersion == other.osVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jc(_$hash, osVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRegisterPushTokenRequest')
          ..add('deviceId', deviceId)
          ..add('token', token)
          ..add('platform', platform)
          ..add('appVersion', appVersion)
          ..add('osVersion', osVersion))
        .toString();
  }
}

class AuthRegisterPushTokenRequestBuilder
    implements
        Builder<
          AuthRegisterPushTokenRequest,
          AuthRegisterPushTokenRequestBuilder
        > {
  _$AuthRegisterPushTokenRequest? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  AuthRegisterPushTokenRequestPlatformEnum? _platform;
  AuthRegisterPushTokenRequestPlatformEnum? get platform => _$this._platform;
  set platform(AuthRegisterPushTokenRequestPlatformEnum? platform) =>
      _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  String? _osVersion;
  String? get osVersion => _$this._osVersion;
  set osVersion(String? osVersion) => _$this._osVersion = osVersion;

  AuthRegisterPushTokenRequestBuilder() {
    AuthRegisterPushTokenRequest._defaults(this);
  }

  AuthRegisterPushTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _token = $v.token;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _osVersion = $v.osVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRegisterPushTokenRequest other) {
    _$v = other as _$AuthRegisterPushTokenRequest;
  }

  @override
  void update(void Function(AuthRegisterPushTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRegisterPushTokenRequest build() => _build();

  _$AuthRegisterPushTokenRequest _build() {
    final _$result =
        _$v ??
        _$AuthRegisterPushTokenRequest._(
          deviceId: BuiltValueNullFieldError.checkNotNull(
            deviceId,
            r'AuthRegisterPushTokenRequest',
            'deviceId',
          ),
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'AuthRegisterPushTokenRequest',
            'token',
          ),
          platform: BuiltValueNullFieldError.checkNotNull(
            platform,
            r'AuthRegisterPushTokenRequest',
            'platform',
          ),
          appVersion: appVersion,
          osVersion: osVersion,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
