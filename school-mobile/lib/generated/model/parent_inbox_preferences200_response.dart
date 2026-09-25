//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_preferences200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_preferences200_response.g.dart';

/// ParentInboxPreferences200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxPreferences200Response implements Built<ParentInboxPreferences200Response, ParentInboxPreferences200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxPreferences200ResponseData get data;

  ParentInboxPreferences200Response._();

  factory ParentInboxPreferences200Response([void updates(ParentInboxPreferences200ResponseBuilder b)]) = _$ParentInboxPreferences200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxPreferences200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxPreferences200Response> get serializer => _$ParentInboxPreferences200ResponseSerializer();
}

class _$ParentInboxPreferences200ResponseSerializer implements PrimitiveSerializer<ParentInboxPreferences200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxPreferences200Response, _$ParentInboxPreferences200Response];

  @override
  final String wireName = r'ParentInboxPreferences200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxPreferences200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxPreferences200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxPreferences200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxPreferences200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxPreferences200ResponseData),
          ) as ParentInboxPreferences200ResponseData;
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
  ParentInboxPreferences200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxPreferences200ResponseBuilder();
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

