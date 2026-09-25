//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/mobile_student_assignments200_response_data_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_assignments200_response.g.dart';

/// TeacherAssignments200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherAssignments200Response implements Built<TeacherAssignments200Response, TeacherAssignments200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  MobileStudentAssignments200ResponseDataAnyOf get data;

  TeacherAssignments200Response._();

  factory TeacherAssignments200Response([void updates(TeacherAssignments200ResponseBuilder b)]) = _$TeacherAssignments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAssignments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAssignments200Response> get serializer => _$TeacherAssignments200ResponseSerializer();
}

class _$TeacherAssignments200ResponseSerializer implements PrimitiveSerializer<TeacherAssignments200Response> {
  @override
  final Iterable<Type> types = const [TeacherAssignments200Response, _$TeacherAssignments200Response];

  @override
  final String wireName = r'TeacherAssignments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(MobileStudentAssignments200ResponseDataAnyOf),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAssignments200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MobileStudentAssignments200ResponseDataAnyOf),
          ) as MobileStudentAssignments200ResponseDataAnyOf;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAssignments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAssignments200ResponseBuilder();
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

