// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_permissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUserPermissions200Response
    extends AdminUserPermissions200Response {
  @override
  final int userId;
  @override
  final String role;
  @override
  final AdminUserPermissions200ResponseRoleKeys roleKeys;
  @override
  final BuiltList<JsonObject?> grants;
  @override
  final BuiltList<JsonObject?> denies;
  @override
  final AdminUserPermissions200ResponseEffective effective;

  factory _$AdminUserPermissions200Response([
    void Function(AdminUserPermissions200ResponseBuilder)? updates,
  ]) => (AdminUserPermissions200ResponseBuilder()..update(updates))._build();

  _$AdminUserPermissions200Response._({
    required this.userId,
    required this.role,
    required this.roleKeys,
    required this.grants,
    required this.denies,
    required this.effective,
  }) : super._();
  @override
  AdminUserPermissions200Response rebuild(
    void Function(AdminUserPermissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUserPermissions200ResponseBuilder toBuilder() =>
      AdminUserPermissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUserPermissions200Response &&
        userId == other.userId &&
        role == other.role &&
        roleKeys == other.roleKeys &&
        grants == other.grants &&
        denies == other.denies &&
        effective == other.effective;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, roleKeys.hashCode);
    _$hash = $jc(_$hash, grants.hashCode);
    _$hash = $jc(_$hash, denies.hashCode);
    _$hash = $jc(_$hash, effective.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminUserPermissions200Response')
          ..add('userId', userId)
          ..add('role', role)
          ..add('roleKeys', roleKeys)
          ..add('grants', grants)
          ..add('denies', denies)
          ..add('effective', effective))
        .toString();
  }
}

class AdminUserPermissions200ResponseBuilder
    implements
        Builder<
          AdminUserPermissions200Response,
          AdminUserPermissions200ResponseBuilder
        > {
  _$AdminUserPermissions200Response? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  AdminUserPermissions200ResponseRoleKeysBuilder? _roleKeys;
  AdminUserPermissions200ResponseRoleKeysBuilder get roleKeys =>
      _$this._roleKeys ??= AdminUserPermissions200ResponseRoleKeysBuilder();
  set roleKeys(AdminUserPermissions200ResponseRoleKeysBuilder? roleKeys) =>
      _$this._roleKeys = roleKeys;

  ListBuilder<JsonObject?>? _grants;
  ListBuilder<JsonObject?> get grants =>
      _$this._grants ??= ListBuilder<JsonObject?>();
  set grants(ListBuilder<JsonObject?>? grants) => _$this._grants = grants;

  ListBuilder<JsonObject?>? _denies;
  ListBuilder<JsonObject?> get denies =>
      _$this._denies ??= ListBuilder<JsonObject?>();
  set denies(ListBuilder<JsonObject?>? denies) => _$this._denies = denies;

  AdminUserPermissions200ResponseEffectiveBuilder? _effective;
  AdminUserPermissions200ResponseEffectiveBuilder get effective =>
      _$this._effective ??= AdminUserPermissions200ResponseEffectiveBuilder();
  set effective(AdminUserPermissions200ResponseEffectiveBuilder? effective) =>
      _$this._effective = effective;

  AdminUserPermissions200ResponseBuilder() {
    AdminUserPermissions200Response._defaults(this);
  }

  AdminUserPermissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _role = $v.role;
      _roleKeys = $v.roleKeys.toBuilder();
      _grants = $v.grants.toBuilder();
      _denies = $v.denies.toBuilder();
      _effective = $v.effective.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUserPermissions200Response other) {
    _$v = other as _$AdminUserPermissions200Response;
  }

  @override
  void update(void Function(AdminUserPermissions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminUserPermissions200Response build() => _build();

  _$AdminUserPermissions200Response _build() {
    _$AdminUserPermissions200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminUserPermissions200Response._(
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'AdminUserPermissions200Response',
              'userId',
            ),
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'AdminUserPermissions200Response',
              'role',
            ),
            roleKeys: roleKeys.build(),
            grants: grants.build(),
            denies: denies.build(),
            effective: effective.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roleKeys';
        roleKeys.build();
        _$failedField = 'grants';
        grants.build();
        _$failedField = 'denies';
        denies.build();
        _$failedField = 'effective';
        effective.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminUserPermissions200Response',
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
