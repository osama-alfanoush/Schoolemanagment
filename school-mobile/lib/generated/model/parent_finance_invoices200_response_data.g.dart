// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_invoices200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceInvoices200ResponseData
    extends ParentFinanceInvoices200ResponseData {
  @override
  final BuiltList<String> invoices;

  factory _$ParentFinanceInvoices200ResponseData([
    void Function(ParentFinanceInvoices200ResponseDataBuilder)? updates,
  ]) =>
      (ParentFinanceInvoices200ResponseDataBuilder()..update(updates))._build();

  _$ParentFinanceInvoices200ResponseData._({required this.invoices})
    : super._();
  @override
  ParentFinanceInvoices200ResponseData rebuild(
    void Function(ParentFinanceInvoices200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInvoices200ResponseDataBuilder toBuilder() =>
      ParentFinanceInvoices200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInvoices200ResponseData &&
        invoices == other.invoices;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invoices.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentFinanceInvoices200ResponseData',
    )..add('invoices', invoices)).toString();
  }
}

class ParentFinanceInvoices200ResponseDataBuilder
    implements
        Builder<
          ParentFinanceInvoices200ResponseData,
          ParentFinanceInvoices200ResponseDataBuilder
        > {
  _$ParentFinanceInvoices200ResponseData? _$v;

  ListBuilder<String>? _invoices;
  ListBuilder<String> get invoices =>
      _$this._invoices ??= ListBuilder<String>();
  set invoices(ListBuilder<String>? invoices) => _$this._invoices = invoices;

  ParentFinanceInvoices200ResponseDataBuilder() {
    ParentFinanceInvoices200ResponseData._defaults(this);
  }

  ParentFinanceInvoices200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoices = $v.invoices.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInvoices200ResponseData other) {
    _$v = other as _$ParentFinanceInvoices200ResponseData;
  }

  @override
  void update(
    void Function(ParentFinanceInvoices200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInvoices200ResponseData build() => _build();

  _$ParentFinanceInvoices200ResponseData _build() {
    _$ParentFinanceInvoices200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentFinanceInvoices200ResponseData._(invoices: invoices.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invoices';
        invoices.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceInvoices200ResponseData',
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
