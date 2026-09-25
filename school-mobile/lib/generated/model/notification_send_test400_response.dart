//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_test400_response.g.dart';

/// NotificationSendTest400Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationSendTest400Response implements Built<NotificationSendTest400Response, NotificationSendTest400ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationSendTest400ResponseMessageEnum get message;
  // enum messageEnum {  Failed to send notification,  };

  NotificationSendTest400Response._();

  factory NotificationSendTest400Response([void updates(NotificationSendTest400ResponseBuilder b)]) = _$NotificationSendTest400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendTest400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendTest400Response> get serializer => _$NotificationSendTest400ResponseSerializer();
}

class _$NotificationSendTest400ResponseSerializer implements PrimitiveSerializer<NotificationSendTest400Response> {
  @override
  final Iterable<Type> types = const [NotificationSendTest400Response, _$NotificationSendTest400Response];

  @override
  final String wireName = r'NotificationSendTest400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendTest400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationSendTest400ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendTest400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendTest400ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSendTest400ResponseMessageEnum),
          ) as NotificationSendTest400ResponseMessageEnum;
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
  NotificationSendTest400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendTest400ResponseBuilder();
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

class NotificationSendTest400ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Failed to send notification')
  static const NotificationSendTest400ResponseMessageEnum failedToSendNotification = _$notificationSendTest400ResponseMessageEnum_failedToSendNotification;

  static Serializer<NotificationSendTest400ResponseMessageEnum> get serializer => _$notificationSendTest400ResponseMessageEnumSerializer;

  const NotificationSendTest400ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationSendTest400ResponseMessageEnum> get values => _$notificationSendTest400ResponseMessageEnumValues;
  static NotificationSendTest400ResponseMessageEnum valueOf(String name) => _$notificationSendTest400ResponseMessageEnumValueOf(name);
}

