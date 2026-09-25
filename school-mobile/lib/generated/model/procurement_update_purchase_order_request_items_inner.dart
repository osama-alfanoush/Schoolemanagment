//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_update_purchase_order_request_items_inner.g.dart';

/// ProcurementUpdatePurchaseOrderRequestItemsInner
///
/// Properties:
/// * [warehouseItemId] 
/// * [description] 
/// * [quantityOrdered] 
/// * [unit] 
/// * [unitCost] 
/// * [warehouseLocation] 
@BuiltValue()
abstract class ProcurementUpdatePurchaseOrderRequestItemsInner implements Built<ProcurementUpdatePurchaseOrderRequestItemsInner, ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder> {
  @BuiltValueField(wireName: r'warehouse_item_id')
  int? get warehouseItemId;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'quantity_ordered')
  num? get quantityOrdered;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  @BuiltValueField(wireName: r'unit_cost')
  num? get unitCost;

  @BuiltValueField(wireName: r'warehouse_location')
  String? get warehouseLocation;

  ProcurementUpdatePurchaseOrderRequestItemsInner._();

  factory ProcurementUpdatePurchaseOrderRequestItemsInner([void updates(ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder b)]) = _$ProcurementUpdatePurchaseOrderRequestItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementUpdatePurchaseOrderRequestItemsInner> get serializer => _$ProcurementUpdatePurchaseOrderRequestItemsInnerSerializer();
}

class _$ProcurementUpdatePurchaseOrderRequestItemsInnerSerializer implements PrimitiveSerializer<ProcurementUpdatePurchaseOrderRequestItemsInner> {
  @override
  final Iterable<Type> types = const [ProcurementUpdatePurchaseOrderRequestItemsInner, _$ProcurementUpdatePurchaseOrderRequestItemsInner];

  @override
  final String wireName = r'ProcurementUpdatePurchaseOrderRequestItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementUpdatePurchaseOrderRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.warehouseItemId != null) {
      yield r'warehouse_item_id';
      yield serializers.serialize(
        object.warehouseItemId,
        specifiedType: const FullType(int),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.quantityOrdered != null) {
      yield r'quantity_ordered';
      yield serializers.serialize(
        object.quantityOrdered,
        specifiedType: const FullType(num),
      );
    }
    if (object.unit != null) {
      yield r'unit';
      yield serializers.serialize(
        object.unit,
        specifiedType: const FullType(String),
      );
    }
    if (object.unitCost != null) {
      yield r'unit_cost';
      yield serializers.serialize(
        object.unitCost,
        specifiedType: const FullType(num),
      );
    }
    if (object.warehouseLocation != null) {
      yield r'warehouse_location';
      yield serializers.serialize(
        object.warehouseLocation,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementUpdatePurchaseOrderRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'warehouse_item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.warehouseItemId = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'quantity_ordered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.quantityOrdered = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'unit_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.unitCost = valueDes;
          break;
        case r'warehouse_location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.warehouseLocation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementUpdatePurchaseOrderRequestItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder();
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

