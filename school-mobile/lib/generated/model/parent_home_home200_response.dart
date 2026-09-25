//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_home_home200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_home200_response.g.dart';

/// ParentHomeHome200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentHomeHome200Response implements Built<ParentHomeHome200Response, ParentHomeHome200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentHomeHome200ResponseData get data;

  ParentHomeHome200Response._();

  factory ParentHomeHome200Response([void updates(ParentHomeHome200ResponseBuilder b)]) = _$ParentHomeHome200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeHome200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeHome200Response> get serializer => _$ParentHomeHome200ResponseSerializer();
}

class _$ParentHomeHome200ResponseSerializer implements PrimitiveSerializer<ParentHomeHome200Response> {
  @override
  final Iterable<Type> types = const [ParentHomeHome200Response, _$ParentHomeHome200Response];

  @override
  final String wireName = r'ParentHomeHome200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeHome200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentHomeHome200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeHome200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeHome200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeHome200ResponseData),
          ) as ParentHomeHome200ResponseData;
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
  ParentHomeHome200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeHome200ResponseBuilder();
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

