//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_issue_request.g.dart';

/// GradebookIssueRequest
///
/// Properties:
/// * [studentEnrollmentId] 
/// * [gradingPeriodId] 
/// * [correctionReason] 
@BuiltValue()
abstract class GradebookIssueRequest implements Built<GradebookIssueRequest, GradebookIssueRequestBuilder> {
  @BuiltValueField(wireName: r'student_enrollment_id')
  int get studentEnrollmentId;

  @BuiltValueField(wireName: r'grading_period_id')
  int get gradingPeriodId;

  @BuiltValueField(wireName: r'correction_reason')
  String? get correctionReason;

  GradebookIssueRequest._();

  factory GradebookIssueRequest([void updates(GradebookIssueRequestBuilder b)]) = _$GradebookIssueRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookIssueRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookIssueRequest> get serializer => _$GradebookIssueRequestSerializer();
}

class _$GradebookIssueRequestSerializer implements PrimitiveSerializer<GradebookIssueRequest> {
  @override
  final Iterable<Type> types = const [GradebookIssueRequest, _$GradebookIssueRequest];

  @override
  final String wireName = r'GradebookIssueRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookIssueRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.correctionReason != null) {
      yield r'correction_reason';
      yield serializers.serialize(
        object.correctionReason,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GradebookIssueRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookIssueRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'correction_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.correctionReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GradebookIssueRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookIssueRequestBuilder();
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

