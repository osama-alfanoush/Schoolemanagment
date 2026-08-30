// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_receipt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentReceipt extends PaymentReceipt {
  @override
  final int id;
  @override
  final String receiptNo;
  @override
  final int studentUserId;
  @override
  final String amount;
  @override
  final String method;
  @override
  final DateTime receiptDate;
  @override
  final String? reference;
  @override
  final String? cashAccount;
  @override
  final String? note;
  @override
  final String status;
  @override
  final String idempotencyKey;
  @override
  final String idempotencyPayloadHash;
  @override
  final int createdBy;
  @override
  final int? approvedBy;
  @override
  final int? postedBy;
  @override
  final int? reversedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? postedAt;
  @override
  final DateTime? reversedAt;
  @override
  final String? reversalReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$PaymentReceipt([void Function(PaymentReceiptBuilder)? updates]) =>
      (PaymentReceiptBuilder()..update(updates))._build();

  _$PaymentReceipt._({
    required this.id,
    required this.receiptNo,
    required this.studentUserId,
    required this.amount,
    required this.method,
    required this.receiptDate,
    this.reference,
    this.cashAccount,
    this.note,
    required this.status,
    required this.idempotencyKey,
    required this.idempotencyPayloadHash,
    required this.createdBy,
    this.approvedBy,
    this.postedBy,
    this.reversedBy,
    this.approvedAt,
    this.postedAt,
    this.reversedAt,
    this.reversalReason,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  PaymentReceipt rebuild(void Function(PaymentReceiptBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentReceiptBuilder toBuilder() => PaymentReceiptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentReceipt &&
        id == other.id &&
        receiptNo == other.receiptNo &&
        studentUserId == other.studentUserId &&
        amount == other.amount &&
        method == other.method &&
        receiptDate == other.receiptDate &&
        reference == other.reference &&
        cashAccount == other.cashAccount &&
        note == other.note &&
        status == other.status &&
        idempotencyKey == other.idempotencyKey &&
        idempotencyPayloadHash == other.idempotencyPayloadHash &&
        createdBy == other.createdBy &&
        approvedBy == other.approvedBy &&
        postedBy == other.postedBy &&
        reversedBy == other.reversedBy &&
        approvedAt == other.approvedAt &&
        postedAt == other.postedAt &&
        reversedAt == other.reversedAt &&
        reversalReason == other.reversalReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, receiptNo.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, receiptDate.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, cashAccount.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, idempotencyPayloadHash.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, postedBy.hashCode);
    _$hash = $jc(_$hash, reversedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, reversedAt.hashCode);
    _$hash = $jc(_$hash, reversalReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentReceipt')
          ..add('id', id)
          ..add('receiptNo', receiptNo)
          ..add('studentUserId', studentUserId)
          ..add('amount', amount)
          ..add('method', method)
          ..add('receiptDate', receiptDate)
          ..add('reference', reference)
          ..add('cashAccount', cashAccount)
          ..add('note', note)
          ..add('status', status)
          ..add('idempotencyKey', idempotencyKey)
          ..add('idempotencyPayloadHash', idempotencyPayloadHash)
          ..add('createdBy', createdBy)
          ..add('approvedBy', approvedBy)
          ..add('postedBy', postedBy)
          ..add('reversedBy', reversedBy)
          ..add('approvedAt', approvedAt)
          ..add('postedAt', postedAt)
          ..add('reversedAt', reversedAt)
          ..add('reversalReason', reversalReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PaymentReceiptBuilder
    implements Builder<PaymentReceipt, PaymentReceiptBuilder> {
  _$PaymentReceipt? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _receiptNo;
  String? get receiptNo => _$this._receiptNo;
  set receiptNo(String? receiptNo) => _$this._receiptNo = receiptNo;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  DateTime? _receiptDate;
  DateTime? get receiptDate => _$this._receiptDate;
  set receiptDate(DateTime? receiptDate) => _$this._receiptDate = receiptDate;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  String? _cashAccount;
  String? get cashAccount => _$this._cashAccount;
  set cashAccount(String? cashAccount) => _$this._cashAccount = cashAccount;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _idempotencyPayloadHash;
  String? get idempotencyPayloadHash => _$this._idempotencyPayloadHash;
  set idempotencyPayloadHash(String? idempotencyPayloadHash) =>
      _$this._idempotencyPayloadHash = idempotencyPayloadHash;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  int? _postedBy;
  int? get postedBy => _$this._postedBy;
  set postedBy(int? postedBy) => _$this._postedBy = postedBy;

  int? _reversedBy;
  int? get reversedBy => _$this._reversedBy;
  set reversedBy(int? reversedBy) => _$this._reversedBy = reversedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _postedAt;
  DateTime? get postedAt => _$this._postedAt;
  set postedAt(DateTime? postedAt) => _$this._postedAt = postedAt;

  DateTime? _reversedAt;
  DateTime? get reversedAt => _$this._reversedAt;
  set reversedAt(DateTime? reversedAt) => _$this._reversedAt = reversedAt;

  String? _reversalReason;
  String? get reversalReason => _$this._reversalReason;
  set reversalReason(String? reversalReason) =>
      _$this._reversalReason = reversalReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PaymentReceiptBuilder() {
    PaymentReceipt._defaults(this);
  }

  PaymentReceiptBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _receiptNo = $v.receiptNo;
      _studentUserId = $v.studentUserId;
      _amount = $v.amount;
      _method = $v.method;
      _receiptDate = $v.receiptDate;
      _reference = $v.reference;
      _cashAccount = $v.cashAccount;
      _note = $v.note;
      _status = $v.status;
      _idempotencyKey = $v.idempotencyKey;
      _idempotencyPayloadHash = $v.idempotencyPayloadHash;
      _createdBy = $v.createdBy;
      _approvedBy = $v.approvedBy;
      _postedBy = $v.postedBy;
      _reversedBy = $v.reversedBy;
      _approvedAt = $v.approvedAt;
      _postedAt = $v.postedAt;
      _reversedAt = $v.reversedAt;
      _reversalReason = $v.reversalReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentReceipt other) {
    _$v = other as _$PaymentReceipt;
  }

  @override
  void update(void Function(PaymentReceiptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentReceipt build() => _build();

  _$PaymentReceipt _build() {
    final _$result =
        _$v ??
        _$PaymentReceipt._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'PaymentReceipt',
            'id',
          ),
          receiptNo: BuiltValueNullFieldError.checkNotNull(
            receiptNo,
            r'PaymentReceipt',
            'receiptNo',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'PaymentReceipt',
            'studentUserId',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'PaymentReceipt',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'PaymentReceipt',
            'method',
          ),
          receiptDate: BuiltValueNullFieldError.checkNotNull(
            receiptDate,
            r'PaymentReceipt',
            'receiptDate',
          ),
          reference: reference,
          cashAccount: cashAccount,
          note: note,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PaymentReceipt',
            'status',
          ),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'PaymentReceipt',
            'idempotencyKey',
          ),
          idempotencyPayloadHash: BuiltValueNullFieldError.checkNotNull(
            idempotencyPayloadHash,
            r'PaymentReceipt',
            'idempotencyPayloadHash',
          ),
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'PaymentReceipt',
            'createdBy',
          ),
          approvedBy: approvedBy,
          postedBy: postedBy,
          reversedBy: reversedBy,
          approvedAt: approvedAt,
          postedAt: postedAt,
          reversedAt: reversedAt,
          reversalReason: reversalReason,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PaymentReceipt',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
