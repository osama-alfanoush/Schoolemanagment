// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_list_permissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminListPermissions200Response
    extends AdminListPermissions200Response {
  @override
  final BuiltList<BuiltList<String>> data;

  factory _$AdminListPermissions200Response([
    void Function(AdminListPermissions200ResponseBuilder)? updates,
  ]) => (AdminListPermissions200ResponseBuilder()..update(updates))._build();

  _$AdminListPermissions200Response._({required this.data}) : super._();
  @override
  AdminListPermissions200Response rebuild(
    void Function(AdminListPermissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminListPermissions200ResponseBuilder toBuilder() =>
      AdminListPermissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminListPermissions200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminListPermissions200Response',
    )..add('data', data)).toString();
  }
}

class AdminListPermissions200ResponseBuilder
    implements
        Builder<
          AdminListPermissions200Response,
          AdminListPermissions200ResponseBuilder
        > {
  _$AdminListPermissions200Response? _$v;

  ListBuilder<BuiltList<String>>? _data;
  ListBuilder<BuiltList<String>> get data =>
      _$this._data ??= ListBuilder<BuiltList<String>>();
  set data(ListBuilder<BuiltList<String>>? data) => _$this._data = data;

  AdminListPermissions200ResponseBuilder() {
    AdminListPermissions200Response._defaults(this);
  }

  AdminListPermissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminListPermissions200Response other) {
    _$v = other as _$AdminListPermissions200Response;
  }

  @override
  void update(void Function(AdminListPermissions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminListPermissions200Response build() => _build();

  _$AdminListPermissions200Response _build() {
    _$AdminListPermissions200Response _$result;
    try {
      _$result = _$v ?? _$AdminListPermissions200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminListPermissions200Response',
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
