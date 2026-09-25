//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/warehouse_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_index_categories200_response.g.dart';

/// WarehouseIndexCategories200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseIndexCategories200Response implements Built<WarehouseIndexCategories200Response, WarehouseIndexCategories200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<WarehouseCategory> get data;

  WarehouseIndexCategories200Response._();

  factory WarehouseIndexCategories200Response([void updates(WarehouseIndexCategories200ResponseBuilder b)]) = _$WarehouseIndexCategories200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseIndexCategories200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseIndexCategories200Response> get serializer => _$WarehouseIndexCategories200ResponseSerializer();
}

class _$WarehouseIndexCategories200ResponseSerializer implements PrimitiveSerializer<WarehouseIndexCategories200Response> {
  @override
  final Iterable<Type> types = const [WarehouseIndexCategories200Response, _$WarehouseIndexCategories200Response];

  @override
  final String wireName = r'WarehouseIndexCategories200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseIndexCategories200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseCategory)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseIndexCategories200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseIndexCategories200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseCategory)]),
          ) as BuiltList<WarehouseCategory>;
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
  WarehouseIndexCategories200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseIndexCategories200ResponseBuilder();
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

