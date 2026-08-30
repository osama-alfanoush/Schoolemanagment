//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_create_payment_intent403_response.g.dart';

/// PaymentCreatePaymentIntent403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class PaymentCreatePaymentIntent403Response implements Built<PaymentCreatePaymentIntent403Response, PaymentCreatePaymentIntent403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  PaymentCreatePaymentIntent403ResponseMessageEnum get message;
  // enum messageEnum {  Unauthorized,  };

  PaymentCreatePaymentIntent403Response._();

  factory PaymentCreatePaymentIntent403Response([void updates(PaymentCreatePaymentIntent403ResponseBuilder b)]) = _$PaymentCreatePaymentIntent403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentCreatePaymentIntent403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentCreatePaymentIntent403Response> get serializer => _$PaymentCreatePaymentIntent403ResponseSerializer();
}

class _$PaymentCreatePaymentIntent403ResponseSerializer implements PrimitiveSerializer<PaymentCreatePaymentIntent403Response> {
  @override
  final Iterable<Type> types = const [PaymentCreatePaymentIntent403Response, _$PaymentCreatePaymentIntent403Response];

  @override
  final String wireName = r'PaymentCreatePaymentIntent403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentCreatePaymentIntent403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PaymentCreatePaymentIntent403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreatePaymentIntent403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentCreatePaymentIntent403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentCreatePaymentIntent403ResponseMessageEnum),
          ) as PaymentCreatePaymentIntent403ResponseMessageEnum;
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
  PaymentCreatePaymentIntent403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentCreatePaymentIntent403ResponseBuilder();
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

class PaymentCreatePaymentIntent403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Unauthorized')
  static const PaymentCreatePaymentIntent403ResponseMessageEnum unauthorized = _$paymentCreatePaymentIntent403ResponseMessageEnum_unauthorized;

  static Serializer<PaymentCreatePaymentIntent403ResponseMessageEnum> get serializer => _$paymentCreatePaymentIntent403ResponseMessageEnumSerializer;

  const PaymentCreatePaymentIntent403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PaymentCreatePaymentIntent403ResponseMessageEnum> get values => _$paymentCreatePaymentIntent403ResponseMessageEnumValues;
  static PaymentCreatePaymentIntent403ResponseMessageEnum valueOf(String name) => _$paymentCreatePaymentIntent403ResponseMessageEnumValueOf(name);
}

