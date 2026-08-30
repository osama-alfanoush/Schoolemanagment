//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/warehouse_inventory_report200_response_data_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_inventory_report200_response.g.dart';

/// WarehouseInventoryReport200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class WarehouseInventoryReport200Response implements Built<WarehouseInventoryReport200Response, WarehouseInventoryReport200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<WarehouseInventoryReport200ResponseDataInner> get data;

  WarehouseInventoryReport200Response._();

  factory WarehouseInventoryReport200Response([void updates(WarehouseInventoryReport200ResponseBuilder b)]) = _$WarehouseInventoryReport200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseInventoryReport200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseInventoryReport200Response> get serializer => _$WarehouseInventoryReport200ResponseSerializer();
}

class _$WarehouseInventoryReport200ResponseSerializer implements PrimitiveSerializer<WarehouseInventoryReport200Response> {
  @override
  final Iterable<Type> types = const [WarehouseInventoryReport200Response, _$WarehouseInventoryReport200Response];

  @override
  final String wireName = r'WarehouseInventoryReport200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseInventoryReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseInventoryReport200ResponseDataInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseInventoryReport200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseInventoryReport200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseInventoryReport200ResponseDataInner)]),
          ) as BuiltList<WarehouseInventoryReport200ResponseDataInner>;
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
  WarehouseInventoryReport200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseInventoryReport200ResponseBuilder();
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

