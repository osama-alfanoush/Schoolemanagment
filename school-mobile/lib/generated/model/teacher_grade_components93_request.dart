//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grade_components93_request.g.dart';

/// TeacherGradeComponents93Request
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [weight] 
/// * [maxScore] 
/// * [semesterId] 
/// * [gradingPeriodId] 
@BuiltValue()
abstract class TeacherGradeComponents93Request implements Built<TeacherGradeComponents93Request, TeacherGradeComponents93RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  TeacherGradeComponents93RequestTypeEnum get type;
  // enum typeEnum {  quiz,  homework,  exam,  };

  @BuiltValueField(wireName: r'weight')
  num get weight;

  @BuiltValueField(wireName: r'max_score')
  num get maxScore;

  @BuiltValueField(wireName: r'semester_id')
  int? get semesterId;

  @BuiltValueField(wireName: r'grading_period_id')
  int? get gradingPeriodId;

  TeacherGradeComponents93Request._();

  factory TeacherGradeComponents93Request([void updates(TeacherGradeComponents93RequestBuilder b)]) = _$TeacherGradeComponents93Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradeComponents93RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradeComponents93Request> get serializer => _$TeacherGradeComponents93RequestSerializer();
}

class _$TeacherGradeComponents93RequestSerializer implements PrimitiveSerializer<TeacherGradeComponents93Request> {
  @override
  final Iterable<Type> types = const [TeacherGradeComponents93Request, _$TeacherGradeComponents93Request];

  @override
  final String wireName = r'TeacherGradeComponents93Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradeComponents93Request object, {
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
      specifiedType: const FullType(TeacherGradeComponents93RequestTypeEnum),
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
    TeacherGradeComponents93Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradeComponents93RequestBuilder result,
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
            specifiedType: const FullType(TeacherGradeComponents93RequestTypeEnum),
          ) as TeacherGradeComponents93RequestTypeEnum;
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
  TeacherGradeComponents93Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradeComponents93RequestBuilder();
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

class TeacherGradeComponents93RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quiz')
  static const TeacherGradeComponents93RequestTypeEnum quiz = _$teacherGradeComponents93RequestTypeEnum_quiz;
  @BuiltValueEnumConst(wireName: r'homework')
  static const TeacherGradeComponents93RequestTypeEnum homework = _$teacherGradeComponents93RequestTypeEnum_homework;
  @BuiltValueEnumConst(wireName: r'exam')
  static const TeacherGradeComponents93RequestTypeEnum exam = _$teacherGradeComponents93RequestTypeEnum_exam;

  static Serializer<TeacherGradeComponents93RequestTypeEnum> get serializer => _$teacherGradeComponents93RequestTypeEnumSerializer;

  const TeacherGradeComponents93RequestTypeEnum._(String name): super(name);

  static BuiltSet<TeacherGradeComponents93RequestTypeEnum> get values => _$teacherGradeComponents93RequestTypeEnumValues;
  static TeacherGradeComponents93RequestTypeEnum valueOf(String name) => _$teacherGradeComponents93RequestTypeEnumValueOf(name);
}

