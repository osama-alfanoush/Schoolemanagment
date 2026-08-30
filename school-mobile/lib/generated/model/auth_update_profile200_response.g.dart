// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_update_profile200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthUpdateProfile200Response extends AuthUpdateProfile200Response {
  @override
  final User? user;

  factory _$AuthUpdateProfile200Response([
    void Function(AuthUpdateProfile200ResponseBuilder)? updates,
  ]) => (AuthUpdateProfile200ResponseBuilder()..update(updates))._build();

  _$AuthUpdateProfile200Response._({this.user}) : super._();
  @override
  AuthUpdateProfile200Response rebuild(
    void Function(AuthUpdateProfile200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthUpdateProfile200ResponseBuilder toBuilder() =>
      AuthUpdateProfile200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthUpdateProfile200Response && user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthUpdateProfile200Response',
    )..add('user', user)).toString();
  }
}

class AuthUpdateProfile200ResponseBuilder
    implements
        Builder<
          AuthUpdateProfile200Response,
          AuthUpdateProfile200ResponseBuilder
        > {
  _$AuthUpdateProfile200Response? _$v;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  AuthUpdateProfile200ResponseBuilder() {
    AuthUpdateProfile200Response._defaults(this);
  }

  AuthUpdateProfile200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthUpdateProfile200Response other) {
    _$v = other as _$AuthUpdateProfile200Response;
  }

  @override
  void update(void Function(AuthUpdateProfile200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthUpdateProfile200Response build() => _build();

  _$AuthUpdateProfile200Response _build() {
    _$AuthUpdateProfile200Response _$result;
    try {
      _$result = _$v ?? _$AuthUpdateProfile200Response._(user: _user?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AuthUpdateProfile200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
