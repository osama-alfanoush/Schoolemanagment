// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry259201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry259201Response
    extends AccountingStoreJournalEntry259201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry259201Response([
    void Function(AccountingStoreJournalEntry259201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry259201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry259201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry259201Response rebuild(
    void Function(AccountingStoreJournalEntry259201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry259201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry259201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry259201Response &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AccountingStoreJournalEntry259201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry259201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry259201Response,
          AccountingStoreJournalEntry259201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry259201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry259201ResponseBuilder() {
    AccountingStoreJournalEntry259201Response._defaults(this);
  }

  AccountingStoreJournalEntry259201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry259201Response other) {
    _$v = other as _$AccountingStoreJournalEntry259201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry259201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry259201Response build() => _build();

  _$AccountingStoreJournalEntry259201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry259201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry259201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
