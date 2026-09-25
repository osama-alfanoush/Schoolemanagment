//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_consumption_report200_response_data_inner.g.dart';

/// WarehouseConsumptionReport200ResponseDataInner
///
/// Properties:
/// * [itemName] 
/// * [sku] 
/// * [department] 
/// * [totalQuantity] 
/// * [unit] 
@BuiltValue()
abstract class WarehouseConsumptionReport200ResponseDataInner implements Built<WarehouseConsumptionReport200ResponseDataInner, WarehouseConsumptionReport200ResponseDataInnerBuilder> {
  @BuiltValueField(wireName: r'item_name')
  String get itemName;

  @BuiltValueField(wireName: r'sku')
  String get sku;

  @BuiltValueField(wireName: r'department')
  String? get department;

  @BuiltValueField(wireName: r'total_quantity')
  num get totalQuantity;

  @BuiltValueField(wireName: r'unit')
  String get unit;

  WarehouseConsumptionReport200ResponseDataInner._();

  factory WarehouseConsumptionReport200ResponseDataInner([void updates(WarehouseConsumptionReport200ResponseDataInnerBuilder b)]) = _$WarehouseConsumptionReport200ResponseDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseConsumptionReport200ResponseDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseConsumptionReport200ResponseDataInner> get serializer => _$WarehouseConsumptionReport200ResponseDataInnerSerializer();
}

class _$WarehouseConsumptionReport200ResponseDataInnerSerializer implements PrimitiveSerializer<WarehouseConsumptionReport200ResponseDataInner> {
  @override
  final Iterable<Type> types = const [WarehouseConsumptionReport200ResponseDataInner, _$WarehouseConsumptionReport200ResponseDataInner];

  @override
  final String wireName = r'WarehouseConsumptionReport200ResponseDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseConsumptionReport200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_name';
    yield serializers.serialize(
      object.itemName,
      specifiedType: const FullType(String),
    );
    yield r'sku';
    yield serializers.serialize(
      object.sku,
      specifiedType: const FullType(String),
    );
    yield r'department';
    yield object.department == null ? null : serializers.serialize(
      object.department,
      specifiedType: const FullType.nullable(String),
    );
    yield r'total_quantity';
    yield serializers.serialize(
      object.totalQuantity,
      specifiedType: const FullType(num),
    );
    yield r'unit';
    yield serializers.serialize(
      object.unit,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseConsumptionReport200ResponseDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseConsumptionReport200ResponseDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.itemName = valueDes;
          break;
        case r'sku':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sku = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.department = valueDes;
          break;
        case r'total_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalQuantity = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  WarehouseConsumptionReport200ResponseDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseConsumptionReport200ResponseDataInnerBuilder();
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

