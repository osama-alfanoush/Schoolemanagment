//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_create_setup_intent501_response.g.dart';

/// PaymentCreateSetupIntent501Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class PaymentCreateSetupIntent501Response implements Built<PaymentCreateSetupIntent501Response, PaymentCreateSetupIntent501ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  PaymentCreateSetupIntent501ResponseMessageEnum get message;
  // enum messageEnum {  Setup intent feature coming soon,  };

  PaymentCreateSetupIntent501Response._();

  factory PaymentCreateSetupIntent501Response([void updates(PaymentCreateSetupIntent501ResponseBuilder b)]) = _$PaymentCreateSetupIntent501Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentCreateSetupIntent501ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentCreateSetupIntent501Response> get serializer => _$PaymentCreateSetupIntent501ResponseSerializer();
}

class _$PaymentCreateSetupIntent501ResponseSerializer implements PrimitiveSerializer<PaymentCreateSetupIntent501Response> {
  @override
  final Iterable<Type> types = const [PaymentCreateSetupIntent501Response, _$PaymentCreateSetupIntent501Response];

  @override
  final String wireName = r'PaymentCreateSetupIntent501Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentCreateSetupIntent501Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PaymentCreateSetupIntent501ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreateSetupIntent501Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentCreateSetupIntent501ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PaymentCreateSetupIntent501ResponseMessageEnum),
          ) as PaymentCreateSetupIntent501ResponseMessageEnum;
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
  PaymentCreateSetupIntent501Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentCreateSetupIntent501ResponseBuilder();
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

class PaymentCreateSetupIntent501ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Setup intent feature coming soon')
  static const PaymentCreateSetupIntent501ResponseMessageEnum setupIntentFeatureComingSoon = _$paymentCreateSetupIntent501ResponseMessageEnum_setupIntentFeatureComingSoon;

  static Serializer<PaymentCreateSetupIntent501ResponseMessageEnum> get serializer => _$paymentCreateSetupIntent501ResponseMessageEnumSerializer;

  const PaymentCreateSetupIntent501ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PaymentCreateSetupIntent501ResponseMessageEnum> get values => _$paymentCreateSetupIntent501ResponseMessageEnumValues;
  static PaymentCreateSetupIntent501ResponseMessageEnum valueOf(String name) => _$paymentCreateSetupIntent501ResponseMessageEnumValueOf(name);
}

