//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_unregister_device200_response.g.dart';

/// NotificationUnregisterDevice200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationUnregisterDevice200Response implements Built<NotificationUnregisterDevice200Response, NotificationUnregisterDevice200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationUnregisterDevice200ResponseMessageEnum get message;
  // enum messageEnum {  Device unregistered,  };

  NotificationUnregisterDevice200Response._();

  factory NotificationUnregisterDevice200Response([void updates(NotificationUnregisterDevice200ResponseBuilder b)]) = _$NotificationUnregisterDevice200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUnregisterDevice200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUnregisterDevice200Response> get serializer => _$NotificationUnregisterDevice200ResponseSerializer();
}

class _$NotificationUnregisterDevice200ResponseSerializer implements PrimitiveSerializer<NotificationUnregisterDevice200Response> {
  @override
  final Iterable<Type> types = const [NotificationUnregisterDevice200Response, _$NotificationUnregisterDevice200Response];

  @override
  final String wireName = r'NotificationUnregisterDevice200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUnregisterDevice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationUnregisterDevice200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUnregisterDevice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUnregisterDevice200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationUnregisterDevice200ResponseMessageEnum),
          ) as NotificationUnregisterDevice200ResponseMessageEnum;
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
  NotificationUnregisterDevice200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUnregisterDevice200ResponseBuilder();
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

class NotificationUnregisterDevice200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Device unregistered')
  static const NotificationUnregisterDevice200ResponseMessageEnum deviceUnregistered = _$notificationUnregisterDevice200ResponseMessageEnum_deviceUnregistered;

  static Serializer<NotificationUnregisterDevice200ResponseMessageEnum> get serializer => _$notificationUnregisterDevice200ResponseMessageEnumSerializer;

  const NotificationUnregisterDevice200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationUnregisterDevice200ResponseMessageEnum> get values => _$notificationUnregisterDevice200ResponseMessageEnumValues;
  static NotificationUnregisterDevice200ResponseMessageEnum valueOf(String name) => _$notificationUnregisterDevice200ResponseMessageEnumValueOf(name);
}

