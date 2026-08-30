//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_mark_attendance_request_records_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_mark_attendance_request.g.dart';

/// TeacherMarkAttendanceRequest
///
/// Properties:
/// * [classRoomId] 
/// * [subjectId] 
/// * [courseSectionId] 
/// * [date] 
/// * [records] 
@BuiltValue()
abstract class TeacherMarkAttendanceRequest implements Built<TeacherMarkAttendanceRequest, TeacherMarkAttendanceRequestBuilder> {
  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int? get subjectId;

  @BuiltValueField(wireName: r'course_section_id')
  int? get courseSectionId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'records')
  BuiltList<TeacherMarkAttendanceRequestRecordsInner> get records;

  TeacherMarkAttendanceRequest._();

  factory TeacherMarkAttendanceRequest([void updates(TeacherMarkAttendanceRequestBuilder b)]) = _$TeacherMarkAttendanceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherMarkAttendanceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherMarkAttendanceRequest> get serializer => _$TeacherMarkAttendanceRequestSerializer();
}

class _$TeacherMarkAttendanceRequestSerializer implements PrimitiveSerializer<TeacherMarkAttendanceRequest> {
  @override
  final Iterable<Type> types = const [TeacherMarkAttendanceRequest, _$TeacherMarkAttendanceRequest];

  @override
  final String wireName = r'TeacherMarkAttendanceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherMarkAttendanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    if (object.subjectId != null) {
      yield r'subject_id';
      yield serializers.serialize(
        object.subjectId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.courseSectionId != null) {
      yield r'course_section_id';
      yield serializers.serialize(
        object.courseSectionId,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(TeacherMarkAttendanceRequestRecordsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherMarkAttendanceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherMarkAttendanceRequestBuilder result,
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
        case r'subject_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.subjectId = valueDes;
          break;
        case r'course_section_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.courseSectionId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherMarkAttendanceRequestRecordsInner)]),
          ) as BuiltList<TeacherMarkAttendanceRequestRecordsInner>;
          result.records.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherMarkAttendanceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherMarkAttendanceRequestBuilder();
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

