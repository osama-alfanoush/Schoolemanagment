// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_handle_webhook400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentHandleWebhook400ResponseMessageEnum
_$paymentHandleWebhook400ResponseMessageEnum_missingStripeSignatureHeader =
    const PaymentHandleWebhook400ResponseMessageEnum._(
      'missingStripeSignatureHeader',
    );

PaymentHandleWebhook400ResponseMessageEnum
_$paymentHandleWebhook400ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'missingStripeSignatureHeader':
      return _$paymentHandleWebhook400ResponseMessageEnum_missingStripeSignatureHeader;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentHandleWebhook400ResponseMessageEnum>
_$paymentHandleWebhook400ResponseMessageEnumValues =
    BuiltSet<PaymentHandleWebhook400ResponseMessageEnum>(const <
      PaymentHandleWebhook400ResponseMessageEnum
    >[
      _$paymentHandleWebhook400ResponseMessageEnum_missingStripeSignatureHeader,
    ]);

Serializer<PaymentHandleWebhook400ResponseMessageEnum>
_$paymentHandleWebhook400ResponseMessageEnumSerializer =
    _$PaymentHandleWebhook400ResponseMessageEnumSerializer();

class _$PaymentHandleWebhook400ResponseMessageEnumSerializer
    implements PrimitiveSerializer<PaymentHandleWebhook400ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'missingStripeSignatureHeader': 'Missing Stripe-Signature header',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Missing Stripe-Signature header': 'missingStripeSignatureHeader',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentHandleWebhook400ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PaymentHandleWebhook400ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentHandleWebhook400ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentHandleWebhook400ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentHandleWebhook400ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentHandleWebhook400Response
    extends PaymentHandleWebhook400Response {
  @override
  final AnyOf anyOf;

  factory _$PaymentHandleWebhook400Response([
    void Function(PaymentHandleWebhook400ResponseBuilder)? updates,
  ]) => (PaymentHandleWebhook400ResponseBuilder()..update(updates))._build();

  _$PaymentHandleWebhook400Response._({required this.anyOf}) : super._();
  @override
  PaymentHandleWebhook400Response rebuild(
    void Function(PaymentHandleWebhook400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentHandleWebhook400ResponseBuilder toBuilder() =>
      PaymentHandleWebhook400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentHandleWebhook400Response && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PaymentHandleWebhook400Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class PaymentHandleWebhook400ResponseBuilder
    implements
        Builder<
          PaymentHandleWebhook400Response,
          PaymentHandleWebhook400ResponseBuilder
        > {
  _$PaymentHandleWebhook400Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  PaymentHandleWebhook400ResponseBuilder() {
    PaymentHandleWebhook400Response._defaults(this);
  }

  PaymentHandleWebhook400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentHandleWebhook400Response other) {
    _$v = other as _$PaymentHandleWebhook400Response;
  }

  @override
  void update(void Function(PaymentHandleWebhook400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentHandleWebhook400Response build() => _build();

  _$PaymentHandleWebhook400Response _build() {
    final _$result =
        _$v ??
        _$PaymentHandleWebhook400Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'PaymentHandleWebhook400Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
