// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_balance_sheet200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingBalanceSheet200Response
    extends AccountingBalanceSheet200Response {
  @override
  final AccountingBalanceSheet200ResponseData data;

  factory _$AccountingBalanceSheet200Response([
    void Function(AccountingBalanceSheet200ResponseBuilder)? updates,
  ]) => (AccountingBalanceSheet200ResponseBuilder()..update(updates))._build();

  _$AccountingBalanceSheet200Response._({required this.data}) : super._();
  @override
  AccountingBalanceSheet200Response rebuild(
    void Function(AccountingBalanceSheet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingBalanceSheet200ResponseBuilder toBuilder() =>
      AccountingBalanceSheet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingBalanceSheet200Response && data == other.data;
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
      r'AccountingBalanceSheet200Response',
    )..add('data', data)).toString();
  }
}

class AccountingBalanceSheet200ResponseBuilder
    implements
        Builder<
          AccountingBalanceSheet200Response,
          AccountingBalanceSheet200ResponseBuilder
        > {
  _$AccountingBalanceSheet200Response? _$v;

  AccountingBalanceSheet200ResponseDataBuilder? _data;
  AccountingBalanceSheet200ResponseDataBuilder get data =>
      _$this._data ??= AccountingBalanceSheet200ResponseDataBuilder();
  set data(AccountingBalanceSheet200ResponseDataBuilder? data) =>
      _$this._data = data;

  AccountingBalanceSheet200ResponseBuilder() {
    AccountingBalanceSheet200Response._defaults(this);
  }

  AccountingBalanceSheet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingBalanceSheet200Response other) {
    _$v = other as _$AccountingBalanceSheet200Response;
  }

  @override
  void update(
    void Function(AccountingBalanceSheet200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingBalanceSheet200Response build() => _build();

  _$AccountingBalanceSheet200Response _build() {
    _$AccountingBalanceSheet200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingBalanceSheet200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingBalanceSheet200Response',
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
