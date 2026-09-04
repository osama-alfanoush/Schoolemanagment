// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_journal_entry271422_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingStoreJournalEntry271422Response
    extends AccountingStoreJournalEntry271422Response {
  @override
  final String message;

  factory _$AccountingStoreJournalEntry271422Response([
    void Function(AccountingStoreJournalEntry271422ResponseBuilder)? updates,
  ]) => (AccountingStoreJournalEntry271422ResponseBuilder()..update(updates))
      ._build();

  _$AccountingStoreJournalEntry271422Response._({required this.message})
    : super._();
  @override
  AccountingStoreJournalEntry271422Response rebuild(
    void Function(AccountingStoreJournalEntry271422ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreJournalEntry271422ResponseBuilder toBuilder() =>
      AccountingStoreJournalEntry271422ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreJournalEntry271422Response &&
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
      r'AccountingStoreJournalEntry271422Response',
    )..add('message', message)).toString();
  }
}

class AccountingStoreJournalEntry271422ResponseBuilder
    implements
        Builder<
          AccountingStoreJournalEntry271422Response,
          AccountingStoreJournalEntry271422ResponseBuilder
        > {
  _$AccountingStoreJournalEntry271422Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AccountingStoreJournalEntry271422ResponseBuilder() {
    AccountingStoreJournalEntry271422Response._defaults(this);
  }

  AccountingStoreJournalEntry271422ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingStoreJournalEntry271422Response other) {
    _$v = other as _$AccountingStoreJournalEntry271422Response;
  }

  @override
  void update(
    void Function(AccountingStoreJournalEntry271422ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreJournalEntry271422Response build() => _build();

  _$AccountingStoreJournalEntry271422Response _build() {
    final _$result =
        _$v ??
        _$AccountingStoreJournalEntry271422Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingStoreJournalEntry271422Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
