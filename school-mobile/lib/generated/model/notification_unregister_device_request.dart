//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_unregister_device_request.g.dart';

/// NotificationUnregisterDeviceRequest
///
/// Properties:
/// * [deviceId] 
@BuiltValue()
abstract class NotificationUnregisterDeviceRequest implements Built<NotificationUnregisterDeviceRequest, NotificationUnregisterDeviceRequestBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  NotificationUnregisterDeviceRequest._();

  factory NotificationUnregisterDeviceRequest([void updates(NotificationUnregisterDeviceRequestBuilder b)]) = _$NotificationUnregisterDeviceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUnregisterDeviceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUnregisterDeviceRequest> get serializer => _$NotificationUnregisterDeviceRequestSerializer();
}

class _$NotificationUnregisterDeviceRequestSerializer implements PrimitiveSerializer<NotificationUnregisterDeviceRequest> {
  @override
  final Iterable<Type> types = const [NotificationUnregisterDeviceRequest, _$NotificationUnregisterDeviceRequest];

  @override
  final String wireName = r'NotificationUnregisterDeviceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUnregisterDeviceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUnregisterDeviceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUnregisterDeviceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  NotificationUnregisterDeviceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUnregisterDeviceRequestBuilder();
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

