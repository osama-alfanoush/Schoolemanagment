//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_attach_to_assignment200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_attach_to_assignment200_response.g.dart';

/// TeacherAttachToAssignment200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherAttachToAssignment200Response implements Built<TeacherAttachToAssignment200Response, TeacherAttachToAssignment200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherAttachToAssignment200ResponseData get data;

  TeacherAttachToAssignment200Response._();

  factory TeacherAttachToAssignment200Response([void updates(TeacherAttachToAssignment200ResponseBuilder b)]) = _$TeacherAttachToAssignment200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAttachToAssignment200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAttachToAssignment200Response> get serializer => _$TeacherAttachToAssignment200ResponseSerializer();
}

class _$TeacherAttachToAssignment200ResponseSerializer implements PrimitiveSerializer<TeacherAttachToAssignment200Response> {
  @override
  final Iterable<Type> types = const [TeacherAttachToAssignment200Response, _$TeacherAttachToAssignment200Response];

  @override
  final String wireName = r'TeacherAttachToAssignment200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAttachToAssignment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherAttachToAssignment200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttachToAssignment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAttachToAssignment200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherAttachToAssignment200ResponseData),
          ) as TeacherAttachToAssignment200ResponseData;
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
  TeacherAttachToAssignment200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAttachToAssignment200ResponseBuilder();
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

