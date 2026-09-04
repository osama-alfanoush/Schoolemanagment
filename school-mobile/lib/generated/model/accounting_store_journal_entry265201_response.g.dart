// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry265201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry265201Response
    extends AccountingStoreJournalEntry265201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry265201Response([
    void Function(AccountingStoreJournalEntry265201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry265201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry265201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry265201Response rebuild(
    void Function(AccountingStoreJournalEntry265201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry265201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry265201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry265201Response &&
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
      r'AccountingStoreJournalEntry265201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry265201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry265201Response,
          AccountingStoreJournalEntry265201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry265201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry265201ResponseBuilder() {
    AccountingStoreJournalEntry265201Response._defaults(this);
  }

  AccountingStoreJournalEntry265201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry265201Response other) {
    _$v = other as _$AccountingStoreJournalEntry265201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry265201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry265201Response build() => _build();

  _$AccountingStoreJournalEntry265201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry265201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry265201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
