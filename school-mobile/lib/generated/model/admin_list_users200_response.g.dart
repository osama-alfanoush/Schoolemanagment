// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_list_users200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminListUsers200Response extends AdminListUsers200Response {
  @override
  final AdminListUsers200ResponseData data;

  factory _$AdminListUsers200Response([
    void Function(AdminListUsers200ResponseBuilder)? updates,
  ]) => (AdminListUsers200ResponseBuilder()..update(updates))._build();

  _$AdminListUsers200Response._({required this.data}) : super._();
  @override
  AdminListUsers200Response rebuild(
    void Function(AdminListUsers200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminListUsers200ResponseBuilder toBuilder() =>
      AdminListUsers200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminListUsers200Response && data == other.data;
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
      r'AdminListUsers200Response',
    )..add('data', data)).toString();
  }
}

class AdminListUsers200ResponseBuilder
    implements
        Builder<AdminListUsers200Response, AdminListUsers200ResponseBuilder> {
  _$AdminListUsers200Response? _$v;

  AdminListUsers200ResponseDataBuilder? _data;
  AdminListUsers200ResponseDataBuilder get data =>
      _$this._data ??= AdminListUsers200ResponseDataBuilder();
  set data(AdminListUsers200ResponseDataBuilder? data) => _$this._data = data;

  AdminListUsers200ResponseBuilder() {
    AdminListUsers200Response._defaults(this);
  }

  AdminListUsers200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminListUsers200Response other) {
    _$v = other as _$AdminListUsers200Response;
  }

  @override
  void update(void Function(AdminListUsers200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminListUsers200Response build() => _build();

  _$AdminListUsers200Response _build() {
    _$AdminListUsers200Response _$result;
    try {
      _$result = _$v ?? _$AdminListUsers200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminListUsers200Response',
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
