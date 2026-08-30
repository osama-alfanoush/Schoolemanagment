// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry259422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry259422Response
    extends AccountingStoreJournalEntry259422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry259422Response([
    void Function(AccountingStoreJournalEntry259422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry259422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry259422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry259422Response rebuild(
    void Function(AccountingStoreJournalEntry259422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry259422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry259422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry259422Response &&
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
      r'AccountingStoreJournalEntry259422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry259422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry259422Response,
          AccountingStoreJournalEntry259422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry259422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry259422ResponseBuilder() {
    AccountingStoreJournalEntry259422Response._defaults(this);
  }

  AccountingStoreJournalEntry259422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry259422Response other) {
    _$v = other as _$AccountingStoreJournalEntry259422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry259422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry259422Response build() => _build();

  _$AccountingStoreJournalEntry259422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry259422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry259422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
