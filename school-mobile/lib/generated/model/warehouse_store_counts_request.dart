//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/warehouse_store_counts_request_items_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_counts_request.g.dart';

/// WarehouseStoreCountsRequest
///
/// Properties:
/// * [countType] 
/// * [countDate] 
/// * [items] 
@BuiltValue()
abstract class WarehouseStoreCountsRequest implements Built<WarehouseStoreCountsRequest, WarehouseStoreCountsRequestBuilder> {
  @BuiltValueField(wireName: r'count_type')
  WarehouseStoreCountsRequestCountTypeEnum get countType;
  // enum countTypeEnum {  monthly,  annual,  spot,  };

  @BuiltValueField(wireName: r'count_date')
  DateTime get countDate;

  @BuiltValueField(wireName: r'items')
  BuiltList<WarehouseStoreCountsRequestItemsInner> get items;

  WarehouseStoreCountsRequest._();

  factory WarehouseStoreCountsRequest([void updates(WarehouseStoreCountsRequestBuilder b)]) = _$WarehouseStoreCountsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreCountsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreCountsRequest> get serializer => _$WarehouseStoreCountsRequestSerializer();
}

class _$WarehouseStoreCountsRequestSerializer implements PrimitiveSerializer<WarehouseStoreCountsRequest> {
  @override
  final Iterable<Type> types = const [WarehouseStoreCountsRequest, _$WarehouseStoreCountsRequest];

  @override
  final String wireName = r'WarehouseStoreCountsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreCountsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'count_type';
    yield serializers.serialize(
      object.countType,
      specifiedType: const FullType(WarehouseStoreCountsRequestCountTypeEnum),
    );
    yield r'count_date';
    yield serializers.serialize(
      object.countDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(WarehouseStoreCountsRequestItemsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreCountsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreCountsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'count_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WarehouseStoreCountsRequestCountTypeEnum),
          ) as WarehouseStoreCountsRequestCountTypeEnum;
          result.countType = valueDes;
          break;
        case r'count_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.countDate = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WarehouseStoreCountsRequestItemsInner)]),
          ) as BuiltList<WarehouseStoreCountsRequestItemsInner>;
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
  WarehouseStoreCountsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreCountsRequestBuilder();
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

class WarehouseStoreCountsRequestCountTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const WarehouseStoreCountsRequestCountTypeEnum monthly = _$warehouseStoreCountsRequestCountTypeEnum_monthly;
  @BuiltValueEnumConst(wireName: r'annual')
  static const WarehouseStoreCountsRequestCountTypeEnum annual = _$warehouseStoreCountsRequestCountTypeEnum_annual;
  @BuiltValueEnumConst(wireName: r'spot')
  static const WarehouseStoreCountsRequestCountTypeEnum spot = _$warehouseStoreCountsRequestCountTypeEnum_spot;

  static Serializer<WarehouseStoreCountsRequestCountTypeEnum> get serializer => _$warehouseStoreCountsRequestCountTypeEnumSerializer;

  const WarehouseStoreCountsRequestCountTypeEnum._(String name): super(name);

  static BuiltSet<WarehouseStoreCountsRequestCountTypeEnum> get values => _$warehouseStoreCountsRequestCountTypeEnumValues;
  static WarehouseStoreCountsRequestCountTypeEnum valueOf(String name) => _$warehouseStoreCountsRequestCountTypeEnumValueOf(name);
}

