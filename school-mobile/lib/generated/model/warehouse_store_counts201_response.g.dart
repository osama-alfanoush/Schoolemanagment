// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_counts201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreCounts201Response
    extends WarehouseStoreCounts201Response {
  @override
  final BuiltList<InventoryCount> data;

  factory _$WarehouseStoreCounts201Response([
    void Function(WarehouseStoreCounts201ResponseBuilder)? updates,
  ]) => (WarehouseStoreCounts201ResponseBuilder()..update(updates))._build();

  _$WarehouseStoreCounts201Response._({required this.data}) : super._();
  @override
  WarehouseStoreCounts201Response rebuild(
    void Function(WarehouseStoreCounts201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreCounts201ResponseBuilder toBuilder() =>
      WarehouseStoreCounts201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreCounts201Response && data == other.data;
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
      r'WarehouseStoreCounts201Response',
    )..add('data', data)).toString();
  }
}

class WarehouseStoreCounts201ResponseBuilder
    implements
        Builder<
          WarehouseStoreCounts201Response,
          WarehouseStoreCounts201ResponseBuilder
        > {
  _$WarehouseStoreCounts201Response? _$v;

  ListBuilder<InventoryCount>? _data;
  ListBuilder<InventoryCount> get data =>
      _$this._data ??= ListBuilder<InventoryCount>();
  set data(ListBuilder<InventoryCount>? data) => _$this._data = data;

  WarehouseStoreCounts201ResponseBuilder() {
    WarehouseStoreCounts201Response._defaults(this);
  }

  WarehouseStoreCounts201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreCounts201Response other) {
    _$v = other as _$WarehouseStoreCounts201Response;
  }

  @override
  void update(void Function(WarehouseStoreCounts201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreCounts201Response build() => _build();

  _$WarehouseStoreCounts201Response _build() {
    _$WarehouseStoreCounts201Response _$result;
    try {
      _$result = _$v ?? _$WarehouseStoreCounts201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStoreCounts201Response',
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
