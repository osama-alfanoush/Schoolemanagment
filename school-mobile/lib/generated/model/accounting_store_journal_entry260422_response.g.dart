// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry260422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry260422Response
    extends AccountingStoreJournalEntry260422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry260422Response([
    void Function(AccountingStoreJournalEntry260422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry260422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry260422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry260422Response rebuild(
    void Function(AccountingStoreJournalEntry260422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry260422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry260422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry260422Response &&
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
      r'AccountingStoreJournalEntry260422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry260422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry260422Response,
          AccountingStoreJournalEntry260422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry260422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry260422ResponseBuilder() {
    AccountingStoreJournalEntry260422Response._defaults(this);
  }

  AccountingStoreJournalEntry260422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry260422Response other) {
    _$v = other as _$AccountingStoreJournalEntry260422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry260422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry260422Response build() => _build();

  _$AccountingStoreJournalEntry260422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry260422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry260422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
