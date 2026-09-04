//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_academics_grades200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_grades200_response.g.dart';

/// ParentAcademicsGrades200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentAcademicsGrades200Response implements Built<ParentAcademicsGrades200Response, ParentAcademicsGrades200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentAcademicsGrades200ResponseData get data;

  ParentAcademicsGrades200Response._();

  factory ParentAcademicsGrades200Response([void updates(ParentAcademicsGrades200ResponseBuilder b)]) = _$ParentAcademicsGrades200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsGrades200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsGrades200Response> get serializer => _$ParentAcademicsGrades200ResponseSerializer();
}

class _$ParentAcademicsGrades200ResponseSerializer implements PrimitiveSerializer<ParentAcademicsGrades200Response> {
  @override
  final Iterable<Type> types = const [ParentAcademicsGrades200Response, _$ParentAcademicsGrades200Response];

  @override
  final String wireName = r'ParentAcademicsGrades200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentAcademicsGrades200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsGrades200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentAcademicsGrades200ResponseData),
          ) as ParentAcademicsGrades200ResponseData;
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
  ParentAcademicsGrades200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsGrades200ResponseBuilder();
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

