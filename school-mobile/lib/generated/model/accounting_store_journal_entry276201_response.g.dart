// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry276201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry276201Response
    extends AccountingStoreJournalEntry276201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry276201Response([
    void Function(AccountingStoreJournalEntry276201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry276201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry276201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry276201Response rebuild(
    void Function(AccountingStoreJournalEntry276201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry276201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry276201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry276201Response &&
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
      r'AccountingStoreJournalEntry276201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry276201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry276201Response,
          AccountingStoreJournalEntry276201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry276201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry276201ResponseBuilder() {
    AccountingStoreJournalEntry276201Response._defaults(this);
  }

  AccountingStoreJournalEntry276201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry276201Response other) {
    _$v = other as _$AccountingStoreJournalEntry276201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry276201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry276201Response build() => _build();

  _$AccountingStoreJournalEntry276201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry276201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry276201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
