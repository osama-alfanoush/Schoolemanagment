//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_seed_templates200_response.g.dart';

/// NotificationSeedTemplates200Response
///
/// Properties:
/// * [message] 
/// * [count] 
@BuiltValue()
abstract class NotificationSeedTemplates200Response implements Built<NotificationSeedTemplates200Response, NotificationSeedTemplates200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  NotificationSeedTemplates200ResponseMessageEnum get message;
  // enum messageEnum {  Templates seeded successfully,  };

  @BuiltValueField(wireName: r'count')
  int get count;

  NotificationSeedTemplates200Response._();

  factory NotificationSeedTemplates200Response([void updates(NotificationSeedTemplates200ResponseBuilder b)]) = _$NotificationSeedTemplates200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSeedTemplates200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSeedTemplates200Response> get serializer => _$NotificationSeedTemplates200ResponseSerializer();
}

class _$NotificationSeedTemplates200ResponseSerializer implements PrimitiveSerializer<NotificationSeedTemplates200Response> {
  @override
  final Iterable<Type> types = const [NotificationSeedTemplates200Response, _$NotificationSeedTemplates200Response];

  @override
  final String wireName = r'NotificationSeedTemplates200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSeedTemplates200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(NotificationSeedTemplates200ResponseMessageEnum),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSeedTemplates200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSeedTemplates200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSeedTemplates200ResponseMessageEnum),
          ) as NotificationSeedTemplates200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSeedTemplates200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSeedTemplates200ResponseBuilder();
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

class NotificationSeedTemplates200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Templates seeded successfully')
  static const NotificationSeedTemplates200ResponseMessageEnum templatesSeededSuccessfully = _$notificationSeedTemplates200ResponseMessageEnum_templatesSeededSuccessfully;

  static Serializer<NotificationSeedTemplates200ResponseMessageEnum> get serializer => _$notificationSeedTemplates200ResponseMessageEnumSerializer;

  const NotificationSeedTemplates200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<NotificationSeedTemplates200ResponseMessageEnum> get values => _$notificationSeedTemplates200ResponseMessageEnumValues;
  static NotificationSeedTemplates200ResponseMessageEnum valueOf(String name) => _$notificationSeedTemplates200ResponseMessageEnumValueOf(name);
}

