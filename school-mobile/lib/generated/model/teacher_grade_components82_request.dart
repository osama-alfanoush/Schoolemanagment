//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grade_components82_request.g.dart';

/// TeacherGradeComponents82Request
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [weight] 
/// * [maxScore] 
/// * [semesterId] 
/// * [gradingPeriodId] 
@BuiltValue()
abstract class TeacherGradeComponents82Request implements Built<TeacherGradeComponents82Request, TeacherGradeComponents82RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  TeacherGradeComponents82RequestTypeEnum get type;
  // enum typeEnum {  quiz,  homework,  exam,  };

  @BuiltValueField(wireName: r'weight')
  num get weight;

  @BuiltValueField(wireName: r'max_score')
  num get maxScore;

  @BuiltValueField(wireName: r'semester_id')
  int? get semesterId;

  @BuiltValueField(wireName: r'grading_period_id')
  int? get gradingPeriodId;

  TeacherGradeComponents82Request._();

  factory TeacherGradeComponents82Request([void updates(TeacherGradeComponents82RequestBuilder b)]) = _$TeacherGradeComponents82Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradeComponents82RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradeComponents82Request> get serializer => _$TeacherGradeComponents82RequestSerializer();
}

class _$TeacherGradeComponents82RequestSerializer implements PrimitiveSerializer<TeacherGradeComponents82Request> {
  @override
  final Iterable<Type> types = const [TeacherGradeComponents82Request, _$TeacherGradeComponents82Request];

  @override
  final String wireName = r'TeacherGradeComponents82Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradeComponents82Request object, {
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
      specifiedType: const FullType(TeacherGradeComponents82RequestTypeEnum),
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
    TeacherGradeComponents82Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradeComponents82RequestBuilder result,
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
            specifiedType: const FullType(TeacherGradeComponents82RequestTypeEnum),
          ) as TeacherGradeComponents82RequestTypeEnum;
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
  TeacherGradeComponents82Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradeComponents82RequestBuilder();
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

class TeacherGradeComponents82RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quiz')
  static const TeacherGradeComponents82RequestTypeEnum quiz = _$teacherGradeComponents82RequestTypeEnum_quiz;
  @BuiltValueEnumConst(wireName: r'homework')
  static const TeacherGradeComponents82RequestTypeEnum homework = _$teacherGradeComponents82RequestTypeEnum_homework;
  @BuiltValueEnumConst(wireName: r'exam')
  static const TeacherGradeComponents82RequestTypeEnum exam = _$teacherGradeComponents82RequestTypeEnum_exam;

  static Serializer<TeacherGradeComponents82RequestTypeEnum> get serializer => _$teacherGradeComponents82RequestTypeEnumSerializer;

  const TeacherGradeComponents82RequestTypeEnum._(String name): super(name);

  static BuiltSet<TeacherGradeComponents82RequestTypeEnum> get values => _$teacherGradeComponents82RequestTypeEnumValues;
  static TeacherGradeComponents82RequestTypeEnum valueOf(String name) => _$teacherGradeComponents82RequestTypeEnumValueOf(name);
}

