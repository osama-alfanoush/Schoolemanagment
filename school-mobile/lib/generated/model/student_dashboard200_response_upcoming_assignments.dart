//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/assignment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'student_dashboard200_response_upcoming_assignments.g.dart';

/// StudentDashboard200ResponseUpcomingAssignments
@BuiltValue()
abstract class StudentDashboard200ResponseUpcomingAssignments implements Built<StudentDashboard200ResponseUpcomingAssignments, StudentDashboard200ResponseUpcomingAssignmentsBuilder> {
  /// Any Of [BuiltList<Assignment>], [BuiltList<String>]
  AnyOf get anyOf;

  StudentDashboard200ResponseUpcomingAssignments._();

  factory StudentDashboard200ResponseUpcomingAssignments([void updates(StudentDashboard200ResponseUpcomingAssignmentsBuilder b)]) = _$StudentDashboard200ResponseUpcomingAssignments;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentDashboard200ResponseUpcomingAssignmentsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentDashboard200ResponseUpcomingAssignments> get serializer => _$StudentDashboard200ResponseUpcomingAssignmentsSerializer();
}

class _$StudentDashboard200ResponseUpcomingAssignmentsSerializer implements PrimitiveSerializer<StudentDashboard200ResponseUpcomingAssignments> {
  @override
  final Iterable<Type> types = const [StudentDashboard200ResponseUpcomingAssignments, _$StudentDashboard200ResponseUpcomingAssignments];

  @override
  final String wireName = r'StudentDashboard200ResponseUpcomingAssignments';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentDashboard200ResponseUpcomingAssignments object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentDashboard200ResponseUpcomingAssignments object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  StudentDashboard200ResponseUpcomingAssignments deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentDashboard200ResponseUpcomingAssignmentsBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(Assignment)]), FullType(BuiltList, [FullType(String)]), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

