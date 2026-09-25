// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_purchase_request201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStorePurchaseRequest201Response
    extends WarehouseStorePurchaseRequest201Response {
  @override
  final PurchaseRequest data;

  factory _$WarehouseStorePurchaseRequest201Response([
    void Function(WarehouseStorePurchaseRequest201ResponseBuilder)? updates,
  ]) => (WarehouseStorePurchaseRequest201ResponseBuilder()..update(updates))
      ._build();

  _$WarehouseStorePurchaseRequest201Response._({required this.data})
    : super._();
  @override
  WarehouseStorePurchaseRequest201Response rebuild(
    void Function(WarehouseStorePurchaseRequest201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStorePurchaseRequest201ResponseBuilder toBuilder() =>
      WarehouseStorePurchaseRequest201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStorePurchaseRequest201Response &&
        data == other.data;
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
      r'WarehouseStorePurchaseRequest201Response',
    )..add('data', data)).toString();
  }
}

class WarehouseStorePurchaseRequest201ResponseBuilder
    implements
        Builder<
          WarehouseStorePurchaseRequest201Response,
          WarehouseStorePurchaseRequest201ResponseBuilder
        > {
  _$WarehouseStorePurchaseRequest201Response? _$v;

  PurchaseRequestBuilder? _data;
  PurchaseRequestBuilder get data => _$this._data ??= PurchaseRequestBuilder();
  set data(PurchaseRequestBuilder? data) => _$this._data = data;

  WarehouseStorePurchaseRequest201ResponseBuilder() {
    WarehouseStorePurchaseRequest201Response._defaults(this);
  }

  WarehouseStorePurchaseRequest201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStorePurchaseRequest201Response other) {
    _$v = other as _$WarehouseStorePurchaseRequest201Response;
  }

  @override
  void update(
    void Function(WarehouseStorePurchaseRequest201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStorePurchaseRequest201Response build() => _build();

  _$WarehouseStorePurchaseRequest201Response _build() {
    _$WarehouseStorePurchaseRequest201Response _$result;
    try {
      _$result =
          _$v ??
          _$WarehouseStorePurchaseRequest201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseStorePurchaseRequest201Response',
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
