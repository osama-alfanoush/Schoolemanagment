// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_create_payment_intent200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentCreatePaymentIntent200Response
    extends PaymentCreatePaymentIntent200Response {
  @override
  final String clientSecret;
  @override
  final String paymentIntentId;
  @override
  final String amount;

  factory _$PaymentCreatePaymentIntent200Response([
    void Function(PaymentCreatePaymentIntent200ResponseBuilder)? updates,
  ]) => (PaymentCreatePaymentIntent200ResponseBuilder()..update(updates))
      ._build();

  _$PaymentCreatePaymentIntent200Response._({
    required this.clientSecret,
    required this.paymentIntentId,
    required this.amount,
  }) : super._();
  @override
  PaymentCreatePaymentIntent200Response rebuild(
    void Function(PaymentCreatePaymentIntent200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentCreatePaymentIntent200ResponseBuilder toBuilder() =>
      PaymentCreatePaymentIntent200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentCreatePaymentIntent200Response &&
        clientSecret == other.clientSecret &&
        paymentIntentId == other.paymentIntentId &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientSecret.hashCode);
    _$hash = $jc(_$hash, paymentIntentId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'PaymentCreatePaymentIntent200Response',
          )
          ..add('clientSecret', clientSecret)
          ..add('paymentIntentId', paymentIntentId)
          ..add('amount', amount))
        .toString();
  }
}

class PaymentCreatePaymentIntent200ResponseBuilder
    implements
        Builder<
          PaymentCreatePaymentIntent200Response,
          PaymentCreatePaymentIntent200ResponseBuilder
        > {
  _$PaymentCreatePaymentIntent200Response? _$v;

  String? _clientSecret;
  String? get clientSecret => _$this._clientSecret;
  set clientSecret(String? clientSecret) => _$this._clientSecret = clientSecret;

  String? _paymentIntentId;
  String? get paymentIntentId => _$this._paymentIntentId;
  set paymentIntentId(String? paymentIntentId) =>
      _$this._paymentIntentId = paymentIntentId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  PaymentCreatePaymentIntent200ResponseBuilder() {
    PaymentCreatePaymentIntent200Response._defaults(this);
  }

  PaymentCreatePaymentIntent200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientSecret = $v.clientSecret;
      _paymentIntentId = $v.paymentIntentId;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentCreatePaymentIntent200Response other) {
    _$v = other as _$PaymentCreatePaymentIntent200Response;
  }

  @override
  void update(
    void Function(PaymentCreatePaymentIntent200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentCreatePaymentIntent200Response build() => _build();

  _$PaymentCreatePaymentIntent200Response _build() {
    final _$result =
        _$v ??
        _$PaymentCreatePaymentIntent200Response._(
          clientSecret: BuiltValueNullFieldError.checkNotNull(
            clientSecret,
            r'PaymentCreatePaymentIntent200Response',
            'clientSecret',
          ),
          paymentIntentId: BuiltValueNullFieldError.checkNotNull(
            paymentIntentId,
            r'PaymentCreatePaymentIntent200Response',
            'paymentIntentId',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'PaymentCreatePaymentIntent200Response',
            'amount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
