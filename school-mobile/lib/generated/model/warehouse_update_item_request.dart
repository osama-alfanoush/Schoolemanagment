//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_update_item_request.g.dart';

/// WarehouseUpdateItemRequest
///
/// Properties:
/// * [name] 
/// * [categoryId] 
/// * [unit] 
/// * [minStockQty] 
/// * [location] 
/// * [description] 
/// * [sku] 
/// * [isActive] 
@BuiltValue()
abstract class WarehouseUpdateItemRequest implements Built<WarehouseUpdateItemRequest, WarehouseUpdateItemRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'category_id')
  int? get categoryId;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  @BuiltValueField(wireName: r'min_stock_qty')
  num? get minStockQty;

  @BuiltValueField(wireName: r'location')
  String? get location;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'sku')
  String? get sku;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  WarehouseUpdateItemRequest._();

  factory WarehouseUpdateItemRequest([void updates(WarehouseUpdateItemRequestBuilder b)]) = _$WarehouseUpdateItemRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseUpdateItemRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseUpdateItemRequest> get serializer => _$WarehouseUpdateItemRequestSerializer();
}

class _$WarehouseUpdateItemRequestSerializer implements PrimitiveSerializer<WarehouseUpdateItemRequest> {
  @override
  final Iterable<Type> types = const [WarehouseUpdateItemRequest, _$WarehouseUpdateItemRequest];

  @override
  final String wireName = r'WarehouseUpdateItemRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseUpdateItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.categoryId != null) {
      yield r'category_id';
      yield serializers.serialize(
        object.categoryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.unit != null) {
      yield r'unit';
      yield serializers.serialize(
        object.unit,
        specifiedType: const FullType(String),
      );
    }
    if (object.minStockQty != null) {
      yield r'min_stock_qty';
      yield serializers.serialize(
        object.minStockQty,
        specifiedType: const FullType(num),
      );
    }
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sku != null) {
      yield r'sku';
      yield serializers.serialize(
        object.sku,
        specifiedType: const FullType(String),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseUpdateItemRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseUpdateItemRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'category_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.categoryId = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unit = valueDes;
          break;
        case r'min_stock_qty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minStockQty = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.location = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'sku':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sku = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseUpdateItemRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseUpdateItemRequestBuilder();
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

