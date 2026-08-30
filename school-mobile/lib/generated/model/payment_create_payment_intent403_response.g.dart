// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_create_payment_intent403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentCreatePaymentIntent403ResponseMessageEnum
_$paymentCreatePaymentIntent403ResponseMessageEnum_unauthorized =
    const PaymentCreatePaymentIntent403ResponseMessageEnum._('unauthorized');

PaymentCreatePaymentIntent403ResponseMessageEnum
_$paymentCreatePaymentIntent403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'unauthorized':
      return _$paymentCreatePaymentIntent403ResponseMessageEnum_unauthorized;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentCreatePaymentIntent403ResponseMessageEnum>
_$paymentCreatePaymentIntent403ResponseMessageEnumValues =
    BuiltSet<PaymentCreatePaymentIntent403ResponseMessageEnum>(
      const <PaymentCreatePaymentIntent403ResponseMessageEnum>[
        _$paymentCreatePaymentIntent403ResponseMessageEnum_unauthorized,
      ],
    );

Serializer<PaymentCreatePaymentIntent403ResponseMessageEnum>
_$paymentCreatePaymentIntent403ResponseMessageEnumSerializer =
    _$PaymentCreatePaymentIntent403ResponseMessageEnumSerializer();

class _$PaymentCreatePaymentIntent403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<PaymentCreatePaymentIntent403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unauthorized': 'Unauthorized',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unauthorized': 'unauthorized',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentCreatePaymentIntent403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PaymentCreatePaymentIntent403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreatePaymentIntent403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentCreatePaymentIntent403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentCreatePaymentIntent403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentCreatePaymentIntent403Response
    extends PaymentCreatePaymentIntent403Response {
  @override
  final PaymentCreatePaymentIntent403ResponseMessageEnum message;

  factory _$PaymentCreatePaymentIntent403Response([
    void Function(PaymentCreatePaymentIntent403ResponseBuilder)? updates,
  ]) => (PaymentCreatePaymentIntent403ResponseBuilder()..update(updates))
      ._build();

  _$PaymentCreatePaymentIntent403Response._({required this.message})
    : super._();
  @override
  PaymentCreatePaymentIntent403Response rebuild(
    void Function(PaymentCreatePaymentIntent403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentCreatePaymentIntent403ResponseBuilder toBuilder() =>
      PaymentCreatePaymentIntent403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentCreatePaymentIntent403Response &&
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
      r'PaymentCreatePaymentIntent403Response',
    )..add('message', message)).toString();
  }
}

class PaymentCreatePaymentIntent403ResponseBuilder
    implements
        Builder<
          PaymentCreatePaymentIntent403Response,
          PaymentCreatePaymentIntent403ResponseBuilder
        > {
  _$PaymentCreatePaymentIntent403Response? _$v;

  PaymentCreatePaymentIntent403ResponseMessageEnum? _message;
  PaymentCreatePaymentIntent403ResponseMessageEnum? get message =>
      _$this._message;
  set message(PaymentCreatePaymentIntent403ResponseMessageEnum? message) =>
      _$this._message = message;

  PaymentCreatePaymentIntent403ResponseBuilder() {
    PaymentCreatePaymentIntent403Response._defaults(this);
  }

  PaymentCreatePaymentIntent403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentCreatePaymentIntent403Response other) {
    _$v = other as _$PaymentCreatePaymentIntent403Response;
  }

  @override
  void update(
    void Function(PaymentCreatePaymentIntent403ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentCreatePaymentIntent403Response build() => _build();

  _$PaymentCreatePaymentIntent403Response _build() {
    final _$result =
        _$v ??
        _$PaymentCreatePaymentIntent403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'PaymentCreatePaymentIntent403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
