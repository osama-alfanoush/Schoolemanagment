// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_journal_entries200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexJournalEntries200Response
    extends AccountingIndexJournalEntries200Response {
  @override
  final AccountingIndexJournalEntries200ResponseData data;

  factory _$AccountingIndexJournalEntries200Response([
    void Function(AccountingIndexJournalEntries200ResponseBuilder)? updates,
  ]) => (AccountingIndexJournalEntries200ResponseBuilder()..update(updates))
      ._build();

  _$AccountingIndexJournalEntries200Response._({required this.data})
    : super._();
  @override
  AccountingIndexJournalEntries200Response rebuild(
    void Function(AccountingIndexJournalEntries200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexJournalEntries200ResponseBuilder toBuilder() =>
      AccountingIndexJournalEntries200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexJournalEntries200Response &&
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
      r'AccountingIndexJournalEntries200Response',
    )..add('data', data)).toString();
  }
}

class AccountingIndexJournalEntries200ResponseBuilder
    implements
        Builder<
          AccountingIndexJournalEntries200Response,
          AccountingIndexJournalEntries200ResponseBuilder
        > {
  _$AccountingIndexJournalEntries200Response? _$v;

  AccountingIndexJournalEntries200ResponseDataBuilder? _data;
  AccountingIndexJournalEntries200ResponseDataBuilder get data =>
      _$this._data ??= AccountingIndexJournalEntries200ResponseDataBuilder();
  set data(AccountingIndexJournalEntries200ResponseDataBuilder? data) =>
      _$this._data = data;

  AccountingIndexJournalEntries200ResponseBuilder() {
    AccountingIndexJournalEntries200Response._defaults(this);
  }

  AccountingIndexJournalEntries200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexJournalEntries200Response other) {
    _$v = other as _$AccountingIndexJournalEntries200Response;
  }

  @override
  void update(
    void Function(AccountingIndexJournalEntries200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexJournalEntries200Response build() => _build();

  _$AccountingIndexJournalEntries200Response _build() {
    _$AccountingIndexJournalEntries200Response _$result;
    try {
      _$result =
          _$v ??
          _$AccountingIndexJournalEntries200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIndexJournalEntries200Response',
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
