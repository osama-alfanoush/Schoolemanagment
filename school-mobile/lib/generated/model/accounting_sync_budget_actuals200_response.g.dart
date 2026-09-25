// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_sync_budget_actuals200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingSyncBudgetActuals200Response
    extends AccountingSyncBudgetActuals200Response {
  @override
  final AccountingSyncBudgetActuals200ResponseData data;

  factory _$AccountingSyncBudgetActuals200Response([
    void Function(AccountingSyncBudgetActuals200ResponseBuilder)? updates,
  ]) => (AccountingSyncBudgetActuals200ResponseBuilder()..update(updates))
      ._build();

  _$AccountingSyncBudgetActuals200Response._({required this.data}) : super._();
  @override
  AccountingSyncBudgetActuals200Response rebuild(
    void Function(AccountingSyncBudgetActuals200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingSyncBudgetActuals200ResponseBuilder toBuilder() =>
      AccountingSyncBudgetActuals200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingSyncBudgetActuals200Response &&
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
      r'AccountingSyncBudgetActuals200Response',
    )..add('data', data)).toString();
  }
}

class AccountingSyncBudgetActuals200ResponseBuilder
    implements
        Builder<
          AccountingSyncBudgetActuals200Response,
          AccountingSyncBudgetActuals200ResponseBuilder
        > {
  _$AccountingSyncBudgetActuals200Response? _$v;

  AccountingSyncBudgetActuals200ResponseDataBuilder? _data;
  AccountingSyncBudgetActuals200ResponseDataBuilder get data =>
      _$this._data ??= AccountingSyncBudgetActuals200ResponseDataBuilder();
  set data(AccountingSyncBudgetActuals200ResponseDataBuilder? data) =>
      _$this._data = data;

  AccountingSyncBudgetActuals200ResponseBuilder() {
    AccountingSyncBudgetActuals200Response._defaults(this);
  }

  AccountingSyncBudgetActuals200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingSyncBudgetActuals200Response other) {
    _$v = other as _$AccountingSyncBudgetActuals200Response;
  }

  @override
  void update(
    void Function(AccountingSyncBudgetActuals200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingSyncBudgetActuals200Response build() => _build();

  _$AccountingSyncBudgetActuals200Response _build() {
    _$AccountingSyncBudgetActuals200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingSyncBudgetActuals200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingSyncBudgetActuals200Response',
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
