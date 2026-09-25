// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_role_permissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminRolePermissions200Response
    extends AdminRolePermissions200Response {
  @override
  final String role;
  @override
  final BuiltMap<String, JsonObject?> keys;

  factory _$AdminRolePermissions200Response([
    void Function(AdminRolePermissions200ResponseBuilder)? updates,
  ]) => (AdminRolePermissions200ResponseBuilder()..update(updates))._build();

  _$AdminRolePermissions200Response._({required this.role, required this.keys})
    : super._();
  @override
  AdminRolePermissions200Response rebuild(
    void Function(AdminRolePermissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminRolePermissions200ResponseBuilder toBuilder() =>
      AdminRolePermissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminRolePermissions200Response &&
        role == other.role &&
        keys == other.keys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, keys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminRolePermissions200Response')
          ..add('role', role)
          ..add('keys', keys))
        .toString();
  }
}

class AdminRolePermissions200ResponseBuilder
    implements
        Builder<
          AdminRolePermissions200Response,
          AdminRolePermissions200ResponseBuilder
        > {
  _$AdminRolePermissions200Response? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  MapBuilder<String, JsonObject?>? _keys;
  MapBuilder<String, JsonObject?> get keys =>
      _$this._keys ??= MapBuilder<String, JsonObject?>();
  set keys(MapBuilder<String, JsonObject?>? keys) => _$this._keys = keys;

  AdminRolePermissions200ResponseBuilder() {
    AdminRolePermissions200Response._defaults(this);
  }

  AdminRolePermissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _keys = $v.keys.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminRolePermissions200Response other) {
    _$v = other as _$AdminRolePermissions200Response;
  }

  @override
  void update(void Function(AdminRolePermissions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminRolePermissions200Response build() => _build();

  _$AdminRolePermissions200Response _build() {
    _$AdminRolePermissions200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminRolePermissions200Response._(
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'AdminRolePermissions200Response',
              'role',
            ),
            keys: keys.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'keys';
        keys.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminRolePermissions200Response',
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
