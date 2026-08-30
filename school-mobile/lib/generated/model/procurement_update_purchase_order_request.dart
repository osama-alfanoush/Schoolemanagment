//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/procurement_update_purchase_order_request_items_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_update_purchase_order_request.g.dart';

/// ProcurementUpdatePurchaseOrderRequest
///
/// Properties:
/// * [expectedDate] 
/// * [tax] 
/// * [notes] 
/// * [items] 
@BuiltValue()
abstract class ProcurementUpdatePurchaseOrderRequest implements Built<ProcurementUpdatePurchaseOrderRequest, ProcurementUpdatePurchaseOrderRequestBuilder> {
  @BuiltValueField(wireName: r'expected_date')
  DateTime? get expectedDate;

  @BuiltValueField(wireName: r'tax')
  num? get tax;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'items')
  BuiltList<ProcurementUpdatePurchaseOrderRequestItemsInner>? get items;

  ProcurementUpdatePurchaseOrderRequest._();

  factory ProcurementUpdatePurchaseOrderRequest([void updates(ProcurementUpdatePurchaseOrderRequestBuilder b)]) = _$ProcurementUpdatePurchaseOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementUpdatePurchaseOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementUpdatePurchaseOrderRequest> get serializer => _$ProcurementUpdatePurchaseOrderRequestSerializer();
}

class _$ProcurementUpdatePurchaseOrderRequestSerializer implements PrimitiveSerializer<ProcurementUpdatePurchaseOrderRequest> {
  @override
  final Iterable<Type> types = const [ProcurementUpdatePurchaseOrderRequest, _$ProcurementUpdatePurchaseOrderRequest];

  @override
  final String wireName = r'ProcurementUpdatePurchaseOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementUpdatePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(num),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.items != null) {
      yield r'items';
      yield serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, [FullType(ProcurementUpdatePurchaseOrderRequestItemsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementUpdatePurchaseOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementUpdatePurchaseOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(num),
          ) as num;
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
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProcurementUpdatePurchaseOrderRequestItemsInner)]),
          ) as BuiltList<ProcurementUpdatePurchaseOrderRequestItemsInner>;
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
  ProcurementUpdatePurchaseOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementUpdatePurchaseOrderRequestBuilder();
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

