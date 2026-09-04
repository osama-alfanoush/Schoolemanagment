//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_home_child_overview200_response.g.dart';

/// ParentHomeChildOverview200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentHomeChildOverview200Response implements Built<ParentHomeChildOverview200Response, ParentHomeChildOverview200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  String? get data;

  ParentHomeChildOverview200Response._();

  factory ParentHomeChildOverview200Response([void updates(ParentHomeChildOverview200ResponseBuilder b)]) = _$ParentHomeChildOverview200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentHomeChildOverview200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentHomeChildOverview200Response> get serializer => _$ParentHomeChildOverview200ResponseSerializer();
}

class _$ParentHomeChildOverview200ResponseSerializer implements PrimitiveSerializer<ParentHomeChildOverview200Response> {
  @override
  final Iterable<Type> types = const [ParentHomeChildOverview200Response, _$ParentHomeChildOverview200Response];

  @override
  final String wireName = r'ParentHomeChildOverview200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentHomeChildOverview200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentHomeChildOverview200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentHomeChildOverview200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.data = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentHomeChildOverview200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentHomeChildOverview200ResponseBuilder();
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

