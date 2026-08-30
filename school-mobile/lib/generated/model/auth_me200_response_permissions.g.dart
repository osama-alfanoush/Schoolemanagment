// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_me200_response_permissions.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthMe200ResponsePermissions extends AuthMe200ResponsePermissions {
  @override
  final AnyOf anyOf;

  factory _$AuthMe200ResponsePermissions([
    void Function(AuthMe200ResponsePermissionsBuilder)? updates,
  ]) => (AuthMe200ResponsePermissionsBuilder()..update(updates))._build();

  _$AuthMe200ResponsePermissions._({required this.anyOf}) : super._();
  @override
  AuthMe200ResponsePermissions rebuild(
    void Function(AuthMe200ResponsePermissionsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AuthMe200ResponsePermissionsBuilder toBuilder() =>
      AuthMe200ResponsePermissionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthMe200ResponsePermissions && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AuthMe200ResponsePermissions',
    )..add('anyOf', anyOf)).toString();
  }
}

class AuthMe200ResponsePermissionsBuilder
    implements
        Builder<
          AuthMe200ResponsePermissions,
          AuthMe200ResponsePermissionsBuilder
        > {
  _$AuthMe200ResponsePermissions? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AuthMe200ResponsePermissionsBuilder() {
    AuthMe200ResponsePermissions._defaults(this);
  }

  AuthMe200ResponsePermissionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthMe200ResponsePermissions other) {
    _$v = other as _$AuthMe200ResponsePermissions;
  }

  @override
  void update(void Function(AuthMe200ResponsePermissionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthMe200ResponsePermissions build() => _build();

  _$AuthMe200ResponsePermissions _build() {
    final _$result =
        _$v ??
        _$AuthMe200ResponsePermissions._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AuthMe200ResponsePermissions',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
