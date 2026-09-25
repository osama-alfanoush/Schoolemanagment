//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grade_submission_request.g.dart';

/// TeacherGradeSubmissionRequest
///
/// Properties:
/// * [score] 
/// * [feedback] 
@BuiltValue()
abstract class TeacherGradeSubmissionRequest implements Built<TeacherGradeSubmissionRequest, TeacherGradeSubmissionRequestBuilder> {
  @BuiltValueField(wireName: r'score')
  num get score;

  @BuiltValueField(wireName: r'feedback')
  String? get feedback;

  TeacherGradeSubmissionRequest._();

  factory TeacherGradeSubmissionRequest([void updates(TeacherGradeSubmissionRequestBuilder b)]) = _$TeacherGradeSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradeSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradeSubmissionRequest> get serializer => _$TeacherGradeSubmissionRequestSerializer();
}

class _$TeacherGradeSubmissionRequestSerializer implements PrimitiveSerializer<TeacherGradeSubmissionRequest> {
  @override
  final Iterable<Type> types = const [TeacherGradeSubmissionRequest, _$TeacherGradeSubmissionRequest];

  @override
  final String wireName = r'TeacherGradeSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradeSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(num),
    );
    if (object.feedback != null) {
      yield r'feedback';
      yield serializers.serialize(
        object.feedback,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradeSubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.score = valueDes;
          break;
        case r'feedback':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feedback = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherGradeSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradeSubmissionRequestBuilder();
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

