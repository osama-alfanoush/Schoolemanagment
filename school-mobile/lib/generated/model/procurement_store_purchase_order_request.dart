//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/procurement_store_purchase_order_request_items_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_store_purchase_order_request.g.dart';

/// ProcurementStorePurchaseOrderRequest
///
/// Properties:
/// * [supplierId] 
/// * [orderDate] 
/// * [expectedDate] 
/// * [tax] 
/// * [notes] 
/// * [purchaseRequestId] 
/// * [items] 
@BuiltValue()
abstract class ProcurementStorePurchaseOrderRequest implements Built<ProcurementStorePurchaseOrderRequest, ProcurementStorePurchaseOrderRequestBuilder> {
  @BuiltValueField(wireName: r'supplier_id')
  int get supplierId;

  @BuiltValueField(wireName: r'order_date')
  DateTime get orderDate;

  @BuiltValueField(wireName: r'expected_date')
  DateTime? get expectedDate;

  @BuiltValueField(wireName: r'tax')
  num? get tax;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'purchase_request_id')
  int? get purchaseRequestId;

  @BuiltValueField(wireName: r'items')
  BuiltList<ProcurementStorePurchaseOrderRequestItemsInner> get items;

  ProcurementStorePurchaseOrderRequest._();

  factory ProcurementStorePurchaseOrderRequest([void updates(ProcurementStorePurchaseOrderRequestBuilder b)]) = _$ProcurementStorePurchaseOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementStorePurchaseOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementStorePurchaseOrderRequest> get serializer => _$ProcurementStorePurchaseOrderRequestSerializer();
}

class _$ProcurementStorePurchaseOrderRequestSerializer implements PrimitiveSerializer<ProcurementStorePurchaseOrderRequest> {
  @override
  final Iterable<Type> types = const [ProcurementStorePurchaseOrderRequest, _$ProcurementStorePurchaseOrderRequest];

  @override
  final String wireName = r'ProcurementStorePurchaseOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementStorePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'supplier_id';
    yield serializers.serialize(
      object.supplierId,
      specifiedType: const FullType(int),
    );
    yield r'order_date';
    yield serializers.serialize(
      object.orderDate,
      specifiedType: const FullType(DateTime),
    );
    if (object.expectedDate != null) {
      yield r'expected_date';
      yield serializers.serialize(
        object.expectedDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.tax != null) {
      yield r'tax';
      yield serializers.serialize(
        object.tax,
        specifiedType: const FullType.nullable(num),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.purchaseRequestId != null) {
      yield r'purchase_request_id';
      yield serializers.serialize(
        object.purchaseRequestId,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(ProcurementStorePurchaseOrderRequestItemsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementStorePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementStorePurchaseOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'supplier_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.supplierId = valueDes;
          break;
        case r'order_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.orderDate = valueDes;
          break;
        case r'expected_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expectedDate = valueDes;
          break;
        case r'tax':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.tax = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'purchase_request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.purchaseRequestId = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProcurementStorePurchaseOrderRequestItemsInner)]),
          ) as BuiltList<ProcurementStorePurchaseOrderRequestItemsInner>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementStorePurchaseOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementStorePurchaseOrderRequestBuilder();
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

