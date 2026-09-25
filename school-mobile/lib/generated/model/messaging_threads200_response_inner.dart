//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/messaging_threads200_response_inner_other_user.dart';
import 'package:school_mobile/generated/model/messaging_threads200_response_inner_last_message.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'messaging_threads200_response_inner.g.dart';

/// MessagingThreads200ResponseInner
///
/// Properties:
/// * [id] 
/// * [otherUser] 
/// * [lastMessage] 
/// * [unreadCount] 
@BuiltValue()
abstract class MessagingThreads200ResponseInner implements Built<MessagingThreads200ResponseInner, MessagingThreads200ResponseInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'other_user')
  MessagingThreads200ResponseInnerOtherUser get otherUser;

  @BuiltValueField(wireName: r'last_message')
  MessagingThreads200ResponseInnerLastMessage get lastMessage;

  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  MessagingThreads200ResponseInner._();

  factory MessagingThreads200ResponseInner([void updates(MessagingThreads200ResponseInnerBuilder b)]) = _$MessagingThreads200ResponseInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessagingThreads200ResponseInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessagingThreads200ResponseInner> get serializer => _$MessagingThreads200ResponseInnerSerializer();
}

class _$MessagingThreads200ResponseInnerSerializer implements PrimitiveSerializer<MessagingThreads200ResponseInner> {
  @override
  final Iterable<Type> types = const [MessagingThreads200ResponseInner, _$MessagingThreads200ResponseInner];

  @override
  final String wireName = r'MessagingThreads200ResponseInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessagingThreads200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'other_user';
    yield serializers.serialize(
      object.otherUser,
      specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
    );
    yield r'last_message';
    yield serializers.serialize(
      object.lastMessage,
      specifiedType: const FullType(MessagingThreads200ResponseInnerLastMessage),
    );
    yield r'unread_count';
    yield serializers.serialize(
      object.unreadCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessagingThreads200ResponseInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessagingThreads200ResponseInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'other_user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
          ) as MessagingThreads200ResponseInnerOtherUser;
          result.otherUser.replace(valueDes);
          break;
        case r'last_message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessagingThreads200ResponseInnerLastMessage),
          ) as MessagingThreads200ResponseInnerLastMessage;
          result.lastMessage.replace(valueDes);
          break;
        case r'unread_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessagingThreads200ResponseInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessagingThreads200ResponseInnerBuilder();
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

