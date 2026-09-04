// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry285201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry285201Response
    extends AccountingStoreJournalEntry285201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry285201Response([
    void Function(AccountingStoreJournalEntry285201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry285201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry285201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry285201Response rebuild(
    void Function(AccountingStoreJournalEntry285201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry285201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry285201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry285201Response &&
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
      r'AccountingStoreJournalEntry285201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry285201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry285201Response,
          AccountingStoreJournalEntry285201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry285201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry285201ResponseBuilder() {
    AccountingStoreJournalEntry285201Response._defaults(this);
  }

  AccountingStoreJournalEntry285201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry285201Response other) {
    _$v = other as _$AccountingStoreJournalEntry285201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry285201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry285201Response build() => _build();

  _$AccountingStoreJournalEntry285201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry285201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry285201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
