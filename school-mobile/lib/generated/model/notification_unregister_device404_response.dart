//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_unregister_device404_response.g.dart';

/// NotificationUnregisterDevice404Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationUnregisterDevice404Response implements Built<NotificationUnregisterDevice404Response, NotificationUnregisterDevice404ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationUnregisterDevice404ResponseMessageEnum get message;
  // enum messageEnum {  Device not found,  };

  NotificationUnregisterDevice404Response._();

  factory NotificationUnregisterDevice404Response([void updates(NotificationUnregisterDevice404ResponseBuilder b)]) = _$NotificationUnregisterDevice404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUnregisterDevice404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUnregisterDevice404Response> get serializer => _$NotificationUnregisterDevice404ResponseSerializer();
}

class _$NotificationUnregisterDevice404ResponseSerializer implements PrimitiveSerializer<NotificationUnregisterDevice404Response> {
  @override
  final Iterable<Type> types = const [NotificationUnregisterDevice404Response, _$NotificationUnregisterDevice404Response];

  @override
  final String wireName = r'NotificationUnregisterDevice404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUnregisterDevice404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationUnregisterDevice404ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUnregisterDevice404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUnregisterDevice404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationUnregisterDevice404ResponseMessageEnum),
          ) as NotificationUnregisterDevice404ResponseMessageEnum;
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
  NotificationUnregisterDevice404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUnregisterDevice404ResponseBuilder();
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

class NotificationUnregisterDevice404ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Device not found')
  static const NotificationUnregisterDevice404ResponseMessageEnum deviceNotFound = _$notificationUnregisterDevice404ResponseMessageEnum_deviceNotFound;

  static Serializer<NotificationUnregisterDevice404ResponseMessageEnum> get serializer => _$notificationUnregisterDevice404ResponseMessageEnumSerializer;

  const NotificationUnregisterDevice404ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationUnregisterDevice404ResponseMessageEnum> get values => _$notificationUnregisterDevice404ResponseMessageEnumValues;
  static NotificationUnregisterDevice404ResponseMessageEnum valueOf(String name) => _$notificationUnregisterDevice404ResponseMessageEnumValueOf(name);
}

