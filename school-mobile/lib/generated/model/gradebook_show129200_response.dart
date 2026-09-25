//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_show129200_response.g.dart';

/// GradebookShow129200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookShow129200Response implements Built<GradebookShow129200Response, GradebookShow129200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Gradebook get data;

  GradebookShow129200Response._();

  factory GradebookShow129200Response([void updates(GradebookShow129200ResponseBuilder b)]) = _$GradebookShow129200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookShow129200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookShow129200Response> get serializer => _$GradebookShow129200ResponseSerializer();
}

class _$GradebookShow129200ResponseSerializer implements PrimitiveSerializer<GradebookShow129200Response> {
  @override
  final Iterable<Type> types = const [GradebookShow129200Response, _$GradebookShow129200Response];

  @override
  final String wireName = r'GradebookShow129200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookShow129200Response object, {
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
    GradebookShow129200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookShow129200ResponseBuilder result,
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
  GradebookShow129200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookShow129200ResponseBuilder();
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

