// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_consumption_report200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseConsumptionReport200Response
    extends WarehouseConsumptionReport200Response {
  @override
  final BuiltList<WarehouseConsumptionReport200ResponseDataInner> data;

  factory _$WarehouseConsumptionReport200Response([
    void Function(WarehouseConsumptionReport200ResponseBuilder)? updates,
  ]) => (WarehouseConsumptionReport200ResponseBuilder()..update(updates))
      ._build();

  _$WarehouseConsumptionReport200Response._({required this.data}) : super._();
  @override
  WarehouseConsumptionReport200Response rebuild(
    void Function(WarehouseConsumptionReport200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseConsumptionReport200ResponseBuilder toBuilder() =>
      WarehouseConsumptionReport200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseConsumptionReport200Response && data == other.data;
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
      r'WarehouseConsumptionReport200Response',
    )..add('data', data)).toString();
  }
}

class WarehouseConsumptionReport200ResponseBuilder
    implements
        Builder<
          WarehouseConsumptionReport200Response,
          WarehouseConsumptionReport200ResponseBuilder
        > {
  _$WarehouseConsumptionReport200Response? _$v;

  ListBuilder<WarehouseConsumptionReport200ResponseDataInner>? _data;
  ListBuilder<WarehouseConsumptionReport200ResponseDataInner> get data =>
      _$this._data ??=
          ListBuilder<WarehouseConsumptionReport200ResponseDataInner>();
  set data(ListBuilder<WarehouseConsumptionReport200ResponseDataInner>? data) =>
      _$this._data = data;

  WarehouseConsumptionReport200ResponseBuilder() {
    WarehouseConsumptionReport200Response._defaults(this);
  }

  WarehouseConsumptionReport200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseConsumptionReport200Response other) {
    _$v = other as _$WarehouseConsumptionReport200Response;
  }

  @override
  void update(
    void Function(WarehouseConsumptionReport200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseConsumptionReport200Response build() => _build();

  _$WarehouseConsumptionReport200Response _build() {
    _$WarehouseConsumptionReport200Response _$result;
    try {
      _$result =
          _$v ?? _$WarehouseConsumptionReport200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseConsumptionReport200Response',
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
