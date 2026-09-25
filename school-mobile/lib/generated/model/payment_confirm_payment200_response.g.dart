// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_confirm_payment200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentConfirmPayment200ResponseMessageEnum
_$paymentConfirmPayment200ResponseMessageEnum_paymentConfirmed =
    const PaymentConfirmPayment200ResponseMessageEnum._('paymentConfirmed');

PaymentConfirmPayment200ResponseMessageEnum
_$paymentConfirmPayment200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'paymentConfirmed':
      return _$paymentConfirmPayment200ResponseMessageEnum_paymentConfirmed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentConfirmPayment200ResponseMessageEnum>
_$paymentConfirmPayment200ResponseMessageEnumValues =
    BuiltSet<PaymentConfirmPayment200ResponseMessageEnum>(
      const <PaymentConfirmPayment200ResponseMessageEnum>[
        _$paymentConfirmPayment200ResponseMessageEnum_paymentConfirmed,
      ],
    );

Serializer<PaymentConfirmPayment200ResponseMessageEnum>
_$paymentConfirmPayment200ResponseMessageEnumSerializer =
    _$PaymentConfirmPayment200ResponseMessageEnumSerializer();

class _$PaymentConfirmPayment200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<PaymentConfirmPayment200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'paymentConfirmed': 'Payment confirmed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Payment confirmed': 'paymentConfirmed',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentConfirmPayment200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PaymentConfirmPayment200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentConfirmPayment200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentConfirmPayment200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentConfirmPayment200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentConfirmPayment200Response
    extends PaymentConfirmPayment200Response {
  @override
  final PaymentConfirmPayment200ResponseMessageEnum message;
  @override
  final JsonObject? payment;
  @override
  final JsonObject? alreadyRecorded;

  factory _$PaymentConfirmPayment200Response([
    void Function(PaymentConfirmPayment200ResponseBuilder)? updates,
  ]) => (PaymentConfirmPayment200ResponseBuilder()..update(updates))._build();

  _$PaymentConfirmPayment200Response._({
    required this.message,
    this.payment,
    this.alreadyRecorded,
  }) : super._();
  @override
  PaymentConfirmPayment200Response rebuild(
    void Function(PaymentConfirmPayment200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentConfirmPayment200ResponseBuilder toBuilder() =>
      PaymentConfirmPayment200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentConfirmPayment200Response &&
        message == other.message &&
        payment == other.payment &&
        alreadyRecorded == other.alreadyRecorded;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, payment.hashCode);
    _$hash = $jc(_$hash, alreadyRecorded.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentConfirmPayment200Response')
          ..add('message', message)
          ..add('payment', payment)
          ..add('alreadyRecorded', alreadyRecorded))
        .toString();
  }
}

class PaymentConfirmPayment200ResponseBuilder
    implements
        Builder<
          PaymentConfirmPayment200Response,
          PaymentConfirmPayment200ResponseBuilder
        > {
  _$PaymentConfirmPayment200Response? _$v;

  PaymentConfirmPayment200ResponseMessageEnum? _message;
  PaymentConfirmPayment200ResponseMessageEnum? get message => _$this._message;
  set message(PaymentConfirmPayment200ResponseMessageEnum? message) =>
      _$this._message = message;

  JsonObject? _payment;
  JsonObject? get payment => _$this._payment;
  set payment(JsonObject? payment) => _$this._payment = payment;

  JsonObject? _alreadyRecorded;
  JsonObject? get alreadyRecorded => _$this._alreadyRecorded;
  set alreadyRecorded(JsonObject? alreadyRecorded) =>
      _$this._alreadyRecorded = alreadyRecorded;

  PaymentConfirmPayment200ResponseBuilder() {
    PaymentConfirmPayment200Response._defaults(this);
  }

  PaymentConfirmPayment200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _payment = $v.payment;
      _alreadyRecorded = $v.alreadyRecorded;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentConfirmPayment200Response other) {
    _$v = other as _$PaymentConfirmPayment200Response;
  }

  @override
  void update(void Function(PaymentConfirmPayment200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentConfirmPayment200Response build() => _build();

  _$PaymentConfirmPayment200Response _build() {
    final _$result =
        _$v ??
        _$PaymentConfirmPayment200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'PaymentConfirmPayment200Response',
            'message',
          ),
          payment: payment,
          alreadyRecorded: alreadyRecorded,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
