//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_preference.g.dart';

/// NotificationPreference
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [pushEnabled] 
/// * [emailEnabled] 
/// * [inAppEnabled] 
/// * [typePreferences] 
/// * [quietHours] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class NotificationPreference implements Built<NotificationPreference, NotificationPreferenceBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'push_enabled')
  bool get pushEnabled;

  @BuiltValueField(wireName: r'email_enabled')
  bool get emailEnabled;

  @BuiltValueField(wireName: r'in_app_enabled')
  bool get inAppEnabled;

  @BuiltValueField(wireName: r'type_preferences')
  BuiltList<JsonObject?>? get typePreferences;

  @BuiltValueField(wireName: r'quiet_hours')
  BuiltList<JsonObject?>? get quietHours;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  NotificationPreference._();

  factory NotificationPreference([void updates(NotificationPreferenceBuilder b)]) = _$NotificationPreference;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationPreferenceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationPreference> get serializer => _$NotificationPreferenceSerializer();
}

class _$NotificationPreferenceSerializer implements PrimitiveSerializer<NotificationPreference> {
  @override
  final Iterable<Type> types = const [NotificationPreference, _$NotificationPreference];

  @override
  final String wireName = r'NotificationPreference';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationPreference object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'push_enabled';
    yield serializers.serialize(
      object.pushEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'email_enabled';
    yield serializers.serialize(
      object.emailEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'in_app_enabled';
    yield serializers.serialize(
      object.inAppEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'type_preferences';
    yield object.typePreferences == null ? null : serializers.serialize(
      object.typePreferences,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'quiet_hours';
    yield object.quietHours == null ? null : serializers.serialize(
      object.quietHours,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationPreference object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationPreferenceBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'push_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.pushEnabled = valueDes;
          break;
        case r'email_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.emailEnabled = valueDes;
          break;
        case r'in_app_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.inAppEnabled = valueDes;
          break;
        case r'type_preferences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.typePreferences.replace(valueDes);
          break;
        case r'quiet_hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.quietHours.replace(valueDes);
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationPreference deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationPreferenceBuilder();
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

