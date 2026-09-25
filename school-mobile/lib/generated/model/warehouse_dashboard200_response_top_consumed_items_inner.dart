//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_dashboard200_response_top_consumed_items_inner.g.dart';

/// WarehouseDashboard200ResponseTopConsumedItemsInner
///
/// Properties:
/// * [itemName] 
/// * [sku] 
/// * [totalOut] 
/// * [unit] 
@BuiltValue()
abstract class WarehouseDashboard200ResponseTopConsumedItemsInner implements Built<WarehouseDashboard200ResponseTopConsumedItemsInner, WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder> {
  @BuiltValueField(wireName: r'item_name')
  String? get itemName;

  @BuiltValueField(wireName: r'sku')
  String? get sku;

  @BuiltValueField(wireName: r'total_out')
  num get totalOut;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  WarehouseDashboard200ResponseTopConsumedItemsInner._();

  factory WarehouseDashboard200ResponseTopConsumedItemsInner([void updates(WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder b)]) = _$WarehouseDashboard200ResponseTopConsumedItemsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseDashboard200ResponseTopConsumedItemsInner> get serializer => _$WarehouseDashboard200ResponseTopConsumedItemsInnerSerializer();
}

class _$WarehouseDashboard200ResponseTopConsumedItemsInnerSerializer implements PrimitiveSerializer<WarehouseDashboard200ResponseTopConsumedItemsInner> {
  @override
  final Iterable<Type> types = const [WarehouseDashboard200ResponseTopConsumedItemsInner, _$WarehouseDashboard200ResponseTopConsumedItemsInner];

  @override
  final String wireName = r'WarehouseDashboard200ResponseTopConsumedItemsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseDashboard200ResponseTopConsumedItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_name';
    yield object.itemName == null ? null : serializers.serialize(
      object.itemName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'sku';
    yield object.sku == null ? null : serializers.serialize(
      object.sku,
      specifiedType: const FullType.nullable(String),
    );
    yield r'total_out';
    yield serializers.serialize(
      object.totalOut,
      specifiedType: const FullType(num),
    );
    yield r'unit';
    yield object.unit == null ? null : serializers.serialize(
      object.unit,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseDashboard200ResponseTopConsumedItemsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.itemName = valueDes;
          break;
        case r'sku':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sku = valueDes;
          break;
        case r'total_out':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalOut = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseDashboard200ResponseTopConsumedItemsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder();
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

