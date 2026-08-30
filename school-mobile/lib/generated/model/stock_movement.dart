//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stock_movement.g.dart';

/// StockMovement
///
/// Properties:
/// * [id] 
/// * [itemId] 
/// * [movementType] 
/// * [quantity] 
/// * [qtyBefore] 
/// * [qtyAfter] 
/// * [department] 
/// * [recipientName] 
/// * [reason] 
/// * [referenceNo] 
/// * [supplier] 
/// * [performedBy] 
/// * [movementDate] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [unitCost] 
/// * [purchaseOrderId] 
/// * [schoolId] 
@BuiltValue()
abstract class StockMovement implements Built<StockMovement, StockMovementBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'movement_type')
  String get movementType;

  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  @BuiltValueField(wireName: r'qty_before')
  String get qtyBefore;

  @BuiltValueField(wireName: r'qty_after')
  String get qtyAfter;

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

  @BuiltValueField(wireName: r'performed_by')
  int get performedBy;

  @BuiltValueField(wireName: r'movement_date')
  DateTime get movementDate;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'unit_cost')
  String? get unitCost;

  @BuiltValueField(wireName: r'purchase_order_id')
  int? get purchaseOrderId;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  StockMovement._();

  factory StockMovement([void updates(StockMovementBuilder b)]) = _$StockMovement;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StockMovementBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StockMovement> get serializer => _$StockMovementSerializer();
}

class _$StockMovementSerializer implements PrimitiveSerializer<StockMovement> {
  @override
  final Iterable<Type> types = const [StockMovement, _$StockMovement];

  @override
  final String wireName = r'StockMovement';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StockMovement object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'movement_type';
    yield serializers.serialize(
      object.movementType,
      specifiedType: const FullType(String),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'qty_before';
    yield serializers.serialize(
      object.qtyBefore,
      specifiedType: const FullType(String),
    );
    yield r'qty_after';
    yield serializers.serialize(
      object.qtyAfter,
      specifiedType: const FullType(String),
    );
    yield r'department';
    yield object.department == null ? null : serializers.serialize(
      object.department,
      specifiedType: const FullType.nullable(String),
    );
    yield r'recipient_name';
    yield object.recipientName == null ? null : serializers.serialize(
      object.recipientName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reason';
    yield object.reason == null ? null : serializers.serialize(
      object.reason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reference_no';
    yield object.referenceNo == null ? null : serializers.serialize(
      object.referenceNo,
      specifiedType: const FullType.nullable(String),
    );
    yield r'supplier';
    yield object.supplier == null ? null : serializers.serialize(
      object.supplier,
      specifiedType: const FullType.nullable(String),
    );
    yield r'performed_by';
    yield serializers.serialize(
      object.performedBy,
      specifiedType: const FullType(int),
    );
    yield r'movement_date';
    yield serializers.serialize(
      object.movementDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'unit_cost';
    yield object.unitCost == null ? null : serializers.serialize(
      object.unitCost,
      specifiedType: const FullType.nullable(String),
    );
    yield r'purchase_order_id';
    yield object.purchaseOrderId == null ? null : serializers.serialize(
      object.purchaseOrderId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StockMovement object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StockMovementBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType(String),
          ) as String;
          result.movementType = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'qty_before':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.qtyBefore = valueDes;
          break;
        case r'qty_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.qtyAfter = valueDes;
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
        case r'performed_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.performedBy = valueDes;
          break;
        case r'movement_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.movementDate = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'unit_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unitCost = valueDes;
          break;
        case r'purchase_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.purchaseOrderId = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StockMovement deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StockMovementBuilder();
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

