//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_show86200_response.g.dart';

/// GradebookShow86200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookShow86200Response implements Built<GradebookShow86200Response, GradebookShow86200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Gradebook get data;

  GradebookShow86200Response._();

  factory GradebookShow86200Response([void updates(GradebookShow86200ResponseBuilder b)]) = _$GradebookShow86200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookShow86200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookShow86200Response> get serializer => _$GradebookShow86200ResponseSerializer();
}

class _$GradebookShow86200ResponseSerializer implements PrimitiveSerializer<GradebookShow86200Response> {
  @override
  final Iterable<Type> types = const [GradebookShow86200Response, _$GradebookShow86200Response];

  @override
  final String wireName = r'GradebookShow86200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookShow86200Response object, {
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
    GradebookShow86200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookShow86200ResponseBuilder result,
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
  GradebookShow86200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookShow86200ResponseBuilder();
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

