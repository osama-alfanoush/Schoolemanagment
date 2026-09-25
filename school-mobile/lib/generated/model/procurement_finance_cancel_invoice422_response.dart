//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_cancel_invoice422_response.g.dart';

/// ProcurementFinanceCancelInvoice422Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class ProcurementFinanceCancelInvoice422Response implements Built<ProcurementFinanceCancelInvoice422Response, ProcurementFinanceCancelInvoice422ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ProcurementFinanceCancelInvoice422ResponseMessageEnum get message;
  // enum messageEnum {  Invoices with recorded payments cannot be cancelled.,  };

  ProcurementFinanceCancelInvoice422Response._();

  factory ProcurementFinanceCancelInvoice422Response([void updates(ProcurementFinanceCancelInvoice422ResponseBuilder b)]) = _$ProcurementFinanceCancelInvoice422Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceCancelInvoice422ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceCancelInvoice422Response> get serializer => _$ProcurementFinanceCancelInvoice422ResponseSerializer();
}

class _$ProcurementFinanceCancelInvoice422ResponseSerializer implements PrimitiveSerializer<ProcurementFinanceCancelInvoice422Response> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceCancelInvoice422Response, _$ProcurementFinanceCancelInvoice422Response];

  @override
  final String wireName = r'ProcurementFinanceCancelInvoice422Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceCancelInvoice422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ProcurementFinanceCancelInvoice422ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceCancelInvoice422Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceCancelInvoice422ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProcurementFinanceCancelInvoice422ResponseMessageEnum),
          ) as ProcurementFinanceCancelInvoice422ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementFinanceCancelInvoice422Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceCancelInvoice422ResponseBuilder();
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

class ProcurementFinanceCancelInvoice422ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Invoices with recorded payments cannot be cancelled.')
  static const ProcurementFinanceCancelInvoice422ResponseMessageEnum invoicesWithRecordedPaymentsCannotBeCancelledPeriod = _$procurementFinanceCancelInvoice422ResponseMessageEnum_invoicesWithRecordedPaymentsCannotBeCancelledPeriod;

  static Serializer<ProcurementFinanceCancelInvoice422ResponseMessageEnum> get serializer => _$procurementFinanceCancelInvoice422ResponseMessageEnumSerializer;

  const ProcurementFinanceCancelInvoice422ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ProcurementFinanceCancelInvoice422ResponseMessageEnum> get values => _$procurementFinanceCancelInvoice422ResponseMessageEnumValues;
  static ProcurementFinanceCancelInvoice422ResponseMessageEnum valueOf(String name) => _$procurementFinanceCancelInvoice422ResponseMessageEnumValueOf(name);
}

