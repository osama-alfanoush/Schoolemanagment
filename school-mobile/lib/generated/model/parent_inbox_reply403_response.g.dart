// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_reply403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentInboxReply403ResponseMessageEnum
_$parentInboxReply403ResponseMessageEnum_youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod =
    const ParentInboxReply403ResponseMessageEnum._(
      'youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod',
    );

ParentInboxReply403ResponseMessageEnum
_$parentInboxReply403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod':
      return _$parentInboxReply403ResponseMessageEnum_youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentInboxReply403ResponseMessageEnum>
_$parentInboxReply403ResponseMessageEnumValues =
    BuiltSet<ParentInboxReply403ResponseMessageEnum>(const <
      ParentInboxReply403ResponseMessageEnum
    >[
      _$parentInboxReply403ResponseMessageEnum_youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod,
    ]);

Serializer<ParentInboxReply403ResponseMessageEnum>
_$parentInboxReply403ResponseMessageEnumSerializer =
    _$ParentInboxReply403ResponseMessageEnumSerializer();

class _$ParentInboxReply403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<ParentInboxReply403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod': 'You can reply to messages the school sends you, but you cannot start a new conversation here.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You can reply to messages the school sends you, but you cannot start a new conversation here.': 'youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentInboxReply403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentInboxReply403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReply403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentInboxReply403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentInboxReply403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentInboxReply403Response extends ParentInboxReply403Response {
  @override
  final ParentInboxReply403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentInboxReply403Response([
    void Function(ParentInboxReply403ResponseBuilder)? updates,
  ]) => (ParentInboxReply403ResponseBuilder()..update(updates))._build();

  _$ParentInboxReply403Response._({required this.message, required this.errors})
    : super._();
  @override
  ParentInboxReply403Response rebuild(
    void Function(ParentInboxReply403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxReply403ResponseBuilder toBuilder() =>
      ParentInboxReply403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxReply403Response &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxReply403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentInboxReply403ResponseBuilder
    implements
        Builder<
          ParentInboxReply403Response,
          ParentInboxReply403ResponseBuilder
        > {
  _$ParentInboxReply403Response? _$v;

  ParentInboxReply403ResponseMessageEnum? _message;
  ParentInboxReply403ResponseMessageEnum? get message => _$this._message;
  set message(ParentInboxReply403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentInboxReply403ResponseBuilder() {
    ParentInboxReply403Response._defaults(this);
  }

  ParentInboxReply403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxReply403Response other) {
    _$v = other as _$ParentInboxReply403Response;
  }

  @override
  void update(void Function(ParentInboxReply403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxReply403Response build() => _build();

  _$ParentInboxReply403Response _build() {
    final _$result =
        _$v ??
        _$ParentInboxReply403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentInboxReply403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentInboxReply403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
