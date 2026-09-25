//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/student_dashboard200_response_upcoming_assignments.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/attendance_record.dart';
import 'package:school_mobile/generated/model/grade.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_dashboard200_response.g.dart';

/// StudentDashboard200Response
///
/// Properties:
/// * [upcomingAssignments] 
/// * [recentGrades] 
/// * [todayAttendance] 
@BuiltValue()
abstract class StudentDashboard200Response implements Built<StudentDashboard200Response, StudentDashboard200ResponseBuilder> {
  @BuiltValueField(wireName: r'upcoming_assignments')
  StudentDashboard200ResponseUpcomingAssignments get upcomingAssignments;

  @BuiltValueField(wireName: r'recent_grades')
  BuiltList<Grade> get recentGrades;

  @BuiltValueField(wireName: r'today_attendance')
  AttendanceRecord? get todayAttendance;

  StudentDashboard200Response._();

  factory StudentDashboard200Response([void updates(StudentDashboard200ResponseBuilder b)]) = _$StudentDashboard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentDashboard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentDashboard200Response> get serializer => _$StudentDashboard200ResponseSerializer();
}

class _$StudentDashboard200ResponseSerializer implements PrimitiveSerializer<StudentDashboard200Response> {
  @override
  final Iterable<Type> types = const [StudentDashboard200Response, _$StudentDashboard200Response];

  @override
  final String wireName = r'StudentDashboard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'upcoming_assignments';
    yield serializers.serialize(
      object.upcomingAssignments,
      specifiedType: const FullType(StudentDashboard200ResponseUpcomingAssignments),
    );
    yield r'recent_grades';
    yield serializers.serialize(
      object.recentGrades,
      specifiedType: const FullType(BuiltList, [FullType(Grade)]),
    );
    yield r'today_attendance';
    yield object.todayAttendance == null ? null : serializers.serialize(
      object.todayAttendance,
      specifiedType: const FullType.nullable(AttendanceRecord),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentDashboard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'upcoming_assignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentDashboard200ResponseUpcomingAssignments),
          ) as StudentDashboard200ResponseUpcomingAssignments;
          result.upcomingAssignments.replace(valueDes);
          break;
        case r'recent_grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Grade)]),
          ) as BuiltList<Grade>;
          result.recentGrades.replace(valueDes);
          break;
        case r'today_attendance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AttendanceRecord),
          ) as AttendanceRecord?;
          if (valueDes == null) continue;
          result.todayAttendance.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentDashboard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentDashboard200ResponseBuilder();
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

