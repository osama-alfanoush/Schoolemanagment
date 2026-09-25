//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_enter_grade_request.g.dart';

/// TeacherEnterGradeRequest
///
/// Properties:
/// * [studentUserId] 
/// * [gradeComponentId] 
/// * [score] 
/// * [version] 
/// * [reason] 
@BuiltValue()
abstract class TeacherEnterGradeRequest implements Built<TeacherEnterGradeRequest, TeacherEnterGradeRequestBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'grade_component_id')
  int get gradeComponentId;

  @BuiltValueField(wireName: r'score')
  num get score;

  @BuiltValueField(wireName: r'version')
  int? get version;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  TeacherEnterGradeRequest._();

  factory TeacherEnterGradeRequest([void updates(TeacherEnterGradeRequestBuilder b)]) = _$TeacherEnterGradeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherEnterGradeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherEnterGradeRequest> get serializer => _$TeacherEnterGradeRequestSerializer();
}

class _$TeacherEnterGradeRequestSerializer implements PrimitiveSerializer<TeacherEnterGradeRequest> {
  @override
  final Iterable<Type> types = const [TeacherEnterGradeRequest, _$TeacherEnterGradeRequest];

  @override
  final String wireName = r'TeacherEnterGradeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherEnterGradeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'grade_component_id';
    yield serializers.serialize(
      object.gradeComponentId,
      specifiedType: const FullType(int),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(num),
    );
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherEnterGradeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherEnterGradeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'grade_component_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.gradeComponentId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.score = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.version = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherEnterGradeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherEnterGradeRequestBuilder();
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

