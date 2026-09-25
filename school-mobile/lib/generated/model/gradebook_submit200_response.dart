//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_submit200_response.g.dart';

/// GradebookSubmit200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookSubmit200Response implements Built<GradebookSubmit200Response, GradebookSubmit200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  String get data;

  GradebookSubmit200Response._();

  factory GradebookSubmit200Response([void updates(GradebookSubmit200ResponseBuilder b)]) = _$GradebookSubmit200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookSubmit200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookSubmit200Response> get serializer => _$GradebookSubmit200ResponseSerializer();
}

class _$GradebookSubmit200ResponseSerializer implements PrimitiveSerializer<GradebookSubmit200Response> {
  @override
  final Iterable<Type> types = const [GradebookSubmit200Response, _$GradebookSubmit200Response];

  @override
  final String wireName = r'GradebookSubmit200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookSubmit200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GradebookSubmit200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookSubmit200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  GradebookSubmit200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookSubmit200ResponseBuilder();
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

