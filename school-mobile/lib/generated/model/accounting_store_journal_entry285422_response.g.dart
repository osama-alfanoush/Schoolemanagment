// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry285422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry285422Response
    extends AccountingStoreJournalEntry285422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry285422Response([
    void Function(AccountingStoreJournalEntry285422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry285422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry285422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry285422Response rebuild(
    void Function(AccountingStoreJournalEntry285422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry285422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry285422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry285422Response &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AccountingStoreJournalEntry285422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry285422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry285422Response,
          AccountingStoreJournalEntry285422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry285422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry285422ResponseBuilder() {
    AccountingStoreJournalEntry285422Response._defaults(this);
  }

  AccountingStoreJournalEntry285422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry285422Response other) {
    _$v = other as _$AccountingStoreJournalEntry285422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry285422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry285422Response build() => _build();

  _$AccountingStoreJournalEntry285422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry285422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry285422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
