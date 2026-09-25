//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/warehouse_dashboard200_response_movements_this_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/warehouse_dashboard200_response_top_consumed_items_inner.dart';
import 'package:school_mobile/generated/model/warehouse_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_dashboard200_response.g.dart';

/// WarehouseDashboard200Response
///
/// Properties:
/// * [totalItems] 
/// * [lowStockItems] 
/// * [pendingPurchaseRequests] 
/// * [movementsThisMonth] 
/// * [topConsumedItems] 
@BuiltValue()
abstract class WarehouseDashboard200Response implements Built<WarehouseDashboard200Response, WarehouseDashboard200ResponseBuilder> {
  @BuiltValueField(wireName: r'total_items')
  int get totalItems;

  @BuiltValueField(wireName: r'low_stock_items')
  BuiltList<WarehouseItem> get lowStockItems;

  @BuiltValueField(wireName: r'pending_purchase_requests')
  int get pendingPurchaseRequests;

  @BuiltValueField(wireName: r'movements_this_month')
  WarehouseDashboard200ResponseMovementsThisMonth get movementsThisMonth;

  @BuiltValueField(wireName: r'top_consumed_items')
  BuiltList<WarehouseDashboard200ResponseTopConsumedItemsInner> get topConsumedItems;

  WarehouseDashboard200Response._();

  factory WarehouseDashboard200Response([void updates(WarehouseDashboard200ResponseBuilder b)]) = _$WarehouseDashboard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseDashboard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseDashboard200Response> get serializer => _$WarehouseDashboard200ResponseSerializer();
}

class _$WarehouseDashboard200ResponseSerializer implements PrimitiveSerializer<WarehouseDashboard200Response> {
  @override
  final Iterable<Type> types = const [WarehouseDashboard200Response, _$WarehouseDashboard200Response];

  @override
  final String wireName = r'WarehouseDashboard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_items';
    yield serializers.serialize(
      object.totalItems,
      specifiedType: const FullType(int),
    );
    yield r'low_stock_items';
    yield serializers.serialize(
      object.lowStockItems,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseItem)]),
    );
    yield r'pending_purchase_requests';
    yield serializers.serialize(
      object.pendingPurchaseRequests,
      specifiedType: const FullType(int),
    );
    yield r'movements_this_month';
    yield serializers.serialize(
      object.movementsThisMonth,
      specifiedType: const FullType(WarehouseDashboard200ResponseMovementsThisMonth),
    );
    yield r'top_consumed_items';
    yield serializers.serialize(
      object.topConsumedItems,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseDashboard200ResponseTopConsumedItemsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseDashboard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalItems = valueDes;
          break;
        case r'low_stock_items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseItem)]),
          ) as BuiltList<WarehouseItem>;
          result.lowStockItems.replace(valueDes);
          break;
        case r'pending_purchase_requests':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingPurchaseRequests = valueDes;
          break;
        case r'movements_this_month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WarehouseDashboard200ResponseMovementsThisMonth),
          ) as WarehouseDashboard200ResponseMovementsThisMonth;
          result.movementsThisMonth.replace(valueDes);
          break;
        case r'top_consumed_items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseDashboard200ResponseTopConsumedItemsInner)]),
          ) as BuiltList<WarehouseDashboard200ResponseTopConsumedItemsInner>;
          result.topConsumedItems.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseDashboard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseDashboard200ResponseBuilder();
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

