//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_today200_response_data_attendance_window.dart';
import 'package:school_mobile/generated/model/teacher_roster200_response_data_students_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_roster200_response_data.g.dart';

/// TeacherRoster200ResponseData
///
/// Properties:
/// * [classRoomId] 
/// * [date] 
/// * [attendanceWindow] 
/// * [students] 
@BuiltValue()
abstract class TeacherRoster200ResponseData implements Built<TeacherRoster200ResponseData, TeacherRoster200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'date')
  String get date;

  @BuiltValueField(wireName: r'attendance_window')
  TeacherToday200ResponseDataAttendanceWindow get attendanceWindow;

  @BuiltValueField(wireName: r'students')
  BuiltList<TeacherRoster200ResponseDataStudentsInner> get students;

  TeacherRoster200ResponseData._();

  factory TeacherRoster200ResponseData([void updates(TeacherRoster200ResponseDataBuilder b)]) = _$TeacherRoster200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherRoster200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherRoster200ResponseData> get serializer => _$TeacherRoster200ResponseDataSerializer();
}

class _$TeacherRoster200ResponseDataSerializer implements PrimitiveSerializer<TeacherRoster200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherRoster200ResponseData, _$TeacherRoster200ResponseData];

  @override
  final String wireName = r'TeacherRoster200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherRoster200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
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
    yield r'students';
    yield serializers.serialize(
      object.students,
      specifiedType: const FullType(BuiltList, [FullType(TeacherRoster200ResponseDataStudentsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherRoster200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherRoster200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
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
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherRoster200ResponseDataStudentsInner)]),
          ) as BuiltList<TeacherRoster200ResponseDataStudentsInner>;
          result.students.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherRoster200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherRoster200ResponseDataBuilder();
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

