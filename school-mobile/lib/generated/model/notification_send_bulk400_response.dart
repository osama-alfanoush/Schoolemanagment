//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_bulk400_response.g.dart';

/// NotificationSendBulk400Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class NotificationSendBulk400Response implements Built<NotificationSendBulk400Response, NotificationSendBulk400ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationSendBulk400ResponseMessageEnum get message;
  // enum messageEnum {  No valid target specified,  };

  NotificationSendBulk400Response._();

  factory NotificationSendBulk400Response([void updates(NotificationSendBulk400ResponseBuilder b)]) = _$NotificationSendBulk400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendBulk400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendBulk400Response> get serializer => _$NotificationSendBulk400ResponseSerializer();
}

class _$NotificationSendBulk400ResponseSerializer implements PrimitiveSerializer<NotificationSendBulk400Response> {
  @override
  final Iterable<Type> types = const [NotificationSendBulk400Response, _$NotificationSendBulk400Response];

  @override
  final String wireName = r'NotificationSendBulk400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendBulk400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationSendBulk400ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulk400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendBulk400ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSendBulk400ResponseMessageEnum),
          ) as NotificationSendBulk400ResponseMessageEnum;
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
  NotificationSendBulk400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendBulk400ResponseBuilder();
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

class NotificationSendBulk400ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'No valid target specified')
  static const NotificationSendBulk400ResponseMessageEnum noValidTargetSpecified = _$notificationSendBulk400ResponseMessageEnum_noValidTargetSpecified;

  static Serializer<NotificationSendBulk400ResponseMessageEnum> get serializer => _$notificationSendBulk400ResponseMessageEnumSerializer;

  const NotificationSendBulk400ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationSendBulk400ResponseMessageEnum> get values => _$notificationSendBulk400ResponseMessageEnumValues;
  static NotificationSendBulk400ResponseMessageEnum valueOf(String name) => _$notificationSendBulk400ResponseMessageEnumValueOf(name);
}

