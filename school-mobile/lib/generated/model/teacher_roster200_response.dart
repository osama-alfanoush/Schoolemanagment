//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_roster200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_roster200_response.g.dart';

/// TeacherRoster200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherRoster200Response implements Built<TeacherRoster200Response, TeacherRoster200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherRoster200ResponseData get data;

  TeacherRoster200Response._();

  factory TeacherRoster200Response([void updates(TeacherRoster200ResponseBuilder b)]) = _$TeacherRoster200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherRoster200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherRoster200Response> get serializer => _$TeacherRoster200ResponseSerializer();
}

class _$TeacherRoster200ResponseSerializer implements PrimitiveSerializer<TeacherRoster200Response> {
  @override
  final Iterable<Type> types = const [TeacherRoster200Response, _$TeacherRoster200Response];

  @override
  final String wireName = r'TeacherRoster200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherRoster200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherRoster200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherRoster200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherRoster200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherRoster200ResponseData),
          ) as TeacherRoster200ResponseData;
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
  TeacherRoster200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherRoster200ResponseBuilder();
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

