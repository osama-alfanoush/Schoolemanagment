//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_record_payment_request.g.dart';

/// FinanceRecordPaymentRequest
///
/// Properties:
/// * [idempotencyKey] 
/// * [amount] 
/// * [method] 
/// * [reference] 
/// * [paidAt] 
/// * [note] 
@BuiltValue()
abstract class FinanceRecordPaymentRequest implements Built<FinanceRecordPaymentRequest, FinanceRecordPaymentRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'method')
  FinanceRecordPaymentRequestMethodEnum get method;
  // enum methodEnum {  cash,  bank_transfer,  card,  online,  };

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  @BuiltValueField(wireName: r'paid_at')
  DateTime? get paidAt;

  @BuiltValueField(wireName: r'note')
  String? get note;

  FinanceRecordPaymentRequest._();

  factory FinanceRecordPaymentRequest([void updates(FinanceRecordPaymentRequestBuilder b)]) = _$FinanceRecordPaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceRecordPaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceRecordPaymentRequest> get serializer => _$FinanceRecordPaymentRequestSerializer();
}

class _$FinanceRecordPaymentRequestSerializer implements PrimitiveSerializer<FinanceRecordPaymentRequest> {
  @override
  final Iterable<Type> types = const [FinanceRecordPaymentRequest, _$FinanceRecordPaymentRequest];

  @override
  final String wireName = r'FinanceRecordPaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceRecordPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(FinanceRecordPaymentRequestMethodEnum),
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
    FinanceRecordPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceRecordPaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
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
            specifiedType: const FullType(FinanceRecordPaymentRequestMethodEnum),
          ) as FinanceRecordPaymentRequestMethodEnum;
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
  FinanceRecordPaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceRecordPaymentRequestBuilder();
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

class FinanceRecordPaymentRequestMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cash')
  static const FinanceRecordPaymentRequestMethodEnum cash = _$financeRecordPaymentRequestMethodEnum_cash;
  @BuiltValueEnumConst(wireName: r'bank_transfer')
  static const FinanceRecordPaymentRequestMethodEnum bankTransfer = _$financeRecordPaymentRequestMethodEnum_bankTransfer;
  @BuiltValueEnumConst(wireName: r'card')
  static const FinanceRecordPaymentRequestMethodEnum card = _$financeRecordPaymentRequestMethodEnum_card;
  @BuiltValueEnumConst(wireName: r'online')
  static const FinanceRecordPaymentRequestMethodEnum online = _$financeRecordPaymentRequestMethodEnum_online;

  static Serializer<FinanceRecordPaymentRequestMethodEnum> get serializer => _$financeRecordPaymentRequestMethodEnumSerializer;

  const FinanceRecordPaymentRequestMethodEnum._(String name): super(name);

  static BuiltSet<FinanceRecordPaymentRequestMethodEnum> get values => _$financeRecordPaymentRequestMethodEnumValues;
  static FinanceRecordPaymentRequestMethodEnum valueOf(String name) => _$financeRecordPaymentRequestMethodEnumValueOf(name);
}

