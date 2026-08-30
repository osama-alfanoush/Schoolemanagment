//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_confirm_payment200_response.g.dart';

/// PaymentConfirmPayment200Response
///
/// Properties:
/// * [message] 
/// * [payment] 
/// * [alreadyRecorded] 
@BuiltValue()
abstract class PaymentConfirmPayment200Response implements Built<PaymentConfirmPayment200Response, PaymentConfirmPayment200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  PaymentConfirmPayment200ResponseMessageEnum get message;
  // enum messageEnum {  Payment confirmed,  };

  @BuiltValueField(wireName: r'payment')
  JsonObject? get payment;

  @BuiltValueField(wireName: r'already_recorded')
  JsonObject? get alreadyRecorded;

  PaymentConfirmPayment200Response._();

  factory PaymentConfirmPayment200Response([void updates(PaymentConfirmPayment200ResponseBuilder b)]) = _$PaymentConfirmPayment200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentConfirmPayment200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentConfirmPayment200Response> get serializer => _$PaymentConfirmPayment200ResponseSerializer();
}

class _$PaymentConfirmPayment200ResponseSerializer implements PrimitiveSerializer<PaymentConfirmPayment200Response> {
  @override
  final Iterable<Type> types = const [PaymentConfirmPayment200Response, _$PaymentConfirmPayment200Response];

  @override
  final String wireName = r'PaymentConfirmPayment200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentConfirmPayment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PaymentConfirmPayment200ResponseMessageEnum),
    );
    yield r'payment';
    yield object.payment == null ? null : serializers.serialize(
      object.payment,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'already_recorded';
    yield object.alreadyRecorded == null ? null : serializers.serialize(
      object.alreadyRecorded,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentConfirmPayment200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentConfirmPayment200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentConfirmPayment200ResponseMessageEnum),
          ) as PaymentConfirmPayment200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.payment = valueDes;
          break;
        case r'already_recorded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.alreadyRecorded = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentConfirmPayment200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentConfirmPayment200ResponseBuilder();
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

class PaymentConfirmPayment200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Payment confirmed')
  static const PaymentConfirmPayment200ResponseMessageEnum paymentConfirmed = _$paymentConfirmPayment200ResponseMessageEnum_paymentConfirmed;

  static Serializer<PaymentConfirmPayment200ResponseMessageEnum> get serializer => _$paymentConfirmPayment200ResponseMessageEnumSerializer;

  const PaymentConfirmPayment200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PaymentConfirmPayment200ResponseMessageEnum> get values => _$paymentConfirmPayment200ResponseMessageEnumValues;
  static PaymentConfirmPayment200ResponseMessageEnum valueOf(String name) => _$paymentConfirmPayment200ResponseMessageEnumValueOf(name);
}

