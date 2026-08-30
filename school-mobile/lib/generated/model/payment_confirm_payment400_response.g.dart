// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_confirm_payment400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentConfirmPayment400Response
    extends PaymentConfirmPayment400Response {
  @override
  final JsonObject? message;

  factory _$PaymentConfirmPayment400Response([
    void Function(PaymentConfirmPayment400ResponseBuilder)? updates,
  ]) => (PaymentConfirmPayment400ResponseBuilder()..update(updates))._build();

  _$PaymentConfirmPayment400Response._({this.message}) : super._();
  @override
  PaymentConfirmPayment400Response rebuild(
    void Function(PaymentConfirmPayment400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentConfirmPayment400ResponseBuilder toBuilder() =>
      PaymentConfirmPayment400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentConfirmPayment400Response &&
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
      r'PaymentConfirmPayment400Response',
    )..add('message', message)).toString();
  }
}

class PaymentConfirmPayment400ResponseBuilder
    implements
        Builder<
          PaymentConfirmPayment400Response,
          PaymentConfirmPayment400ResponseBuilder
        > {
  _$PaymentConfirmPayment400Response? _$v;

  JsonObject? _message;
  JsonObject? get message => _$this._message;
  set message(JsonObject? message) => _$this._message = message;

  PaymentConfirmPayment400ResponseBuilder() {
    PaymentConfirmPayment400Response._defaults(this);
  }

  PaymentConfirmPayment400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentConfirmPayment400Response other) {
    _$v = other as _$PaymentConfirmPayment400Response;
  }

  @override
  void update(void Function(PaymentConfirmPayment400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentConfirmPayment400Response build() => _build();

  _$PaymentConfirmPayment400Response _build() {
    final _$result =
        _$v ?? _$PaymentConfirmPayment400Response._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
