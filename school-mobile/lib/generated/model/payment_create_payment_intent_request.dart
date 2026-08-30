//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_create_payment_intent_request.g.dart';

/// PaymentCreatePaymentIntentRequest
///
/// Properties:
/// * [invoiceId] 
/// * [currency] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class PaymentCreatePaymentIntentRequest implements Built<PaymentCreatePaymentIntentRequest, PaymentCreatePaymentIntentRequestBuilder> {
  @BuiltValueField(wireName: r'invoice_id')
  int get invoiceId;

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  PaymentCreatePaymentIntentRequest._();

  factory PaymentCreatePaymentIntentRequest([void updates(PaymentCreatePaymentIntentRequestBuilder b)]) = _$PaymentCreatePaymentIntentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentCreatePaymentIntentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentCreatePaymentIntentRequest> get serializer => _$PaymentCreatePaymentIntentRequestSerializer();
}

class _$PaymentCreatePaymentIntentRequestSerializer implements PrimitiveSerializer<PaymentCreatePaymentIntentRequest> {
  @override
  final Iterable<Type> types = const [PaymentCreatePaymentIntentRequest, _$PaymentCreatePaymentIntentRequest];

  @override
  final String wireName = r'PaymentCreatePaymentIntentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentCreatePaymentIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'invoice_id';
    yield serializers.serialize(
      object.invoiceId,
      specifiedType: const FullType(int),
    );
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreatePaymentIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentCreatePaymentIntentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invoice_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.invoiceId = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currency = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentCreatePaymentIntentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentCreatePaymentIntentRequestBuilder();
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

