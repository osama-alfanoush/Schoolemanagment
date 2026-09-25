//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_today200_response_data_attendance_window.dart';
import 'package:school_mobile/generated/model/teacher_today200_response_data_periods_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_today200_response_data.g.dart';

/// TeacherToday200ResponseData
///
/// Properties:
/// * [date] 
/// * [attendanceWindow] 
/// * [periods] 
/// * [classes] 
@BuiltValue()
abstract class TeacherToday200ResponseData implements Built<TeacherToday200ResponseData, TeacherToday200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'date')
  String get date;

  @BuiltValueField(wireName: r'attendance_window')
  TeacherToday200ResponseDataAttendanceWindow get attendanceWindow;

  @BuiltValueField(wireName: r'periods')
  BuiltList<TeacherToday200ResponseDataPeriodsInner> get periods;

  @BuiltValueField(wireName: r'classes')
  BuiltList<String> get classes;

  TeacherToday200ResponseData._();

  factory TeacherToday200ResponseData([void updates(TeacherToday200ResponseDataBuilder b)]) = _$TeacherToday200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherToday200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherToday200ResponseData> get serializer => _$TeacherToday200ResponseDataSerializer();
}

class _$TeacherToday200ResponseDataSerializer implements PrimitiveSerializer<TeacherToday200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherToday200ResponseData, _$TeacherToday200ResponseData];

  @override
  final String wireName = r'TeacherToday200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherToday200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(String),
    );
    yield r'attendance_window';
    yield serializers.serialize(
      object.attendanceWindow,
      specifiedType: const FullType(TeacherToday200ResponseDataAttendanceWindow),
    );
    yield r'periods';
    yield serializers.serialize(
      object.periods,
      specifiedType: const FullType(BuiltList, [FullType(TeacherToday200ResponseDataPeriodsInner)]),
    );
    yield r'classes';
    yield serializers.serialize(
      object.classes,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherToday200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherToday200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        case r'attendance_window':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherToday200ResponseDataAttendanceWindow),
          ) as TeacherToday200ResponseDataAttendanceWindow;
          result.attendanceWindow.replace(valueDes);
          break;
        case r'periods':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherToday200ResponseDataPeriodsInner)]),
          ) as BuiltList<TeacherToday200ResponseDataPeriodsInner>;
          result.periods.replace(valueDes);
          break;
        case r'classes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.classes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherToday200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherToday200ResponseDataBuilder();
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

