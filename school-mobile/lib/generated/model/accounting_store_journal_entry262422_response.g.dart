// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry262422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry262422Response
    extends AccountingStoreJournalEntry262422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry262422Response([
    void Function(AccountingStoreJournalEntry262422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry262422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry262422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry262422Response rebuild(
    void Function(AccountingStoreJournalEntry262422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry262422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry262422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry262422Response &&
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
      r'AccountingStoreJournalEntry262422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry262422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry262422Response,
          AccountingStoreJournalEntry262422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry262422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry262422ResponseBuilder() {
    AccountingStoreJournalEntry262422Response._defaults(this);
  }

  AccountingStoreJournalEntry262422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry262422Response other) {
    _$v = other as _$AccountingStoreJournalEntry262422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry262422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry262422Response build() => _build();

  _$AccountingStoreJournalEntry262422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry262422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry262422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
