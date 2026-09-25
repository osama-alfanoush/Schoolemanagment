// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_show_journal_entry200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingShowJournalEntry200Response
    extends AccountingShowJournalEntry200Response {
  @override
  final JournalEntry? data;

  factory _$AccountingShowJournalEntry200Response([
    void Function(AccountingShowJournalEntry200ResponseBuilder)? updates,
  ]) => (AccountingShowJournalEntry200ResponseBuilder()..update(updates))
      ._build();

  _$AccountingShowJournalEntry200Response._({this.data}) : super._();
  @override
  AccountingShowJournalEntry200Response rebuild(
    void Function(AccountingShowJournalEntry200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingShowJournalEntry200ResponseBuilder toBuilder() =>
      AccountingShowJournalEntry200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingShowJournalEntry200Response && data == other.data;
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
      r'AccountingShowJournalEntry200Response',
    )..add('data', data)).toString();
  }
}

class AccountingShowJournalEntry200ResponseBuilder
    implements
        Builder<
          AccountingShowJournalEntry200Response,
          AccountingShowJournalEntry200ResponseBuilder
        > {
  _$AccountingShowJournalEntry200Response? _$v;

  JournalEntryBuilder? _data;
  JournalEntryBuilder get data => _$this._data ??= JournalEntryBuilder();
  set data(JournalEntryBuilder? data) => _$this._data = data;

  AccountingShowJournalEntry200ResponseBuilder() {
    AccountingShowJournalEntry200Response._defaults(this);
  }

  AccountingShowJournalEntry200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingShowJournalEntry200Response other) {
    _$v = other as _$AccountingShowJournalEntry200Response;
  }

  @override
  void update(
    void Function(AccountingShowJournalEntry200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingShowJournalEntry200Response build() => _build();

  _$AccountingShowJournalEntry200Response _build() {
    _$AccountingShowJournalEntry200Response _$result;
    try {
      _$result =
          _$v ??
          _$AccountingShowJournalEntry200Response._(data: _data?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingShowJournalEntry200Response',
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
