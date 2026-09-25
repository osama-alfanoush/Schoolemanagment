//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_submit_assignment403_response.g.dart';

/// StudentSubmitAssignment403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class StudentSubmitAssignment403Response implements Built<StudentSubmitAssignment403Response, StudentSubmitAssignment403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  StudentSubmitAssignment403ResponseMessageEnum get message;
  // enum messageEnum {  Forbidden,  };

  StudentSubmitAssignment403Response._();

  factory StudentSubmitAssignment403Response([void updates(StudentSubmitAssignment403ResponseBuilder b)]) = _$StudentSubmitAssignment403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentSubmitAssignment403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentSubmitAssignment403Response> get serializer => _$StudentSubmitAssignment403ResponseSerializer();
}

class _$StudentSubmitAssignment403ResponseSerializer implements PrimitiveSerializer<StudentSubmitAssignment403Response> {
  @override
  final Iterable<Type> types = const [StudentSubmitAssignment403Response, _$StudentSubmitAssignment403Response];

  @override
  final String wireName = r'StudentSubmitAssignment403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentSubmitAssignment403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(StudentSubmitAssignment403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentSubmitAssignment403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentSubmitAssignment403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentSubmitAssignment403ResponseMessageEnum),
          ) as StudentSubmitAssignment403ResponseMessageEnum;
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
  StudentSubmitAssignment403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentSubmitAssignment403ResponseBuilder();
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

class StudentSubmitAssignment403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Forbidden')
  static const StudentSubmitAssignment403ResponseMessageEnum forbidden = _$studentSubmitAssignment403ResponseMessageEnum_forbidden;

  static Serializer<StudentSubmitAssignment403ResponseMessageEnum> get serializer => _$studentSubmitAssignment403ResponseMessageEnumSerializer;

  const StudentSubmitAssignment403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<StudentSubmitAssignment403ResponseMessageEnum> get values => _$studentSubmitAssignment403ResponseMessageEnumValues;
  static StudentSubmitAssignment403ResponseMessageEnum valueOf(String name) => _$studentSubmitAssignment403ResponseMessageEnumValueOf(name);
}

