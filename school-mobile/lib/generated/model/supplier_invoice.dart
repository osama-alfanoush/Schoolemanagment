//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'supplier_invoice.g.dart';

/// SupplierInvoice
///
/// Properties:
/// * [id] 
/// * [invoiceNo] 
/// * [supplierInvoiceRef] 
/// * [supplierId] 
/// * [purchaseOrderId] 
/// * [invoiceDate] 
/// * [dueDate] 
/// * [amount] 
/// * [paidAmount] 
/// * [status] 
/// * [notes] 
/// * [createdBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [deletedAt] 
/// * [schoolId] 
@BuiltValue()
abstract class SupplierInvoice implements Built<SupplierInvoice, SupplierInvoiceBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'invoice_no')
  String get invoiceNo;

  @BuiltValueField(wireName: r'supplier_invoice_ref')
  String? get supplierInvoiceRef;

  @BuiltValueField(wireName: r'supplier_id')
  int get supplierId;

  @BuiltValueField(wireName: r'purchase_order_id')
  int? get purchaseOrderId;

  @BuiltValueField(wireName: r'invoice_date')
  DateTime get invoiceDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime get dueDate;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'paid_amount')
  String get paidAmount;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'created_by')
  int get createdBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'deleted_at')
  DateTime? get deletedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  SupplierInvoice._();

  factory SupplierInvoice([void updates(SupplierInvoiceBuilder b)]) = _$SupplierInvoice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SupplierInvoiceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SupplierInvoice> get serializer => _$SupplierInvoiceSerializer();
}

class _$SupplierInvoiceSerializer implements PrimitiveSerializer<SupplierInvoice> {
  @override
  final Iterable<Type> types = const [SupplierInvoice, _$SupplierInvoice];

  @override
  final String wireName = r'SupplierInvoice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SupplierInvoice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'invoice_no';
    yield serializers.serialize(
      object.invoiceNo,
      specifiedType: const FullType(String),
    );
    yield r'supplier_invoice_ref';
    yield object.supplierInvoiceRef == null ? null : serializers.serialize(
      object.supplierInvoiceRef,
      specifiedType: const FullType.nullable(String),
    );
    yield r'supplier_id';
    yield serializers.serialize(
      object.supplierId,
      specifiedType: const FullType(int),
    );
    yield r'purchase_order_id';
    yield object.purchaseOrderId == null ? null : serializers.serialize(
      object.purchaseOrderId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'invoice_date';
    yield serializers.serialize(
      object.invoiceDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'due_date';
    yield serializers.serialize(
      object.dueDate,
      specifiedType: const FullType(DateTime),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'paid_amount';
    yield serializers.serialize(
      object.paidAmount,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'notes';
    yield object.notes == null ? null : serializers.serialize(
      object.notes,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
      specifiedType: const FullType(int),
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
    SupplierInvoice object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SupplierInvoiceBuilder result,
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
        case r'invoice_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.invoiceNo = valueDes;
          break;
        case r'supplier_invoice_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.supplierInvoiceRef = valueDes;
          break;
        case r'supplier_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.supplierId = valueDes;
          break;
        case r'purchase_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.purchaseOrderId = valueDes;
          break;
        case r'invoice_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.invoiceDate = valueDes;
          break;
        case r'due_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueDate = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'paid_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paidAmount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.createdBy = valueDes;
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
  SupplierInvoice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SupplierInvoiceBuilder();
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

