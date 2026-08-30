//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_purchase_request_request.g.dart';

/// WarehouseStorePurchaseRequestRequest
///
/// Properties:
/// * [itemId] 
/// * [quantityRequested] 
/// * [unit] 
/// * [justification] 
/// * [estimatedCost] 
@BuiltValue()
abstract class WarehouseStorePurchaseRequestRequest implements Built<WarehouseStorePurchaseRequestRequest, WarehouseStorePurchaseRequestRequestBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'quantity_requested')
  num get quantityRequested;

  @BuiltValueField(wireName: r'unit')
  String get unit;

  @BuiltValueField(wireName: r'justification')
  String? get justification;

  @BuiltValueField(wireName: r'estimated_cost')
  num? get estimatedCost;

  WarehouseStorePurchaseRequestRequest._();

  factory WarehouseStorePurchaseRequestRequest([void updates(WarehouseStorePurchaseRequestRequestBuilder b)]) = _$WarehouseStorePurchaseRequestRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStorePurchaseRequestRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStorePurchaseRequestRequest> get serializer => _$WarehouseStorePurchaseRequestRequestSerializer();
}

class _$WarehouseStorePurchaseRequestRequestSerializer implements PrimitiveSerializer<WarehouseStorePurchaseRequestRequest> {
  @override
  final Iterable<Type> types = const [WarehouseStorePurchaseRequestRequest, _$WarehouseStorePurchaseRequestRequest];

  @override
  final String wireName = r'WarehouseStorePurchaseRequestRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStorePurchaseRequestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'quantity_requested';
    yield serializers.serialize(
      object.quantityRequested,
      specifiedType: const FullType(num),
    );
    yield r'unit';
    yield serializers.serialize(
      object.unit,
      specifiedType: const FullType(String),
    );
    if (object.justification != null) {
      yield r'justification';
      yield serializers.serialize(
        object.justification,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estimatedCost != null) {
      yield r'estimated_cost';
      yield serializers.serialize(
        object.estimatedCost,
        specifiedType: const FullType.nullable(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStorePurchaseRequestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStorePurchaseRequestRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemId = valueDes;
          break;
        case r'quantity_requested':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.quantityRequested = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'justification':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.justification = valueDes;
          break;
        case r'estimated_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.estimatedCost = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseStorePurchaseRequestRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStorePurchaseRequestRequestBuilder();
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

