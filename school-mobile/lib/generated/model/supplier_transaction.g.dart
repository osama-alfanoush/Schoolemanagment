// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SupplierTransaction extends SupplierTransaction {
  @override
  final int id;
  @override
  final int supplierAccountId;
  @override
  final String type;
  @override
  final String amount;
  @override
  final String balanceAfter;
  @override
  final String? referenceNo;
  @override
  final String? sourceType;
  @override
  final int? sourceId;
  @override
  final String? description;
  @override
  final int? performedBy;
  @override
  final DateTime transactionDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$SupplierTransaction([
    void Function(SupplierTransactionBuilder)? updates,
  ]) => (SupplierTransactionBuilder()..update(updates))._build();

  _$SupplierTransaction._({
    required this.id,
    required this.supplierAccountId,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    this.referenceNo,
    this.sourceType,
    this.sourceId,
    this.description,
    this.performedBy,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  SupplierTransaction rebuild(
    void Function(SupplierTransactionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SupplierTransactionBuilder toBuilder() =>
      SupplierTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SupplierTransaction &&
        id == other.id &&
        supplierAccountId == other.supplierAccountId &&
        type == other.type &&
        amount == other.amount &&
        balanceAfter == other.balanceAfter &&
        referenceNo == other.referenceNo &&
        sourceType == other.sourceType &&
        sourceId == other.sourceId &&
        description == other.description &&
        performedBy == other.performedBy &&
        transactionDate == other.transactionDate &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, supplierAccountId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, balanceAfter.hashCode);
    _$hash = $jc(_$hash, referenceNo.hashCode);
    _$hash = $jc(_$hash, sourceType.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, performedBy.hashCode);
    _$hash = $jc(_$hash, transactionDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SupplierTransaction')
          ..add('id', id)
          ..add('supplierAccountId', supplierAccountId)
          ..add('type', type)
          ..add('amount', amount)
          ..add('balanceAfter', balanceAfter)
          ..add('referenceNo', referenceNo)
          ..add('sourceType', sourceType)
          ..add('sourceId', sourceId)
          ..add('description', description)
          ..add('performedBy', performedBy)
          ..add('transactionDate', transactionDate)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class SupplierTransactionBuilder
    implements Builder<SupplierTransaction, SupplierTransactionBuilder> {
  _$SupplierTransaction? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _supplierAccountId;
  int? get supplierAccountId => _$this._supplierAccountId;
  set supplierAccountId(int? supplierAccountId) =>
      _$this._supplierAccountId = supplierAccountId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _balanceAfter;
  String? get balanceAfter => _$this._balanceAfter;
  set balanceAfter(String? balanceAfter) => _$this._balanceAfter = balanceAfter;

  String? _referenceNo;
  String? get referenceNo => _$this._referenceNo;
  set referenceNo(String? referenceNo) => _$this._referenceNo = referenceNo;

  String? _sourceType;
  String? get sourceType => _$this._sourceType;
  set sourceType(String? sourceType) => _$this._sourceType = sourceType;

  int? _sourceId;
  int? get sourceId => _$this._sourceId;
  set sourceId(int? sourceId) => _$this._sourceId = sourceId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _performedBy;
  int? get performedBy => _$this._performedBy;
  set performedBy(int? performedBy) => _$this._performedBy = performedBy;

  DateTime? _transactionDate;
  DateTime? get transactionDate => _$this._transactionDate;
  set transactionDate(DateTime? transactionDate) =>
      _$this._transactionDate = transactionDate;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  SupplierTransactionBuilder() {
    SupplierTransaction._defaults(this);
  }

  SupplierTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _supplierAccountId = $v.supplierAccountId;
      _type = $v.type;
      _amount = $v.amount;
      _balanceAfter = $v.balanceAfter;
      _referenceNo = $v.referenceNo;
      _sourceType = $v.sourceType;
      _sourceId = $v.sourceId;
      _description = $v.description;
      _performedBy = $v.performedBy;
      _transactionDate = $v.transactionDate;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SupplierTransaction other) {
    _$v = other as _$SupplierTransaction;
  }

  @override
  void update(void Function(SupplierTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SupplierTransaction build() => _build();

  _$SupplierTransaction _build() {
    final _$result =
        _$v ??
        _$SupplierTransaction._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'SupplierTransaction',
            'id',
          ),
          supplierAccountId: BuiltValueNullFieldError.checkNotNull(
            supplierAccountId,
            r'SupplierTransaction',
            'supplierAccountId',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'SupplierTransaction',
            'type',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'SupplierTransaction',
            'amount',
          ),
          balanceAfter: BuiltValueNullFieldError.checkNotNull(
            balanceAfter,
            r'SupplierTransaction',
            'balanceAfter',
          ),
          referenceNo: referenceNo,
          sourceType: sourceType,
          sourceId: sourceId,
          description: description,
          performedBy: performedBy,
          transactionDate: BuiltValueNullFieldError.checkNotNull(
            transactionDate,
            r'SupplierTransaction',
            'transactionDate',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'SupplierTransaction',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
