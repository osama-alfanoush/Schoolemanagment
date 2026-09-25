//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/student_home200_response_data_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_gradebook200_response_data_students_inner.g.dart';

/// TeacherGradebook200ResponseDataStudentsInner
///
/// Properties:
/// * [studentUserId] 
/// * [name] 
/// * [grades] 
@BuiltValue()
abstract class TeacherGradebook200ResponseDataStudentsInner implements Built<TeacherGradebook200ResponseDataStudentsInner, TeacherGradebook200ResponseDataStudentsInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grades')
  StudentHome200ResponseDataAttendance get grades;

  TeacherGradebook200ResponseDataStudentsInner._();

  factory TeacherGradebook200ResponseDataStudentsInner([void updates(TeacherGradebook200ResponseDataStudentsInnerBuilder b)]) = _$TeacherGradebook200ResponseDataStudentsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradebook200ResponseDataStudentsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradebook200ResponseDataStudentsInner> get serializer => _$TeacherGradebook200ResponseDataStudentsInnerSerializer();
}

class _$TeacherGradebook200ResponseDataStudentsInnerSerializer implements PrimitiveSerializer<TeacherGradebook200ResponseDataStudentsInner> {
  @override
  final Iterable<Type> types = const [TeacherGradebook200ResponseDataStudentsInner, _$TeacherGradebook200ResponseDataStudentsInner];

  @override
  final String wireName = r'TeacherGradebook200ResponseDataStudentsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradebook200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'grades';
    yield serializers.serialize(
      object.grades,
      specifiedType: const FullType(StudentHome200ResponseDataAttendance),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradebook200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradebook200ResponseDataStudentsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentHome200ResponseDataAttendance),
          ) as StudentHome200ResponseDataAttendance;
          result.grades.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherGradebook200ResponseDataStudentsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradebook200ResponseDataStudentsInnerBuilder();
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

