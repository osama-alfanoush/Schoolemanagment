// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry265422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry265422Response
    extends AccountingStoreJournalEntry265422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry265422Response([
    void Function(AccountingStoreJournalEntry265422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry265422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry265422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry265422Response rebuild(
    void Function(AccountingStoreJournalEntry265422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry265422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry265422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry265422Response &&
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
      r'AccountingStoreJournalEntry265422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry265422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry265422Response,
          AccountingStoreJournalEntry265422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry265422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry265422ResponseBuilder() {
    AccountingStoreJournalEntry265422Response._defaults(this);
  }

  AccountingStoreJournalEntry265422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry265422Response other) {
    _$v = other as _$AccountingStoreJournalEntry265422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry265422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry265422Response build() => _build();

  _$AccountingStoreJournalEntry265422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry265422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry265422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
