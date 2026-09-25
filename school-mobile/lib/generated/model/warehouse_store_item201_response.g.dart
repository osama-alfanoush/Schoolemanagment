// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_item201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreItem201Response extends WarehouseStoreItem201Response {
  @override
  final WarehouseItem? data;

  factory _$WarehouseStoreItem201Response([
    void Function(WarehouseStoreItem201ResponseBuilder)? updates,
  ]) => (WarehouseStoreItem201ResponseBuilder()..update(updates))._build();

  _$WarehouseStoreItem201Response._({this.data}) : super._();
  @override
  WarehouseStoreItem201Response rebuild(
    void Function(WarehouseStoreItem201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreItem201ResponseBuilder toBuilder() =>
      WarehouseStoreItem201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreItem201Response && data == other.data;
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
      r'WarehouseStoreItem201Response',
    )..add('data', data)).toString();
  }
}

class WarehouseStoreItem201ResponseBuilder
    implements
        Builder<
          WarehouseStoreItem201Response,
          WarehouseStoreItem201ResponseBuilder
        > {
  _$WarehouseStoreItem201Response? _$v;

  WarehouseItemBuilder? _data;
  WarehouseItemBuilder get data => _$this._data ??= WarehouseItemBuilder();
  set data(WarehouseItemBuilder? data) => _$this._data = data;

  WarehouseStoreItem201ResponseBuilder() {
    WarehouseStoreItem201Response._defaults(this);
  }

  WarehouseStoreItem201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreItem201Response other) {
    _$v = other as _$WarehouseStoreItem201Response;
  }

  @override
  void update(void Function(WarehouseStoreItem201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreItem201Response build() => _build();

  _$WarehouseStoreItem201Response _build() {
    _$WarehouseStoreItem201Response _$result;
    try {
      _$result = _$v ?? _$WarehouseStoreItem201Response._(data: _data?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStoreItem201Response',
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
