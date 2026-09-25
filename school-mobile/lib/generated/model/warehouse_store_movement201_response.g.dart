// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_movement201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreMovement201Response
    extends WarehouseStoreMovement201Response {
  @override
  final StockMovement data;

  factory _$WarehouseStoreMovement201Response([
    void Function(WarehouseStoreMovement201ResponseBuilder)? updates,
  ]) => (WarehouseStoreMovement201ResponseBuilder()..update(updates))._build();

  _$WarehouseStoreMovement201Response._({required this.data}) : super._();
  @override
  WarehouseStoreMovement201Response rebuild(
    void Function(WarehouseStoreMovement201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreMovement201ResponseBuilder toBuilder() =>
      WarehouseStoreMovement201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreMovement201Response && data == other.data;
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
      r'WarehouseStoreMovement201Response',
    )..add('data', data)).toString();
  }
}

class WarehouseStoreMovement201ResponseBuilder
    implements
        Builder<
          WarehouseStoreMovement201Response,
          WarehouseStoreMovement201ResponseBuilder
        > {
  _$WarehouseStoreMovement201Response? _$v;

  StockMovementBuilder? _data;
  StockMovementBuilder get data => _$this._data ??= StockMovementBuilder();
  set data(StockMovementBuilder? data) => _$this._data = data;

  WarehouseStoreMovement201ResponseBuilder() {
    WarehouseStoreMovement201Response._defaults(this);
  }

  WarehouseStoreMovement201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreMovement201Response other) {
    _$v = other as _$WarehouseStoreMovement201Response;
  }

  @override
  void update(
    void Function(WarehouseStoreMovement201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreMovement201Response build() => _build();

  _$WarehouseStoreMovement201Response _build() {
    _$WarehouseStoreMovement201Response _$result;
    try {
      _$result =
          _$v ?? _$WarehouseStoreMovement201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStoreMovement201Response',
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
