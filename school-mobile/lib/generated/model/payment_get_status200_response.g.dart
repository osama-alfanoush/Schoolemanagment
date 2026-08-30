// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_get_status200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentGetStatus200Response extends PaymentGetStatus200Response {
  @override
  final String status;
  @override
  final String amount;
  @override
  final String currency;

  factory _$PaymentGetStatus200Response([
    void Function(PaymentGetStatus200ResponseBuilder)? updates,
  ]) => (PaymentGetStatus200ResponseBuilder()..update(updates))._build();

  _$PaymentGetStatus200Response._({
    required this.status,
    required this.amount,
    required this.currency,
  }) : super._();
  @override
  PaymentGetStatus200Response rebuild(
    void Function(PaymentGetStatus200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentGetStatus200ResponseBuilder toBuilder() =>
      PaymentGetStatus200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentGetStatus200Response &&
        status == other.status &&
        amount == other.amount &&
        currency == other.currency;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentGetStatus200Response')
          ..add('status', status)
          ..add('amount', amount)
          ..add('currency', currency))
        .toString();
  }
}

class PaymentGetStatus200ResponseBuilder
    implements
        Builder<
          PaymentGetStatus200Response,
          PaymentGetStatus200ResponseBuilder
        > {
  _$PaymentGetStatus200Response? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  PaymentGetStatus200ResponseBuilder() {
    PaymentGetStatus200Response._defaults(this);
  }

  PaymentGetStatus200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _amount = $v.amount;
      _currency = $v.currency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentGetStatus200Response other) {
    _$v = other as _$PaymentGetStatus200Response;
  }

  @override
  void update(void Function(PaymentGetStatus200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentGetStatus200Response build() => _build();

  _$PaymentGetStatus200Response _build() {
    final _$result =
        _$v ??
        _$PaymentGetStatus200Response._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PaymentGetStatus200Response',
            'status',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'PaymentGetStatus200Response',
            'amount',
          ),
          currency: BuiltValueNullFieldError.checkNotNull(
            currency,
            r'PaymentGetStatus200Response',
            'currency',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
