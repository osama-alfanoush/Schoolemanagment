//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'procurement_finance_record_payment_request.g.dart';

/// ProcurementFinanceRecordPaymentRequest
///
/// Properties:
/// * [amount] 
/// * [method] 
/// * [reference] 
/// * [paidAt] 
/// * [note] 
@BuiltValue()
abstract class ProcurementFinanceRecordPaymentRequest implements Built<ProcurementFinanceRecordPaymentRequest, ProcurementFinanceRecordPaymentRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'method')
  ProcurementFinanceRecordPaymentRequestMethodEnum get method;
  // enum methodEnum {  cash,  bank_transfer,  cheque,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'paid_at')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'note')
  String? get note;

  ProcurementFinanceRecordPaymentRequest._();

  factory ProcurementFinanceRecordPaymentRequest([void updates(ProcurementFinanceRecordPaymentRequestBuilder b)]) = _$ProcurementFinanceRecordPaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProcurementFinanceRecordPaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProcurementFinanceRecordPaymentRequest> get serializer => _$ProcurementFinanceRecordPaymentRequestSerializer();
}

class _$ProcurementFinanceRecordPaymentRequestSerializer implements PrimitiveSerializer<ProcurementFinanceRecordPaymentRequest> {
  @override
  final Iterable<Type> types = const [ProcurementFinanceRecordPaymentRequest, _$ProcurementFinanceRecordPaymentRequest];

  @override
  final String wireName = r'ProcurementFinanceRecordPaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProcurementFinanceRecordPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(ProcurementFinanceRecordPaymentRequestMethodEnum),
    );
    if (object.reference != null) {
      yield r'reference';
      yield serializers.serialize(
        object.reference,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.paidAt != null) {
      yield r'paid_at';
      yield serializers.serialize(
        object.paidAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceRecordPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProcurementFinanceRecordPaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProcurementFinanceRecordPaymentRequestMethodEnum),
          ) as ProcurementFinanceRecordPaymentRequestMethodEnum;
          result.method = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reference = valueDes;
          break;
        case r'paid_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.paidAt = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProcurementFinanceRecordPaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProcurementFinanceRecordPaymentRequestBuilder();
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

class ProcurementFinanceRecordPaymentRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cash')
  static const ProcurementFinanceRecordPaymentRequestMethodEnum cash = _$procurementFinanceRecordPaymentRequestMethodEnum_cash;
  @BuiltValueEnumConst(wireName: r'bank_transfer')
  static const ProcurementFinanceRecordPaymentRequestMethodEnum bankTransfer = _$procurementFinanceRecordPaymentRequestMethodEnum_bankTransfer;
  @BuiltValueEnumConst(wireName: r'cheque')
  static const ProcurementFinanceRecordPaymentRequestMethodEnum cheque = _$procurementFinanceRecordPaymentRequestMethodEnum_cheque;

  static Serializer<ProcurementFinanceRecordPaymentRequestMethodEnum> get serializer => _$procurementFinanceRecordPaymentRequestMethodEnumSerializer;

  const ProcurementFinanceRecordPaymentRequestMethodEnum._(String name): super(name);

  static BuiltSet<ProcurementFinanceRecordPaymentRequestMethodEnum> get values => _$procurementFinanceRecordPaymentRequestMethodEnumValues;
  static ProcurementFinanceRecordPaymentRequestMethodEnum valueOf(String name) => _$procurementFinanceRecordPaymentRequestMethodEnumValueOf(name);
}

