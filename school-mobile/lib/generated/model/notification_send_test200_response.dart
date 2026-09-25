//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/notification.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_test200_response.g.dart';

/// NotificationSendTest200Response
///
/// Properties:
/// * [message] 
/// * [notification] 
@BuiltValue()
abstract class NotificationSendTest200Response implements Built<NotificationSendTest200Response, NotificationSendTest200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationSendTest200ResponseMessageEnum get message;
  // enum messageEnum {  Test notification sent,  };

  @BuiltValueField(wireName: r'notification')
  Notification? get notification;

  NotificationSendTest200Response._();

  factory NotificationSendTest200Response([void updates(NotificationSendTest200ResponseBuilder b)]) = _$NotificationSendTest200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendTest200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendTest200Response> get serializer => _$NotificationSendTest200ResponseSerializer();
}

class _$NotificationSendTest200ResponseSerializer implements PrimitiveSerializer<NotificationSendTest200Response> {
  @override
  final Iterable<Type> types = const [NotificationSendTest200Response, _$NotificationSendTest200Response];

  @override
  final String wireName = r'NotificationSendTest200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendTest200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationSendTest200ResponseMessageEnum),
    );
    yield r'notification';
    yield object.notification == null ? null : serializers.serialize(
      object.notification,
      specifiedType: const FullType.nullable(Notification),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendTest200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendTest200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSendTest200ResponseMessageEnum),
          ) as NotificationSendTest200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'notification':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Notification),
          ) as Notification?;
          if (valueDes == null) continue;
          result.notification.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSendTest200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendTest200ResponseBuilder();
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

class NotificationSendTest200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Test notification sent')
  static const NotificationSendTest200ResponseMessageEnum testNotificationSent = _$notificationSendTest200ResponseMessageEnum_testNotificationSent;

  static Serializer<NotificationSendTest200ResponseMessageEnum> get serializer => _$notificationSendTest200ResponseMessageEnumSerializer;

  const NotificationSendTest200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationSendTest200ResponseMessageEnum> get values => _$notificationSendTest200ResponseMessageEnumValues;
  static NotificationSendTest200ResponseMessageEnum valueOf(String name) => _$notificationSendTest200ResponseMessageEnumValueOf(name);
}

