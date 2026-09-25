//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_child_assignments200_response_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_assignments200_response.g.dart';

/// ParentChildAssignments200Response
///
/// Properties:
/// * [data] 
/// * [meta] 
@BuiltValue()
abstract class ParentChildAssignments200Response implements Built<ParentChildAssignments200Response, ParentChildAssignments200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltMap<String, String> get data;

  @BuiltValueField(wireName: r'meta')
  ParentChildAssignments200ResponseMeta get meta;

  ParentChildAssignments200Response._();

  factory ParentChildAssignments200Response([void updates(ParentChildAssignments200ResponseBuilder b)]) = _$ParentChildAssignments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildAssignments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildAssignments200Response> get serializer => _$ParentChildAssignments200ResponseSerializer();
}

class _$ParentChildAssignments200ResponseSerializer implements PrimitiveSerializer<ParentChildAssignments200Response> {
  @override
  final Iterable<Type> types = const [ParentChildAssignments200Response, _$ParentChildAssignments200Response];

  @override
  final String wireName = r'ParentChildAssignments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(ParentChildAssignments200ResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildAssignments200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>;
          result.data.replace(valueDes);
          break;
        case r'meta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentChildAssignments200ResponseMeta),
          ) as ParentChildAssignments200ResponseMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildAssignments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildAssignments200ResponseBuilder();
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

