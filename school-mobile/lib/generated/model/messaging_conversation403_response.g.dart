// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_conversation403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MessagingConversation403ResponseMessageEnum
_$messagingConversation403ResponseMessageEnum_youMayNotMessageThisUserPeriod =
    const MessagingConversation403ResponseMessageEnum._(
      'youMayNotMessageThisUserPeriod',
    );

MessagingConversation403ResponseMessageEnum
_$messagingConversation403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youMayNotMessageThisUserPeriod':
      return _$messagingConversation403ResponseMessageEnum_youMayNotMessageThisUserPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MessagingConversation403ResponseMessageEnum>
_$messagingConversation403ResponseMessageEnumValues =
    BuiltSet<MessagingConversation403ResponseMessageEnum>(const <
      MessagingConversation403ResponseMessageEnum
    >[
      _$messagingConversation403ResponseMessageEnum_youMayNotMessageThisUserPeriod,
    ]);

Serializer<MessagingConversation403ResponseMessageEnum>
_$messagingConversation403ResponseMessageEnumSerializer =
    _$MessagingConversation403ResponseMessageEnumSerializer();

class _$MessagingConversation403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<MessagingConversation403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youMayNotMessageThisUserPeriod': 'You may not message this user.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You may not message this user.': 'youMayNotMessageThisUserPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MessagingConversation403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'MessagingConversation403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    MessagingConversation403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MessagingConversation403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MessagingConversation403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MessagingConversation403Response
    extends MessagingConversation403Response {
  @override
  final MessagingConversation403ResponseMessageEnum message;

  factory _$MessagingConversation403Response([
    void Function(MessagingConversation403ResponseBuilder)? updates,
  ]) => (MessagingConversation403ResponseBuilder()..update(updates))._build();

  _$MessagingConversation403Response._({required this.message}) : super._();
  @override
  MessagingConversation403Response rebuild(
    void Function(MessagingConversation403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MessagingConversation403ResponseBuilder toBuilder() =>
      MessagingConversation403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MessagingConversation403Response &&
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
      r'MessagingConversation403Response',
    )..add('message', message)).toString();
  }
}

class MessagingConversation403ResponseBuilder
    implements
        Builder<
          MessagingConversation403Response,
          MessagingConversation403ResponseBuilder
        > {
  _$MessagingConversation403Response? _$v;

  MessagingConversation403ResponseMessageEnum? _message;
  MessagingConversation403ResponseMessageEnum? get message => _$this._message;
  set message(MessagingConversation403ResponseMessageEnum? message) =>
      _$this._message = message;

  MessagingConversation403ResponseBuilder() {
    MessagingConversation403Response._defaults(this);
  }

  MessagingConversation403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MessagingConversation403Response other) {
    _$v = other as _$MessagingConversation403Response;
  }

  @override
  void update(void Function(MessagingConversation403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MessagingConversation403Response build() => _build();

  _$MessagingConversation403Response _build() {
    final _$result =
        _$v ??
        _$MessagingConversation403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'MessagingConversation403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
