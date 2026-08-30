// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_pay_installment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InstallmentPayInstallmentRequestMethodEnum
_$installmentPayInstallmentRequestMethodEnum_cash =
    const InstallmentPayInstallmentRequestMethodEnum._('cash');
const InstallmentPayInstallmentRequestMethodEnum
_$installmentPayInstallmentRequestMethodEnum_bankTransfer =
    const InstallmentPayInstallmentRequestMethodEnum._('bankTransfer');
const InstallmentPayInstallmentRequestMethodEnum
_$installmentPayInstallmentRequestMethodEnum_card =
    const InstallmentPayInstallmentRequestMethodEnum._('card');
const InstallmentPayInstallmentRequestMethodEnum
_$installmentPayInstallmentRequestMethodEnum_online =
    const InstallmentPayInstallmentRequestMethodEnum._('online');

InstallmentPayInstallmentRequestMethodEnum
_$installmentPayInstallmentRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$installmentPayInstallmentRequestMethodEnum_cash;
    case 'bankTransfer':
      return _$installmentPayInstallmentRequestMethodEnum_bankTransfer;
    case 'card':
      return _$installmentPayInstallmentRequestMethodEnum_card;
    case 'online':
      return _$installmentPayInstallmentRequestMethodEnum_online;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InstallmentPayInstallmentRequestMethodEnum>
_$installmentPayInstallmentRequestMethodEnumValues =
    BuiltSet<InstallmentPayInstallmentRequestMethodEnum>(
      const <InstallmentPayInstallmentRequestMethodEnum>[
        _$installmentPayInstallmentRequestMethodEnum_cash,
        _$installmentPayInstallmentRequestMethodEnum_bankTransfer,
        _$installmentPayInstallmentRequestMethodEnum_card,
        _$installmentPayInstallmentRequestMethodEnum_online,
      ],
    );

Serializer<InstallmentPayInstallmentRequestMethodEnum>
_$installmentPayInstallmentRequestMethodEnumSerializer =
    _$InstallmentPayInstallmentRequestMethodEnumSerializer();

class _$InstallmentPayInstallmentRequestMethodEnumSerializer
    implements PrimitiveSerializer<InstallmentPayInstallmentRequestMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cash': 'cash',
    'bankTransfer': 'bank_transfer',
    'card': 'card',
    'online': 'online',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cash': 'cash',
    'bank_transfer': 'bankTransfer',
    'card': 'card',
    'online': 'online',
  };

  @override
  final Iterable<Type> types = const <Type>[
    InstallmentPayInstallmentRequestMethodEnum,
  ];
  @override
  final String wireName = 'InstallmentPayInstallmentRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    InstallmentPayInstallmentRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InstallmentPayInstallmentRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InstallmentPayInstallmentRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InstallmentPayInstallmentRequest
    extends InstallmentPayInstallmentRequest {
  @override
  final num amount;
  @override
  final InstallmentPayInstallmentRequestMethodEnum method;
  @override
  final String? reference;
  @override
  final String? note;

  factory _$InstallmentPayInstallmentRequest([
    void Function(InstallmentPayInstallmentRequestBuilder)? updates,
  ]) => (InstallmentPayInstallmentRequestBuilder()..update(updates))._build();

  _$InstallmentPayInstallmentRequest._({
    required this.amount,
    required this.method,
    this.reference,
    this.note,
  }) : super._();
  @override
  InstallmentPayInstallmentRequest rebuild(
    void Function(InstallmentPayInstallmentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallmentPayInstallmentRequestBuilder toBuilder() =>
      InstallmentPayInstallmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallmentPayInstallmentRequest &&
        amount == other.amount &&
        method == other.method &&
        reference == other.reference &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InstallmentPayInstallmentRequest')
          ..add('amount', amount)
          ..add('method', method)
          ..add('reference', reference)
          ..add('note', note))
        .toString();
  }
}

class InstallmentPayInstallmentRequestBuilder
    implements
        Builder<
          InstallmentPayInstallmentRequest,
          InstallmentPayInstallmentRequestBuilder
        > {
  _$InstallmentPayInstallmentRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  InstallmentPayInstallmentRequestMethodEnum? _method;
  InstallmentPayInstallmentRequestMethodEnum? get method => _$this._method;
  set method(InstallmentPayInstallmentRequestMethodEnum? method) =>
      _$this._method = method;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  InstallmentPayInstallmentRequestBuilder() {
    InstallmentPayInstallmentRequest._defaults(this);
  }

  InstallmentPayInstallmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _method = $v.method;
      _reference = $v.reference;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallmentPayInstallmentRequest other) {
    _$v = other as _$InstallmentPayInstallmentRequest;
  }

  @override
  void update(void Function(InstallmentPayInstallmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InstallmentPayInstallmentRequest build() => _build();

  _$InstallmentPayInstallmentRequest _build() {
    final _$result =
        _$v ??
        _$InstallmentPayInstallmentRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'InstallmentPayInstallmentRequest',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'InstallmentPayInstallmentRequest',
            'method',
          ),
          reference: reference,
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
