//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/notification_update_preferences_request_quiet_hours.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_update_preferences_request.g.dart';

/// NotificationUpdatePreferencesRequest
///
/// Properties:
/// * [pushEnabled] 
/// * [emailEnabled] 
/// * [inAppEnabled] 
/// * [quietHours] 
/// * [typePreferences] 
@BuiltValue()
abstract class NotificationUpdatePreferencesRequest implements Built<NotificationUpdatePreferencesRequest, NotificationUpdatePreferencesRequestBuilder> {
  @BuiltValueField(wireName: r'push_enabled')
  bool? get pushEnabled;

  @BuiltValueField(wireName: r'email_enabled')
  bool? get emailEnabled;

  @BuiltValueField(wireName: r'in_app_enabled')
  bool? get inAppEnabled;

  @BuiltValueField(wireName: r'quiet_hours')
  NotificationUpdatePreferencesRequestQuietHours? get quietHours;

  @BuiltValueField(wireName: r'type_preferences')
  BuiltList<String>? get typePreferences;

  NotificationUpdatePreferencesRequest._();

  factory NotificationUpdatePreferencesRequest([void updates(NotificationUpdatePreferencesRequestBuilder b)]) = _$NotificationUpdatePreferencesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUpdatePreferencesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUpdatePreferencesRequest> get serializer => _$NotificationUpdatePreferencesRequestSerializer();
}

class _$NotificationUpdatePreferencesRequestSerializer implements PrimitiveSerializer<NotificationUpdatePreferencesRequest> {
  @override
  final Iterable<Type> types = const [NotificationUpdatePreferencesRequest, _$NotificationUpdatePreferencesRequest];

  @override
  final String wireName = r'NotificationUpdatePreferencesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUpdatePreferencesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.pushEnabled != null) {
      yield r'push_enabled';
      yield serializers.serialize(
        object.pushEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.emailEnabled != null) {
      yield r'email_enabled';
      yield serializers.serialize(
        object.emailEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.inAppEnabled != null) {
      yield r'in_app_enabled';
      yield serializers.serialize(
        object.inAppEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.quietHours != null) {
      yield r'quiet_hours';
      yield serializers.serialize(
        object.quietHours,
        specifiedType: const FullType(NotificationUpdatePreferencesRequestQuietHours),
      );
    }
    if (object.typePreferences != null) {
      yield r'type_preferences';
      yield serializers.serialize(
        object.typePreferences,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUpdatePreferencesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUpdatePreferencesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'quiet_hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationUpdatePreferencesRequestQuietHours),
          ) as NotificationUpdatePreferencesRequestQuietHours;
          result.quietHours.replace(valueDes);
          break;
        case r'type_preferences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.typePreferences.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationUpdatePreferencesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUpdatePreferencesRequestBuilder();
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

