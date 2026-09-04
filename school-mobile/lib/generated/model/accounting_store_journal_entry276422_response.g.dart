// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry276422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry276422Response
    extends AccountingStoreJournalEntry276422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry276422Response([
    void Function(AccountingStoreJournalEntry276422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry276422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry276422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry276422Response rebuild(
    void Function(AccountingStoreJournalEntry276422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry276422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry276422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry276422Response &&
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
      r'AccountingStoreJournalEntry276422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry276422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry276422Response,
          AccountingStoreJournalEntry276422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry276422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry276422ResponseBuilder() {
    AccountingStoreJournalEntry276422Response._defaults(this);
  }

  AccountingStoreJournalEntry276422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry276422Response other) {
    _$v = other as _$AccountingStoreJournalEntry276422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry276422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry276422Response build() => _build();

  _$AccountingStoreJournalEntry276422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry276422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry276422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
