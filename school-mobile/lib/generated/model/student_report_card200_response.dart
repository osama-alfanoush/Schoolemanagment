//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/user.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_report_card200_response.g.dart';

/// StudentReportCard200Response
///
/// Properties:
/// * [student] 
/// * [grades] 
/// * [generatedAt] 
@BuiltValue()
abstract class StudentReportCard200Response implements Built<StudentReportCard200Response, StudentReportCard200ResponseBuilder> {
  @BuiltValueField(wireName: r'student')
  User? get student;

  @BuiltValueField(wireName: r'grades')
  JsonObject? get grades;

  @BuiltValueField(wireName: r'generated_at')
  String get generatedAt;

  StudentReportCard200Response._();

  factory StudentReportCard200Response([void updates(StudentReportCard200ResponseBuilder b)]) = _$StudentReportCard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentReportCard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentReportCard200Response> get serializer => _$StudentReportCard200ResponseSerializer();
}

class _$StudentReportCard200ResponseSerializer implements PrimitiveSerializer<StudentReportCard200Response> {
  @override
  final Iterable<Type> types = const [StudentReportCard200Response, _$StudentReportCard200Response];

  @override
  final String wireName = r'StudentReportCard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentReportCard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student';
    yield object.student == null ? null : serializers.serialize(
      object.student,
      specifiedType: const FullType.nullable(User),
    );
    yield r'grades';
    yield object.grades == null ? null : serializers.serialize(
      object.grades,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'generated_at';
    yield serializers.serialize(
      object.generatedAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentReportCard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentReportCard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(User),
          ) as User?;
          if (valueDes == null) continue;
          result.student.replace(valueDes);
          break;
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.grades = valueDes;
          break;
        case r'generated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.generatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentReportCard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentReportCard200ResponseBuilder();
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

