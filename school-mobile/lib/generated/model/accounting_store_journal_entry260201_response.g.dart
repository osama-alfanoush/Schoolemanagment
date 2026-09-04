// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry260201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry260201Response
    extends AccountingStoreJournalEntry260201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry260201Response([
    void Function(AccountingStoreJournalEntry260201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry260201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry260201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry260201Response rebuild(
    void Function(AccountingStoreJournalEntry260201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry260201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry260201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry260201Response &&
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
      r'AccountingStoreJournalEntry260201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry260201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry260201Response,
          AccountingStoreJournalEntry260201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry260201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry260201ResponseBuilder() {
    AccountingStoreJournalEntry260201Response._defaults(this);
  }

  AccountingStoreJournalEntry260201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry260201Response other) {
    _$v = other as _$AccountingStoreJournalEntry260201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry260201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry260201Response build() => _build();

  _$AccountingStoreJournalEntry260201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry260201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry260201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
