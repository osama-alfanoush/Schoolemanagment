//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_roster403_response.g.dart';

/// TeacherRoster403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class TeacherRoster403Response implements Built<TeacherRoster403Response, TeacherRoster403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  TeacherRoster403ResponseMessageEnum get message;
  // enum messageEnum {  You are not assigned to this class.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  TeacherRoster403Response._();

  factory TeacherRoster403Response([void updates(TeacherRoster403ResponseBuilder b)]) = _$TeacherRoster403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherRoster403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherRoster403Response> get serializer => _$TeacherRoster403ResponseSerializer();
}

class _$TeacherRoster403ResponseSerializer implements PrimitiveSerializer<TeacherRoster403Response> {
  @override
  final Iterable<Type> types = const [TeacherRoster403Response, _$TeacherRoster403Response];

  @override
  final String wireName = r'TeacherRoster403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherRoster403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(TeacherRoster403ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherRoster403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherRoster403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherRoster403ResponseMessageEnum),
          ) as TeacherRoster403ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherRoster403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherRoster403ResponseBuilder();
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

class TeacherRoster403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You are not assigned to this class.')
  static const TeacherRoster403ResponseMessageEnum youAreNotAssignedToThisClassPeriod = _$teacherRoster403ResponseMessageEnum_youAreNotAssignedToThisClassPeriod;

  static Serializer<TeacherRoster403ResponseMessageEnum> get serializer => _$teacherRoster403ResponseMessageEnumSerializer;

  const TeacherRoster403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<TeacherRoster403ResponseMessageEnum> get values => _$teacherRoster403ResponseMessageEnumValues;
  static TeacherRoster403ResponseMessageEnum valueOf(String name) => _$teacherRoster403ResponseMessageEnumValueOf(name);
}

