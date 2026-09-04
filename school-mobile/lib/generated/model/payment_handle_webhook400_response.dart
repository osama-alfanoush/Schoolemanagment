//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_store_journal_entry285422_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/payment_handle_webhook400_response_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'payment_handle_webhook400_response.g.dart';

/// PaymentHandleWebhook400Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class PaymentHandleWebhook400Response implements Built<PaymentHandleWebhook400Response, PaymentHandleWebhook400ResponseBuilder> {
  /// Any Of [AccountingStoreJournalEntry285422Response], [PaymentHandleWebhook400ResponseAnyOf]
  AnyOf get anyOf;

  PaymentHandleWebhook400Response._();

  factory PaymentHandleWebhook400Response([void updates(PaymentHandleWebhook400ResponseBuilder b)]) = _$PaymentHandleWebhook400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentHandleWebhook400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentHandleWebhook400Response> get serializer => _$PaymentHandleWebhook400ResponseSerializer();
}

class _$PaymentHandleWebhook400ResponseSerializer implements PrimitiveSerializer<PaymentHandleWebhook400Response> {
  @override
  final Iterable<Type> types = const [PaymentHandleWebhook400Response, _$PaymentHandleWebhook400Response];

  @override
  final String wireName = r'PaymentHandleWebhook400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaymentHandleWebhook400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    PaymentHandleWebhook400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  PaymentHandleWebhook400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaymentHandleWebhook400ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(AccountingStoreJournalEntry285422Response), FullType(PaymentHandleWebhook400ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class PaymentHandleWebhook400ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Missing Stripe-Signature header')
  static const PaymentHandleWebhook400ResponseMessageEnum missingStripeSignatureHeader = _$paymentHandleWebhook400ResponseMessageEnum_missingStripeSignatureHeader;

  static Serializer<PaymentHandleWebhook400ResponseMessageEnum> get serializer => _$paymentHandleWebhook400ResponseMessageEnumSerializer;

  const PaymentHandleWebhook400ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PaymentHandleWebhook400ResponseMessageEnum> get values => _$paymentHandleWebhook400ResponseMessageEnumValues;
  static PaymentHandleWebhook400ResponseMessageEnum valueOf(String name) => _$paymentHandleWebhook400ResponseMessageEnumValueOf(name);
}

