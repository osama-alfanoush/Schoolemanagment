//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_conversation200_response_data_reply_window.g.dart';

/// ParentInboxConversation200ResponseDataReplyWindow
///
/// Properties:
/// * [from] 
/// * [to] 
@BuiltValue()
abstract class ParentInboxConversation200ResponseDataReplyWindow implements Built<ParentInboxConversation200ResponseDataReplyWindow, ParentInboxConversation200ResponseDataReplyWindowBuilder> {
  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  ParentInboxConversation200ResponseDataReplyWindow._();

  factory ParentInboxConversation200ResponseDataReplyWindow([void updates(ParentInboxConversation200ResponseDataReplyWindowBuilder b)]) = _$ParentInboxConversation200ResponseDataReplyWindow;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxConversation200ResponseDataReplyWindowBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxConversation200ResponseDataReplyWindow> get serializer => _$ParentInboxConversation200ResponseDataReplyWindowSerializer();
}

class _$ParentInboxConversation200ResponseDataReplyWindowSerializer implements PrimitiveSerializer<ParentInboxConversation200ResponseDataReplyWindow> {
  @override
  final Iterable<Type> types = const [ParentInboxConversation200ResponseDataReplyWindow, _$ParentInboxConversation200ResponseDataReplyWindow];

  @override
  final String wireName = r'ParentInboxConversation200ResponseDataReplyWindow';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxConversation200ResponseDataReplyWindow object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxConversation200ResponseDataReplyWindow object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxConversation200ResponseDataReplyWindowBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxConversation200ResponseDataReplyWindow deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxConversation200ResponseDataReplyWindowBuilder();
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

