// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_trial_balance200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingTrialBalance200Response
    extends AccountingTrialBalance200Response {
  @override
  final BuiltList<AccountingTrialBalance200ResponseDataInner> data;

  factory _$AccountingTrialBalance200Response([
    void Function(AccountingTrialBalance200ResponseBuilder)? updates,
  ]) => (AccountingTrialBalance200ResponseBuilder()..update(updates))._build();

  _$AccountingTrialBalance200Response._({required this.data}) : super._();
  @override
  AccountingTrialBalance200Response rebuild(
    void Function(AccountingTrialBalance200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingTrialBalance200ResponseBuilder toBuilder() =>
      AccountingTrialBalance200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingTrialBalance200Response && data == other.data;
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
      r'AccountingTrialBalance200Response',
    )..add('data', data)).toString();
  }
}

class AccountingTrialBalance200ResponseBuilder
    implements
        Builder<
          AccountingTrialBalance200Response,
          AccountingTrialBalance200ResponseBuilder
        > {
  _$AccountingTrialBalance200Response? _$v;

  ListBuilder<AccountingTrialBalance200ResponseDataInner>? _data;
  ListBuilder<AccountingTrialBalance200ResponseDataInner> get data =>
      _$this._data ??=
          ListBuilder<AccountingTrialBalance200ResponseDataInner>();
  set data(ListBuilder<AccountingTrialBalance200ResponseDataInner>? data) =>
      _$this._data = data;

  AccountingTrialBalance200ResponseBuilder() {
    AccountingTrialBalance200Response._defaults(this);
  }

  AccountingTrialBalance200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingTrialBalance200Response other) {
    _$v = other as _$AccountingTrialBalance200Response;
  }

  @override
  void update(
    void Function(AccountingTrialBalance200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingTrialBalance200Response build() => _build();

  _$AccountingTrialBalance200Response _build() {
    _$AccountingTrialBalance200Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingTrialBalance200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingTrialBalance200Response',
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
