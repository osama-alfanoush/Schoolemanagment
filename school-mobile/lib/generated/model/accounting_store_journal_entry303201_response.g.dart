// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry303201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry303201Response
    extends AccountingStoreJournalEntry303201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry303201Response([
    void Function(AccountingStoreJournalEntry303201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry303201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry303201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry303201Response rebuild(
    void Function(AccountingStoreJournalEntry303201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry303201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry303201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry303201Response &&
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
      r'AccountingStoreJournalEntry303201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry303201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry303201Response,
          AccountingStoreJournalEntry303201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry303201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry303201ResponseBuilder() {
    AccountingStoreJournalEntry303201Response._defaults(this);
  }

  AccountingStoreJournalEntry303201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry303201Response other) {
    _$v = other as _$AccountingStoreJournalEntry303201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry303201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry303201Response build() => _build();

  _$AccountingStoreJournalEntry303201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry303201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry303201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
