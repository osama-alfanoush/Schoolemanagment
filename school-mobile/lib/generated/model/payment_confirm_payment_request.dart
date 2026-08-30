//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_confirm_payment_request.g.dart';

/// PaymentConfirmPaymentRequest
///
/// Properties:
/// * [paymentIntentId] 
@BuiltValue()
abstract class PaymentConfirmPaymentRequest implements Built<PaymentConfirmPaymentRequest, PaymentConfirmPaymentRequestBuilder> {
  @BuiltValueField(wireName: r'payment_intent_id')
  String get paymentIntentId;

  PaymentConfirmPaymentRequest._();

  factory PaymentConfirmPaymentRequest([void updates(PaymentConfirmPaymentRequestBuilder b)]) = _$PaymentConfirmPaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentConfirmPaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentConfirmPaymentRequest> get serializer => _$PaymentConfirmPaymentRequestSerializer();
}

class _$PaymentConfirmPaymentRequestSerializer implements PrimitiveSerializer<PaymentConfirmPaymentRequest> {
  @override
  final Iterable<Type> types = const [PaymentConfirmPaymentRequest, _$PaymentConfirmPaymentRequest];

  @override
  final String wireName = r'PaymentConfirmPaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentConfirmPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'payment_intent_id';
    yield serializers.serialize(
      object.paymentIntentId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentConfirmPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentConfirmPaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'payment_intent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paymentIntentId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentConfirmPaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentConfirmPaymentRequestBuilder();
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

