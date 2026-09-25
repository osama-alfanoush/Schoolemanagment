//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_submissions200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_submissions200_response.g.dart';

/// TeacherSubmissions200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherSubmissions200Response implements Built<TeacherSubmissions200Response, TeacherSubmissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherSubmissions200ResponseData get data;

  TeacherSubmissions200Response._();

  factory TeacherSubmissions200Response([void updates(TeacherSubmissions200ResponseBuilder b)]) = _$TeacherSubmissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherSubmissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherSubmissions200Response> get serializer => _$TeacherSubmissions200ResponseSerializer();
}

class _$TeacherSubmissions200ResponseSerializer implements PrimitiveSerializer<TeacherSubmissions200Response> {
  @override
  final Iterable<Type> types = const [TeacherSubmissions200Response, _$TeacherSubmissions200Response];

  @override
  final String wireName = r'TeacherSubmissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherSubmissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherSubmissions200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherSubmissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherSubmissions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherSubmissions200ResponseData),
          ) as TeacherSubmissions200ResponseData;
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
  TeacherSubmissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherSubmissions200ResponseBuilder();
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

