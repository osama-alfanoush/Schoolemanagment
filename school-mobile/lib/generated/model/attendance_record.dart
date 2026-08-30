//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'attendance_record.g.dart';

/// AttendanceRecord
///
/// Properties:
/// * [id] 
/// * [studentUserId] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [date] 
/// * [status] 
/// * [markedBy] 
/// * [note] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [studentEnrollmentId] 
/// * [courseSectionId] 
/// * [submissionBatchId] 
/// * [scopeKey] 
/// * [version] 
/// * [schoolId] 
@BuiltValue()
abstract class AttendanceRecord implements Built<AttendanceRecord, AttendanceRecordBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int? get subjectId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'marked_by')
  int get markedBy;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'student_enrollment_id')
  int? get studentEnrollmentId;

  @BuiltValueField(wireName: r'course_section_id')
  int? get courseSectionId;

  @BuiltValueField(wireName: r'submission_batch_id')
  int? get submissionBatchId;

  @BuiltValueField(wireName: r'scope_key')
  String get scopeKey;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  AttendanceRecord._();

  factory AttendanceRecord([void updates(AttendanceRecordBuilder b)]) = _$AttendanceRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AttendanceRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AttendanceRecord> get serializer => _$AttendanceRecordSerializer();
}

class _$AttendanceRecordSerializer implements PrimitiveSerializer<AttendanceRecord> {
  @override
  final Iterable<Type> types = const [AttendanceRecord, _$AttendanceRecord];

  @override
  final String wireName = r'AttendanceRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AttendanceRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'subject_id';
    yield object.subjectId == null ? null : serializers.serialize(
      object.subjectId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'marked_by';
    yield serializers.serialize(
      object.markedBy,
      specifiedType: const FullType(int),
    );
    yield r'note';
    yield object.note == null ? null : serializers.serialize(
      object.note,
      specifiedType: const FullType.nullable(String),
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
    yield r'student_enrollment_id';
    yield object.studentEnrollmentId == null ? null : serializers.serialize(
      object.studentEnrollmentId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'course_section_id';
    yield object.courseSectionId == null ? null : serializers.serialize(
      object.courseSectionId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'submission_batch_id';
    yield object.submissionBatchId == null ? null : serializers.serialize(
      object.submissionBatchId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'scope_key';
    yield serializers.serialize(
      object.scopeKey,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
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
    AttendanceRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AttendanceRecordBuilder result,
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
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
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
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'marked_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.markedBy = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
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
        case r'student_enrollment_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.studentEnrollmentId = valueDes;
          break;
        case r'course_section_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.courseSectionId = valueDes;
          break;
        case r'submission_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.submissionBatchId = valueDes;
          break;
        case r'scope_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scopeKey = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
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
  AttendanceRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AttendanceRecordBuilder();
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

