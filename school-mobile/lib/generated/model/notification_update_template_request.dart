//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_update_template_request.g.dart';

/// NotificationUpdateTemplateRequest
///
/// Properties:
/// * [titleTemplate] 
/// * [bodyTemplate] 
/// * [defaultPriority] 
/// * [actionUrlTemplate] 
@BuiltValue()
abstract class NotificationUpdateTemplateRequest implements Built<NotificationUpdateTemplateRequest, NotificationUpdateTemplateRequestBuilder> {
  @BuiltValueField(wireName: r'title_template')
  String? get titleTemplate;

  @BuiltValueField(wireName: r'body_template')
  String? get bodyTemplate;

  @BuiltValueField(wireName: r'default_priority')
  NotificationUpdateTemplateRequestDefaultPriorityEnum? get defaultPriority;
  // enum defaultPriorityEnum {  low,  normal,  high,  urgent,  };

  @BuiltValueField(wireName: r'action_url_template')
  String? get actionUrlTemplate;

  NotificationUpdateTemplateRequest._();

  factory NotificationUpdateTemplateRequest([void updates(NotificationUpdateTemplateRequestBuilder b)]) = _$NotificationUpdateTemplateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUpdateTemplateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUpdateTemplateRequest> get serializer => _$NotificationUpdateTemplateRequestSerializer();
}

class _$NotificationUpdateTemplateRequestSerializer implements PrimitiveSerializer<NotificationUpdateTemplateRequest> {
  @override
  final Iterable<Type> types = const [NotificationUpdateTemplateRequest, _$NotificationUpdateTemplateRequest];

  @override
  final String wireName = r'NotificationUpdateTemplateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUpdateTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.titleTemplate != null) {
      yield r'title_template';
      yield serializers.serialize(
        object.titleTemplate,
        specifiedType: const FullType(String),
      );
    }
    if (object.bodyTemplate != null) {
      yield r'body_template';
      yield serializers.serialize(
        object.bodyTemplate,
        specifiedType: const FullType(String),
      );
    }
    if (object.defaultPriority != null) {
      yield r'default_priority';
      yield serializers.serialize(
        object.defaultPriority,
        specifiedType: const FullType(NotificationUpdateTemplateRequestDefaultPriorityEnum),
      );
    }
    if (object.actionUrlTemplate != null) {
      yield r'action_url_template';
      yield serializers.serialize(
        object.actionUrlTemplate,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUpdateTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUpdateTemplateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title_template':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.titleTemplate = valueDes;
          break;
        case r'body_template':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bodyTemplate = valueDes;
          break;
        case r'default_priority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationUpdateTemplateRequestDefaultPriorityEnum),
          ) as NotificationUpdateTemplateRequestDefaultPriorityEnum;
          result.defaultPriority = valueDes;
          break;
        case r'action_url_template':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actionUrlTemplate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationUpdateTemplateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUpdateTemplateRequestBuilder();
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

class NotificationUpdateTemplateRequestDefaultPriorityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'low')
  static const NotificationUpdateTemplateRequestDefaultPriorityEnum low = _$notificationUpdateTemplateRequestDefaultPriorityEnum_low;
  @BuiltValueEnumConst(wireName: r'normal')
  static const NotificationUpdateTemplateRequestDefaultPriorityEnum normal = _$notificationUpdateTemplateRequestDefaultPriorityEnum_normal;
  @BuiltValueEnumConst(wireName: r'high')
  static const NotificationUpdateTemplateRequestDefaultPriorityEnum high = _$notificationUpdateTemplateRequestDefaultPriorityEnum_high;
  @BuiltValueEnumConst(wireName: r'urgent')
  static const NotificationUpdateTemplateRequestDefaultPriorityEnum urgent = _$notificationUpdateTemplateRequestDefaultPriorityEnum_urgent;

  static Serializer<NotificationUpdateTemplateRequestDefaultPriorityEnum> get serializer => _$notificationUpdateTemplateRequestDefaultPriorityEnumSerializer;

  const NotificationUpdateTemplateRequestDefaultPriorityEnum._(String name): super(name);

  static BuiltSet<NotificationUpdateTemplateRequestDefaultPriorityEnum> get values => _$notificationUpdateTemplateRequestDefaultPriorityEnumValues;
  static NotificationUpdateTemplateRequestDefaultPriorityEnum valueOf(String name) => _$notificationUpdateTemplateRequestDefaultPriorityEnumValueOf(name);
}

