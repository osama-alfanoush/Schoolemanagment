//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_update_invoice_request.g.dart';

/// ProcurementFinanceUpdateInvoiceRequest
///
/// Properties:
/// * [supplierInvoiceRef] 
/// * [invoiceDate] 
/// * [dueDate] 
/// * [amount] 
/// * [notes] 
@BuiltValue()
abstract class ProcurementFinanceUpdateInvoiceRequest implements Built<ProcurementFinanceUpdateInvoiceRequest, ProcurementFinanceUpdateInvoiceRequestBuilder> {
  @BuiltValueField(wireName: r'supplier_invoice_ref')
  String? get supplierInvoiceRef;

  @BuiltValueField(wireName: r'invoice_date')
  DateTime? get invoiceDate;

  @BuiltValueField(wireName: r'due_date')
  DateTime? get dueDate;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  ProcurementFinanceUpdateInvoiceRequest._();

  factory ProcurementFinanceUpdateInvoiceRequest([void updates(ProcurementFinanceUpdateInvoiceRequestBuilder b)]) = _$ProcurementFinanceUpdateInvoiceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceUpdateInvoiceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceUpdateInvoiceRequest> get serializer => _$ProcurementFinanceUpdateInvoiceRequestSerializer();
}

class _$ProcurementFinanceUpdateInvoiceRequestSerializer implements PrimitiveSerializer<ProcurementFinanceUpdateInvoiceRequest> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceUpdateInvoiceRequest, _$ProcurementFinanceUpdateInvoiceRequest];

  @override
  final String wireName = r'ProcurementFinanceUpdateInvoiceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceUpdateInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.supplierInvoiceRef != null) {
      yield r'supplier_invoice_ref';
      yield serializers.serialize(
        object.supplierInvoiceRef,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.invoiceDate != null) {
      yield r'invoice_date';
      yield serializers.serialize(
        object.invoiceDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.dueDate != null) {
      yield r'due_date';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(num),
      );
    }
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
    ProcurementFinanceUpdateInvoiceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceUpdateInvoiceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ProcurementFinanceUpdateInvoiceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceUpdateInvoiceRequestBuilder();
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

