// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_show_journal_entry404_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountingShowJournalEntry404ResponseMessageEnum
_$accountingShowJournalEntry404ResponseMessageEnum_notFound =
    const AccountingShowJournalEntry404ResponseMessageEnum._('notFound');

AccountingShowJournalEntry404ResponseMessageEnum
_$accountingShowJournalEntry404ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'notFound':
      return _$accountingShowJournalEntry404ResponseMessageEnum_notFound;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountingShowJournalEntry404ResponseMessageEnum>
_$accountingShowJournalEntry404ResponseMessageEnumValues =
    BuiltSet<AccountingShowJournalEntry404ResponseMessageEnum>(
      const <AccountingShowJournalEntry404ResponseMessageEnum>[
        _$accountingShowJournalEntry404ResponseMessageEnum_notFound,
      ],
    );

Serializer<AccountingShowJournalEntry404ResponseMessageEnum>
_$accountingShowJournalEntry404ResponseMessageEnumSerializer =
    _$AccountingShowJournalEntry404ResponseMessageEnumSerializer();

class _$AccountingShowJournalEntry404ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<AccountingShowJournalEntry404ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notFound': 'Not found',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Not found': 'notFound',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AccountingShowJournalEntry404ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AccountingShowJournalEntry404ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountingShowJournalEntry404ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountingShowJournalEntry404ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountingShowJournalEntry404ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountingShowJournalEntry404Response
    extends AccountingShowJournalEntry404Response {
  @override
  final AccountingShowJournalEntry404ResponseMessageEnum message;

  factory _$AccountingShowJournalEntry404Response([
    void Function(AccountingShowJournalEntry404ResponseBuilder)? updates,
  ]) => (AccountingShowJournalEntry404ResponseBuilder()..update(updates))
      ._build();

  _$AccountingShowJournalEntry404Response._({required this.message})
    : super._();
  @override
  AccountingShowJournalEntry404Response rebuild(
    void Function(AccountingShowJournalEntry404ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingShowJournalEntry404ResponseBuilder toBuilder() =>
      AccountingShowJournalEntry404ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingShowJournalEntry404Response &&
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
      r'AccountingShowJournalEntry404Response',
    )..add('message', message)).toString();
  }
}

class AccountingShowJournalEntry404ResponseBuilder
    implements
        Builder<
          AccountingShowJournalEntry404Response,
          AccountingShowJournalEntry404ResponseBuilder
        > {
  _$AccountingShowJournalEntry404Response? _$v;

  AccountingShowJournalEntry404ResponseMessageEnum? _message;
  AccountingShowJournalEntry404ResponseMessageEnum? get message =>
      _$this._message;
  set message(AccountingShowJournalEntry404ResponseMessageEnum? message) =>
      _$this._message = message;

  AccountingShowJournalEntry404ResponseBuilder() {
    AccountingShowJournalEntry404Response._defaults(this);
  }

  AccountingShowJournalEntry404ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingShowJournalEntry404Response other) {
    _$v = other as _$AccountingShowJournalEntry404Response;
  }

  @override
  void update(
    void Function(AccountingShowJournalEntry404ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingShowJournalEntry404Response build() => _build();

  _$AccountingShowJournalEntry404Response _build() {
    final _$result =
        _$v ??
        _$AccountingShowJournalEntry404Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AccountingShowJournalEntry404Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
