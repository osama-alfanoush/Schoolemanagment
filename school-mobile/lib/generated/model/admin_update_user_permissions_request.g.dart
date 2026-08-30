// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_user_permissions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminUpdateUserPermissionsRequest
    extends AdminUpdateUserPermissionsRequest {
  @override
  final BuiltList<String> grants;
  @override
  final BuiltList<String> denies;

  factory _$AdminUpdateUserPermissionsRequest([
    void Function(AdminUpdateUserPermissionsRequestBuilder)? updates,
  ]) => (AdminUpdateUserPermissionsRequestBuilder()..update(updates))._build();

  _$AdminUpdateUserPermissionsRequest._({
    required this.grants,
    required this.denies,
  }) : super._();
  @override
  AdminUpdateUserPermissionsRequest rebuild(
    void Function(AdminUpdateUserPermissionsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminUpdateUserPermissionsRequestBuilder toBuilder() =>
      AdminUpdateUserPermissionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUpdateUserPermissionsRequest &&
        grants == other.grants &&
        denies == other.denies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grants.hashCode);
    _$hash = $jc(_$hash, denies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminUpdateUserPermissionsRequest')
          ..add('grants', grants)
          ..add('denies', denies))
        .toString();
  }
}

class AdminUpdateUserPermissionsRequestBuilder
    implements
        Builder<
          AdminUpdateUserPermissionsRequest,
          AdminUpdateUserPermissionsRequestBuilder
        > {
  _$AdminUpdateUserPermissionsRequest? _$v;

  ListBuilder<String>? _grants;
  ListBuilder<String> get grants => _$this._grants ??= ListBuilder<String>();
  set grants(ListBuilder<String>? grants) => _$this._grants = grants;

  ListBuilder<String>? _denies;
  ListBuilder<String> get denies => _$this._denies ??= ListBuilder<String>();
  set denies(ListBuilder<String>? denies) => _$this._denies = denies;

  AdminUpdateUserPermissionsRequestBuilder() {
    AdminUpdateUserPermissionsRequest._defaults(this);
  }

  AdminUpdateUserPermissionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grants = $v.grants.toBuilder();
      _denies = $v.denies.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUpdateUserPermissionsRequest other) {
    _$v = other as _$AdminUpdateUserPermissionsRequest;
  }

  @override
  void update(
    void Function(AdminUpdateUserPermissionsRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminUpdateUserPermissionsRequest build() => _build();

  _$AdminUpdateUserPermissionsRequest _build() {
    _$AdminUpdateUserPermissionsRequest _$result;
    try {
      _$result =
          _$v ??
          _$AdminUpdateUserPermissionsRequest._(
            grants: grants.build(),
            denies: denies.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'grants';
        grants.build();
        _$failedField = 'denies';
        denies.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminUpdateUserPermissionsRequest',
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
