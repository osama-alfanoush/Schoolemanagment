//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_today200_response_data_attendance_window.g.dart';

/// TeacherToday200ResponseDataAttendanceWindow
///
/// Properties:
/// * [open] 
/// * [hours] 
/// * [closesAt] 
/// * [reason] 
@BuiltValue()
abstract class TeacherToday200ResponseDataAttendanceWindow implements Built<TeacherToday200ResponseDataAttendanceWindow, TeacherToday200ResponseDataAttendanceWindowBuilder> {
  @BuiltValueField(wireName: r'open')
  bool get open;

  @BuiltValueField(wireName: r'hours')
  int get hours;

  @BuiltValueField(wireName: r'closes_at')
  String get closesAt;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  TeacherToday200ResponseDataAttendanceWindow._();

  factory TeacherToday200ResponseDataAttendanceWindow([void updates(TeacherToday200ResponseDataAttendanceWindowBuilder b)]) = _$TeacherToday200ResponseDataAttendanceWindow;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherToday200ResponseDataAttendanceWindowBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherToday200ResponseDataAttendanceWindow> get serializer => _$TeacherToday200ResponseDataAttendanceWindowSerializer();
}

class _$TeacherToday200ResponseDataAttendanceWindowSerializer implements PrimitiveSerializer<TeacherToday200ResponseDataAttendanceWindow> {
  @override
  final Iterable<Type> types = const [TeacherToday200ResponseDataAttendanceWindow, _$TeacherToday200ResponseDataAttendanceWindow];

  @override
  final String wireName = r'TeacherToday200ResponseDataAttendanceWindow';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherToday200ResponseDataAttendanceWindow object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'open';
    yield serializers.serialize(
      object.open,
      specifiedType: const FullType(bool),
    );
    yield r'hours';
    yield serializers.serialize(
      object.hours,
      specifiedType: const FullType(int),
    );
    yield r'closes_at';
    yield serializers.serialize(
      object.closesAt,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield object.reason == null ? null : serializers.serialize(
      object.reason,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherToday200ResponseDataAttendanceWindow object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherToday200ResponseDataAttendanceWindowBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'open':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.open = valueDes;
          break;
        case r'hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.hours = valueDes;
          break;
        case r'closes_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.closesAt = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherToday200ResponseDataAttendanceWindow deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherToday200ResponseDataAttendanceWindowBuilder();
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

