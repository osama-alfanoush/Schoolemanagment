// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Payment extends Payment {
  @override
  final int id;
  @override
  final int invoiceId;
  @override
  final String amount;
  @override
  final String method;
  @override
  final String? reference;
  @override
  final int? recordedBy;
  @override
  final DateTime paidAt;
  @override
  final String? note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? idempotencyKey;
  @override
  final String? idempotencyPayloadHash;
  @override
  final int? paymentReceiptId;
  @override
  final String status;
  @override
  final DateTime? reversedAt;
  @override
  final int schoolId;

  factory _$Payment([void Function(PaymentBuilder)? updates]) =>
      (PaymentBuilder()..update(updates))._build();

  _$Payment._({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.method,
    this.reference,
    this.recordedBy,
    required this.paidAt,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.idempotencyKey,
    this.idempotencyPayloadHash,
    this.paymentReceiptId,
    required this.status,
    this.reversedAt,
    required this.schoolId,
  }) : super._();
  @override
  Payment rebuild(void Function(PaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentBuilder toBuilder() => PaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Payment &&
        id == other.id &&
        invoiceId == other.invoiceId &&
        amount == other.amount &&
        method == other.method &&
        reference == other.reference &&
        recordedBy == other.recordedBy &&
        paidAt == other.paidAt &&
        note == other.note &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        idempotencyKey == other.idempotencyKey &&
        idempotencyPayloadHash == other.idempotencyPayloadHash &&
        paymentReceiptId == other.paymentReceiptId &&
        status == other.status &&
        reversedAt == other.reversedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, recordedBy.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, idempotencyPayloadHash.hashCode);
    _$hash = $jc(_$hash, paymentReceiptId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reversedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Payment')
          ..add('id', id)
          ..add('invoiceId', invoiceId)
          ..add('amount', amount)
          ..add('method', method)
          ..add('reference', reference)
          ..add('recordedBy', recordedBy)
          ..add('paidAt', paidAt)
          ..add('note', note)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('idempotencyKey', idempotencyKey)
          ..add('idempotencyPayloadHash', idempotencyPayloadHash)
          ..add('paymentReceiptId', paymentReceiptId)
          ..add('status', status)
          ..add('reversedAt', reversedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PaymentBuilder implements Builder<Payment, PaymentBuilder> {
  _$Payment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _invoiceId;
  int? get invoiceId => _$this._invoiceId;
  set invoiceId(int? invoiceId) => _$this._invoiceId = invoiceId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  int? _recordedBy;
  int? get recordedBy => _$this._recordedBy;
  set recordedBy(int? recordedBy) => _$this._recordedBy = recordedBy;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _idempotencyPayloadHash;
  String? get idempotencyPayloadHash => _$this._idempotencyPayloadHash;
  set idempotencyPayloadHash(String? idempotencyPayloadHash) =>
      _$this._idempotencyPayloadHash = idempotencyPayloadHash;

  int? _paymentReceiptId;
  int? get paymentReceiptId => _$this._paymentReceiptId;
  set paymentReceiptId(int? paymentReceiptId) =>
      _$this._paymentReceiptId = paymentReceiptId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _reversedAt;
  DateTime? get reversedAt => _$this._reversedAt;
  set reversedAt(DateTime? reversedAt) => _$this._reversedAt = reversedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PaymentBuilder() {
    Payment._defaults(this);
  }

  PaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _invoiceId = $v.invoiceId;
      _amount = $v.amount;
      _method = $v.method;
      _reference = $v.reference;
      _recordedBy = $v.recordedBy;
      _paidAt = $v.paidAt;
      _note = $v.note;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _idempotencyKey = $v.idempotencyKey;
      _idempotencyPayloadHash = $v.idempotencyPayloadHash;
      _paymentReceiptId = $v.paymentReceiptId;
      _status = $v.status;
      _reversedAt = $v.reversedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Payment other) {
    _$v = other as _$Payment;
  }

  @override
  void update(void Function(PaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Payment build() => _build();

  _$Payment _build() {
    final _$result =
        _$v ??
        _$Payment._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Payment', 'id'),
          invoiceId: BuiltValueNullFieldError.checkNotNull(
            invoiceId,
            r'Payment',
            'invoiceId',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'Payment',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'Payment',
            'method',
          ),
          reference: reference,
          recordedBy: recordedBy,
          paidAt: BuiltValueNullFieldError.checkNotNull(
            paidAt,
            r'Payment',
            'paidAt',
          ),
          note: note,
          createdAt: createdAt,
          updatedAt: updatedAt,
          idempotencyKey: idempotencyKey,
          idempotencyPayloadHash: idempotencyPayloadHash,
          paymentReceiptId: paymentReceiptId,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Payment',
            'status',
          ),
          reversedAt: reversedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Payment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
