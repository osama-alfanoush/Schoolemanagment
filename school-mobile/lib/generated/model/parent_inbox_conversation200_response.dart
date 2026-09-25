//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_conversation200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_conversation200_response.g.dart';

/// ParentInboxConversation200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxConversation200Response implements Built<ParentInboxConversation200Response, ParentInboxConversation200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxConversation200ResponseData get data;

  ParentInboxConversation200Response._();

  factory ParentInboxConversation200Response([void updates(ParentInboxConversation200ResponseBuilder b)]) = _$ParentInboxConversation200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxConversation200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxConversation200Response> get serializer => _$ParentInboxConversation200ResponseSerializer();
}

class _$ParentInboxConversation200ResponseSerializer implements PrimitiveSerializer<ParentInboxConversation200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxConversation200Response, _$ParentInboxConversation200Response];

  @override
  final String wireName = r'ParentInboxConversation200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxConversation200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxConversation200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxConversation200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxConversation200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxConversation200ResponseData),
          ) as ParentInboxConversation200ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxConversation200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxConversation200ResponseBuilder();
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

