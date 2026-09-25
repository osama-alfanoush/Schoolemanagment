// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_closings200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexClosings200Response
    extends AccountingIndexClosings200Response {
  @override
  final BuiltList<FinancialClosing> data;

  factory _$AccountingIndexClosings200Response([
    void Function(AccountingIndexClosings200ResponseBuilder)? updates,
  ]) => (AccountingIndexClosings200ResponseBuilder()..update(updates))._build();

  _$AccountingIndexClosings200Response._({required this.data}) : super._();
  @override
  AccountingIndexClosings200Response rebuild(
    void Function(AccountingIndexClosings200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexClosings200ResponseBuilder toBuilder() =>
      AccountingIndexClosings200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexClosings200Response && data == other.data;
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
      r'AccountingIndexClosings200Response',
    )..add('data', data)).toString();
  }
}

class AccountingIndexClosings200ResponseBuilder
    implements
        Builder<
          AccountingIndexClosings200Response,
          AccountingIndexClosings200ResponseBuilder
        > {
  _$AccountingIndexClosings200Response? _$v;

  ListBuilder<FinancialClosing>? _data;
  ListBuilder<FinancialClosing> get data =>
      _$this._data ??= ListBuilder<FinancialClosing>();
  set data(ListBuilder<FinancialClosing>? data) => _$this._data = data;

  AccountingIndexClosings200ResponseBuilder() {
    AccountingIndexClosings200Response._defaults(this);
  }

  AccountingIndexClosings200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexClosings200Response other) {
    _$v = other as _$AccountingIndexClosings200Response;
  }

  @override
  void update(
    void Function(AccountingIndexClosings200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexClosings200Response build() => _build();

  _$AccountingIndexClosings200Response _build() {
    _$AccountingIndexClosings200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingIndexClosings200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIndexClosings200Response',
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
