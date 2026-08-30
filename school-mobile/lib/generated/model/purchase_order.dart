//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'purchase_order.g.dart';

/// PurchaseOrder
///
/// Properties:
/// * [id] 
/// * [poNo] 
/// * [supplierId] 
/// * [status] 
/// * [orderDate] 
/// * [expectedDate] 
/// * [subtotal] 
/// * [tax] 
/// * [total] 
/// * [notes] 
/// * [purchaseRequestId] 
/// * [requestedBy] 
/// * [approvedBy] 
/// * [approvedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [deletedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class PurchaseOrder implements Built<PurchaseOrder, PurchaseOrderBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'po_no')
  String get poNo;

  @BuiltValueField(wireName: r'supplier_id')
  int get supplierId;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'order_date')
  DateTime get orderDate;

  @BuiltValueField(wireName: r'expected_date')
  DateTime? get expectedDate;

  @BuiltValueField(wireName: r'subtotal')
  String get subtotal;

  @BuiltValueField(wireName: r'tax')
  String get tax;

  @BuiltValueField(wireName: r'total')
  String get total;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'purchase_request_id')
  int? get purchaseRequestId;

  @BuiltValueField(wireName: r'requested_by')
  int get requestedBy;

  @BuiltValueField(wireName: r'approved_by')
  int? get approvedBy;

  @BuiltValueField(wireName: r'approved_at')
  DateTime? get approvedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'deleted_at')
  DateTime? get deletedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  PurchaseOrder._();

  factory PurchaseOrder([void updates(PurchaseOrderBuilder b)]) = _$PurchaseOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PurchaseOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PurchaseOrder> get serializer => _$PurchaseOrderSerializer();
}

class _$PurchaseOrderSerializer implements PrimitiveSerializer<PurchaseOrder> {
  @override
  final Iterable<Type> types = const [PurchaseOrder, _$PurchaseOrder];

  @override
  final String wireName = r'PurchaseOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PurchaseOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'po_no';
    yield serializers.serialize(
      object.poNo,
      specifiedType: const FullType(String),
    );
    yield r'supplier_id';
    yield serializers.serialize(
      object.supplierId,
      specifiedType: const FullType(int),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'order_date';
    yield serializers.serialize(
      object.orderDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'expected_date';
    yield object.expectedDate == null ? null : serializers.serialize(
      object.expectedDate,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'subtotal';
    yield serializers.serialize(
      object.subtotal,
      specifiedType: const FullType(String),
    );
    yield r'tax';
    yield serializers.serialize(
      object.tax,
      specifiedType: const FullType(String),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(String),
    );
    yield r'notes';
    yield object.notes == null ? null : serializers.serialize(
      object.notes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'purchase_request_id';
    yield object.purchaseRequestId == null ? null : serializers.serialize(
      object.purchaseRequestId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'requested_by';
    yield serializers.serialize(
      object.requestedBy,
      specifiedType: const FullType(int),
    );
    yield r'approved_by';
    yield object.approvedBy == null ? null : serializers.serialize(
      object.approvedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'approved_at';
    yield object.approvedAt == null ? null : serializers.serialize(
      object.approvedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    yield r'deleted_at';
    yield object.deletedAt == null ? null : serializers.serialize(
      object.deletedAt,
      specifiedType: const FullType.nullable(DateTime),
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
    PurchaseOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PurchaseOrderBuilder result,
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
        case r'po_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.poNo = valueDes;
          break;
        case r'supplier_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.supplierId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'order_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.orderDate = valueDes;
          break;
        case r'expected_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expectedDate = valueDes;
          break;
        case r'subtotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtotal = valueDes;
          break;
        case r'tax':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tax = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.total = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'purchase_request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.purchaseRequestId = valueDes;
          break;
        case r'requested_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requestedBy = valueDes;
          break;
        case r'approved_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.approvedBy = valueDes;
          break;
        case r'approved_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.approvedAt = valueDes;
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
        case r'deleted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deletedAt = valueDes;
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
  PurchaseOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PurchaseOrderBuilder();
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

