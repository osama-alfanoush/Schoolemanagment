// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StockMovement extends StockMovement {
  @override
  final int id;
  @override
  final int itemId;
  @override
  final String movementType;
  @override
  final String quantity;
  @override
  final String qtyBefore;
  @override
  final String qtyAfter;
  @override
  final String? department;
  @override
  final String? recipientName;
  @override
  final String? reason;
  @override
  final String? referenceNo;
  @override
  final String? supplier;
  @override
  final int performedBy;
  @override
  final DateTime movementDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? unitCost;
  @override
  final int? purchaseOrderId;
  @override
  final int schoolId;

  factory _$StockMovement([void Function(StockMovementBuilder)? updates]) =>
      (StockMovementBuilder()..update(updates))._build();

  _$StockMovement._({
    required this.id,
    required this.itemId,
    required this.movementType,
    required this.quantity,
    required this.qtyBefore,
    required this.qtyAfter,
    this.department,
    this.recipientName,
    this.reason,
    this.referenceNo,
    this.supplier,
    required this.performedBy,
    required this.movementDate,
    this.createdAt,
    this.updatedAt,
    this.unitCost,
    this.purchaseOrderId,
    required this.schoolId,
  }) : super._();
  @override
  StockMovement rebuild(void Function(StockMovementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StockMovementBuilder toBuilder() => StockMovementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StockMovement &&
        id == other.id &&
        itemId == other.itemId &&
        movementType == other.movementType &&
        quantity == other.quantity &&
        qtyBefore == other.qtyBefore &&
        qtyAfter == other.qtyAfter &&
        department == other.department &&
        recipientName == other.recipientName &&
        reason == other.reason &&
        referenceNo == other.referenceNo &&
        supplier == other.supplier &&
        performedBy == other.performedBy &&
        movementDate == other.movementDate &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        unitCost == other.unitCost &&
        purchaseOrderId == other.purchaseOrderId &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, movementType.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, qtyBefore.hashCode);
    _$hash = $jc(_$hash, qtyAfter.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, recipientName.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, referenceNo.hashCode);
    _$hash = $jc(_$hash, supplier.hashCode);
    _$hash = $jc(_$hash, performedBy.hashCode);
    _$hash = $jc(_$hash, movementDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, unitCost.hashCode);
    _$hash = $jc(_$hash, purchaseOrderId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StockMovement')
          ..add('id', id)
          ..add('itemId', itemId)
          ..add('movementType', movementType)
          ..add('quantity', quantity)
          ..add('qtyBefore', qtyBefore)
          ..add('qtyAfter', qtyAfter)
          ..add('department', department)
          ..add('recipientName', recipientName)
          ..add('reason', reason)
          ..add('referenceNo', referenceNo)
          ..add('supplier', supplier)
          ..add('performedBy', performedBy)
          ..add('movementDate', movementDate)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('unitCost', unitCost)
          ..add('purchaseOrderId', purchaseOrderId)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class StockMovementBuilder
    implements Builder<StockMovement, StockMovementBuilder> {
  _$StockMovement? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  String? _movementType;
  String? get movementType => _$this._movementType;
  set movementType(String? movementType) => _$this._movementType = movementType;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _qtyBefore;
  String? get qtyBefore => _$this._qtyBefore;
  set qtyBefore(String? qtyBefore) => _$this._qtyBefore = qtyBefore;

  String? _qtyAfter;
  String? get qtyAfter => _$this._qtyAfter;
  set qtyAfter(String? qtyAfter) => _$this._qtyAfter = qtyAfter;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _recipientName;
  String? get recipientName => _$this._recipientName;
  set recipientName(String? recipientName) =>
      _$this._recipientName = recipientName;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _referenceNo;
  String? get referenceNo => _$this._referenceNo;
  set referenceNo(String? referenceNo) => _$this._referenceNo = referenceNo;

  String? _supplier;
  String? get supplier => _$this._supplier;
  set supplier(String? supplier) => _$this._supplier = supplier;

  int? _performedBy;
  int? get performedBy => _$this._performedBy;
  set performedBy(int? performedBy) => _$this._performedBy = performedBy;

  DateTime? _movementDate;
  DateTime? get movementDate => _$this._movementDate;
  set movementDate(DateTime? movementDate) =>
      _$this._movementDate = movementDate;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _unitCost;
  String? get unitCost => _$this._unitCost;
  set unitCost(String? unitCost) => _$this._unitCost = unitCost;

  int? _purchaseOrderId;
  int? get purchaseOrderId => _$this._purchaseOrderId;
  set purchaseOrderId(int? purchaseOrderId) =>
      _$this._purchaseOrderId = purchaseOrderId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  StockMovementBuilder() {
    StockMovement._defaults(this);
  }

  StockMovementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _itemId = $v.itemId;
      _movementType = $v.movementType;
      _quantity = $v.quantity;
      _qtyBefore = $v.qtyBefore;
      _qtyAfter = $v.qtyAfter;
      _department = $v.department;
      _recipientName = $v.recipientName;
      _reason = $v.reason;
      _referenceNo = $v.referenceNo;
      _supplier = $v.supplier;
      _performedBy = $v.performedBy;
      _movementDate = $v.movementDate;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _unitCost = $v.unitCost;
      _purchaseOrderId = $v.purchaseOrderId;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StockMovement other) {
    _$v = other as _$StockMovement;
  }

  @override
  void update(void Function(StockMovementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StockMovement build() => _build();

  _$StockMovement _build() {
    final _$result =
        _$v ??
        _$StockMovement._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'StockMovement', 'id'),
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'StockMovement',
            'itemId',
          ),
          movementType: BuiltValueNullFieldError.checkNotNull(
            movementType,
            r'StockMovement',
            'movementType',
          ),
          quantity: BuiltValueNullFieldError.checkNotNull(
            quantity,
            r'StockMovement',
            'quantity',
          ),
          qtyBefore: BuiltValueNullFieldError.checkNotNull(
            qtyBefore,
            r'StockMovement',
            'qtyBefore',
          ),
          qtyAfter: BuiltValueNullFieldError.checkNotNull(
            qtyAfter,
            r'StockMovement',
            'qtyAfter',
          ),
          department: department,
          recipientName: recipientName,
          reason: reason,
          referenceNo: referenceNo,
          supplier: supplier,
          performedBy: BuiltValueNullFieldError.checkNotNull(
            performedBy,
            r'StockMovement',
            'performedBy',
          ),
          movementDate: BuiltValueNullFieldError.checkNotNull(
            movementDate,
            r'StockMovement',
            'movementDate',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          unitCost: unitCost,
          purchaseOrderId: purchaseOrderId,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'StockMovement',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
