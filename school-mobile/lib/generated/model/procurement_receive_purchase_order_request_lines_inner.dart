//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_receive_purchase_order_request_lines_inner.g.dart';

/// ProcurementReceivePurchaseOrderRequestLinesInner
///
/// Properties:
/// * [purchaseOrderItemId] 
/// * [quantityReceived] 
/// * [unitCost] 
/// * [warehouseLocation] 
@BuiltValue()
abstract class ProcurementReceivePurchaseOrderRequestLinesInner implements Built<ProcurementReceivePurchaseOrderRequestLinesInner, ProcurementReceivePurchaseOrderRequestLinesInnerBuilder> {
  @BuiltValueField(wireName: r'purchase_order_item_id')
  int get purchaseOrderItemId;

  @BuiltValueField(wireName: r'quantity_received')
  num get quantityReceived;

  @BuiltValueField(wireName: r'unit_cost')
  num? get unitCost;

  @BuiltValueField(wireName: r'warehouse_location')
  String? get warehouseLocation;

  ProcurementReceivePurchaseOrderRequestLinesInner._();

  factory ProcurementReceivePurchaseOrderRequestLinesInner([void updates(ProcurementReceivePurchaseOrderRequestLinesInnerBuilder b)]) = _$ProcurementReceivePurchaseOrderRequestLinesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementReceivePurchaseOrderRequestLinesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementReceivePurchaseOrderRequestLinesInner> get serializer => _$ProcurementReceivePurchaseOrderRequestLinesInnerSerializer();
}

class _$ProcurementReceivePurchaseOrderRequestLinesInnerSerializer implements PrimitiveSerializer<ProcurementReceivePurchaseOrderRequestLinesInner> {
  @override
  final Iterable<Type> types = const [ProcurementReceivePurchaseOrderRequestLinesInner, _$ProcurementReceivePurchaseOrderRequestLinesInner];

  @override
  final String wireName = r'ProcurementReceivePurchaseOrderRequestLinesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementReceivePurchaseOrderRequestLinesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'purchase_order_item_id';
    yield serializers.serialize(
      object.purchaseOrderItemId,
      specifiedType: const FullType(int),
    );
    yield r'quantity_received';
    yield serializers.serialize(
      object.quantityReceived,
      specifiedType: const FullType(num),
    );
    if (object.unitCost != null) {
      yield r'unit_cost';
      yield serializers.serialize(
        object.unitCost,
        specifiedType: const FullType.nullable(num),
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
    ProcurementReceivePurchaseOrderRequestLinesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementReceivePurchaseOrderRequestLinesInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'purchase_order_item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.purchaseOrderItemId = valueDes;
          break;
        case r'quantity_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.quantityReceived = valueDes;
          break;
        case r'unit_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
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
  ProcurementReceivePurchaseOrderRequestLinesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementReceivePurchaseOrderRequestLinesInnerBuilder();
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

