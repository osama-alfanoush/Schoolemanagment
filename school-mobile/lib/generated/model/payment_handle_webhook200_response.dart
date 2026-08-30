//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_handle_webhook200_response.g.dart';

/// PaymentHandleWebhook200Response
///
/// Properties:
/// * [received] 
@BuiltValue()
abstract class PaymentHandleWebhook200Response implements Built<PaymentHandleWebhook200Response, PaymentHandleWebhook200ResponseBuilder> {
  @BuiltValueField(wireName: r'received')
  bool get received;

  PaymentHandleWebhook200Response._();

  factory PaymentHandleWebhook200Response([void updates(PaymentHandleWebhook200ResponseBuilder b)]) = _$PaymentHandleWebhook200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentHandleWebhook200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentHandleWebhook200Response> get serializer => _$PaymentHandleWebhook200ResponseSerializer();
}

class _$PaymentHandleWebhook200ResponseSerializer implements PrimitiveSerializer<PaymentHandleWebhook200Response> {
  @override
  final Iterable<Type> types = const [PaymentHandleWebhook200Response, _$PaymentHandleWebhook200Response];

  @override
  final String wireName = r'PaymentHandleWebhook200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentHandleWebhook200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'received';
    yield serializers.serialize(
      object.received,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentHandleWebhook200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PaymentHandleWebhook200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.received = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PaymentHandleWebhook200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentHandleWebhook200ResponseBuilder();
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

