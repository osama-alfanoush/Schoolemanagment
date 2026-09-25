//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'student_home200_response_data_attendance.g.dart';

/// StudentHome200ResponseDataAttendance
@BuiltValue()
abstract class StudentHome200ResponseDataAttendance implements Built<StudentHome200ResponseDataAttendance, StudentHome200ResponseDataAttendanceBuilder> {
  /// Any Of [BuiltList<String>], [String]
  AnyOf get anyOf;

  StudentHome200ResponseDataAttendance._();

  factory StudentHome200ResponseDataAttendance([void updates(StudentHome200ResponseDataAttendanceBuilder b)]) = _$StudentHome200ResponseDataAttendance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentHome200ResponseDataAttendanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentHome200ResponseDataAttendance> get serializer => _$StudentHome200ResponseDataAttendanceSerializer();
}

class _$StudentHome200ResponseDataAttendanceSerializer implements PrimitiveSerializer<StudentHome200ResponseDataAttendance> {
  @override
  final Iterable<Type> types = const [StudentHome200ResponseDataAttendance, _$StudentHome200ResponseDataAttendance];

  @override
  final String wireName = r'StudentHome200ResponseDataAttendance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentHome200ResponseDataAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentHome200ResponseDataAttendance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  StudentHome200ResponseDataAttendance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentHome200ResponseDataAttendanceBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(String), FullType(BuiltList, [FullType(String)]), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

