// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthLoginRequest extends AuthLoginRequest {
  @override
  final String email;
  @override
  final String password;
  @override
  final String? deviceName;
  @override
  final String? deviceId;

  factory _$AuthLoginRequest([
    void Function(AuthLoginRequestBuilder)? updates,
  ]) => (AuthLoginRequestBuilder()..update(updates))._build();

  _$AuthLoginRequest._({
    required this.email,
    required this.password,
    this.deviceName,
    this.deviceId,
  }) : super._();
  @override
  AuthLoginRequest rebuild(void Function(AuthLoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthLoginRequestBuilder toBuilder() =>
      AuthLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthLoginRequest &&
        email == other.email &&
        password == other.password &&
        deviceName == other.deviceName &&
        deviceId == other.deviceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthLoginRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('deviceName', deviceName)
          ..add('deviceId', deviceId))
        .toString();
  }
}

class AuthLoginRequestBuilder
    implements Builder<AuthLoginRequest, AuthLoginRequestBuilder> {
  _$AuthLoginRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  AuthLoginRequestBuilder() {
    AuthLoginRequest._defaults(this);
  }

  AuthLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _deviceName = $v.deviceName;
      _deviceId = $v.deviceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthLoginRequest other) {
    _$v = other as _$AuthLoginRequest;
  }

  @override
  void update(void Function(AuthLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthLoginRequest build() => _build();

  _$AuthLoginRequest _build() {
    final _$result =
        _$v ??
        _$AuthLoginRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'AuthLoginRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'AuthLoginRequest',
            'password',
          ),
          deviceName: deviceName,
          deviceId: deviceId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
