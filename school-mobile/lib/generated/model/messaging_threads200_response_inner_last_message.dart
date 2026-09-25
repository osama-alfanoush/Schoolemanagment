//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/messaging_threads200_response_inner_other_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'messaging_threads200_response_inner_last_message.g.dart';

/// MessagingThreads200ResponseInnerLastMessage
///
/// Properties:
/// * [id] 
/// * [senderUserId] 
/// * [recipientUserId] 
/// * [aboutStudentUserId] 
/// * [body] 
/// * [readAt] 
/// * [createdAt] 
/// * [isMine] 
/// * [sender] 
/// * [recipient] 
@BuiltValue()
abstract class MessagingThreads200ResponseInnerLastMessage implements Built<MessagingThreads200ResponseInnerLastMessage, MessagingThreads200ResponseInnerLastMessageBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'sender_user_id')
  int get senderUserId;

  @BuiltValueField(wireName: r'recipient_user_id')
  int get recipientUserId;

  @BuiltValueField(wireName: r'about_student_user_id')
  int? get aboutStudentUserId;

  @BuiltValueField(wireName: r'body')
  String get body;

  @BuiltValueField(wireName: r'read_at')
  String get readAt;

  @BuiltValueField(wireName: r'created_at')
  String get createdAt;

  @BuiltValueField(wireName: r'is_mine')
  bool get isMine;

  @BuiltValueField(wireName: r'sender')
  MessagingThreads200ResponseInnerOtherUser get sender;

  @BuiltValueField(wireName: r'recipient')
  MessagingThreads200ResponseInnerOtherUser get recipient;

  MessagingThreads200ResponseInnerLastMessage._();

  factory MessagingThreads200ResponseInnerLastMessage([void updates(MessagingThreads200ResponseInnerLastMessageBuilder b)]) = _$MessagingThreads200ResponseInnerLastMessage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MessagingThreads200ResponseInnerLastMessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MessagingThreads200ResponseInnerLastMessage> get serializer => _$MessagingThreads200ResponseInnerLastMessageSerializer();
}

class _$MessagingThreads200ResponseInnerLastMessageSerializer implements PrimitiveSerializer<MessagingThreads200ResponseInnerLastMessage> {
  @override
  final Iterable<Type> types = const [MessagingThreads200ResponseInnerLastMessage, _$MessagingThreads200ResponseInnerLastMessage];

  @override
  final String wireName = r'MessagingThreads200ResponseInnerLastMessage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MessagingThreads200ResponseInnerLastMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'sender_user_id';
    yield serializers.serialize(
      object.senderUserId,
      specifiedType: const FullType(int),
    );
    yield r'recipient_user_id';
    yield serializers.serialize(
      object.recipientUserId,
      specifiedType: const FullType(int),
    );
    yield r'about_student_user_id';
    yield object.aboutStudentUserId == null ? null : serializers.serialize(
      object.aboutStudentUserId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
    yield r'read_at';
    yield serializers.serialize(
      object.readAt,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(String),
    );
    yield r'is_mine';
    yield serializers.serialize(
      object.isMine,
      specifiedType: const FullType(bool),
    );
    yield r'sender';
    yield serializers.serialize(
      object.sender,
      specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MessagingThreads200ResponseInnerLastMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MessagingThreads200ResponseInnerLastMessageBuilder result,
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
        case r'sender_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.senderUserId = valueDes;
          break;
        case r'recipient_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recipientUserId = valueDes;
          break;
        case r'about_student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.aboutStudentUserId = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        case r'read_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.readAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'is_mine':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isMine = valueDes;
          break;
        case r'sender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
          ) as MessagingThreads200ResponseInnerOtherUser;
          result.sender.replace(valueDes);
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MessagingThreads200ResponseInnerOtherUser),
          ) as MessagingThreads200ResponseInnerOtherUser;
          result.recipient.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MessagingThreads200ResponseInnerLastMessage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MessagingThreads200ResponseInnerLastMessageBuilder();
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

