//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'warehouse_store_movement_request.g.dart';

/// WarehouseStoreMovementRequest
///
/// Properties:
/// * [itemId] 
/// * [movementType] 
/// * [quantity] 
/// * [department] 
/// * [recipientName] 
/// * [reason] 
/// * [referenceNo] 
/// * [supplier] 
@BuiltValue()
abstract class WarehouseStoreMovementRequest implements Built<WarehouseStoreMovementRequest, WarehouseStoreMovementRequestBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'movement_type')
  WarehouseStoreMovementRequestMovementTypeEnum get movementType;
  // enum movementTypeEnum {  in,  out,  adjustment,  return,  };

  @BuiltValueField(wireName: r'quantity')
  num get quantity;

  @BuiltValueField(wireName: r'department')
  String? get department;

  @BuiltValueField(wireName: r'recipient_name')
  String? get recipientName;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'reference_no')
  String? get referenceNo;

  @BuiltValueField(wireName: r'supplier')
  String? get supplier;

  WarehouseStoreMovementRequest._();

  factory WarehouseStoreMovementRequest([void updates(WarehouseStoreMovementRequestBuilder b)]) = _$WarehouseStoreMovementRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WarehouseStoreMovementRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WarehouseStoreMovementRequest> get serializer => _$WarehouseStoreMovementRequestSerializer();
}

class _$WarehouseStoreMovementRequestSerializer implements PrimitiveSerializer<WarehouseStoreMovementRequest> {
  @override
  final Iterable<Type> types = const [WarehouseStoreMovementRequest, _$WarehouseStoreMovementRequest];

  @override
  final String wireName = r'WarehouseStoreMovementRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WarehouseStoreMovementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'movement_type';
    yield serializers.serialize(
      object.movementType,
      specifiedType: const FullType(WarehouseStoreMovementRequestMovementTypeEnum),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(num),
    );
    if (object.department != null) {
      yield r'department';
      yield serializers.serialize(
        object.department,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.recipientName != null) {
      yield r'recipient_name';
      yield serializers.serialize(
        object.recipientName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.referenceNo != null) {
      yield r'reference_no';
      yield serializers.serialize(
        object.referenceNo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.supplier != null) {
      yield r'supplier';
      yield serializers.serialize(
        object.supplier,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WarehouseStoreMovementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WarehouseStoreMovementRequestBuilder result,
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
        case r'movement_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WarehouseStoreMovementRequestMovementTypeEnum),
          ) as WarehouseStoreMovementRequestMovementTypeEnum;
          result.movementType = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.quantity = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.department = valueDes;
          break;
        case r'recipient_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.recipientName = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'reference_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referenceNo = valueDes;
          break;
        case r'supplier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.supplier = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WarehouseStoreMovementRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WarehouseStoreMovementRequestBuilder();
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

class WarehouseStoreMovementRequestMovementTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'in')
  static const WarehouseStoreMovementRequestMovementTypeEnum in_ = _$warehouseStoreMovementRequestMovementTypeEnum_in_;
  @BuiltValueEnumConst(wireName: r'out')
  static const WarehouseStoreMovementRequestMovementTypeEnum out_ = _$warehouseStoreMovementRequestMovementTypeEnum_out_;
  @BuiltValueEnumConst(wireName: r'adjustment')
  static const WarehouseStoreMovementRequestMovementTypeEnum adjustment = _$warehouseStoreMovementRequestMovementTypeEnum_adjustment;
  @BuiltValueEnumConst(wireName: r'return')
  static const WarehouseStoreMovementRequestMovementTypeEnum return_ = _$warehouseStoreMovementRequestMovementTypeEnum_return_;

  static Serializer<WarehouseStoreMovementRequestMovementTypeEnum> get serializer => _$warehouseStoreMovementRequestMovementTypeEnumSerializer;

  const WarehouseStoreMovementRequestMovementTypeEnum._(String name): super(name);

  static BuiltSet<WarehouseStoreMovementRequestMovementTypeEnum> get values => _$warehouseStoreMovementRequestMovementTypeEnumValues;
  static WarehouseStoreMovementRequestMovementTypeEnum valueOf(String name) => _$warehouseStoreMovementRequestMovementTypeEnumValueOf(name);
}

