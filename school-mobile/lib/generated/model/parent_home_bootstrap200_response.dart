//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_home_bootstrap200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_bootstrap200_response.g.dart';

/// ParentHomeBootstrap200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentHomeBootstrap200Response implements Built<ParentHomeBootstrap200Response, ParentHomeBootstrap200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentHomeBootstrap200ResponseData get data;

  ParentHomeBootstrap200Response._();

  factory ParentHomeBootstrap200Response([void updates(ParentHomeBootstrap200ResponseBuilder b)]) = _$ParentHomeBootstrap200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeBootstrap200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeBootstrap200Response> get serializer => _$ParentHomeBootstrap200ResponseSerializer();
}

class _$ParentHomeBootstrap200ResponseSerializer implements PrimitiveSerializer<ParentHomeBootstrap200Response> {
  @override
  final Iterable<Type> types = const [ParentHomeBootstrap200Response, _$ParentHomeBootstrap200Response];

  @override
  final String wireName = r'ParentHomeBootstrap200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeBootstrap200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentHomeBootstrap200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeBootstrap200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeBootstrap200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentHomeBootstrap200ResponseData),
          ) as ParentHomeBootstrap200ResponseData;
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
  ParentHomeBootstrap200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeBootstrap200ResponseBuilder();
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

