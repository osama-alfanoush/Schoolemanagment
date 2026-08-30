// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_record_payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementFinanceRecordPaymentRequestMethodEnum
_$procurementFinanceRecordPaymentRequestMethodEnum_cash =
    const ProcurementFinanceRecordPaymentRequestMethodEnum._('cash');
const ProcurementFinanceRecordPaymentRequestMethodEnum
_$procurementFinanceRecordPaymentRequestMethodEnum_bankTransfer =
    const ProcurementFinanceRecordPaymentRequestMethodEnum._('bankTransfer');
const ProcurementFinanceRecordPaymentRequestMethodEnum
_$procurementFinanceRecordPaymentRequestMethodEnum_cheque =
    const ProcurementFinanceRecordPaymentRequestMethodEnum._('cheque');

ProcurementFinanceRecordPaymentRequestMethodEnum
_$procurementFinanceRecordPaymentRequestMethodEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$procurementFinanceRecordPaymentRequestMethodEnum_cash;
    case 'bankTransfer':
      return _$procurementFinanceRecordPaymentRequestMethodEnum_bankTransfer;
    case 'cheque':
      return _$procurementFinanceRecordPaymentRequestMethodEnum_cheque;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementFinanceRecordPaymentRequestMethodEnum>
_$procurementFinanceRecordPaymentRequestMethodEnumValues =
    BuiltSet<ProcurementFinanceRecordPaymentRequestMethodEnum>(
      const <ProcurementFinanceRecordPaymentRequestMethodEnum>[
        _$procurementFinanceRecordPaymentRequestMethodEnum_cash,
        _$procurementFinanceRecordPaymentRequestMethodEnum_bankTransfer,
        _$procurementFinanceRecordPaymentRequestMethodEnum_cheque,
      ],
    );

Serializer<ProcurementFinanceRecordPaymentRequestMethodEnum>
_$procurementFinanceRecordPaymentRequestMethodEnumSerializer =
    _$ProcurementFinanceRecordPaymentRequestMethodEnumSerializer();

class _$ProcurementFinanceRecordPaymentRequestMethodEnumSerializer
    implements
        PrimitiveSerializer<ProcurementFinanceRecordPaymentRequestMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cash': 'cash',
    'bankTransfer': 'bank_transfer',
    'cheque': 'cheque',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cash': 'cash',
    'bank_transfer': 'bankTransfer',
    'cheque': 'cheque',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementFinanceRecordPaymentRequestMethodEnum,
  ];
  @override
  final String wireName = 'ProcurementFinanceRecordPaymentRequestMethodEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementFinanceRecordPaymentRequestMethodEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementFinanceRecordPaymentRequestMethodEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementFinanceRecordPaymentRequestMethodEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementFinanceRecordPaymentRequest
    extends ProcurementFinanceRecordPaymentRequest {
  @override
  final num amount;
  @override
  final ProcurementFinanceRecordPaymentRequestMethodEnum method;
  @override
  final String? reference;
  @override
  final DateTime? paidAt;
  @override
  final String? note;

  factory _$ProcurementFinanceRecordPaymentRequest([
    void Function(ProcurementFinanceRecordPaymentRequestBuilder)? updates,
  ]) => (ProcurementFinanceRecordPaymentRequestBuilder()..update(updates))
      ._build();

  _$ProcurementFinanceRecordPaymentRequest._({
    required this.amount,
    required this.method,
    this.reference,
    this.paidAt,
    this.note,
  }) : super._();
  @override
  ProcurementFinanceRecordPaymentRequest rebuild(
    void Function(ProcurementFinanceRecordPaymentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceRecordPaymentRequestBuilder toBuilder() =>
      ProcurementFinanceRecordPaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceRecordPaymentRequest &&
        amount == other.amount &&
        method == other.method &&
        reference == other.reference &&
        paidAt == other.paidAt &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    return (newBuiltValueToStringHelper(
            r'ProcurementFinanceRecordPaymentRequest',
          )
          ..add('amount', amount)
          ..add('method', method)
          ..add('reference', reference)
          ..add('paidAt', paidAt)
          ..add('note', note))
        .toString();
  }
}

class ProcurementFinanceRecordPaymentRequestBuilder
    implements
        Builder<
          ProcurementFinanceRecordPaymentRequest,
          ProcurementFinanceRecordPaymentRequestBuilder
        > {
  _$ProcurementFinanceRecordPaymentRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  ProcurementFinanceRecordPaymentRequestMethodEnum? _method;
  ProcurementFinanceRecordPaymentRequestMethodEnum? get method =>
      _$this._method;
  set method(ProcurementFinanceRecordPaymentRequestMethodEnum? method) =>
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

  ProcurementFinanceRecordPaymentRequestBuilder() {
    ProcurementFinanceRecordPaymentRequest._defaults(this);
  }

  ProcurementFinanceRecordPaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(ProcurementFinanceRecordPaymentRequest other) {
    _$v = other as _$ProcurementFinanceRecordPaymentRequest;
  }

  @override
  void update(
    void Function(ProcurementFinanceRecordPaymentRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceRecordPaymentRequest build() => _build();

  _$ProcurementFinanceRecordPaymentRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementFinanceRecordPaymentRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'ProcurementFinanceRecordPaymentRequest',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'ProcurementFinanceRecordPaymentRequest',
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
