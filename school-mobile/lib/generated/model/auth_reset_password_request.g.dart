// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_reset_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthResetPasswordRequest extends AuthResetPasswordRequest {
  @override
  final String token;
  @override
  final String email;
  @override
  final String password;
  @override
  final String passwordConfirmation;

  factory _$AuthResetPasswordRequest([
    void Function(AuthResetPasswordRequestBuilder)? updates,
  ]) => (AuthResetPasswordRequestBuilder()..update(updates))._build();

  _$AuthResetPasswordRequest._({
    required this.token,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  }) : super._();
  @override
  AuthResetPasswordRequest rebuild(
    void Function(AuthResetPasswordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthResetPasswordRequestBuilder toBuilder() =>
      AuthResetPasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthResetPasswordRequest &&
        token == other.token &&
        email == other.email &&
        password == other.password &&
        passwordConfirmation == other.passwordConfirmation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, passwordConfirmation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthResetPasswordRequest')
          ..add('token', token)
          ..add('email', email)
          ..add('password', password)
          ..add('passwordConfirmation', passwordConfirmation))
        .toString();
  }
}

class AuthResetPasswordRequestBuilder
    implements
        Builder<AuthResetPasswordRequest, AuthResetPasswordRequestBuilder> {
  _$AuthResetPasswordRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _passwordConfirmation;
  String? get passwordConfirmation => _$this._passwordConfirmation;
  set passwordConfirmation(String? passwordConfirmation) =>
      _$this._passwordConfirmation = passwordConfirmation;

  AuthResetPasswordRequestBuilder() {
    AuthResetPasswordRequest._defaults(this);
  }

  AuthResetPasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _email = $v.email;
      _password = $v.password;
      _passwordConfirmation = $v.passwordConfirmation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthResetPasswordRequest other) {
    _$v = other as _$AuthResetPasswordRequest;
  }

  @override
  void update(void Function(AuthResetPasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthResetPasswordRequest build() => _build();

  _$AuthResetPasswordRequest _build() {
    final _$result =
        _$v ??
        _$AuthResetPasswordRequest._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'AuthResetPasswordRequest',
            'token',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'AuthResetPasswordRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'AuthResetPasswordRequest',
            'password',
          ),
          passwordConfirmation: BuiltValueNullFieldError.checkNotNull(
            passwordConfirmation,
            r'AuthResetPasswordRequest',
            'passwordConfirmation',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
