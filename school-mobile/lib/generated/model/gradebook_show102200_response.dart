//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_show102200_response.g.dart';

/// GradebookShow102200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookShow102200Response implements Built<GradebookShow102200Response, GradebookShow102200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Gradebook get data;

  GradebookShow102200Response._();

  factory GradebookShow102200Response([void updates(GradebookShow102200ResponseBuilder b)]) = _$GradebookShow102200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookShow102200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookShow102200Response> get serializer => _$GradebookShow102200ResponseSerializer();
}

class _$GradebookShow102200ResponseSerializer implements PrimitiveSerializer<GradebookShow102200Response> {
  @override
  final Iterable<Type> types = const [GradebookShow102200Response, _$GradebookShow102200Response];

  @override
  final String wireName = r'GradebookShow102200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookShow102200Response object, {
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
    GradebookShow102200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookShow102200ResponseBuilder result,
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
  GradebookShow102200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookShow102200ResponseBuilder();
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

