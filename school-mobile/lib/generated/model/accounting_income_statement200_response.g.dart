// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_income_statement200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIncomeStatement200Response
    extends AccountingIncomeStatement200Response {
  @override
  final AccountingIncomeStatement200ResponseData data;

  factory _$AccountingIncomeStatement200Response([
    void Function(AccountingIncomeStatement200ResponseBuilder)? updates,
  ]) =>
      (AccountingIncomeStatement200ResponseBuilder()..update(updates))._build();

  _$AccountingIncomeStatement200Response._({required this.data}) : super._();
  @override
  AccountingIncomeStatement200Response rebuild(
    void Function(AccountingIncomeStatement200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIncomeStatement200ResponseBuilder toBuilder() =>
      AccountingIncomeStatement200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIncomeStatement200Response && data == other.data;
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
      r'AccountingIncomeStatement200Response',
    )..add('data', data)).toString();
  }
}

class AccountingIncomeStatement200ResponseBuilder
    implements
        Builder<
          AccountingIncomeStatement200Response,
          AccountingIncomeStatement200ResponseBuilder
        > {
  _$AccountingIncomeStatement200Response? _$v;

  AccountingIncomeStatement200ResponseDataBuilder? _data;
  AccountingIncomeStatement200ResponseDataBuilder get data =>
      _$this._data ??= AccountingIncomeStatement200ResponseDataBuilder();
  set data(AccountingIncomeStatement200ResponseDataBuilder? data) =>
      _$this._data = data;

  AccountingIncomeStatement200ResponseBuilder() {
    AccountingIncomeStatement200Response._defaults(this);
  }

  AccountingIncomeStatement200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIncomeStatement200Response other) {
    _$v = other as _$AccountingIncomeStatement200Response;
  }

  @override
  void update(
    void Function(AccountingIncomeStatement200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIncomeStatement200Response build() => _build();

  _$AccountingIncomeStatement200Response _build() {
    _$AccountingIncomeStatement200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingIncomeStatement200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIncomeStatement200Response',
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
