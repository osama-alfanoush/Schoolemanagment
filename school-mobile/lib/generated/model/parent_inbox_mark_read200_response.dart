//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_mark_read200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_mark_read200_response.g.dart';

/// ParentInboxMarkRead200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxMarkRead200Response implements Built<ParentInboxMarkRead200Response, ParentInboxMarkRead200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxMarkRead200ResponseData get data;

  ParentInboxMarkRead200Response._();

  factory ParentInboxMarkRead200Response([void updates(ParentInboxMarkRead200ResponseBuilder b)]) = _$ParentInboxMarkRead200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxMarkRead200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxMarkRead200Response> get serializer => _$ParentInboxMarkRead200ResponseSerializer();
}

class _$ParentInboxMarkRead200ResponseSerializer implements PrimitiveSerializer<ParentInboxMarkRead200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxMarkRead200Response, _$ParentInboxMarkRead200Response];

  @override
  final String wireName = r'ParentInboxMarkRead200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxMarkRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxMarkRead200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxMarkRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxMarkRead200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxMarkRead200ResponseData),
          ) as ParentInboxMarkRead200ResponseData;
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
  ParentInboxMarkRead200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxMarkRead200ResponseBuilder();
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

