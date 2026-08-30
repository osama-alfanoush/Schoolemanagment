//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_counts_request_items_inner.g.dart';

/// WarehouseStoreCountsRequestItemsInner
///
/// Properties:
/// * [itemId] 
/// * [physicalQty] 
/// * [notes] 
@BuiltValue()
abstract class WarehouseStoreCountsRequestItemsInner implements Built<WarehouseStoreCountsRequestItemsInner, WarehouseStoreCountsRequestItemsInnerBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'physical_qty')
  num get physicalQty;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  WarehouseStoreCountsRequestItemsInner._();

  factory WarehouseStoreCountsRequestItemsInner([void updates(WarehouseStoreCountsRequestItemsInnerBuilder b)]) = _$WarehouseStoreCountsRequestItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreCountsRequestItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreCountsRequestItemsInner> get serializer => _$WarehouseStoreCountsRequestItemsInnerSerializer();
}

class _$WarehouseStoreCountsRequestItemsInnerSerializer implements PrimitiveSerializer<WarehouseStoreCountsRequestItemsInner> {
  @override
  final Iterable<Type> types = const [WarehouseStoreCountsRequestItemsInner, _$WarehouseStoreCountsRequestItemsInner];

  @override
  final String wireName = r'WarehouseStoreCountsRequestItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreCountsRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'physical_qty';
    yield serializers.serialize(
      object.physicalQty,
      specifiedType: const FullType(num),
    );
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreCountsRequestItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreCountsRequestItemsInnerBuilder result,
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
        case r'physical_qty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.physicalQty = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseStoreCountsRequestItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreCountsRequestItemsInnerBuilder();
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

