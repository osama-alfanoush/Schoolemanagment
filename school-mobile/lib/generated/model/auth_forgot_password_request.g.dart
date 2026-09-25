// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthForgotPasswordRequest extends AuthForgotPasswordRequest {
  @override
  final String email;

  factory _$AuthForgotPasswordRequest([
    void Function(AuthForgotPasswordRequestBuilder)? updates,
  ]) => (AuthForgotPasswordRequestBuilder()..update(updates))._build();

  _$AuthForgotPasswordRequest._({required this.email}) : super._();
  @override
  AuthForgotPasswordRequest rebuild(
    void Function(AuthForgotPasswordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthForgotPasswordRequestBuilder toBuilder() =>
      AuthForgotPasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthForgotPasswordRequest && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthForgotPasswordRequest',
    )..add('email', email)).toString();
  }
}

class AuthForgotPasswordRequestBuilder
    implements
        Builder<AuthForgotPasswordRequest, AuthForgotPasswordRequestBuilder> {
  _$AuthForgotPasswordRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AuthForgotPasswordRequestBuilder() {
    AuthForgotPasswordRequest._defaults(this);
  }

  AuthForgotPasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthForgotPasswordRequest other) {
    _$v = other as _$AuthForgotPasswordRequest;
  }

  @override
  void update(void Function(AuthForgotPasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthForgotPasswordRequest build() => _build();

  _$AuthForgotPasswordRequest _build() {
    final _$result =
        _$v ??
        _$AuthForgotPasswordRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'AuthForgotPasswordRequest',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
