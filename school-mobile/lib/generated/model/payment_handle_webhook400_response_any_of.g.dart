// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_handle_webhook400_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentHandleWebhook400ResponseAnyOfMessageEnum
_$paymentHandleWebhook400ResponseAnyOfMessageEnum_missingStripeSignatureHeader =
    const PaymentHandleWebhook400ResponseAnyOfMessageEnum._(
      'missingStripeSignatureHeader',
    );

PaymentHandleWebhook400ResponseAnyOfMessageEnum
_$paymentHandleWebhook400ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'missingStripeSignatureHeader':
      return _$paymentHandleWebhook400ResponseAnyOfMessageEnum_missingStripeSignatureHeader;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentHandleWebhook400ResponseAnyOfMessageEnum>
_$paymentHandleWebhook400ResponseAnyOfMessageEnumValues =
    BuiltSet<PaymentHandleWebhook400ResponseAnyOfMessageEnum>(const <
      PaymentHandleWebhook400ResponseAnyOfMessageEnum
    >[
      _$paymentHandleWebhook400ResponseAnyOfMessageEnum_missingStripeSignatureHeader,
    ]);

Serializer<PaymentHandleWebhook400ResponseAnyOfMessageEnum>
_$paymentHandleWebhook400ResponseAnyOfMessageEnumSerializer =
    _$PaymentHandleWebhook400ResponseAnyOfMessageEnumSerializer();

class _$PaymentHandleWebhook400ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<PaymentHandleWebhook400ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'missingStripeSignatureHeader': 'Missing Stripe-Signature header',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Missing Stripe-Signature header': 'missingStripeSignatureHeader',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentHandleWebhook400ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'PaymentHandleWebhook400ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentHandleWebhook400ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentHandleWebhook400ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentHandleWebhook400ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentHandleWebhook400ResponseAnyOf
    extends PaymentHandleWebhook400ResponseAnyOf {
  @override
  final PaymentHandleWebhook400ResponseAnyOfMessageEnum message;

  factory _$PaymentHandleWebhook400ResponseAnyOf([
    void Function(PaymentHandleWebhook400ResponseAnyOfBuilder)? updates,
  ]) =>
      (PaymentHandleWebhook400ResponseAnyOfBuilder()..update(updates))._build();

  _$PaymentHandleWebhook400ResponseAnyOf._({required this.message}) : super._();
  @override
  PaymentHandleWebhook400ResponseAnyOf rebuild(
    void Function(PaymentHandleWebhook400ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentHandleWebhook400ResponseAnyOfBuilder toBuilder() =>
      PaymentHandleWebhook400ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentHandleWebhook400ResponseAnyOf &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PaymentHandleWebhook400ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class PaymentHandleWebhook400ResponseAnyOfBuilder
    implements
        Builder<
          PaymentHandleWebhook400ResponseAnyOf,
          PaymentHandleWebhook400ResponseAnyOfBuilder
        > {
  _$PaymentHandleWebhook400ResponseAnyOf? _$v;

  PaymentHandleWebhook400ResponseAnyOfMessageEnum? _message;
  PaymentHandleWebhook400ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(PaymentHandleWebhook400ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  PaymentHandleWebhook400ResponseAnyOfBuilder() {
    PaymentHandleWebhook400ResponseAnyOf._defaults(this);
  }

  PaymentHandleWebhook400ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentHandleWebhook400ResponseAnyOf other) {
    _$v = other as _$PaymentHandleWebhook400ResponseAnyOf;
  }

  @override
  void update(
    void Function(PaymentHandleWebhook400ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentHandleWebhook400ResponseAnyOf build() => _build();

  _$PaymentHandleWebhook400ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$PaymentHandleWebhook400ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'PaymentHandleWebhook400ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
