//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/user.dart';
import 'package:school_mobile/generated/model/assignment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_assignment_submissions200_response.g.dart';

/// TeacherAssignmentSubmissions200Response
///
/// Properties:
/// * [assignment] 
/// * [students] 
@BuiltValue()
abstract class TeacherAssignmentSubmissions200Response implements Built<TeacherAssignmentSubmissions200Response, TeacherAssignmentSubmissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'assignment')
  Assignment get assignment;

  @BuiltValueField(wireName: r'students')
  BuiltList<User> get students;

  TeacherAssignmentSubmissions200Response._();

  factory TeacherAssignmentSubmissions200Response([void updates(TeacherAssignmentSubmissions200ResponseBuilder b)]) = _$TeacherAssignmentSubmissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAssignmentSubmissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAssignmentSubmissions200Response> get serializer => _$TeacherAssignmentSubmissions200ResponseSerializer();
}

class _$TeacherAssignmentSubmissions200ResponseSerializer implements PrimitiveSerializer<TeacherAssignmentSubmissions200Response> {
  @override
  final Iterable<Type> types = const [TeacherAssignmentSubmissions200Response, _$TeacherAssignmentSubmissions200Response];

  @override
  final String wireName = r'TeacherAssignmentSubmissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAssignmentSubmissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'assignment';
    yield serializers.serialize(
      object.assignment,
      specifiedType: const FullType(Assignment),
    );
    yield r'students';
    yield serializers.serialize(
      object.students,
      specifiedType: const FullType(BuiltList, [FullType(User)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAssignmentSubmissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAssignmentSubmissions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assignment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Assignment),
          ) as Assignment;
          result.assignment.replace(valueDes);
          break;
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(User)]),
          ) as BuiltList<User>;
          result.students.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAssignmentSubmissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAssignmentSubmissions200ResponseBuilder();
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

