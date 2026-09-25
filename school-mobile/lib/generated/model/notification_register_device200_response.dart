//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_register_device200_response.g.dart';

/// NotificationRegisterDevice200Response
///
/// Properties:
/// * [message] 
/// * [id] 
/// * [deviceId] 
@BuiltValue()
abstract class NotificationRegisterDevice200Response implements Built<NotificationRegisterDevice200Response, NotificationRegisterDevice200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationRegisterDevice200ResponseMessageEnum get message;
  // enum messageEnum {  Device registered successfully,  };

  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  NotificationRegisterDevice200Response._();

  factory NotificationRegisterDevice200Response([void updates(NotificationRegisterDevice200ResponseBuilder b)]) = _$NotificationRegisterDevice200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationRegisterDevice200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationRegisterDevice200Response> get serializer => _$NotificationRegisterDevice200ResponseSerializer();
}

class _$NotificationRegisterDevice200ResponseSerializer implements PrimitiveSerializer<NotificationRegisterDevice200Response> {
  @override
  final Iterable<Type> types = const [NotificationRegisterDevice200Response, _$NotificationRegisterDevice200Response];

  @override
  final String wireName = r'NotificationRegisterDevice200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationRegisterDevice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationRegisterDevice200ResponseMessageEnum),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationRegisterDevice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationRegisterDevice200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationRegisterDevice200ResponseMessageEnum),
          ) as NotificationRegisterDevice200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationRegisterDevice200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationRegisterDevice200ResponseBuilder();
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

class NotificationRegisterDevice200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Device registered successfully')
  static const NotificationRegisterDevice200ResponseMessageEnum deviceRegisteredSuccessfully = _$notificationRegisterDevice200ResponseMessageEnum_deviceRegisteredSuccessfully;

  static Serializer<NotificationRegisterDevice200ResponseMessageEnum> get serializer => _$notificationRegisterDevice200ResponseMessageEnumSerializer;

  const NotificationRegisterDevice200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationRegisterDevice200ResponseMessageEnum> get values => _$notificationRegisterDevice200ResponseMessageEnumValues;
  static NotificationRegisterDevice200ResponseMessageEnum valueOf(String name) => _$notificationRegisterDevice200ResponseMessageEnumValueOf(name);
}

