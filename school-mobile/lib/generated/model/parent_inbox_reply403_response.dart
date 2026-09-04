//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_reply403_response.g.dart';

/// ParentInboxReply403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentInboxReply403Response implements Built<ParentInboxReply403Response, ParentInboxReply403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentInboxReply403ResponseMessageEnum get message;
  // enum messageEnum {  You can reply to messages the school sends you, but you cannot start a new conversation here.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentInboxReply403Response._();

  factory ParentInboxReply403Response([void updates(ParentInboxReply403ResponseBuilder b)]) = _$ParentInboxReply403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxReply403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxReply403Response> get serializer => _$ParentInboxReply403ResponseSerializer();
}

class _$ParentInboxReply403ResponseSerializer implements PrimitiveSerializer<ParentInboxReply403Response> {
  @override
  final Iterable<Type> types = const [ParentInboxReply403Response, _$ParentInboxReply403Response];

  @override
  final String wireName = r'ParentInboxReply403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxReply403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentInboxReply403ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReply403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxReply403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxReply403ResponseMessageEnum),
          ) as ParentInboxReply403ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxReply403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxReply403ResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class ParentInboxReply403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You can reply to messages the school sends you, but you cannot start a new conversation here.')
  static const ParentInboxReply403ResponseMessageEnum youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod = _$parentInboxReply403ResponseMessageEnum_youCanReplyToMessagesTheSchoolSendsYouCommaButYouCannotStartANewConversationHerePeriod;

  static Serializer<ParentInboxReply403ResponseMessageEnum> get serializer => _$parentInboxReply403ResponseMessageEnumSerializer;

  const ParentInboxReply403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentInboxReply403ResponseMessageEnum> get values => _$parentInboxReply403ResponseMessageEnumValues;
  static ParentInboxReply403ResponseMessageEnum valueOf(String name) => _$parentInboxReply403ResponseMessageEnumValueOf(name);
}

