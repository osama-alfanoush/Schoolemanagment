//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_gradebook200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_gradebook200_response.g.dart';

/// TeacherGradebook200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherGradebook200Response implements Built<TeacherGradebook200Response, TeacherGradebook200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherGradebook200ResponseData get data;

  TeacherGradebook200Response._();

  factory TeacherGradebook200Response([void updates(TeacherGradebook200ResponseBuilder b)]) = _$TeacherGradebook200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradebook200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradebook200Response> get serializer => _$TeacherGradebook200ResponseSerializer();
}

class _$TeacherGradebook200ResponseSerializer implements PrimitiveSerializer<TeacherGradebook200Response> {
  @override
  final Iterable<Type> types = const [TeacherGradebook200Response, _$TeacherGradebook200Response];

  @override
  final String wireName = r'TeacherGradebook200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradebook200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherGradebook200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradebook200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradebook200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherGradebook200ResponseData),
          ) as TeacherGradebook200ResponseData;
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
  TeacherGradebook200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradebook200ResponseBuilder();
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

