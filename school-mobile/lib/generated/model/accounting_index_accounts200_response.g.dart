// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_accounts200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexAccounts200Response
    extends AccountingIndexAccounts200Response {
  @override
  final BuiltList<ChartOfAccount> data;

  factory _$AccountingIndexAccounts200Response([
    void Function(AccountingIndexAccounts200ResponseBuilder)? updates,
  ]) => (AccountingIndexAccounts200ResponseBuilder()..update(updates))._build();

  _$AccountingIndexAccounts200Response._({required this.data}) : super._();
  @override
  AccountingIndexAccounts200Response rebuild(
    void Function(AccountingIndexAccounts200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexAccounts200ResponseBuilder toBuilder() =>
      AccountingIndexAccounts200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexAccounts200Response && data == other.data;
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
      r'AccountingIndexAccounts200Response',
    )..add('data', data)).toString();
  }
}

class AccountingIndexAccounts200ResponseBuilder
    implements
        Builder<
          AccountingIndexAccounts200Response,
          AccountingIndexAccounts200ResponseBuilder
        > {
  _$AccountingIndexAccounts200Response? _$v;

  ListBuilder<ChartOfAccount>? _data;
  ListBuilder<ChartOfAccount> get data =>
      _$this._data ??= ListBuilder<ChartOfAccount>();
  set data(ListBuilder<ChartOfAccount>? data) => _$this._data = data;

  AccountingIndexAccounts200ResponseBuilder() {
    AccountingIndexAccounts200Response._defaults(this);
  }

  AccountingIndexAccounts200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexAccounts200Response other) {
    _$v = other as _$AccountingIndexAccounts200Response;
  }

  @override
  void update(
    void Function(AccountingIndexAccounts200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexAccounts200Response build() => _build();

  _$AccountingIndexAccounts200Response _build() {
    _$AccountingIndexAccounts200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingIndexAccounts200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIndexAccounts200Response',
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
