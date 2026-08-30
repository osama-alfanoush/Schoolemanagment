//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_mark_all_as_read200_response.g.dart';

/// NotificationMarkAllAsRead200Response
///
/// Properties:
/// * [message] 
/// * [markedCount] 
@BuiltValue()
abstract class NotificationMarkAllAsRead200Response implements Built<NotificationMarkAllAsRead200Response, NotificationMarkAllAsRead200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationMarkAllAsRead200ResponseMessageEnum get message;
  // enum messageEnum {  All notifications marked as read,  };

  @BuiltValueField(wireName: r'marked_count')
  int get markedCount;

  NotificationMarkAllAsRead200Response._();

  factory NotificationMarkAllAsRead200Response([void updates(NotificationMarkAllAsRead200ResponseBuilder b)]) = _$NotificationMarkAllAsRead200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationMarkAllAsRead200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationMarkAllAsRead200Response> get serializer => _$NotificationMarkAllAsRead200ResponseSerializer();
}

class _$NotificationMarkAllAsRead200ResponseSerializer implements PrimitiveSerializer<NotificationMarkAllAsRead200Response> {
  @override
  final Iterable<Type> types = const [NotificationMarkAllAsRead200Response, _$NotificationMarkAllAsRead200Response];

  @override
  final String wireName = r'NotificationMarkAllAsRead200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationMarkAllAsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationMarkAllAsRead200ResponseMessageEnum),
    );
    yield r'marked_count';
    yield serializers.serialize(
      object.markedCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAllAsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationMarkAllAsRead200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationMarkAllAsRead200ResponseMessageEnum),
          ) as NotificationMarkAllAsRead200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'marked_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.markedCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationMarkAllAsRead200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationMarkAllAsRead200ResponseBuilder();
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

class NotificationMarkAllAsRead200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'All notifications marked as read')
  static const NotificationMarkAllAsRead200ResponseMessageEnum allNotificationsMarkedAsRead = _$notificationMarkAllAsRead200ResponseMessageEnum_allNotificationsMarkedAsRead;

  static Serializer<NotificationMarkAllAsRead200ResponseMessageEnum> get serializer => _$notificationMarkAllAsRead200ResponseMessageEnumSerializer;

  const NotificationMarkAllAsRead200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationMarkAllAsRead200ResponseMessageEnum> get values => _$notificationMarkAllAsRead200ResponseMessageEnumValues;
  static NotificationMarkAllAsRead200ResponseMessageEnum valueOf(String name) => _$notificationMarkAllAsRead200ResponseMessageEnumValueOf(name);
}

