//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_store_invoice_request.g.dart';

/// ProcurementFinanceStoreInvoiceRequest
///
/// Properties:
/// * [supplierId] 
/// * [purchaseOrderId] 
/// * [supplierInvoiceRef] 
/// * [invoiceDate] 
/// * [dueDate] 
/// * [amount] 
/// * [notes] 
@BuiltValue()
abstract class ProcurementFinanceStoreInvoiceRequest implements Built<ProcurementFinanceStoreInvoiceRequest, ProcurementFinanceStoreInvoiceRequestBuilder> {
  @BuiltValueField(wireName: r'supplier_id')
  int get supplierId;

  @BuiltValueField(wireName: r'purchase_order_id')
  int? get purchaseOrderId;

  @BuiltValueField(wireName: r'supplier_invoice_ref')
  String? get supplierInvoiceRef;

  @BuiltValueField(wireName: r'invoice_date')
  DateTime get invoiceDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime get dueDate;

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  ProcurementFinanceStoreInvoiceRequest._();

  factory ProcurementFinanceStoreInvoiceRequest([void updates(ProcurementFinanceStoreInvoiceRequestBuilder b)]) = _$ProcurementFinanceStoreInvoiceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceStoreInvoiceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceStoreInvoiceRequest> get serializer => _$ProcurementFinanceStoreInvoiceRequestSerializer();
}

class _$ProcurementFinanceStoreInvoiceRequestSerializer implements PrimitiveSerializer<ProcurementFinanceStoreInvoiceRequest> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceStoreInvoiceRequest, _$ProcurementFinanceStoreInvoiceRequest];

  @override
  final String wireName = r'ProcurementFinanceStoreInvoiceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceStoreInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'supplier_id';
    yield serializers.serialize(
      object.supplierId,
      specifiedType: const FullType(int),
    );
    if (object.purchaseOrderId != null) {
      yield r'purchase_order_id';
      yield serializers.serialize(
        object.purchaseOrderId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.supplierInvoiceRef != null) {
      yield r'supplier_invoice_ref';
      yield serializers.serialize(
        object.supplierInvoiceRef,
        specifiedType: const FullType.nullable(String),
      );
    }
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
    ProcurementFinanceStoreInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceStoreInvoiceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'supplier_invoice_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.supplierInvoiceRef = valueDes;
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
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
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
  ProcurementFinanceStoreInvoiceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceStoreInvoiceRequestBuilder();
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

