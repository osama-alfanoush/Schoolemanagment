//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_get_payment_methods200_response.g.dart';

/// PaymentGetPaymentMethods200Response
///
/// Properties:
/// * [methods] 
/// * [message] 
@BuiltValue()
abstract class PaymentGetPaymentMethods200Response implements Built<PaymentGetPaymentMethods200Response, PaymentGetPaymentMethods200ResponseBuilder> {
  @BuiltValueField(wireName: r'methods')
  BuiltList<String> get methods;

  @BuiltValueField(wireName: r'message')
  PaymentGetPaymentMethods200ResponseMessageEnum get message;
  // enum messageEnum {  Payment methods feature coming soon,  };

  PaymentGetPaymentMethods200Response._();

  factory PaymentGetPaymentMethods200Response([void updates(PaymentGetPaymentMethods200ResponseBuilder b)]) = _$PaymentGetPaymentMethods200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentGetPaymentMethods200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentGetPaymentMethods200Response> get serializer => _$PaymentGetPaymentMethods200ResponseSerializer();
}

class _$PaymentGetPaymentMethods200ResponseSerializer implements PrimitiveSerializer<PaymentGetPaymentMethods200Response> {
  @override
  final Iterable<Type> types = const [PaymentGetPaymentMethods200Response, _$PaymentGetPaymentMethods200Response];

  @override
  final String wireName = r'PaymentGetPaymentMethods200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentGetPaymentMethods200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'methods';
    yield serializers.serialize(
      object.methods,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PaymentGetPaymentMethods200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentGetPaymentMethods200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentGetPaymentMethods200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'methods':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.methods.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentGetPaymentMethods200ResponseMessageEnum),
          ) as PaymentGetPaymentMethods200ResponseMessageEnum;
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
  PaymentGetPaymentMethods200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentGetPaymentMethods200ResponseBuilder();
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

class PaymentGetPaymentMethods200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Payment methods feature coming soon')
  static const PaymentGetPaymentMethods200ResponseMessageEnum paymentMethodsFeatureComingSoon = _$paymentGetPaymentMethods200ResponseMessageEnum_paymentMethodsFeatureComingSoon;

  static Serializer<PaymentGetPaymentMethods200ResponseMessageEnum> get serializer => _$paymentGetPaymentMethods200ResponseMessageEnumSerializer;

  const PaymentGetPaymentMethods200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PaymentGetPaymentMethods200ResponseMessageEnum> get values => _$paymentGetPaymentMethods200ResponseMessageEnumValues;
  static PaymentGetPaymentMethods200ResponseMessageEnum valueOf(String name) => _$paymentGetPaymentMethods200ResponseMessageEnumValueOf(name);
}

