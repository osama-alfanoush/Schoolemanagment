// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_record_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceRecordPaymentRequestMethodEnum
_$financeRecordPaymentRequestMethodEnum_cash =
    const FinanceRecordPaymentRequestMethodEnum._('cash');
const FinanceRecordPaymentRequestMethodEnum
_$financeRecordPaymentRequestMethodEnum_bankTransfer =
    const FinanceRecordPaymentRequestMethodEnum._('bankTransfer');
const FinanceRecordPaymentRequestMethodEnum
_$financeRecordPaymentRequestMethodEnum_card =
    const FinanceRecordPaymentRequestMethodEnum._('card');
const FinanceRecordPaymentRequestMethodEnum
_$financeRecordPaymentRequestMethodEnum_online =
    const FinanceRecordPaymentRequestMethodEnum._('online');

FinanceRecordPaymentRequestMethodEnum
_$financeRecordPaymentRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$financeRecordPaymentRequestMethodEnum_cash;
    case 'bankTransfer':
      return _$financeRecordPaymentRequestMethodEnum_bankTransfer;
    case 'card':
      return _$financeRecordPaymentRequestMethodEnum_card;
    case 'online':
      return _$financeRecordPaymentRequestMethodEnum_online;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceRecordPaymentRequestMethodEnum>
_$financeRecordPaymentRequestMethodEnumValues =
    BuiltSet<FinanceRecordPaymentRequestMethodEnum>(
      const <FinanceRecordPaymentRequestMethodEnum>[
        _$financeRecordPaymentRequestMethodEnum_cash,
        _$financeRecordPaymentRequestMethodEnum_bankTransfer,
        _$financeRecordPaymentRequestMethodEnum_card,
        _$financeRecordPaymentRequestMethodEnum_online,
      ],
    );

Serializer<FinanceRecordPaymentRequestMethodEnum>
_$financeRecordPaymentRequestMethodEnumSerializer =
    _$FinanceRecordPaymentRequestMethodEnumSerializer();

class _$FinanceRecordPaymentRequestMethodEnumSerializer
    implements PrimitiveSerializer<FinanceRecordPaymentRequestMethodEnum> {
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
    FinanceRecordPaymentRequestMethodEnum,
  ];
  @override
  final String wireName = 'FinanceRecordPaymentRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceRecordPaymentRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceRecordPaymentRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceRecordPaymentRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceRecordPaymentRequest extends FinanceRecordPaymentRequest {
  @override
  final String idempotencyKey;
  @override
  final num amount;
  @override
  final FinanceRecordPaymentRequestMethodEnum method;
  @override
  final String? reference;
  @override
  final DateTime? paidAt;
  @override
  final String? note;

  factory _$FinanceRecordPaymentRequest([
    void Function(FinanceRecordPaymentRequestBuilder)? updates,
  ]) => (FinanceRecordPaymentRequestBuilder()..update(updates))._build();

  _$FinanceRecordPaymentRequest._({
    required this.idempotencyKey,
    required this.amount,
    required this.method,
    this.reference,
    this.paidAt,
    this.note,
  }) : super._();
  @override
  FinanceRecordPaymentRequest rebuild(
    void Function(FinanceRecordPaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceRecordPaymentRequestBuilder toBuilder() =>
      FinanceRecordPaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceRecordPaymentRequest &&
        idempotencyKey == other.idempotencyKey &&
        amount == other.amount &&
        method == other.method &&
        reference == other.reference &&
        paidAt == other.paidAt &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceRecordPaymentRequest')
          ..add('idempotencyKey', idempotencyKey)
          ..add('amount', amount)
          ..add('method', method)
          ..add('reference', reference)
          ..add('paidAt', paidAt)
          ..add('note', note))
        .toString();
  }
}

class FinanceRecordPaymentRequestBuilder
    implements
        Builder<
          FinanceRecordPaymentRequest,
          FinanceRecordPaymentRequestBuilder
        > {
  _$FinanceRecordPaymentRequest? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  FinanceRecordPaymentRequestMethodEnum? _method;
  FinanceRecordPaymentRequestMethodEnum? get method => _$this._method;
  set method(FinanceRecordPaymentRequestMethodEnum? method) =>
      _$this._method = method;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  FinanceRecordPaymentRequestBuilder() {
    FinanceRecordPaymentRequest._defaults(this);
  }

  FinanceRecordPaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _amount = $v.amount;
      _method = $v.method;
      _reference = $v.reference;
      _paidAt = $v.paidAt;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceRecordPaymentRequest other) {
    _$v = other as _$FinanceRecordPaymentRequest;
  }

  @override
  void update(void Function(FinanceRecordPaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceRecordPaymentRequest build() => _build();

  _$FinanceRecordPaymentRequest _build() {
    final _$result =
        _$v ??
        _$FinanceRecordPaymentRequest._(
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'FinanceRecordPaymentRequest',
            'idempotencyKey',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceRecordPaymentRequest',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'FinanceRecordPaymentRequest',
            'method',
          ),
          reference: reference,
          paidAt: paidAt,
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
