// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_confirm_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentConfirmPaymentRequest extends PaymentConfirmPaymentRequest {
  @override
  final String paymentIntentId;

  factory _$PaymentConfirmPaymentRequest([
    void Function(PaymentConfirmPaymentRequestBuilder)? updates,
  ]) => (PaymentConfirmPaymentRequestBuilder()..update(updates))._build();

  _$PaymentConfirmPaymentRequest._({required this.paymentIntentId}) : super._();
  @override
  PaymentConfirmPaymentRequest rebuild(
    void Function(PaymentConfirmPaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentConfirmPaymentRequestBuilder toBuilder() =>
      PaymentConfirmPaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentConfirmPaymentRequest &&
        paymentIntentId == other.paymentIntentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentIntentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PaymentConfirmPaymentRequest',
    )..add('paymentIntentId', paymentIntentId)).toString();
  }
}

class PaymentConfirmPaymentRequestBuilder
    implements
        Builder<
          PaymentConfirmPaymentRequest,
          PaymentConfirmPaymentRequestBuilder
        > {
  _$PaymentConfirmPaymentRequest? _$v;

  String? _paymentIntentId;
  String? get paymentIntentId => _$this._paymentIntentId;
  set paymentIntentId(String? paymentIntentId) =>
      _$this._paymentIntentId = paymentIntentId;

  PaymentConfirmPaymentRequestBuilder() {
    PaymentConfirmPaymentRequest._defaults(this);
  }

  PaymentConfirmPaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentIntentId = $v.paymentIntentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentConfirmPaymentRequest other) {
    _$v = other as _$PaymentConfirmPaymentRequest;
  }

  @override
  void update(void Function(PaymentConfirmPaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentConfirmPaymentRequest build() => _build();

  _$PaymentConfirmPaymentRequest _build() {
    final _$result =
        _$v ??
        _$PaymentConfirmPaymentRequest._(
          paymentIntentId: BuiltValueNullFieldError.checkNotNull(
            paymentIntentId,
            r'PaymentConfirmPaymentRequest',
            'paymentIntentId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
