//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_attendance_batch_request_records_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_attendance_batch_request.g.dart';

/// TeacherAttendanceBatchRequest
///
/// Properties:
/// * [idempotencyKey] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [courseSectionId] 
/// * [date] 
/// * [records] 
@BuiltValue()
abstract class TeacherAttendanceBatchRequest implements Built<TeacherAttendanceBatchRequest, TeacherAttendanceBatchRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int? get subjectId;

  @BuiltValueField(wireName: r'course_section_id')
  int? get courseSectionId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'records')
  BuiltList<TeacherAttendanceBatchRequestRecordsInner> get records;

  TeacherAttendanceBatchRequest._();

  factory TeacherAttendanceBatchRequest([void updates(TeacherAttendanceBatchRequestBuilder b)]) = _$TeacherAttendanceBatchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAttendanceBatchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAttendanceBatchRequest> get serializer => _$TeacherAttendanceBatchRequestSerializer();
}

class _$TeacherAttendanceBatchRequestSerializer implements PrimitiveSerializer<TeacherAttendanceBatchRequest> {
  @override
  final Iterable<Type> types = const [TeacherAttendanceBatchRequest, _$TeacherAttendanceBatchRequest];

  @override
  final String wireName = r'TeacherAttendanceBatchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAttendanceBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
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
      specifiedType: const FullType(BuiltList, [FullType(TeacherAttendanceBatchRequestRecordsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttendanceBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAttendanceBatchRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
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
            specifiedType: const FullType(BuiltList, [FullType(TeacherAttendanceBatchRequestRecordsInner)]),
          ) as BuiltList<TeacherAttendanceBatchRequestRecordsInner>;
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
  TeacherAttendanceBatchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAttendanceBatchRequestBuilder();
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

