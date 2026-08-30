// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_get_payment_methods200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentGetPaymentMethods200ResponseMessageEnum
_$paymentGetPaymentMethods200ResponseMessageEnum_paymentMethodsFeatureComingSoon =
    const PaymentGetPaymentMethods200ResponseMessageEnum._(
      'paymentMethodsFeatureComingSoon',
    );

PaymentGetPaymentMethods200ResponseMessageEnum
_$paymentGetPaymentMethods200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'paymentMethodsFeatureComingSoon':
      return _$paymentGetPaymentMethods200ResponseMessageEnum_paymentMethodsFeatureComingSoon;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentGetPaymentMethods200ResponseMessageEnum>
_$paymentGetPaymentMethods200ResponseMessageEnumValues =
    BuiltSet<PaymentGetPaymentMethods200ResponseMessageEnum>(const <
      PaymentGetPaymentMethods200ResponseMessageEnum
    >[
      _$paymentGetPaymentMethods200ResponseMessageEnum_paymentMethodsFeatureComingSoon,
    ]);

Serializer<PaymentGetPaymentMethods200ResponseMessageEnum>
_$paymentGetPaymentMethods200ResponseMessageEnumSerializer =
    _$PaymentGetPaymentMethods200ResponseMessageEnumSerializer();

class _$PaymentGetPaymentMethods200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<PaymentGetPaymentMethods200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'paymentMethodsFeatureComingSoon': 'Payment methods feature coming soon',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Payment methods feature coming soon': 'paymentMethodsFeatureComingSoon',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PaymentGetPaymentMethods200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'PaymentGetPaymentMethods200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    PaymentGetPaymentMethods200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PaymentGetPaymentMethods200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PaymentGetPaymentMethods200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PaymentGetPaymentMethods200Response
    extends PaymentGetPaymentMethods200Response {
  @override
  final BuiltList<String> methods;
  @override
  final PaymentGetPaymentMethods200ResponseMessageEnum message;

  factory _$PaymentGetPaymentMethods200Response([
    void Function(PaymentGetPaymentMethods200ResponseBuilder)? updates,
  ]) =>
      (PaymentGetPaymentMethods200ResponseBuilder()..update(updates))._build();

  _$PaymentGetPaymentMethods200Response._({
    required this.methods,
    required this.message,
  }) : super._();
  @override
  PaymentGetPaymentMethods200Response rebuild(
    void Function(PaymentGetPaymentMethods200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaymentGetPaymentMethods200ResponseBuilder toBuilder() =>
      PaymentGetPaymentMethods200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentGetPaymentMethods200Response &&
        methods == other.methods &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, methods.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentGetPaymentMethods200Response')
          ..add('methods', methods)
          ..add('message', message))
        .toString();
  }
}

class PaymentGetPaymentMethods200ResponseBuilder
    implements
        Builder<
          PaymentGetPaymentMethods200Response,
          PaymentGetPaymentMethods200ResponseBuilder
        > {
  _$PaymentGetPaymentMethods200Response? _$v;

  ListBuilder<String>? _methods;
  ListBuilder<String> get methods => _$this._methods ??= ListBuilder<String>();
  set methods(ListBuilder<String>? methods) => _$this._methods = methods;

  PaymentGetPaymentMethods200ResponseMessageEnum? _message;
  PaymentGetPaymentMethods200ResponseMessageEnum? get message =>
      _$this._message;
  set message(PaymentGetPaymentMethods200ResponseMessageEnum? message) =>
      _$this._message = message;

  PaymentGetPaymentMethods200ResponseBuilder() {
    PaymentGetPaymentMethods200Response._defaults(this);
  }

  PaymentGetPaymentMethods200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _methods = $v.methods.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentGetPaymentMethods200Response other) {
    _$v = other as _$PaymentGetPaymentMethods200Response;
  }

  @override
  void update(
    void Function(PaymentGetPaymentMethods200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PaymentGetPaymentMethods200Response build() => _build();

  _$PaymentGetPaymentMethods200Response _build() {
    _$PaymentGetPaymentMethods200Response _$result;
    try {
      _$result =
          _$v ??
          _$PaymentGetPaymentMethods200Response._(
            methods: methods.build(),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'PaymentGetPaymentMethods200Response',
              'message',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'methods';
        methods.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PaymentGetPaymentMethods200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
