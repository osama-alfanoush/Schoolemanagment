//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_create_evaluation_request_criteria_scores_inner.g.dart';

/// HrCreateEvaluationRequestCriteriaScoresInner
///
/// Properties:
/// * [criteria] 
/// * [score] 
@BuiltValue()
abstract class HrCreateEvaluationRequestCriteriaScoresInner implements Built<HrCreateEvaluationRequestCriteriaScoresInner, HrCreateEvaluationRequestCriteriaScoresInnerBuilder> {
  @BuiltValueField(wireName: r'criteria')
  String get criteria;

  @BuiltValueField(wireName: r'score')
  int get score;

  HrCreateEvaluationRequestCriteriaScoresInner._();

  factory HrCreateEvaluationRequestCriteriaScoresInner([void updates(HrCreateEvaluationRequestCriteriaScoresInnerBuilder b)]) = _$HrCreateEvaluationRequestCriteriaScoresInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrCreateEvaluationRequestCriteriaScoresInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrCreateEvaluationRequestCriteriaScoresInner> get serializer => _$HrCreateEvaluationRequestCriteriaScoresInnerSerializer();
}

class _$HrCreateEvaluationRequestCriteriaScoresInnerSerializer implements PrimitiveSerializer<HrCreateEvaluationRequestCriteriaScoresInner> {
  @override
  final Iterable<Type> types = const [HrCreateEvaluationRequestCriteriaScoresInner, _$HrCreateEvaluationRequestCriteriaScoresInner];

  @override
  final String wireName = r'HrCreateEvaluationRequestCriteriaScoresInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrCreateEvaluationRequestCriteriaScoresInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'criteria';
    yield serializers.serialize(
      object.criteria,
      specifiedType: const FullType(String),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrCreateEvaluationRequestCriteriaScoresInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrCreateEvaluationRequestCriteriaScoresInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'criteria':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.criteria = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.score = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrCreateEvaluationRequestCriteriaScoresInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrCreateEvaluationRequestCriteriaScoresInnerBuilder();
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

