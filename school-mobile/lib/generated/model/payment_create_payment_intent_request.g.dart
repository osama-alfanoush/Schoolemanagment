// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_create_payment_intent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentCreatePaymentIntentRequest
    extends PaymentCreatePaymentIntentRequest {
  @override
  final int invoiceId;
  @override
  final String? currency;
  @override
  final String idempotencyKey;

  factory _$PaymentCreatePaymentIntentRequest([
    void Function(PaymentCreatePaymentIntentRequestBuilder)? updates,
  ]) => (PaymentCreatePaymentIntentRequestBuilder()..update(updates))._build();

  _$PaymentCreatePaymentIntentRequest._({
    required this.invoiceId,
    this.currency,
    required this.idempotencyKey,
  }) : super._();
  @override
  PaymentCreatePaymentIntentRequest rebuild(
    void Function(PaymentCreatePaymentIntentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentCreatePaymentIntentRequestBuilder toBuilder() =>
      PaymentCreatePaymentIntentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentCreatePaymentIntentRequest &&
        invoiceId == other.invoiceId &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentCreatePaymentIntentRequest')
          ..add('invoiceId', invoiceId)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class PaymentCreatePaymentIntentRequestBuilder
    implements
        Builder<
          PaymentCreatePaymentIntentRequest,
          PaymentCreatePaymentIntentRequestBuilder
        > {
  _$PaymentCreatePaymentIntentRequest? _$v;

  int? _invoiceId;
  int? get invoiceId => _$this._invoiceId;
  set invoiceId(int? invoiceId) => _$this._invoiceId = invoiceId;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  PaymentCreatePaymentIntentRequestBuilder() {
    PaymentCreatePaymentIntentRequest._defaults(this);
  }

  PaymentCreatePaymentIntentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoiceId = $v.invoiceId;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentCreatePaymentIntentRequest other) {
    _$v = other as _$PaymentCreatePaymentIntentRequest;
  }

  @override
  void update(
    void Function(PaymentCreatePaymentIntentRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentCreatePaymentIntentRequest build() => _build();

  _$PaymentCreatePaymentIntentRequest _build() {
    final _$result =
        _$v ??
        _$PaymentCreatePaymentIntentRequest._(
          invoiceId: BuiltValueNullFieldError.checkNotNull(
            invoiceId,
            r'PaymentCreatePaymentIntentRequest',
            'invoiceId',
          ),
          currency: currency,
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'PaymentCreatePaymentIntentRequest',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
