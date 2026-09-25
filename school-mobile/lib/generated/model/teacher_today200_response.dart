//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_today200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_today200_response.g.dart';

/// TeacherToday200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherToday200Response implements Built<TeacherToday200Response, TeacherToday200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherToday200ResponseData get data;

  TeacherToday200Response._();

  factory TeacherToday200Response([void updates(TeacherToday200ResponseBuilder b)]) = _$TeacherToday200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherToday200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherToday200Response> get serializer => _$TeacherToday200ResponseSerializer();
}

class _$TeacherToday200ResponseSerializer implements PrimitiveSerializer<TeacherToday200Response> {
  @override
  final Iterable<Type> types = const [TeacherToday200Response, _$TeacherToday200Response];

  @override
  final String wireName = r'TeacherToday200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherToday200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherToday200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherToday200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherToday200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherToday200ResponseData),
          ) as TeacherToday200ResponseData;
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
  TeacherToday200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherToday200ResponseBuilder();
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

