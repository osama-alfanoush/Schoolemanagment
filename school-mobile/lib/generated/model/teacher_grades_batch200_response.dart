//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook_submit200_response.dart';
import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'teacher_grades_batch200_response.g.dart';

/// TeacherGradesBatch200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherGradesBatch200Response implements Built<TeacherGradesBatch200Response, TeacherGradesBatch200ResponseBuilder> {
  /// Any Of [GradebookSubmit200Response], [String]
  AnyOf get anyOf;

  TeacherGradesBatch200Response._();

  factory TeacherGradesBatch200Response([void updates(TeacherGradesBatch200ResponseBuilder b)]) = _$TeacherGradesBatch200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradesBatch200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradesBatch200Response> get serializer => _$TeacherGradesBatch200ResponseSerializer();
}

class _$TeacherGradesBatch200ResponseSerializer implements PrimitiveSerializer<TeacherGradesBatch200Response> {
  @override
  final Iterable<Type> types = const [TeacherGradesBatch200Response, _$TeacherGradesBatch200Response];

  @override
  final String wireName = r'TeacherGradesBatch200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradesBatch200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradesBatch200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  TeacherGradesBatch200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradesBatch200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(GradebookSubmit200Response), FullType(String), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

