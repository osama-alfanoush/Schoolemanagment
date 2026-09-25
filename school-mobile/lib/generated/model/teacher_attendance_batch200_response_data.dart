//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_today200_response_data_attendance_window.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_attendance_batch200_response_data.g.dart';

/// TeacherAttendanceBatch200ResponseData
///
/// Properties:
/// * [batchId] 
/// * [classRoomId] 
/// * [date] 
/// * [recordCount] 
/// * [committedAt] 
/// * [attendanceWindow] 
@BuiltValue()
abstract class TeacherAttendanceBatch200ResponseData implements Built<TeacherAttendanceBatch200ResponseData, TeacherAttendanceBatch200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'batch_id')
  int get batchId;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'date')
  String get date;

  @BuiltValueField(wireName: r'record_count')
  int get recordCount;

  @BuiltValueField(wireName: r'committed_at')
  String? get committedAt;

  @BuiltValueField(wireName: r'attendance_window')
  TeacherToday200ResponseDataAttendanceWindow get attendanceWindow;

  TeacherAttendanceBatch200ResponseData._();

  factory TeacherAttendanceBatch200ResponseData([void updates(TeacherAttendanceBatch200ResponseDataBuilder b)]) = _$TeacherAttendanceBatch200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAttendanceBatch200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAttendanceBatch200ResponseData> get serializer => _$TeacherAttendanceBatch200ResponseDataSerializer();
}

class _$TeacherAttendanceBatch200ResponseDataSerializer implements PrimitiveSerializer<TeacherAttendanceBatch200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherAttendanceBatch200ResponseData, _$TeacherAttendanceBatch200ResponseData];

  @override
  final String wireName = r'TeacherAttendanceBatch200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAttendanceBatch200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'batch_id';
    yield serializers.serialize(
      object.batchId,
      specifiedType: const FullType(int),
    );
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
    yield r'record_count';
    yield serializers.serialize(
      object.recordCount,
      specifiedType: const FullType(int),
    );
    yield r'committed_at';
    yield object.committedAt == null ? null : serializers.serialize(
      object.committedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'attendance_window';
    yield serializers.serialize(
      object.attendanceWindow,
      specifiedType: const FullType(TeacherToday200ResponseDataAttendanceWindow),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttendanceBatch200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAttendanceBatch200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.batchId = valueDes;
          break;
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
        case r'record_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recordCount = valueDes;
          break;
        case r'committed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.committedAt = valueDes;
          break;
        case r'attendance_window':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherToday200ResponseDataAttendanceWindow),
          ) as TeacherToday200ResponseDataAttendanceWindow;
          result.attendanceWindow.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAttendanceBatch200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAttendanceBatch200ResponseDataBuilder();
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

