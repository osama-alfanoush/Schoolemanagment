//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'performance_evaluation.g.dart';

/// PerformanceEvaluation
///
/// Properties:
/// * [id] 
/// * [staffUserId] 
/// * [evaluatorId] 
/// * [evaluationDate] 
/// * [period] 
/// * [criteriaScores] 
/// * [overallScore] 
/// * [strengths] 
/// * [areasForImprovement] 
/// * [goals] 
/// * [evaluatorComments] 
/// * [reviewedBy] 
/// * [reviewedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class PerformanceEvaluation implements Built<PerformanceEvaluation, PerformanceEvaluationBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'evaluator_id')
  int get evaluatorId;

  @BuiltValueField(wireName: r'evaluation_date')
  DateTime get evaluationDate;

  @BuiltValueField(wireName: r'period')
  String get period;

  @BuiltValueField(wireName: r'criteria_scores')
  BuiltList<JsonObject?> get criteriaScores;

  @BuiltValueField(wireName: r'overall_score')
  String? get overallScore;

  @BuiltValueField(wireName: r'strengths')
  String? get strengths;

  @BuiltValueField(wireName: r'areas_for_improvement')
  String? get areasForImprovement;

  @BuiltValueField(wireName: r'goals')
  String? get goals;

  @BuiltValueField(wireName: r'evaluator_comments')
  String? get evaluatorComments;

  @BuiltValueField(wireName: r'reviewed_by')
  int? get reviewedBy;

  @BuiltValueField(wireName: r'reviewed_at')
  DateTime? get reviewedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  PerformanceEvaluation._();

  factory PerformanceEvaluation([void updates(PerformanceEvaluationBuilder b)]) = _$PerformanceEvaluation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerformanceEvaluationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerformanceEvaluation> get serializer => _$PerformanceEvaluationSerializer();
}

class _$PerformanceEvaluationSerializer implements PrimitiveSerializer<PerformanceEvaluation> {
  @override
  final Iterable<Type> types = const [PerformanceEvaluation, _$PerformanceEvaluation];

  @override
  final String wireName = r'PerformanceEvaluation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerformanceEvaluation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'staff_user_id';
    yield serializers.serialize(
      object.staffUserId,
      specifiedType: const FullType(int),
    );
    yield r'evaluator_id';
    yield serializers.serialize(
      object.evaluatorId,
      specifiedType: const FullType(int),
    );
    yield r'evaluation_date';
    yield serializers.serialize(
      object.evaluationDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'period';
    yield serializers.serialize(
      object.period,
      specifiedType: const FullType(String),
    );
    yield r'criteria_scores';
    yield serializers.serialize(
      object.criteriaScores,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'overall_score';
    yield object.overallScore == null ? null : serializers.serialize(
      object.overallScore,
      specifiedType: const FullType.nullable(String),
    );
    yield r'strengths';
    yield object.strengths == null ? null : serializers.serialize(
      object.strengths,
      specifiedType: const FullType.nullable(String),
    );
    yield r'areas_for_improvement';
    yield object.areasForImprovement == null ? null : serializers.serialize(
      object.areasForImprovement,
      specifiedType: const FullType.nullable(String),
    );
    yield r'goals';
    yield object.goals == null ? null : serializers.serialize(
      object.goals,
      specifiedType: const FullType.nullable(String),
    );
    yield r'evaluator_comments';
    yield object.evaluatorComments == null ? null : serializers.serialize(
      object.evaluatorComments,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reviewed_by';
    yield object.reviewedBy == null ? null : serializers.serialize(
      object.reviewedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'reviewed_at';
    yield object.reviewedAt == null ? null : serializers.serialize(
      object.reviewedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    PerformanceEvaluation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerformanceEvaluationBuilder result,
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
        case r'staff_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffUserId = valueDes;
          break;
        case r'evaluator_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.evaluatorId = valueDes;
          break;
        case r'evaluation_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.evaluationDate = valueDes;
          break;
        case r'period':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.period = valueDes;
          break;
        case r'criteria_scores':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.criteriaScores.replace(valueDes);
          break;
        case r'overall_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.overallScore = valueDes;
          break;
        case r'strengths':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.strengths = valueDes;
          break;
        case r'areas_for_improvement':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.areasForImprovement = valueDes;
          break;
        case r'goals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.goals = valueDes;
          break;
        case r'evaluator_comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.evaluatorComments = valueDes;
          break;
        case r'reviewed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.reviewedBy = valueDes;
          break;
        case r'reviewed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reviewedAt = valueDes;
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
  PerformanceEvaluation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerformanceEvaluationBuilder();
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

