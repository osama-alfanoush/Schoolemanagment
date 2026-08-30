//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'messaging_conversation403_response.g.dart';

/// MessagingConversation403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class MessagingConversation403Response implements Built<MessagingConversation403Response, MessagingConversation403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  MessagingConversation403ResponseMessageEnum get message;
  // enum messageEnum {  You may not message this user.,  };

  MessagingConversation403Response._();

  factory MessagingConversation403Response([void updates(MessagingConversation403ResponseBuilder b)]) = _$MessagingConversation403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessagingConversation403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessagingConversation403Response> get serializer => _$MessagingConversation403ResponseSerializer();
}

class _$MessagingConversation403ResponseSerializer implements PrimitiveSerializer<MessagingConversation403Response> {
  @override
  final Iterable<Type> types = const [MessagingConversation403Response, _$MessagingConversation403Response];

  @override
  final String wireName = r'MessagingConversation403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessagingConversation403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(MessagingConversation403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessagingConversation403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessagingConversation403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessagingConversation403ResponseMessageEnum),
          ) as MessagingConversation403ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessagingConversation403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessagingConversation403ResponseBuilder();
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

class MessagingConversation403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You may not message this user.')
  static const MessagingConversation403ResponseMessageEnum youMayNotMessageThisUserPeriod = _$messagingConversation403ResponseMessageEnum_youMayNotMessageThisUserPeriod;

  static Serializer<MessagingConversation403ResponseMessageEnum> get serializer => _$messagingConversation403ResponseMessageEnumSerializer;

  const MessagingConversation403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<MessagingConversation403ResponseMessageEnum> get values => _$messagingConversation403ResponseMessageEnumValues;
  static MessagingConversation403ResponseMessageEnum valueOf(String name) => _$messagingConversation403ResponseMessageEnumValueOf(name);
}

