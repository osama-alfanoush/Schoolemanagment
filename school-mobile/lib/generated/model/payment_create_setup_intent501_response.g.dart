// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_create_setup_intent501_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentCreateSetupIntent501ResponseMessageEnum
_$paymentCreateSetupIntent501ResponseMessageEnum_setupIntentFeatureComingSoon =
    const PaymentCreateSetupIntent501ResponseMessageEnum._(
      'setupIntentFeatureComingSoon',
    );

PaymentCreateSetupIntent501ResponseMessageEnum
_$paymentCreateSetupIntent501ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'setupIntentFeatureComingSoon':
      return _$paymentCreateSetupIntent501ResponseMessageEnum_setupIntentFeatureComingSoon;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentCreateSetupIntent501ResponseMessageEnum>
_$paymentCreateSetupIntent501ResponseMessageEnumValues =
    BuiltSet<PaymentCreateSetupIntent501ResponseMessageEnum>(const <
      PaymentCreateSetupIntent501ResponseMessageEnum
    >[
      _$paymentCreateSetupIntent501ResponseMessageEnum_setupIntentFeatureComingSoon,
    ]);

Serializer<PaymentCreateSetupIntent501ResponseMessageEnum>
_$paymentCreateSetupIntent501ResponseMessageEnumSerializer =
    _$PaymentCreateSetupIntent501ResponseMessageEnumSerializer();

class _$PaymentCreateSetupIntent501ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<PaymentCreateSetupIntent501ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'setupIntentFeatureComingSoon': 'Setup intent feature coming soon',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Setup intent feature coming soon': 'setupIntentFeatureComingSoon',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentCreateSetupIntent501ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PaymentCreateSetupIntent501ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentCreateSetupIntent501ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentCreateSetupIntent501ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentCreateSetupIntent501ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentCreateSetupIntent501Response
    extends PaymentCreateSetupIntent501Response {
  @override
  final PaymentCreateSetupIntent501ResponseMessageEnum message;

  factory _$PaymentCreateSetupIntent501Response([
    void Function(PaymentCreateSetupIntent501ResponseBuilder)? updates,
  ]) =>
      (PaymentCreateSetupIntent501ResponseBuilder()..update(updates))._build();

  _$PaymentCreateSetupIntent501Response._({required this.message}) : super._();
  @override
  PaymentCreateSetupIntent501Response rebuild(
    void Function(PaymentCreateSetupIntent501ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentCreateSetupIntent501ResponseBuilder toBuilder() =>
      PaymentCreateSetupIntent501ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentCreateSetupIntent501Response &&
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
      r'PaymentCreateSetupIntent501Response',
    )..add('message', message)).toString();
  }
}

class PaymentCreateSetupIntent501ResponseBuilder
    implements
        Builder<
          PaymentCreateSetupIntent501Response,
          PaymentCreateSetupIntent501ResponseBuilder
        > {
  _$PaymentCreateSetupIntent501Response? _$v;

  PaymentCreateSetupIntent501ResponseMessageEnum? _message;
  PaymentCreateSetupIntent501ResponseMessageEnum? get message =>
      _$this._message;
  set message(PaymentCreateSetupIntent501ResponseMessageEnum? message) =>
      _$this._message = message;

  PaymentCreateSetupIntent501ResponseBuilder() {
    PaymentCreateSetupIntent501Response._defaults(this);
  }

  PaymentCreateSetupIntent501ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentCreateSetupIntent501Response other) {
    _$v = other as _$PaymentCreateSetupIntent501Response;
  }

  @override
  void update(
    void Function(PaymentCreateSetupIntent501ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentCreateSetupIntent501Response build() => _build();

  _$PaymentCreateSetupIntent501Response _build() {
    final _$result =
        _$v ??
        _$PaymentCreateSetupIntent501Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'PaymentCreateSetupIntent501Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
