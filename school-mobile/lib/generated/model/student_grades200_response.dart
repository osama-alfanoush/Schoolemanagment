//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/grade.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_grades200_response.g.dart';

/// StudentGrades200Response
///
/// Properties:
/// * [data] 
/// * [bySubject] 
@BuiltValue()
abstract class StudentGrades200Response implements Built<StudentGrades200Response, StudentGrades200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<Grade> get data;

  @BuiltValueField(wireName: r'by_subject')
  String get bySubject;

  StudentGrades200Response._();

  factory StudentGrades200Response([void updates(StudentGrades200ResponseBuilder b)]) = _$StudentGrades200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentGrades200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentGrades200Response> get serializer => _$StudentGrades200ResponseSerializer();
}

class _$StudentGrades200ResponseSerializer implements PrimitiveSerializer<StudentGrades200Response> {
  @override
  final Iterable<Type> types = const [StudentGrades200Response, _$StudentGrades200Response];

  @override
  final String wireName = r'StudentGrades200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Grade)]),
    );
    yield r'by_subject';
    yield serializers.serialize(
      object.bySubject,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentGrades200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Grade)]),
          ) as BuiltList<Grade>;
          result.data.replace(valueDes);
          break;
        case r'by_subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bySubject = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentGrades200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentGrades200ResponseBuilder();
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

