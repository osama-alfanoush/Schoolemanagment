//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_handle_webhook400_response_any_of.g.dart';

/// PaymentHandleWebhook400ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class PaymentHandleWebhook400ResponseAnyOf implements Built<PaymentHandleWebhook400ResponseAnyOf, PaymentHandleWebhook400ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  PaymentHandleWebhook400ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Missing Stripe-Signature header,  };

  PaymentHandleWebhook400ResponseAnyOf._();

  factory PaymentHandleWebhook400ResponseAnyOf([void updates(PaymentHandleWebhook400ResponseAnyOfBuilder b)]) = _$PaymentHandleWebhook400ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentHandleWebhook400ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentHandleWebhook400ResponseAnyOf> get serializer => _$PaymentHandleWebhook400ResponseAnyOfSerializer();
}

class _$PaymentHandleWebhook400ResponseAnyOfSerializer implements PrimitiveSerializer<PaymentHandleWebhook400ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [PaymentHandleWebhook400ResponseAnyOf, _$PaymentHandleWebhook400ResponseAnyOf];

  @override
  final String wireName = r'PaymentHandleWebhook400ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentHandleWebhook400ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PaymentHandleWebhook400ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentHandleWebhook400ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentHandleWebhook400ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentHandleWebhook400ResponseAnyOfMessageEnum),
          ) as PaymentHandleWebhook400ResponseAnyOfMessageEnum;
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
  PaymentHandleWebhook400ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentHandleWebhook400ResponseAnyOfBuilder();
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

class PaymentHandleWebhook400ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Missing Stripe-Signature header')
  static const PaymentHandleWebhook400ResponseAnyOfMessageEnum missingStripeSignatureHeader = _$paymentHandleWebhook400ResponseAnyOfMessageEnum_missingStripeSignatureHeader;

  static Serializer<PaymentHandleWebhook400ResponseAnyOfMessageEnum> get serializer => _$paymentHandleWebhook400ResponseAnyOfMessageEnumSerializer;

  const PaymentHandleWebhook400ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<PaymentHandleWebhook400ResponseAnyOfMessageEnum> get values => _$paymentHandleWebhook400ResponseAnyOfMessageEnumValues;
  static PaymentHandleWebhook400ResponseAnyOfMessageEnum valueOf(String name) => _$paymentHandleWebhook400ResponseAnyOfMessageEnumValueOf(name);
}

