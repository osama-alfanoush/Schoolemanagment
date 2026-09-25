//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_mark_as_clicked200_response.g.dart';

/// NotificationMarkAsClicked200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationMarkAsClicked200Response implements Built<NotificationMarkAsClicked200Response, NotificationMarkAsClicked200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationMarkAsClicked200ResponseMessageEnum get message;
  // enum messageEnum {  Marked as clicked,  };

  NotificationMarkAsClicked200Response._();

  factory NotificationMarkAsClicked200Response([void updates(NotificationMarkAsClicked200ResponseBuilder b)]) = _$NotificationMarkAsClicked200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationMarkAsClicked200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationMarkAsClicked200Response> get serializer => _$NotificationMarkAsClicked200ResponseSerializer();
}

class _$NotificationMarkAsClicked200ResponseSerializer implements PrimitiveSerializer<NotificationMarkAsClicked200Response> {
  @override
  final Iterable<Type> types = const [NotificationMarkAsClicked200Response, _$NotificationMarkAsClicked200Response];

  @override
  final String wireName = r'NotificationMarkAsClicked200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationMarkAsClicked200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationMarkAsClicked200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationMarkAsClicked200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationMarkAsClicked200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationMarkAsClicked200ResponseMessageEnum),
          ) as NotificationMarkAsClicked200ResponseMessageEnum;
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
  NotificationMarkAsClicked200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationMarkAsClicked200ResponseBuilder();
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

class NotificationMarkAsClicked200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Marked as clicked')
  static const NotificationMarkAsClicked200ResponseMessageEnum markedAsClicked = _$notificationMarkAsClicked200ResponseMessageEnum_markedAsClicked;

  static Serializer<NotificationMarkAsClicked200ResponseMessageEnum> get serializer => _$notificationMarkAsClicked200ResponseMessageEnumSerializer;

  const NotificationMarkAsClicked200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationMarkAsClicked200ResponseMessageEnum> get values => _$notificationMarkAsClicked200ResponseMessageEnumValues;
  static NotificationMarkAsClicked200ResponseMessageEnum valueOf(String name) => _$notificationMarkAsClicked200ResponseMessageEnumValueOf(name);
}

