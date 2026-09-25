// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_permissions200_response_role_keys.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUserPermissions200ResponseRoleKeys
    extends AdminUserPermissions200ResponseRoleKeys {
  @override
  final AnyOf anyOf;

  factory _$AdminUserPermissions200ResponseRoleKeys([
    void Function(AdminUserPermissions200ResponseRoleKeysBuilder)? updates,
  ]) => (AdminUserPermissions200ResponseRoleKeysBuilder()..update(updates))
      ._build();

  _$AdminUserPermissions200ResponseRoleKeys._({required this.anyOf})
    : super._();
  @override
  AdminUserPermissions200ResponseRoleKeys rebuild(
    void Function(AdminUserPermissions200ResponseRoleKeysBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUserPermissions200ResponseRoleKeysBuilder toBuilder() =>
      AdminUserPermissions200ResponseRoleKeysBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserPermissions200ResponseRoleKeys &&
        anyOf == other.anyOf;
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
      r'AdminUserPermissions200ResponseRoleKeys',
    )..add('anyOf', anyOf)).toString();
  }
}

class AdminUserPermissions200ResponseRoleKeysBuilder
    implements
        Builder<
          AdminUserPermissions200ResponseRoleKeys,
          AdminUserPermissions200ResponseRoleKeysBuilder
        > {
  _$AdminUserPermissions200ResponseRoleKeys? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AdminUserPermissions200ResponseRoleKeysBuilder() {
    AdminUserPermissions200ResponseRoleKeys._defaults(this);
  }

  AdminUserPermissions200ResponseRoleKeysBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUserPermissions200ResponseRoleKeys other) {
    _$v = other as _$AdminUserPermissions200ResponseRoleKeys;
  }

  @override
  void update(
    void Function(AdminUserPermissions200ResponseRoleKeysBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserPermissions200ResponseRoleKeys build() => _build();

  _$AdminUserPermissions200ResponseRoleKeys _build() {
    final _$result =
        _$v ??
        _$AdminUserPermissions200ResponseRoleKeys._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AdminUserPermissions200ResponseRoleKeys',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
