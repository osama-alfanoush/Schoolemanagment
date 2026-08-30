//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_update_preferences_request_quiet_hours.g.dart';

/// NotificationUpdatePreferencesRequestQuietHours
///
/// Properties:
/// * [start] 
/// * [end] 
@BuiltValue()
abstract class NotificationUpdatePreferencesRequestQuietHours implements Built<NotificationUpdatePreferencesRequestQuietHours, NotificationUpdatePreferencesRequestQuietHoursBuilder> {
  @BuiltValueField(wireName: r'start')
  String? get start;

  @BuiltValueField(wireName: r'end')
  String? get end;

  NotificationUpdatePreferencesRequestQuietHours._();

  factory NotificationUpdatePreferencesRequestQuietHours([void updates(NotificationUpdatePreferencesRequestQuietHoursBuilder b)]) = _$NotificationUpdatePreferencesRequestQuietHours;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationUpdatePreferencesRequestQuietHoursBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationUpdatePreferencesRequestQuietHours> get serializer => _$NotificationUpdatePreferencesRequestQuietHoursSerializer();
}

class _$NotificationUpdatePreferencesRequestQuietHoursSerializer implements PrimitiveSerializer<NotificationUpdatePreferencesRequestQuietHours> {
  @override
  final Iterable<Type> types = const [NotificationUpdatePreferencesRequestQuietHours, _$NotificationUpdatePreferencesRequestQuietHours];

  @override
  final String wireName = r'NotificationUpdatePreferencesRequestQuietHours';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationUpdatePreferencesRequestQuietHours object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.start != null) {
      yield r'start';
      yield serializers.serialize(
        object.start,
        specifiedType: const FullType(String),
      );
    }
    if (object.end != null) {
      yield r'end';
      yield serializers.serialize(
        object.end,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationUpdatePreferencesRequestQuietHours object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationUpdatePreferencesRequestQuietHoursBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.end = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationUpdatePreferencesRequestQuietHours deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationUpdatePreferencesRequestQuietHoursBuilder();
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

