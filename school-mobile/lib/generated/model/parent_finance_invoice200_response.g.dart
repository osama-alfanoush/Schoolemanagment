// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_invoice200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceInvoice200Response
    extends ParentFinanceInvoice200Response {
  @override
  final BuiltMap<String, JsonObject?> data;

  factory _$ParentFinanceInvoice200Response([
    void Function(ParentFinanceInvoice200ResponseBuilder)? updates,
  ]) => (ParentFinanceInvoice200ResponseBuilder()..update(updates))._build();

  _$ParentFinanceInvoice200Response._({required this.data}) : super._();
  @override
  ParentFinanceInvoice200Response rebuild(
    void Function(ParentFinanceInvoice200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInvoice200ResponseBuilder toBuilder() =>
      ParentFinanceInvoice200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInvoice200Response && data == other.data;
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
      r'ParentFinanceInvoice200Response',
    )..add('data', data)).toString();
  }
}

class ParentFinanceInvoice200ResponseBuilder
    implements
        Builder<
          ParentFinanceInvoice200Response,
          ParentFinanceInvoice200ResponseBuilder
        > {
  _$ParentFinanceInvoice200Response? _$v;

  MapBuilder<String, JsonObject?>? _data;
  MapBuilder<String, JsonObject?> get data =>
      _$this._data ??= MapBuilder<String, JsonObject?>();
  set data(MapBuilder<String, JsonObject?>? data) => _$this._data = data;

  ParentFinanceInvoice200ResponseBuilder() {
    ParentFinanceInvoice200Response._defaults(this);
  }

  ParentFinanceInvoice200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInvoice200Response other) {
    _$v = other as _$ParentFinanceInvoice200Response;
  }

  @override
  void update(void Function(ParentFinanceInvoice200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInvoice200Response build() => _build();

  _$ParentFinanceInvoice200Response _build() {
    _$ParentFinanceInvoice200Response _$result;
    try {
      _$result = _$v ?? _$ParentFinanceInvoice200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceInvoice200Response',
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
