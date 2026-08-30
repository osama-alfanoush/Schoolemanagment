// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_handle_webhook200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentHandleWebhook200Response
    extends PaymentHandleWebhook200Response {
  @override
  final bool received;

  factory _$PaymentHandleWebhook200Response([
    void Function(PaymentHandleWebhook200ResponseBuilder)? updates,
  ]) => (PaymentHandleWebhook200ResponseBuilder()..update(updates))._build();

  _$PaymentHandleWebhook200Response._({required this.received}) : super._();
  @override
  PaymentHandleWebhook200Response rebuild(
    void Function(PaymentHandleWebhook200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentHandleWebhook200ResponseBuilder toBuilder() =>
      PaymentHandleWebhook200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentHandleWebhook200Response &&
        received == other.received;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, received.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PaymentHandleWebhook200Response',
    )..add('received', received)).toString();
  }
}

class PaymentHandleWebhook200ResponseBuilder
    implements
        Builder<
          PaymentHandleWebhook200Response,
          PaymentHandleWebhook200ResponseBuilder
        > {
  _$PaymentHandleWebhook200Response? _$v;

  bool? _received;
  bool? get received => _$this._received;
  set received(bool? received) => _$this._received = received;

  PaymentHandleWebhook200ResponseBuilder() {
    PaymentHandleWebhook200Response._defaults(this);
  }

  PaymentHandleWebhook200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _received = $v.received;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentHandleWebhook200Response other) {
    _$v = other as _$PaymentHandleWebhook200Response;
  }

  @override
  void update(void Function(PaymentHandleWebhook200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentHandleWebhook200Response build() => _build();

  _$PaymentHandleWebhook200Response _build() {
    final _$result =
        _$v ??
        _$PaymentHandleWebhook200Response._(
          received: BuiltValueNullFieldError.checkNotNull(
            received,
            r'PaymentHandleWebhook200Response',
            'received',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
