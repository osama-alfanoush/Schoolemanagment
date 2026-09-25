// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_role_permissions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUpdateRolePermissionsRequest
    extends AdminUpdateRolePermissionsRequest {
  @override
  final BuiltList<String> keys;

  factory _$AdminUpdateRolePermissionsRequest([
    void Function(AdminUpdateRolePermissionsRequestBuilder)? updates,
  ]) => (AdminUpdateRolePermissionsRequestBuilder()..update(updates))._build();

  _$AdminUpdateRolePermissionsRequest._({required this.keys}) : super._();
  @override
  AdminUpdateRolePermissionsRequest rebuild(
    void Function(AdminUpdateRolePermissionsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUpdateRolePermissionsRequestBuilder toBuilder() =>
      AdminUpdateRolePermissionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUpdateRolePermissionsRequest && keys == other.keys;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, keys.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminUpdateRolePermissionsRequest',
    )..add('keys', keys)).toString();
  }
}

class AdminUpdateRolePermissionsRequestBuilder
    implements
        Builder<
          AdminUpdateRolePermissionsRequest,
          AdminUpdateRolePermissionsRequestBuilder
        > {
  _$AdminUpdateRolePermissionsRequest? _$v;

  ListBuilder<String>? _keys;
  ListBuilder<String> get keys => _$this._keys ??= ListBuilder<String>();
  set keys(ListBuilder<String>? keys) => _$this._keys = keys;

  AdminUpdateRolePermissionsRequestBuilder() {
    AdminUpdateRolePermissionsRequest._defaults(this);
  }

  AdminUpdateRolePermissionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _keys = $v.keys.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUpdateRolePermissionsRequest other) {
    _$v = other as _$AdminUpdateRolePermissionsRequest;
  }

  @override
  void update(
    void Function(AdminUpdateRolePermissionsRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminUpdateRolePermissionsRequest build() => _build();

  _$AdminUpdateRolePermissionsRequest _build() {
    _$AdminUpdateRolePermissionsRequest _$result;
    try {
      _$result =
          _$v ?? _$AdminUpdateRolePermissionsRequest._(keys: keys.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'keys';
        keys.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminUpdateRolePermissionsRequest',
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
