//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_log_conduct403_response.g.dart';

/// TeacherLogConduct403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class TeacherLogConduct403Response implements Built<TeacherLogConduct403Response, TeacherLogConduct403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  TeacherLogConduct403ResponseMessageEnum get message;
  // enum messageEnum {  You may not log conduct for this student.,  };

  TeacherLogConduct403Response._();

  factory TeacherLogConduct403Response([void updates(TeacherLogConduct403ResponseBuilder b)]) = _$TeacherLogConduct403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherLogConduct403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherLogConduct403Response> get serializer => _$TeacherLogConduct403ResponseSerializer();
}

class _$TeacherLogConduct403ResponseSerializer implements PrimitiveSerializer<TeacherLogConduct403Response> {
  @override
  final Iterable<Type> types = const [TeacherLogConduct403Response, _$TeacherLogConduct403Response];

  @override
  final String wireName = r'TeacherLogConduct403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherLogConduct403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(TeacherLogConduct403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherLogConduct403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherLogConduct403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherLogConduct403ResponseMessageEnum),
          ) as TeacherLogConduct403ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherLogConduct403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherLogConduct403ResponseBuilder();
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

class TeacherLogConduct403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You may not log conduct for this student.')
  static const TeacherLogConduct403ResponseMessageEnum youMayNotLogConductForThisStudentPeriod = _$teacherLogConduct403ResponseMessageEnum_youMayNotLogConductForThisStudentPeriod;

  static Serializer<TeacherLogConduct403ResponseMessageEnum> get serializer => _$teacherLogConduct403ResponseMessageEnumSerializer;

  const TeacherLogConduct403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<TeacherLogConduct403ResponseMessageEnum> get values => _$teacherLogConduct403ResponseMessageEnumValues;
  static TeacherLogConduct403ResponseMessageEnum valueOf(String name) => _$teacherLogConduct403ResponseMessageEnumValueOf(name);
}

