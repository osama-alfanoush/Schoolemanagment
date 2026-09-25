//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/delta_page_resource.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_delta200_response.g.dart';

/// SyncDelta200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class SyncDelta200Response implements Built<SyncDelta200Response, SyncDelta200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  DeltaPageResource get data;

  SyncDelta200Response._();

  factory SyncDelta200Response([void updates(SyncDelta200ResponseBuilder b)]) = _$SyncDelta200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncDelta200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncDelta200Response> get serializer => _$SyncDelta200ResponseSerializer();
}

class _$SyncDelta200ResponseSerializer implements PrimitiveSerializer<SyncDelta200Response> {
  @override
  final Iterable<Type> types = const [SyncDelta200Response, _$SyncDelta200Response];

  @override
  final String wireName = r'SyncDelta200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncDelta200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(DeltaPageResource),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncDelta200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncDelta200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeltaPageResource),
          ) as DeltaPageResource;
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
  SyncDelta200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncDelta200ResponseBuilder();
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

