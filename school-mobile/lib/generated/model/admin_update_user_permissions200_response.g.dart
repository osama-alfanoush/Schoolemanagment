// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_user_permissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUpdateUserPermissions200Response
    extends AdminUpdateUserPermissions200Response {
  @override
  final int userId;
  @override
  final AdminUserPermissions200ResponseEffective permissions;

  factory _$AdminUpdateUserPermissions200Response([
    void Function(AdminUpdateUserPermissions200ResponseBuilder)? updates,
  ]) => (AdminUpdateUserPermissions200ResponseBuilder()..update(updates))
      ._build();

  _$AdminUpdateUserPermissions200Response._({
    required this.userId,
    required this.permissions,
  }) : super._();
  @override
  AdminUpdateUserPermissions200Response rebuild(
    void Function(AdminUpdateUserPermissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUpdateUserPermissions200ResponseBuilder toBuilder() =>
      AdminUpdateUserPermissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUpdateUserPermissions200Response &&
        userId == other.userId &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AdminUpdateUserPermissions200Response',
          )
          ..add('userId', userId)
          ..add('permissions', permissions))
        .toString();
  }
}

class AdminUpdateUserPermissions200ResponseBuilder
    implements
        Builder<
          AdminUpdateUserPermissions200Response,
          AdminUpdateUserPermissions200ResponseBuilder
        > {
  _$AdminUpdateUserPermissions200Response? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  AdminUserPermissions200ResponseEffectiveBuilder? _permissions;
  AdminUserPermissions200ResponseEffectiveBuilder get permissions =>
      _$this._permissions ??= AdminUserPermissions200ResponseEffectiveBuilder();
  set permissions(
    AdminUserPermissions200ResponseEffectiveBuilder? permissions,
  ) => _$this._permissions = permissions;

  AdminUpdateUserPermissions200ResponseBuilder() {
    AdminUpdateUserPermissions200Response._defaults(this);
  }

  AdminUpdateUserPermissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _permissions = $v.permissions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUpdateUserPermissions200Response other) {
    _$v = other as _$AdminUpdateUserPermissions200Response;
  }

  @override
  void update(
    void Function(AdminUpdateUserPermissions200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminUpdateUserPermissions200Response build() => _build();

  _$AdminUpdateUserPermissions200Response _build() {
    _$AdminUpdateUserPermissions200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminUpdateUserPermissions200Response._(
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'AdminUpdateUserPermissions200Response',
              'userId',
            ),
            permissions: permissions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminUpdateUserPermissions200Response',
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
