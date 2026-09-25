// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry303422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry303422Response
    extends AccountingStoreJournalEntry303422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry303422Response([
    void Function(AccountingStoreJournalEntry303422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry303422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry303422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry303422Response rebuild(
    void Function(AccountingStoreJournalEntry303422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry303422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry303422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry303422Response &&
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
      r'AccountingStoreJournalEntry303422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry303422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry303422Response,
          AccountingStoreJournalEntry303422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry303422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry303422ResponseBuilder() {
    AccountingStoreJournalEntry303422Response._defaults(this);
  }

  AccountingStoreJournalEntry303422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry303422Response other) {
    _$v = other as _$AccountingStoreJournalEntry303422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry303422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry303422Response build() => _build();

  _$AccountingStoreJournalEntry303422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry303422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry303422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
