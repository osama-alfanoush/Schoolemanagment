//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_show91200_response.g.dart';

/// GradebookShow91200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookShow91200Response implements Built<GradebookShow91200Response, GradebookShow91200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Gradebook get data;

  GradebookShow91200Response._();

  factory GradebookShow91200Response([void updates(GradebookShow91200ResponseBuilder b)]) = _$GradebookShow91200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookShow91200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookShow91200Response> get serializer => _$GradebookShow91200ResponseSerializer();
}

class _$GradebookShow91200ResponseSerializer implements PrimitiveSerializer<GradebookShow91200Response> {
  @override
  final Iterable<Type> types = const [GradebookShow91200Response, _$GradebookShow91200Response];

  @override
  final String wireName = r'GradebookShow91200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookShow91200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Gradebook),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GradebookShow91200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookShow91200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Gradebook),
          ) as Gradebook;
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
  GradebookShow91200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookShow91200ResponseBuilder();
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

