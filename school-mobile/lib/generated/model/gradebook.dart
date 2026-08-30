//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook.g.dart';

/// Gradebook
///
/// Properties:
/// * [id] 
/// * [schoolId] 
/// * [courseSectionId] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [gradingPeriodId] 
/// * [state] 
/// * [version] 
/// * [submittedBy] 
/// * [submittedAt] 
/// * [approvedBy] 
/// * [approvedAt] 
/// * [finalizedBy] 
/// * [finalizedAt] 
/// * [reopenedBy] 
/// * [reopenedUntil] 
/// * [reopenReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [returnedBy] 
/// * [returnedAt] 
/// * [returnReason] 
@BuiltValue()
abstract class Gradebook implements Built<Gradebook, GradebookBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'course_section_id')
  int? get courseSectionId;

  @BuiltValueField(wireName: r'class_room_id')
  int? get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int? get subjectId;

  @BuiltValueField(wireName: r'grading_period_id')
  int get gradingPeriodId;

  @BuiltValueField(wireName: r'state')
  String get state;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'submitted_by')
  int? get submittedBy;

  @BuiltValueField(wireName: r'submitted_at')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'finalized_by')
  int? get finalizedBy;

  @BuiltValueField(wireName: r'finalized_at')
  DateTime? get finalizedAt;

  @BuiltValueField(wireName: r'reopened_by')
  int? get reopenedBy;

  @BuiltValueField(wireName: r'reopened_until')
  DateTime? get reopenedUntil;

  @BuiltValueField(wireName: r'reopen_reason')
  String? get reopenReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'returned_by')
  int? get returnedBy;

  @BuiltValueField(wireName: r'returned_at')
  DateTime? get returnedAt;

  @BuiltValueField(wireName: r'return_reason')
  String? get returnReason;

  Gradebook._();

  factory Gradebook([void updates(GradebookBuilder b)]) = _$Gradebook;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Gradebook> get serializer => _$GradebookSerializer();
}

class _$GradebookSerializer implements PrimitiveSerializer<Gradebook> {
  @override
  final Iterable<Type> types = const [Gradebook, _$Gradebook];

  @override
  final String wireName = r'Gradebook';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Gradebook object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'course_section_id';
    yield object.courseSectionId == null ? null : serializers.serialize(
      object.courseSectionId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'class_room_id';
    yield object.classRoomId == null ? null : serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'subject_id';
    yield object.subjectId == null ? null : serializers.serialize(
      object.subjectId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'grading_period_id';
    yield serializers.serialize(
      object.gradingPeriodId,
      specifiedType: const FullType(int),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'submitted_by';
    yield object.submittedBy == null ? null : serializers.serialize(
      object.submittedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'submitted_at';
    yield object.submittedAt == null ? null : serializers.serialize(
      object.submittedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'finalized_by';
    yield object.finalizedBy == null ? null : serializers.serialize(
      object.finalizedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'finalized_at';
    yield object.finalizedAt == null ? null : serializers.serialize(
      object.finalizedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reopened_by';
    yield object.reopenedBy == null ? null : serializers.serialize(
      object.reopenedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reopened_until';
    yield object.reopenedUntil == null ? null : serializers.serialize(
      object.reopenedUntil,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reopen_reason';
    yield object.reopenReason == null ? null : serializers.serialize(
      object.reopenReason,
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
    yield r'returned_by';
    yield object.returnedBy == null ? null : serializers.serialize(
      object.returnedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'returned_at';
    yield object.returnedAt == null ? null : serializers.serialize(
      object.returnedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'return_reason';
    yield object.returnReason == null ? null : serializers.serialize(
      object.returnReason,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Gradebook object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookBuilder result,
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
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'course_section_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.courseSectionId = valueDes;
          break;
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
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
        case r'grading_period_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.gradingPeriodId = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'submitted_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.submittedBy = valueDes;
          break;
        case r'submitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
          break;
        case r'finalized_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.finalizedBy = valueDes;
          break;
        case r'finalized_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.finalizedAt = valueDes;
          break;
        case r'reopened_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reopenedBy = valueDes;
          break;
        case r'reopened_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reopenedUntil = valueDes;
          break;
        case r'reopen_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reopenReason = valueDes;
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
        case r'returned_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.returnedBy = valueDes;
          break;
        case r'returned_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.returnedAt = valueDes;
          break;
        case r'return_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.returnReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Gradebook deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookBuilder();
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

