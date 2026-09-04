// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_invoices200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceInvoices200Response
    extends ParentFinanceInvoices200Response {
  @override
  final ParentFinanceInvoices200ResponseData data;

  factory _$ParentFinanceInvoices200Response([
    void Function(ParentFinanceInvoices200ResponseBuilder)? updates,
  ]) => (ParentFinanceInvoices200ResponseBuilder()..update(updates))._build();

  _$ParentFinanceInvoices200Response._({required this.data}) : super._();
  @override
  ParentFinanceInvoices200Response rebuild(
    void Function(ParentFinanceInvoices200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInvoices200ResponseBuilder toBuilder() =>
      ParentFinanceInvoices200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInvoices200Response && data == other.data;
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
      r'ParentFinanceInvoices200Response',
    )..add('data', data)).toString();
  }
}

class ParentFinanceInvoices200ResponseBuilder
    implements
        Builder<
          ParentFinanceInvoices200Response,
          ParentFinanceInvoices200ResponseBuilder
        > {
  _$ParentFinanceInvoices200Response? _$v;

  ParentFinanceInvoices200ResponseDataBuilder? _data;
  ParentFinanceInvoices200ResponseDataBuilder get data =>
      _$this._data ??= ParentFinanceInvoices200ResponseDataBuilder();
  set data(ParentFinanceInvoices200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentFinanceInvoices200ResponseBuilder() {
    ParentFinanceInvoices200Response._defaults(this);
  }

  ParentFinanceInvoices200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInvoices200Response other) {
    _$v = other as _$ParentFinanceInvoices200Response;
  }

  @override
  void update(void Function(ParentFinanceInvoices200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInvoices200Response build() => _build();

  _$ParentFinanceInvoices200Response _build() {
    _$ParentFinanceInvoices200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentFinanceInvoices200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceInvoices200Response',
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
