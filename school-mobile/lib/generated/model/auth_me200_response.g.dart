// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_me200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthMe200Response extends AuthMe200Response {
  @override
  final User? user;
  @override
  final AuthMe200ResponsePermissions permissions;

  factory _$AuthMe200Response([
    void Function(AuthMe200ResponseBuilder)? updates,
  ]) => (AuthMe200ResponseBuilder()..update(updates))._build();

  _$AuthMe200Response._({this.user, required this.permissions}) : super._();
  @override
  AuthMe200Response rebuild(void Function(AuthMe200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthMe200ResponseBuilder toBuilder() =>
      AuthMe200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthMe200Response &&
        user == other.user &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthMe200Response')
          ..add('user', user)
          ..add('permissions', permissions))
        .toString();
  }
}

class AuthMe200ResponseBuilder
    implements Builder<AuthMe200Response, AuthMe200ResponseBuilder> {
  _$AuthMe200Response? _$v;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  AuthMe200ResponsePermissionsBuilder? _permissions;
  AuthMe200ResponsePermissionsBuilder get permissions =>
      _$this._permissions ??= AuthMe200ResponsePermissionsBuilder();
  set permissions(AuthMe200ResponsePermissionsBuilder? permissions) =>
      _$this._permissions = permissions;

  AuthMe200ResponseBuilder() {
    AuthMe200Response._defaults(this);
  }

  AuthMe200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user?.toBuilder();
      _permissions = $v.permissions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthMe200Response other) {
    _$v = other as _$AuthMe200Response;
  }

  @override
  void update(void Function(AuthMe200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthMe200Response build() => _build();

  _$AuthMe200Response _build() {
    _$AuthMe200Response _$result;
    try {
      _$result =
          _$v ??
          _$AuthMe200Response._(
            user: _user?.build(),
            permissions: permissions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AuthMe200Response',
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
