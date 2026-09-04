//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/gradebook.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gradebook_show88200_response.g.dart';

/// GradebookShow88200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class GradebookShow88200Response implements Built<GradebookShow88200Response, GradebookShow88200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Gradebook get data;

  GradebookShow88200Response._();

  factory GradebookShow88200Response([void updates(GradebookShow88200ResponseBuilder b)]) = _$GradebookShow88200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradebookShow88200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GradebookShow88200Response> get serializer => _$GradebookShow88200ResponseSerializer();
}

class _$GradebookShow88200ResponseSerializer implements PrimitiveSerializer<GradebookShow88200Response> {
  @override
  final Iterable<Type> types = const [GradebookShow88200Response, _$GradebookShow88200Response];

  @override
  final String wireName = r'GradebookShow88200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GradebookShow88200Response object, {
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
    GradebookShow88200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradebookShow88200ResponseBuilder result,
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
  GradebookShow88200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradebookShow88200ResponseBuilder();
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

