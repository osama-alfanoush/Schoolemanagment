// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry262201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry262201Response
    extends AccountingStoreJournalEntry262201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry262201Response([
    void Function(AccountingStoreJournalEntry262201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry262201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry262201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry262201Response rebuild(
    void Function(AccountingStoreJournalEntry262201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry262201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry262201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry262201Response &&
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
      r'AccountingStoreJournalEntry262201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry262201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry262201Response,
          AccountingStoreJournalEntry262201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry262201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry262201ResponseBuilder() {
    AccountingStoreJournalEntry262201Response._defaults(this);
  }

  AccountingStoreJournalEntry262201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry262201Response other) {
    _$v = other as _$AccountingStoreJournalEntry262201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry262201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry262201Response build() => _build();

  _$AccountingStoreJournalEntry262201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry262201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry262201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
