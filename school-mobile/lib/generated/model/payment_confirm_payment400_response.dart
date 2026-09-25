//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_confirm_payment400_response.g.dart';

/// PaymentConfirmPayment400Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class PaymentConfirmPayment400Response implements Built<PaymentConfirmPayment400Response, PaymentConfirmPayment400ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  JsonObject? get message;

  PaymentConfirmPayment400Response._();

  factory PaymentConfirmPayment400Response([void updates(PaymentConfirmPayment400ResponseBuilder b)]) = _$PaymentConfirmPayment400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentConfirmPayment400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentConfirmPayment400Response> get serializer => _$PaymentConfirmPayment400ResponseSerializer();
}

class _$PaymentConfirmPayment400ResponseSerializer implements PrimitiveSerializer<PaymentConfirmPayment400Response> {
  @override
  final Iterable<Type> types = const [PaymentConfirmPayment400Response, _$PaymentConfirmPayment400Response];

  @override
  final String wireName = r'PaymentConfirmPayment400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentConfirmPayment400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield object.message == null ? null : serializers.serialize(
      object.message,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentConfirmPayment400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentConfirmPayment400ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
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
  PaymentConfirmPayment400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentConfirmPayment400ResponseBuilder();
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

