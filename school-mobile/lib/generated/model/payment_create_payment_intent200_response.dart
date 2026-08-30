//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_create_payment_intent200_response.g.dart';

/// PaymentCreatePaymentIntent200Response
///
/// Properties:
/// * [clientSecret] 
/// * [paymentIntentId] 
/// * [amount] 
@BuiltValue()
abstract class PaymentCreatePaymentIntent200Response implements Built<PaymentCreatePaymentIntent200Response, PaymentCreatePaymentIntent200ResponseBuilder> {
  @BuiltValueField(wireName: r'client_secret')
  String get clientSecret;

  @BuiltValueField(wireName: r'payment_intent_id')
  String get paymentIntentId;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  PaymentCreatePaymentIntent200Response._();

  factory PaymentCreatePaymentIntent200Response([void updates(PaymentCreatePaymentIntent200ResponseBuilder b)]) = _$PaymentCreatePaymentIntent200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentCreatePaymentIntent200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentCreatePaymentIntent200Response> get serializer => _$PaymentCreatePaymentIntent200ResponseSerializer();
}

class _$PaymentCreatePaymentIntent200ResponseSerializer implements PrimitiveSerializer<PaymentCreatePaymentIntent200Response> {
  @override
  final Iterable<Type> types = const [PaymentCreatePaymentIntent200Response, _$PaymentCreatePaymentIntent200Response];

  @override
  final String wireName = r'PaymentCreatePaymentIntent200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentCreatePaymentIntent200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'client_secret';
    yield serializers.serialize(
      object.clientSecret,
      specifiedType: const FullType(String),
    );
    yield r'payment_intent_id';
    yield serializers.serialize(
      object.paymentIntentId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreatePaymentIntent200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentCreatePaymentIntent200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'client_secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientSecret = valueDes;
          break;
        case r'payment_intent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paymentIntentId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentCreatePaymentIntent200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentCreatePaymentIntent200ResponseBuilder();
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

