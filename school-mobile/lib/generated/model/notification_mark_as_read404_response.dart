//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_mark_as_read404_response.g.dart';

/// NotificationMarkAsRead404Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationMarkAsRead404Response implements Built<NotificationMarkAsRead404Response, NotificationMarkAsRead404ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationMarkAsRead404ResponseMessageEnum get message;
  // enum messageEnum {  Notification not found,  };

  NotificationMarkAsRead404Response._();

  factory NotificationMarkAsRead404Response([void updates(NotificationMarkAsRead404ResponseBuilder b)]) = _$NotificationMarkAsRead404Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationMarkAsRead404ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationMarkAsRead404Response> get serializer => _$NotificationMarkAsRead404ResponseSerializer();
}

class _$NotificationMarkAsRead404ResponseSerializer implements PrimitiveSerializer<NotificationMarkAsRead404Response> {
  @override
  final Iterable<Type> types = const [NotificationMarkAsRead404Response, _$NotificationMarkAsRead404Response];

  @override
  final String wireName = r'NotificationMarkAsRead404Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationMarkAsRead404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationMarkAsRead404ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsRead404Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationMarkAsRead404ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationMarkAsRead404ResponseMessageEnum),
          ) as NotificationMarkAsRead404ResponseMessageEnum;
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
  NotificationMarkAsRead404Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationMarkAsRead404ResponseBuilder();
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

class NotificationMarkAsRead404ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Notification not found')
  static const NotificationMarkAsRead404ResponseMessageEnum notificationNotFound = _$notificationMarkAsRead404ResponseMessageEnum_notificationNotFound;

  static Serializer<NotificationMarkAsRead404ResponseMessageEnum> get serializer => _$notificationMarkAsRead404ResponseMessageEnumSerializer;

  const NotificationMarkAsRead404ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationMarkAsRead404ResponseMessageEnum> get values => _$notificationMarkAsRead404ResponseMessageEnumValues;
  static NotificationMarkAsRead404ResponseMessageEnum valueOf(String name) => _$notificationMarkAsRead404ResponseMessageEnumValueOf(name);
}

