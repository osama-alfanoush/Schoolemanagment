//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_template.g.dart';

/// NotificationTemplate
///
/// Properties:
/// * [id] 
/// * [key] 
/// * [category] 
/// * [titleTemplate] 
/// * [bodyTemplate] 
/// * [defaultPriority] 
/// * [actionUrlTemplate] 
/// * [requiresAction] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class NotificationTemplate implements Built<NotificationTemplate, NotificationTemplateBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'key')
  String get key;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'title_template')
  String get titleTemplate;

  @BuiltValueField(wireName: r'body_template')
  String get bodyTemplate;

  @BuiltValueField(wireName: r'default_priority')
  String get defaultPriority;

  @BuiltValueField(wireName: r'action_url_template')
  String? get actionUrlTemplate;

  @BuiltValueField(wireName: r'requires_action')
  bool get requiresAction;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  NotificationTemplate._();

  factory NotificationTemplate([void updates(NotificationTemplateBuilder b)]) = _$NotificationTemplate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationTemplateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationTemplate> get serializer => _$NotificationTemplateSerializer();
}

class _$NotificationTemplateSerializer implements PrimitiveSerializer<NotificationTemplate> {
  @override
  final Iterable<Type> types = const [NotificationTemplate, _$NotificationTemplate];

  @override
  final String wireName = r'NotificationTemplate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'title_template';
    yield serializers.serialize(
      object.titleTemplate,
      specifiedType: const FullType(String),
    );
    yield r'body_template';
    yield serializers.serialize(
      object.bodyTemplate,
      specifiedType: const FullType(String),
    );
    yield r'default_priority';
    yield serializers.serialize(
      object.defaultPriority,
      specifiedType: const FullType(String),
    );
    yield r'action_url_template';
    yield object.actionUrlTemplate == null ? null : serializers.serialize(
      object.actionUrlTemplate,
      specifiedType: const FullType.nullable(String),
    );
    yield r'requires_action';
    yield serializers.serialize(
      object.requiresAction,
      specifiedType: const FullType(bool),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationTemplateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.key = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
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
            specifiedType: const FullType(String),
          ) as String;
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
        case r'requires_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresAction = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationTemplate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationTemplateBuilder();
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

