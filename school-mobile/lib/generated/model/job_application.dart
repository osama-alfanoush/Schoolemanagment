//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'job_application.g.dart';

/// JobApplication
///
/// Properties:
/// * [id] 
/// * [jobPostingId] 
/// * [applicantName] 
/// * [applicantEmail] 
/// * [applicantPhone] 
/// * [coverLetter] 
/// * [cvPath] 
/// * [status] 
/// * [notes] 
/// * [interviewDate] 
/// * [reviewedBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class JobApplication implements Built<JobApplication, JobApplicationBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'job_posting_id')
  int get jobPostingId;

  @BuiltValueField(wireName: r'applicant_name')
  String get applicantName;

  @BuiltValueField(wireName: r'applicant_email')
  String get applicantEmail;

  @BuiltValueField(wireName: r'applicant_phone')
  String get applicantPhone;

  @BuiltValueField(wireName: r'cover_letter')
  String? get coverLetter;

  @BuiltValueField(wireName: r'cv_path')
  String get cvPath;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'interview_date')
  DateTime? get interviewDate;

  @BuiltValueField(wireName: r'reviewed_by')
  int? get reviewedBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  JobApplication._();

  factory JobApplication([void updates(JobApplicationBuilder b)]) = _$JobApplication;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JobApplicationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JobApplication> get serializer => _$JobApplicationSerializer();
}

class _$JobApplicationSerializer implements PrimitiveSerializer<JobApplication> {
  @override
  final Iterable<Type> types = const [JobApplication, _$JobApplication];

  @override
  final String wireName = r'JobApplication';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JobApplication object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'job_posting_id';
    yield serializers.serialize(
      object.jobPostingId,
      specifiedType: const FullType(int),
    );
    yield r'applicant_name';
    yield serializers.serialize(
      object.applicantName,
      specifiedType: const FullType(String),
    );
    yield r'applicant_email';
    yield serializers.serialize(
      object.applicantEmail,
      specifiedType: const FullType(String),
    );
    yield r'applicant_phone';
    yield serializers.serialize(
      object.applicantPhone,
      specifiedType: const FullType(String),
    );
    yield r'cover_letter';
    yield object.coverLetter == null ? null : serializers.serialize(
      object.coverLetter,
      specifiedType: const FullType.nullable(String),
    );
    yield r'cv_path';
    yield serializers.serialize(
      object.cvPath,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'notes';
    yield object.notes == null ? null : serializers.serialize(
      object.notes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'interview_date';
    yield object.interviewDate == null ? null : serializers.serialize(
      object.interviewDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'reviewed_by';
    yield object.reviewedBy == null ? null : serializers.serialize(
      object.reviewedBy,
      specifiedType: const FullType.nullable(int),
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
    JobApplication object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required JobApplicationBuilder result,
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
        case r'job_posting_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.jobPostingId = valueDes;
          break;
        case r'applicant_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicantName = valueDes;
          break;
        case r'applicant_email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicantEmail = valueDes;
          break;
        case r'applicant_phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicantPhone = valueDes;
          break;
        case r'cover_letter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.coverLetter = valueDes;
          break;
        case r'cv_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cvPath = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'interview_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.interviewDate = valueDes;
          break;
        case r'reviewed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reviewedBy = valueDes;
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
  JobApplication deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JobApplicationBuilder();
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

