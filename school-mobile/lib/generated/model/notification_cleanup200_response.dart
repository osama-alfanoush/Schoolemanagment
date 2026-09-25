//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_cleanup200_response.g.dart';

/// NotificationCleanup200Response
///
/// Properties:
/// * [message] 
/// * [deletedCount] 
@BuiltValue()
abstract class NotificationCleanup200Response implements Built<NotificationCleanup200Response, NotificationCleanup200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationCleanup200ResponseMessageEnum get message;
  // enum messageEnum {  Old notifications cleaned up,  };

  @BuiltValueField(wireName: r'deleted_count')
  JsonObject? get deletedCount;

  NotificationCleanup200Response._();

  factory NotificationCleanup200Response([void updates(NotificationCleanup200ResponseBuilder b)]) = _$NotificationCleanup200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationCleanup200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationCleanup200Response> get serializer => _$NotificationCleanup200ResponseSerializer();
}

class _$NotificationCleanup200ResponseSerializer implements PrimitiveSerializer<NotificationCleanup200Response> {
  @override
  final Iterable<Type> types = const [NotificationCleanup200Response, _$NotificationCleanup200Response];

  @override
  final String wireName = r'NotificationCleanup200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationCleanup200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationCleanup200ResponseMessageEnum),
    );
    yield r'deleted_count';
    yield object.deletedCount == null ? null : serializers.serialize(
      object.deletedCount,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationCleanup200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationCleanup200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationCleanup200ResponseMessageEnum),
          ) as NotificationCleanup200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'deleted_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.deletedCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationCleanup200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationCleanup200ResponseBuilder();
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

class NotificationCleanup200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Old notifications cleaned up')
  static const NotificationCleanup200ResponseMessageEnum oldNotificationsCleanedUp = _$notificationCleanup200ResponseMessageEnum_oldNotificationsCleanedUp;

  static Serializer<NotificationCleanup200ResponseMessageEnum> get serializer => _$notificationCleanup200ResponseMessageEnumSerializer;

  const NotificationCleanup200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationCleanup200ResponseMessageEnum> get values => _$notificationCleanup200ResponseMessageEnumValues;
  static NotificationCleanup200ResponseMessageEnum valueOf(String name) => _$notificationCleanup200ResponseMessageEnumValueOf(name);
}

