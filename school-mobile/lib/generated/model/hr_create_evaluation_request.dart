//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_create_evaluation_request_criteria_scores_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_create_evaluation_request.g.dart';

/// HrCreateEvaluationRequest
///
/// Properties:
/// * [staffUserId] 
/// * [period] 
/// * [criteriaScores] 
/// * [overallScore] 
/// * [strengths] 
/// * [areasForImprovement] 
/// * [goals] 
/// * [evaluatorComments] 
@BuiltValue()
abstract class HrCreateEvaluationRequest implements Built<HrCreateEvaluationRequest, HrCreateEvaluationRequestBuilder> {
  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'period')
  String get period;

  @BuiltValueField(wireName: r'criteria_scores')
  BuiltList<HrCreateEvaluationRequestCriteriaScoresInner> get criteriaScores;

  @BuiltValueField(wireName: r'overall_score')
  num? get overallScore;

  @BuiltValueField(wireName: r'strengths')
  String? get strengths;

  @BuiltValueField(wireName: r'areas_for_improvement')
  String? get areasForImprovement;

  @BuiltValueField(wireName: r'goals')
  String? get goals;

  @BuiltValueField(wireName: r'evaluator_comments')
  String? get evaluatorComments;

  HrCreateEvaluationRequest._();

  factory HrCreateEvaluationRequest([void updates(HrCreateEvaluationRequestBuilder b)]) = _$HrCreateEvaluationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrCreateEvaluationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrCreateEvaluationRequest> get serializer => _$HrCreateEvaluationRequestSerializer();
}

class _$HrCreateEvaluationRequestSerializer implements PrimitiveSerializer<HrCreateEvaluationRequest> {
  @override
  final Iterable<Type> types = const [HrCreateEvaluationRequest, _$HrCreateEvaluationRequest];

  @override
  final String wireName = r'HrCreateEvaluationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrCreateEvaluationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'staff_user_id';
    yield serializers.serialize(
      object.staffUserId,
      specifiedType: const FullType(int),
    );
    yield r'period';
    yield serializers.serialize(
      object.period,
      specifiedType: const FullType(String),
    );
    yield r'criteria_scores';
    yield serializers.serialize(
      object.criteriaScores,
      specifiedType: const FullType(BuiltList, [FullType(HrCreateEvaluationRequestCriteriaScoresInner)]),
    );
    if (object.overallScore != null) {
      yield r'overall_score';
      yield serializers.serialize(
        object.overallScore,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.strengths != null) {
      yield r'strengths';
      yield serializers.serialize(
        object.strengths,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.areasForImprovement != null) {
      yield r'areas_for_improvement';
      yield serializers.serialize(
        object.areasForImprovement,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.goals != null) {
      yield r'goals';
      yield serializers.serialize(
        object.goals,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.evaluatorComments != null) {
      yield r'evaluator_comments';
      yield serializers.serialize(
        object.evaluatorComments,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrCreateEvaluationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrCreateEvaluationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'staff_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffUserId = valueDes;
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
            specifiedType: const FullType(BuiltList, [FullType(HrCreateEvaluationRequestCriteriaScoresInner)]),
          ) as BuiltList<HrCreateEvaluationRequestCriteriaScoresInner>;
          result.criteriaScores.replace(valueDes);
          break;
        case r'overall_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrCreateEvaluationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrCreateEvaluationRequestBuilder();
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

