//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_inbox_conversation200_response_data_reply_window.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_conversation200_response_data.g.dart';

/// ParentInboxConversation200ResponseData
///
/// Properties:
/// * [otherUserId] 
/// * [canReply] 
/// * [replyWindow] 
/// * [messages] 
@BuiltValue()
abstract class ParentInboxConversation200ResponseData implements Built<ParentInboxConversation200ResponseData, ParentInboxConversation200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'other_user_id')
  int get otherUserId;

  @BuiltValueField(wireName: r'can_reply')
  bool get canReply;

  @BuiltValueField(wireName: r'reply_window')
  ParentInboxConversation200ResponseDataReplyWindow get replyWindow;

  @BuiltValueField(wireName: r'messages')
  BuiltList<String> get messages;

  ParentInboxConversation200ResponseData._();

  factory ParentInboxConversation200ResponseData([void updates(ParentInboxConversation200ResponseDataBuilder b)]) = _$ParentInboxConversation200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxConversation200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxConversation200ResponseData> get serializer => _$ParentInboxConversation200ResponseDataSerializer();
}

class _$ParentInboxConversation200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxConversation200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxConversation200ResponseData, _$ParentInboxConversation200ResponseData];

  @override
  final String wireName = r'ParentInboxConversation200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxConversation200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'other_user_id';
    yield serializers.serialize(
      object.otherUserId,
      specifiedType: const FullType(int),
    );
    yield r'can_reply';
    yield serializers.serialize(
      object.canReply,
      specifiedType: const FullType(bool),
    );
    yield r'reply_window';
    yield serializers.serialize(
      object.replyWindow,
      specifiedType: const FullType(ParentInboxConversation200ResponseDataReplyWindow),
    );
    yield r'messages';
    yield serializers.serialize(
      object.messages,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxConversation200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxConversation200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'other_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.otherUserId = valueDes;
          break;
        case r'can_reply':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canReply = valueDes;
          break;
        case r'reply_window':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxConversation200ResponseDataReplyWindow),
          ) as ParentInboxConversation200ResponseDataReplyWindow;
          result.replyWindow.replace(valueDes);
          break;
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.messages.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxConversation200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxConversation200ResponseDataBuilder();
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

