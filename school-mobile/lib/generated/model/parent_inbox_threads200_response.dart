//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_threads200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_threads200_response.g.dart';

/// ParentInboxThreads200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxThreads200Response implements Built<ParentInboxThreads200Response, ParentInboxThreads200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxThreads200ResponseData get data;

  ParentInboxThreads200Response._();

  factory ParentInboxThreads200Response([void updates(ParentInboxThreads200ResponseBuilder b)]) = _$ParentInboxThreads200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxThreads200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxThreads200Response> get serializer => _$ParentInboxThreads200ResponseSerializer();
}

class _$ParentInboxThreads200ResponseSerializer implements PrimitiveSerializer<ParentInboxThreads200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxThreads200Response, _$ParentInboxThreads200Response];

  @override
  final String wireName = r'ParentInboxThreads200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxThreads200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxThreads200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxThreads200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxThreads200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxThreads200ResponseData),
          ) as ParentInboxThreads200ResponseData;
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
  ParentInboxThreads200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxThreads200ResponseBuilder();
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

