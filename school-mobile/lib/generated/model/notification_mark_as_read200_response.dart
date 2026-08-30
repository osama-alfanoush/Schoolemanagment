//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_mark_as_read200_response.g.dart';

/// NotificationMarkAsRead200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationMarkAsRead200Response implements Built<NotificationMarkAsRead200Response, NotificationMarkAsRead200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationMarkAsRead200ResponseMessageEnum get message;
  // enum messageEnum {  Marked as read,  };

  NotificationMarkAsRead200Response._();

  factory NotificationMarkAsRead200Response([void updates(NotificationMarkAsRead200ResponseBuilder b)]) = _$NotificationMarkAsRead200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationMarkAsRead200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationMarkAsRead200Response> get serializer => _$NotificationMarkAsRead200ResponseSerializer();
}

class _$NotificationMarkAsRead200ResponseSerializer implements PrimitiveSerializer<NotificationMarkAsRead200Response> {
  @override
  final Iterable<Type> types = const [NotificationMarkAsRead200Response, _$NotificationMarkAsRead200Response];

  @override
  final String wireName = r'NotificationMarkAsRead200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationMarkAsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationMarkAsRead200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationMarkAsRead200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationMarkAsRead200ResponseMessageEnum),
          ) as NotificationMarkAsRead200ResponseMessageEnum;
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
  NotificationMarkAsRead200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationMarkAsRead200ResponseBuilder();
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

class NotificationMarkAsRead200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Marked as read')
  static const NotificationMarkAsRead200ResponseMessageEnum markedAsRead = _$notificationMarkAsRead200ResponseMessageEnum_markedAsRead;

  static Serializer<NotificationMarkAsRead200ResponseMessageEnum> get serializer => _$notificationMarkAsRead200ResponseMessageEnumSerializer;

  const NotificationMarkAsRead200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationMarkAsRead200ResponseMessageEnum> get values => _$notificationMarkAsRead200ResponseMessageEnumValues;
  static NotificationMarkAsRead200ResponseMessageEnum valueOf(String name) => _$notificationMarkAsRead200ResponseMessageEnumValueOf(name);
}

