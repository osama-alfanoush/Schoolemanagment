// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_category201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreCategory201Response
    extends WarehouseStoreCategory201Response {
  @override
  final WarehouseCategory data;

  factory _$WarehouseStoreCategory201Response([
    void Function(WarehouseStoreCategory201ResponseBuilder)? updates,
  ]) => (WarehouseStoreCategory201ResponseBuilder()..update(updates))._build();

  _$WarehouseStoreCategory201Response._({required this.data}) : super._();
  @override
  WarehouseStoreCategory201Response rebuild(
    void Function(WarehouseStoreCategory201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreCategory201ResponseBuilder toBuilder() =>
      WarehouseStoreCategory201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreCategory201Response && data == other.data;
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
      r'WarehouseStoreCategory201Response',
    )..add('data', data)).toString();
  }
}

class WarehouseStoreCategory201ResponseBuilder
    implements
        Builder<
          WarehouseStoreCategory201Response,
          WarehouseStoreCategory201ResponseBuilder
        > {
  _$WarehouseStoreCategory201Response? _$v;

  WarehouseCategoryBuilder? _data;
  WarehouseCategoryBuilder get data =>
      _$this._data ??= WarehouseCategoryBuilder();
  set data(WarehouseCategoryBuilder? data) => _$this._data = data;

  WarehouseStoreCategory201ResponseBuilder() {
    WarehouseStoreCategory201Response._defaults(this);
  }

  WarehouseStoreCategory201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreCategory201Response other) {
    _$v = other as _$WarehouseStoreCategory201Response;
  }

  @override
  void update(
    void Function(WarehouseStoreCategory201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreCategory201Response build() => _build();

  _$WarehouseStoreCategory201Response _build() {
    _$WarehouseStoreCategory201Response _$result;
    try {
      _$result =
          _$v ?? _$WarehouseStoreCategory201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStoreCategory201Response',
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
