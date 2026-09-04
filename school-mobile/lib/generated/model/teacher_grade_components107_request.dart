//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grade_components107_request.g.dart';

/// TeacherGradeComponents107Request
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [weight] 
/// * [maxScore] 
/// * [semesterId] 
/// * [gradingPeriodId] 
@BuiltValue()
abstract class TeacherGradeComponents107Request implements Built<TeacherGradeComponents107Request, TeacherGradeComponents107RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  TeacherGradeComponents107RequestTypeEnum get type;
  // enum typeEnum {  quiz,  homework,  exam,  };

  @BuiltValueField(wireName: r'weight')
  num get weight;

  @BuiltValueField(wireName: r'max_score')
  num get maxScore;

  @BuiltValueField(wireName: r'semester_id')
  int? get semesterId;

  @BuiltValueField(wireName: r'grading_period_id')
  int? get gradingPeriodId;

  TeacherGradeComponents107Request._();

  factory TeacherGradeComponents107Request([void updates(TeacherGradeComponents107RequestBuilder b)]) = _$TeacherGradeComponents107Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradeComponents107RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradeComponents107Request> get serializer => _$TeacherGradeComponents107RequestSerializer();
}

class _$TeacherGradeComponents107RequestSerializer implements PrimitiveSerializer<TeacherGradeComponents107Request> {
  @override
  final Iterable<Type> types = const [TeacherGradeComponents107Request, _$TeacherGradeComponents107Request];

  @override
  final String wireName = r'TeacherGradeComponents107Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradeComponents107Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(TeacherGradeComponents107RequestTypeEnum),
    );
    yield r'weight';
    yield serializers.serialize(
      object.weight,
      specifiedType: const FullType(num),
    );
    yield r'max_score';
    yield serializers.serialize(
      object.maxScore,
      specifiedType: const FullType(num),
    );
    if (object.semesterId != null) {
      yield r'semester_id';
      yield serializers.serialize(
        object.semesterId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.gradingPeriodId != null) {
      yield r'grading_period_id';
      yield serializers.serialize(
        object.gradingPeriodId,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents107Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradeComponents107RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherGradeComponents107RequestTypeEnum),
          ) as TeacherGradeComponents107RequestTypeEnum;
          result.type = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.weight = valueDes;
          break;
        case r'max_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxScore = valueDes;
          break;
        case r'semester_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.semesterId = valueDes;
          break;
        case r'grading_period_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.gradingPeriodId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherGradeComponents107Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradeComponents107RequestBuilder();
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

class TeacherGradeComponents107RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quiz')
  static const TeacherGradeComponents107RequestTypeEnum quiz = _$teacherGradeComponents107RequestTypeEnum_quiz;
  @BuiltValueEnumConst(wireName: r'homework')
  static const TeacherGradeComponents107RequestTypeEnum homework = _$teacherGradeComponents107RequestTypeEnum_homework;
  @BuiltValueEnumConst(wireName: r'exam')
  static const TeacherGradeComponents107RequestTypeEnum exam = _$teacherGradeComponents107RequestTypeEnum_exam;

  static Serializer<TeacherGradeComponents107RequestTypeEnum> get serializer => _$teacherGradeComponents107RequestTypeEnumSerializer;

  const TeacherGradeComponents107RequestTypeEnum._(String name): super(name);

  static BuiltSet<TeacherGradeComponents107RequestTypeEnum> get values => _$teacherGradeComponents107RequestTypeEnumValues;
  static TeacherGradeComponents107RequestTypeEnum valueOf(String name) => _$teacherGradeComponents107RequestTypeEnumValueOf(name);
}

