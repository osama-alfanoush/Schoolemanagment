// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PurchaseOrder extends PurchaseOrder {
  @override
  final int id;
  @override
  final String poNo;
  @override
  final int supplierId;
  @override
  final String status;
  @override
  final DateTime orderDate;
  @override
  final DateTime? expectedDate;
  @override
  final String subtotal;
  @override
  final String tax;
  @override
  final String total;
  @override
  final String? notes;
  @override
  final int? purchaseRequestId;
  @override
  final int requestedBy;
  @override
  final int? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int schoolId;

  factory _$PurchaseOrder([void Function(PurchaseOrderBuilder)? updates]) =>
      (PurchaseOrderBuilder()..update(updates))._build();

  _$PurchaseOrder._({
    required this.id,
    required this.poNo,
    required this.supplierId,
    required this.status,
    required this.orderDate,
    this.expectedDate,
    required this.subtotal,
    required this.tax,
    required this.total,
    this.notes,
    this.purchaseRequestId,
    required this.requestedBy,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.schoolId,
  }) : super._();
  @override
  PurchaseOrder rebuild(void Function(PurchaseOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PurchaseOrderBuilder toBuilder() => PurchaseOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PurchaseOrder &&
        id == other.id &&
        poNo == other.poNo &&
        supplierId == other.supplierId &&
        status == other.status &&
        orderDate == other.orderDate &&
        expectedDate == other.expectedDate &&
        subtotal == other.subtotal &&
        tax == other.tax &&
        total == other.total &&
        notes == other.notes &&
        purchaseRequestId == other.purchaseRequestId &&
        requestedBy == other.requestedBy &&
        approvedBy == other.approvedBy &&
        approvedAt == other.approvedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, poNo.hashCode);
    _$hash = $jc(_$hash, supplierId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, orderDate.hashCode);
    _$hash = $jc(_$hash, expectedDate.hashCode);
    _$hash = $jc(_$hash, subtotal.hashCode);
    _$hash = $jc(_$hash, tax.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, purchaseRequestId.hashCode);
    _$hash = $jc(_$hash, requestedBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PurchaseOrder')
          ..add('id', id)
          ..add('poNo', poNo)
          ..add('supplierId', supplierId)
          ..add('status', status)
          ..add('orderDate', orderDate)
          ..add('expectedDate', expectedDate)
          ..add('subtotal', subtotal)
          ..add('tax', tax)
          ..add('total', total)
          ..add('notes', notes)
          ..add('purchaseRequestId', purchaseRequestId)
          ..add('requestedBy', requestedBy)
          ..add('approvedBy', approvedBy)
          ..add('approvedAt', approvedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('deletedAt', deletedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PurchaseOrderBuilder
    implements Builder<PurchaseOrder, PurchaseOrderBuilder> {
  _$PurchaseOrder? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _poNo;
  String? get poNo => _$this._poNo;
  set poNo(String? poNo) => _$this._poNo = poNo;

  int? _supplierId;
  int? get supplierId => _$this._supplierId;
  set supplierId(int? supplierId) => _$this._supplierId = supplierId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _orderDate;
  DateTime? get orderDate => _$this._orderDate;
  set orderDate(DateTime? orderDate) => _$this._orderDate = orderDate;

  DateTime? _expectedDate;
  DateTime? get expectedDate => _$this._expectedDate;
  set expectedDate(DateTime? expectedDate) =>
      _$this._expectedDate = expectedDate;

  String? _subtotal;
  String? get subtotal => _$this._subtotal;
  set subtotal(String? subtotal) => _$this._subtotal = subtotal;

  String? _tax;
  String? get tax => _$this._tax;
  set tax(String? tax) => _$this._tax = tax;

  String? _total;
  String? get total => _$this._total;
  set total(String? total) => _$this._total = total;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _purchaseRequestId;
  int? get purchaseRequestId => _$this._purchaseRequestId;
  set purchaseRequestId(int? purchaseRequestId) =>
      _$this._purchaseRequestId = purchaseRequestId;

  int? _requestedBy;
  int? get requestedBy => _$this._requestedBy;
  set requestedBy(int? requestedBy) => _$this._requestedBy = requestedBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _deletedAt;
  DateTime? get deletedAt => _$this._deletedAt;
  set deletedAt(DateTime? deletedAt) => _$this._deletedAt = deletedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PurchaseOrderBuilder() {
    PurchaseOrder._defaults(this);
  }

  PurchaseOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _poNo = $v.poNo;
      _supplierId = $v.supplierId;
      _status = $v.status;
      _orderDate = $v.orderDate;
      _expectedDate = $v.expectedDate;
      _subtotal = $v.subtotal;
      _tax = $v.tax;
      _total = $v.total;
      _notes = $v.notes;
      _purchaseRequestId = $v.purchaseRequestId;
      _requestedBy = $v.requestedBy;
      _approvedBy = $v.approvedBy;
      _approvedAt = $v.approvedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _deletedAt = $v.deletedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PurchaseOrder other) {
    _$v = other as _$PurchaseOrder;
  }

  @override
  void update(void Function(PurchaseOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PurchaseOrder build() => _build();

  _$PurchaseOrder _build() {
    final _$result =
        _$v ??
        _$PurchaseOrder._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'PurchaseOrder', 'id'),
          poNo: BuiltValueNullFieldError.checkNotNull(
            poNo,
            r'PurchaseOrder',
            'poNo',
          ),
          supplierId: BuiltValueNullFieldError.checkNotNull(
            supplierId,
            r'PurchaseOrder',
            'supplierId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PurchaseOrder',
            'status',
          ),
          orderDate: BuiltValueNullFieldError.checkNotNull(
            orderDate,
            r'PurchaseOrder',
            'orderDate',
          ),
          expectedDate: expectedDate,
          subtotal: BuiltValueNullFieldError.checkNotNull(
            subtotal,
            r'PurchaseOrder',
            'subtotal',
          ),
          tax: BuiltValueNullFieldError.checkNotNull(
            tax,
            r'PurchaseOrder',
            'tax',
          ),
          total: BuiltValueNullFieldError.checkNotNull(
            total,
            r'PurchaseOrder',
            'total',
          ),
          notes: notes,
          purchaseRequestId: purchaseRequestId,
          requestedBy: BuiltValueNullFieldError.checkNotNull(
            requestedBy,
            r'PurchaseOrder',
            'requestedBy',
          ),
          approvedBy: approvedBy,
          approvedAt: approvedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PurchaseOrder',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
