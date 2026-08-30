//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_inventory_report200_response_data_inner.g.dart';

/// WarehouseInventoryReport200ResponseDataInner
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [sku] 
/// * [category] 
/// * [unit] 
/// * [currentQty] 
/// * [minStockQty] 
/// * [isLowStock] 
@BuiltValue()
abstract class WarehouseInventoryReport200ResponseDataInner implements Built<WarehouseInventoryReport200ResponseDataInner, WarehouseInventoryReport200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'sku')
  String get sku;

  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'unit')
  String get unit;

  @BuiltValueField(wireName: r'current_qty')
  num get currentQty;

  @BuiltValueField(wireName: r'min_stock_qty')
  num get minStockQty;

  @BuiltValueField(wireName: r'is_low_stock')
  String get isLowStock;

  WarehouseInventoryReport200ResponseDataInner._();

  factory WarehouseInventoryReport200ResponseDataInner([void updates(WarehouseInventoryReport200ResponseDataInnerBuilder b)]) = _$WarehouseInventoryReport200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseInventoryReport200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseInventoryReport200ResponseDataInner> get serializer => _$WarehouseInventoryReport200ResponseDataInnerSerializer();
}

class _$WarehouseInventoryReport200ResponseDataInnerSerializer implements PrimitiveSerializer<WarehouseInventoryReport200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [WarehouseInventoryReport200ResponseDataInner, _$WarehouseInventoryReport200ResponseDataInner];

  @override
  final String wireName = r'WarehouseInventoryReport200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseInventoryReport200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'sku';
    yield serializers.serialize(
      object.sku,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'unit';
    yield serializers.serialize(
      object.unit,
      specifiedType: const FullType(String),
    );
    yield r'current_qty';
    yield serializers.serialize(
      object.currentQty,
      specifiedType: const FullType(num),
    );
    yield r'min_stock_qty';
    yield serializers.serialize(
      object.minStockQty,
      specifiedType: const FullType(num),
    );
    yield r'is_low_stock';
    yield serializers.serialize(
      object.isLowStock,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseInventoryReport200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseInventoryReport200ResponseDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'sku':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sku = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'current_qty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.currentQty = valueDes;
          break;
        case r'min_stock_qty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minStockQty = valueDes;
          break;
        case r'is_low_stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.isLowStock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseInventoryReport200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseInventoryReport200ResponseDataInnerBuilder();
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

