//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/user.dart';
import 'package:school_mobile/generated/model/parent_child_report_card200_response_grades.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_report_card200_response.g.dart';

/// ParentChildReportCard200Response
///
/// Properties:
/// * [student] 
/// * [grades] 
/// * [generatedAt] 
@BuiltValue()
abstract class ParentChildReportCard200Response implements Built<ParentChildReportCard200Response, ParentChildReportCard200ResponseBuilder> {
  @BuiltValueField(wireName: r'student')
  User? get student;

  @BuiltValueField(wireName: r'grades')
  ParentChildReportCard200ResponseGrades get grades;

  @BuiltValueField(wireName: r'generated_at')
  String get generatedAt;

  ParentChildReportCard200Response._();

  factory ParentChildReportCard200Response([void updates(ParentChildReportCard200ResponseBuilder b)]) = _$ParentChildReportCard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildReportCard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildReportCard200Response> get serializer => _$ParentChildReportCard200ResponseSerializer();
}

class _$ParentChildReportCard200ResponseSerializer implements PrimitiveSerializer<ParentChildReportCard200Response> {
  @override
  final Iterable<Type> types = const [ParentChildReportCard200Response, _$ParentChildReportCard200Response];

  @override
  final String wireName = r'ParentChildReportCard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildReportCard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student';
    yield object.student == null ? null : serializers.serialize(
      object.student,
      specifiedType: const FullType.nullable(User),
    );
    yield r'grades';
    yield serializers.serialize(
      object.grades,
      specifiedType: const FullType(ParentChildReportCard200ResponseGrades),
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
    ParentChildReportCard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildReportCard200ResponseBuilder result,
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
            specifiedType: const FullType(ParentChildReportCard200ResponseGrades),
          ) as ParentChildReportCard200ResponseGrades;
          result.grades.replace(valueDes);
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
  ParentChildReportCard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildReportCard200ResponseBuilder();
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

