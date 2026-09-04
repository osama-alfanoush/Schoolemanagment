// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry271201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry271201Response
    extends AccountingStoreJournalEntry271201Response {
  @override
  final AnyOf anyOf;

  factory _$AccountingStoreJournalEntry271201Response([
    void Function(AccountingStoreJournalEntry271201ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry271201ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry271201Response._({required this.anyOf})
    : super._();
  @override
  AccountingStoreJournalEntry271201Response rebuild(
    void Function(AccountingStoreJournalEntry271201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry271201ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry271201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry271201Response &&
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
      r'AccountingStoreJournalEntry271201Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class AccountingStoreJournalEntry271201ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry271201Response,
          AccountingStoreJournalEntry271201ResponseBuilder
        > {
  _$AccountingStoreJournalEntry271201Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AccountingStoreJournalEntry271201ResponseBuilder() {
    AccountingStoreJournalEntry271201Response._defaults(this);
  }

  AccountingStoreJournalEntry271201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry271201Response other) {
    _$v = other as _$AccountingStoreJournalEntry271201Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry271201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry271201Response build() => _build();

  _$AccountingStoreJournalEntry271201Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry271201Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AccountingStoreJournalEntry271201Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
