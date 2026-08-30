//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_bulk200_response.g.dart';

/// NotificationSendBulk200Response
///
/// Properties:
/// * [message] 
/// * [recipientCount] 
/// * [sentCount] 
@BuiltValue()
abstract class NotificationSendBulk200Response implements Built<NotificationSendBulk200Response, NotificationSendBulk200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationSendBulk200ResponseMessageEnum get message;
  // enum messageEnum {  Bulk notification sent,  };

  @BuiltValueField(wireName: r'recipient_count')
  int get recipientCount;

  @BuiltValueField(wireName: r'sent_count')
  int get sentCount;

  NotificationSendBulk200Response._();

  factory NotificationSendBulk200Response([void updates(NotificationSendBulk200ResponseBuilder b)]) = _$NotificationSendBulk200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendBulk200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendBulk200Response> get serializer => _$NotificationSendBulk200ResponseSerializer();
}

class _$NotificationSendBulk200ResponseSerializer implements PrimitiveSerializer<NotificationSendBulk200Response> {
  @override
  final Iterable<Type> types = const [NotificationSendBulk200Response, _$NotificationSendBulk200Response];

  @override
  final String wireName = r'NotificationSendBulk200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendBulk200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationSendBulk200ResponseMessageEnum),
    );
    yield r'recipient_count';
    yield serializers.serialize(
      object.recipientCount,
      specifiedType: const FullType(int),
    );
    yield r'sent_count';
    yield serializers.serialize(
      object.sentCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulk200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendBulk200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSendBulk200ResponseMessageEnum),
          ) as NotificationSendBulk200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'recipient_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recipientCount = valueDes;
          break;
        case r'sent_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sentCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSendBulk200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendBulk200ResponseBuilder();
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

class NotificationSendBulk200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bulk notification sent')
  static const NotificationSendBulk200ResponseMessageEnum bulkNotificationSent = _$notificationSendBulk200ResponseMessageEnum_bulkNotificationSent;

  static Serializer<NotificationSendBulk200ResponseMessageEnum> get serializer => _$notificationSendBulk200ResponseMessageEnumSerializer;

  const NotificationSendBulk200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationSendBulk200ResponseMessageEnum> get values => _$notificationSendBulk200ResponseMessageEnumValues;
  static NotificationSendBulk200ResponseMessageEnum valueOf(String name) => _$notificationSendBulk200ResponseMessageEnumValueOf(name);
}

