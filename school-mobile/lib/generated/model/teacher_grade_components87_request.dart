//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grade_components87_request.g.dart';

/// TeacherGradeComponents87Request
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [weight] 
/// * [maxScore] 
/// * [semesterId] 
/// * [gradingPeriodId] 
@BuiltValue()
abstract class TeacherGradeComponents87Request implements Built<TeacherGradeComponents87Request, TeacherGradeComponents87RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  TeacherGradeComponents87RequestTypeEnum get type;
  // enum typeEnum {  quiz,  homework,  exam,  };

  @BuiltValueField(wireName: r'weight')
  num get weight;

  @BuiltValueField(wireName: r'max_score')
  num get maxScore;

  @BuiltValueField(wireName: r'semester_id')
  int? get semesterId;

  @BuiltValueField(wireName: r'grading_period_id')
  int? get gradingPeriodId;

  TeacherGradeComponents87Request._();

  factory TeacherGradeComponents87Request([void updates(TeacherGradeComponents87RequestBuilder b)]) = _$TeacherGradeComponents87Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradeComponents87RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradeComponents87Request> get serializer => _$TeacherGradeComponents87RequestSerializer();
}

class _$TeacherGradeComponents87RequestSerializer implements PrimitiveSerializer<TeacherGradeComponents87Request> {
  @override
  final Iterable<Type> types = const [TeacherGradeComponents87Request, _$TeacherGradeComponents87Request];

  @override
  final String wireName = r'TeacherGradeComponents87Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradeComponents87Request object, {
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
      specifiedType: const FullType(TeacherGradeComponents87RequestTypeEnum),
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
    TeacherGradeComponents87Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradeComponents87RequestBuilder result,
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
            specifiedType: const FullType(TeacherGradeComponents87RequestTypeEnum),
          ) as TeacherGradeComponents87RequestTypeEnum;
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
  TeacherGradeComponents87Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradeComponents87RequestBuilder();
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

class TeacherGradeComponents87RequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quiz')
  static const TeacherGradeComponents87RequestTypeEnum quiz = _$teacherGradeComponents87RequestTypeEnum_quiz;
  @BuiltValueEnumConst(wireName: r'homework')
  static const TeacherGradeComponents87RequestTypeEnum homework = _$teacherGradeComponents87RequestTypeEnum_homework;
  @BuiltValueEnumConst(wireName: r'exam')
  static const TeacherGradeComponents87RequestTypeEnum exam = _$teacherGradeComponents87RequestTypeEnum_exam;

  static Serializer<TeacherGradeComponents87RequestTypeEnum> get serializer => _$teacherGradeComponents87RequestTypeEnumSerializer;

  const TeacherGradeComponents87RequestTypeEnum._(String name): super(name);

  static BuiltSet<TeacherGradeComponents87RequestTypeEnum> get values => _$teacherGradeComponents87RequestTypeEnumValues;
  static TeacherGradeComponents87RequestTypeEnum valueOf(String name) => _$teacherGradeComponents87RequestTypeEnumValueOf(name);
}

