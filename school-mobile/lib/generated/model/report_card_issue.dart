//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_card_issue.g.dart';

/// ReportCardIssue
///
/// Properties:
/// * [id] 
/// * [studentEnrollmentId] 
/// * [gradingPeriodId] 
/// * [issueVersion] 
/// * [snapshot] 
/// * [documentPath] 
/// * [checksum] 
/// * [correctionReason] 
/// * [issuedBy] 
/// * [issuedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class ReportCardIssue implements Built<ReportCardIssue, ReportCardIssueBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'student_enrollment_id')
  int get studentEnrollmentId;

  @BuiltValueField(wireName: r'grading_period_id')
  int get gradingPeriodId;

  @BuiltValueField(wireName: r'issue_version')
  int get issueVersion;

  @BuiltValueField(wireName: r'snapshot')
  BuiltList<JsonObject?> get snapshot;

  @BuiltValueField(wireName: r'document_path')
  String? get documentPath;

  @BuiltValueField(wireName: r'checksum')
  String? get checksum;

  @BuiltValueField(wireName: r'correction_reason')
  String? get correctionReason;

  @BuiltValueField(wireName: r'issued_by')
  int get issuedBy;

  @BuiltValueField(wireName: r'issued_at')
  DateTime get issuedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  ReportCardIssue._();

  factory ReportCardIssue([void updates(ReportCardIssueBuilder b)]) = _$ReportCardIssue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportCardIssueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportCardIssue> get serializer => _$ReportCardIssueSerializer();
}

class _$ReportCardIssueSerializer implements PrimitiveSerializer<ReportCardIssue> {
  @override
  final Iterable<Type> types = const [ReportCardIssue, _$ReportCardIssue];

  @override
  final String wireName = r'ReportCardIssue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportCardIssue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'student_enrollment_id';
    yield serializers.serialize(
      object.studentEnrollmentId,
      specifiedType: const FullType(int),
    );
    yield r'grading_period_id';
    yield serializers.serialize(
      object.gradingPeriodId,
      specifiedType: const FullType(int),
    );
    yield r'issue_version';
    yield serializers.serialize(
      object.issueVersion,
      specifiedType: const FullType(int),
    );
    yield r'snapshot';
    yield serializers.serialize(
      object.snapshot,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'document_path';
    yield object.documentPath == null ? null : serializers.serialize(
      object.documentPath,
      specifiedType: const FullType.nullable(String),
    );
    yield r'checksum';
    yield object.checksum == null ? null : serializers.serialize(
      object.checksum,
      specifiedType: const FullType.nullable(String),
    );
    yield r'correction_reason';
    yield object.correctionReason == null ? null : serializers.serialize(
      object.correctionReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'issued_by';
    yield serializers.serialize(
      object.issuedBy,
      specifiedType: const FullType(int),
    );
    yield r'issued_at';
    yield serializers.serialize(
      object.issuedAt,
      specifiedType: const FullType(DateTime),
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
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReportCardIssue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportCardIssueBuilder result,
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
        case r'student_enrollment_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentEnrollmentId = valueDes;
          break;
        case r'grading_period_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.gradingPeriodId = valueDes;
          break;
        case r'issue_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.issueVersion = valueDes;
          break;
        case r'snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.snapshot.replace(valueDes);
          break;
        case r'document_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.documentPath = valueDes;
          break;
        case r'checksum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.checksum = valueDes;
          break;
        case r'correction_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.correctionReason = valueDes;
          break;
        case r'issued_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.issuedBy = valueDes;
          break;
        case r'issued_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.issuedAt = valueDes;
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
  ReportCardIssue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportCardIssueBuilder();
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

