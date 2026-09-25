// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_account201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreAccount201Response
    extends AccountingStoreAccount201Response {
  @override
  final ChartOfAccount data;

  factory _$AccountingStoreAccount201Response([
    void Function(AccountingStoreAccount201ResponseBuilder)? updates,
  ]) => (AccountingStoreAccount201ResponseBuilder()..update(updates))._build();

  _$AccountingStoreAccount201Response._({required this.data}) : super._();
  @override
  AccountingStoreAccount201Response rebuild(
    void Function(AccountingStoreAccount201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreAccount201ResponseBuilder toBuilder() =>
      AccountingStoreAccount201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreAccount201Response && data == other.data;
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
      r'AccountingStoreAccount201Response',
    )..add('data', data)).toString();
  }
}

class AccountingStoreAccount201ResponseBuilder
    implements
        Builder<
          AccountingStoreAccount201Response,
          AccountingStoreAccount201ResponseBuilder
        > {
  _$AccountingStoreAccount201Response? _$v;

  ChartOfAccountBuilder? _data;
  ChartOfAccountBuilder get data => _$this._data ??= ChartOfAccountBuilder();
  set data(ChartOfAccountBuilder? data) => _$this._data = data;

  AccountingStoreAccount201ResponseBuilder() {
    AccountingStoreAccount201Response._defaults(this);
  }

  AccountingStoreAccount201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreAccount201Response other) {
    _$v = other as _$AccountingStoreAccount201Response;
  }

  @override
  void update(
    void Function(AccountingStoreAccount201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreAccount201Response build() => _build();

  _$AccountingStoreAccount201Response _build() {
    _$AccountingStoreAccount201Response _$result;
    try {
      _$result =
          _$v ?? _$AccountingStoreAccount201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingStoreAccount201Response',
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
